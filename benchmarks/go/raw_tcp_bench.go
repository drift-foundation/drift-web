// Go raw TCP baseline: same workload as Drift baseline-vt.
//
// Server: accept one connection, read until \r\n\r\n, write canned response.
// Client: write fixed request, read fixed-length response.
// No net/http on either side. Measures pure TCP + goroutine scheduler cost.
//
// - One listener on localhost, ephemeral port
// - One keep-alive TCP connection, sequential ping-pong
// - Warmup 50, measure 5000
//
// Run: go run benchmarks/go/raw_tcp_bench.go

package main

import (
	"bytes"
	"fmt"
	"net"
	"time"
)

const (
	warmupN  = 50
	measureN = 5000
)

var (
	fixedReq  = []byte("GET / HTTP/1.1\r\nHost: localhost\r\n\r\n")
	fixedResp = []byte("HTTP/1.1 200 OK\r\nContent-Length: 2\r\nConnection: keep-alive\r\n\r\nok")
	crlfcrlf  = []byte("\r\n\r\n")
)

func server(ln net.Listener, totalN int) {
	conn, err := ln.Accept()
	if err != nil {
		return
	}
	defer conn.Close()

	buf := make([]byte, 4096)
	served := 0
	var leftover []byte

	for served < totalN {
		// Check leftover from previous read for a complete request.
		if idx := bytes.Index(leftover, crlfcrlf); idx >= 0 {
			leftover = leftover[idx+4:]
			conn.Write(fixedResp)
			served++
			continue
		}

		n, err := conn.Read(buf)
		if err != nil || n == 0 {
			return
		}
		leftover = append(leftover, buf[:n]...)
		// Process all complete requests in this read.
		for {
			idx := bytes.Index(leftover, crlfcrlf)
			if idx < 0 {
				break
			}
			leftover = leftover[idx+4:]
			conn.Write(fixedResp)
			served++
		}
	}
}

func main() {
	ln, err := net.Listen("tcp", "127.0.0.1:0")
	if err != nil {
		fmt.Printf("listen error: %v\n", err)
		return
	}
	port := ln.Addr().(*net.TCPAddr).Port
	totalN := warmupN + measureN

	go server(ln, totalN)

	// Client
	conn, err := net.Dial("tcp", fmt.Sprintf("127.0.0.1:%d", port))
	if err != nil {
		fmt.Printf("connect error: %v\n", err)
		return
	}
	defer conn.Close()

	respLen := len(fixedResp) // 63 bytes
	readBuf := make([]byte, 4096)

	roundTrip := func() error {
		if _, err := conn.Write(fixedReq); err != nil {
			return err
		}
		got := 0
		for got < respLen {
			n, err := conn.Read(readBuf)
			if err != nil {
				return err
			}
			got += n
		}
		return nil
	}

	// Warmup
	for i := 0; i < warmupN; i++ {
		if err := roundTrip(); err != nil {
			fmt.Printf("warmup error: %v\n", err)
			return
		}
	}

	// Measured
	start := time.Now()
	for i := 0; i < measureN; i++ {
		if err := roundTrip(); err != nil {
			fmt.Printf("measure error at %d: %v\n", i, err)
			return
		}
	}
	elapsed := time.Since(start)

	elapsedMs := elapsed.Milliseconds()
	avgUs := int64(0)
	reqPerSec := int64(0)
	if measureN > 0 {
		avgUs = (elapsedMs * 1000) / int64(measureN)
	}
	if elapsedMs > 0 {
		reqPerSec = (int64(measureN) * 1000) / elapsedMs
	}

	fmt.Printf("[bench] go-raw-tcp  iters=%d  total_ms=%d  avg_us=%d  req_per_sec=%d\n",
		measureN, elapsedMs, avgUs, reqPerSec)
}
