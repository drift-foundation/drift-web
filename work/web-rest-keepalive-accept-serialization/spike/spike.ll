%DriftString = type { i64, ptr }
%DriftError = type { i64, %DriftString, ptr, i64, ptr, i64 }
%DriftIface = type { ptr, ptr, [4 x i64], i8, [7 x i8] }
%DriftCallbackVTable = type [2 x ptr]
%FnResult_Int_Error = type { i8, i64, ptr }
%DriftArrayHeader = type { i64, i64, i64, ptr }
%DriftFatFnPtr = type { ptr, ptr }
%FnResult_Void_Error = type { i8, i8, ptr }
%FnResult_String_Error = type { i8, %DriftString, ptr }
%Struct_std_2Emem_RawBuffer_10d8760b6c6b011c = type { ptr, i64 }
%Struct_std_2Eio_Buffer_e76b5c24b140f2f4 = type { %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c, i64, i64 }
%Struct_std_2Enet_TcpListener_7d3d9b3ee7d65cad = type { i64 }
%Struct_std_2Emem_RawBuffer_1b66b676bebd11aa = type { ptr, i64 }
%Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba = type { %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa }
%Struct_std_2Enet_TcpStream_363317ef680a1400 = type { i64 }
%Struct_std_2Enet_NetError_203564604ea2d3a4 = type { %DriftString, i64 }
%Variant_std_2Ecore_Result_ccaaf7910bb23f6d = type { i8, [7 x i8], [3 x i64] }
%Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 = type { i64 }
%Variant_lang_2Ecore_Optional_0c32631472b0a6e3 = type { i8, [7 x i8], [1 x i64] }
%Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 = type { i8, [7 x i8], [3 x i64] }
%Variant_lang_2Eatomic_MemoryOrder_469abe0ace4b6a6f = type { i8, [7 x i8], [1 x i64] }
%Variant_std_2Ecore_Result_a482b0d00941967a = type { i8, [7 x i8], [3 x i64] }
%Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 = type { %DriftString, i64 }
%Variant_std_2Ecore_Result_4861f1d1d2eeba72 = type { i8, [7 x i8], [3 x i64] }
%Struct_std_2Eerr_IndexError_db7149950235ecbd = type { %DriftString, i64 }
%Variant_std_2Ecore_Result_8541acbd074aaf8c = type { i8, [7 x i8], [1 x i64] }
%Struct_std_2Enet_SocketAddr_461bcf04e30af211 = type { %DriftString, i64 }
%Variant_std_2Ecore_Result_f9949363b6b29c23 = type { i8, [7 x i8], [3 x i64] }
%Struct_lang_2Eatomic_AtomicBool_4466cda2157b83d3 = type { i8 }
%Struct_std_2Esync_AtomicBool_881cc492ae8213fb = type { %Struct_lang_2Eatomic_AtomicBool_4466cda2157b83d3 }
%Struct_spike___lambda_env_cb_main_0_0_7b89ae1f0169a0da = type { %Struct_std_2Enet_TcpListener_7d3d9b3ee7d65cad, %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba }
%Struct_std_2Emem_RawBuffer_b2b1ad1dcb634bff = type { ptr, i64 }
%Struct_std_2Emem_RawBuffer_864958797bafab1a = type { ptr, i64 }
%Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb = type { %Struct_std_2Emem_RawBuffer_864958797bafab1a }
%Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 = type { i8, i64, %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb, i8, i64 }
%Variant_std_2Ecore_Result_37335149f7faff82 = type { i8, [7 x i8], [3 x i64] }
%Struct_lang_2Eatomic_AtomicInt_4a3cfd9b16e4d07c = type { i64 }
%Variant_std_2Econcurrent_SaturationPolicy_360793185eb004ed = type { i8, [7 x i8], [1 x i64] }
%Struct_std_2Econcurrent_ExecutorPolicy_d47ca96967314fb7 = type { i64, i64, i64, %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42, %Variant_std_2Econcurrent_SaturationPolicy_360793185eb004ed, i64 }
%Struct_std_2Econcurrent_ExecutorPolicyBuilder_540c134815cc862b = type { i64, i64, i64, %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42, %Variant_std_2Econcurrent_SaturationPolicy_360793185eb004ed, i64 }
%Struct_std_2Econcurrent_Executor_c4c2a3d6fade171d = type { %Struct_std_2Econcurrent_ExecutorPolicy_d47ca96967314fb7, i64 }
%Struct_std_2Econcurrent_InvalidDuration_a4e3fb5850f7f182 = type { i64 }
%Struct_std_2Econcurrent_ExecSubmitFailed_1afe4ac0bfe13e54 = type { i64 }
%Struct_std_2Eio_IoError_7415ea6adc7a82aa = type { %DriftString, i64 }
%Variant_std_2Ecore_Result_91c2f7f96a418c4d = type { i8, [7 x i8], [3 x i64] }
%Struct_std_2Eio_OutputStreamBuilder_3e71da12881637f4 = type { i64, %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 }
%Struct_std_2Eio_ConfiguredOutputStream_bdad74f25b0e3ac5 = type { i64, %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 }
%Struct_std_2Eio_OutputStream_d623f446e1cca610 = type { i64 }
%Struct_std_2Eio_ProcessStdinCapability_59452a2d778d5df1 = type { i64 }
%Struct_std_2Eio_ProcessStdoutCapability_55cff55291ea241c = type { i64 }
%Struct_std_2Eio_ProcessStderrCapability_d600e110b9a19e1e = type { i64 }
%Struct_std_2Emem_RawBuffer_eb7c8c85e66bfc2f = type { ptr, i64 }
%Struct_std_2Eruntime_GlobalRegistry_4806c2e3110dbbee = type { i64 }
%Struct_std_2Emem_RawBuffer_d10426ae10844bad = type { ptr, i64 }
%Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79 = type { %Struct_std_2Emem_RawBuffer_d10426ae10844bad, i8, i8 }
%Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b = type { ptr, ptr, i8 }
%Struct_std_2Ecore_2Earc_ArcHeader_363bcf8619c06fdd = type { %Struct_lang_2Eatomic_AtomicInt_4a3cfd9b16e4d07c, %Struct_lang_2Eatomic_AtomicInt_4a3cfd9b16e4d07c, ptr }
%Struct_std_2Ecore_2Earc_ArcBox_53a4e98f36ae3d4e = type { %Struct_std_2Ecore_2Earc_ArcHeader_363bcf8619c06fdd, %Struct_std_2Esync_AtomicBool_881cc492ae8213fb }
%Struct_std_2Econcurrent_Mutex_d7f34c574102f8fe = type { %Struct_lang_2Eatomic_AtomicBool_4466cda2157b83d3, %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79 }
%Struct_std_2Ecore_2Earc_ArcBox_431f4747e835d3fd = type { %Struct_std_2Ecore_2Earc_ArcHeader_363bcf8619c06fdd, %Struct_std_2Econcurrent_Mutex_d7f34c574102f8fe }
%Struct_std_2Econcurrent___lambda_env_cb_spawn_cb__inst__5634e65d835e6c93_0_0_6efcf5ee02e3b4f9 = type { %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb, %DriftIface }
%Struct_std_2Emem_RawBuffer_990b24422b696aa0 = type { ptr, i64 }
%Struct_std_2Emem_RawBuffer_60df697c729ca487 = type { ptr, i64 }
%Struct_std_2Emem_RawBuffer_e4b983166d45ea7e = type { ptr, i64 }
%Struct_std_2Emem_RawBuffer_da7fe2d88f7ba0fa = type { ptr, i64 }

@__drift_compiler_build = internal constant [159 x i8] [i8 100, i8 114, i8 105, i8 102, i8 116, i8 99, i8 32, i8 48, i8 46, i8 51, i8 51, i8 46, i8 52, i8 53, i8 32, i8 124, i8 32, i8 97, i8 98, i8 105, i8 32, i8 49, i8 55, i8 32, i8 124, i8 32, i8 119, i8 111, i8 114, i8 100, i8 32, i8 54, i8 52, i8 32, i8 124, i8 32, i8 103, i8 105, i8 116, i8 32, i8 48, i8 49, i8 99, i8 101, i8 101, i8 50, i8 54, i8 54, i8 32, i8 124, i8 32, i8 112, i8 114, i8 111, i8 102, i8 105, i8 108, i8 101, i8 32, i8 111, i8 112, i8 116, i8 105, i8 109, i8 105, i8 122, i8 101, i8 100, i8 32, i8 124, i8 32, i8 118, i8 101, i8 110, i8 100, i8 111, i8 114, i8 32, i8 84, i8 104, i8 101, i8 32, i8 68, i8 114, i8 105, i8 102, i8 116, i8 32, i8 76, i8 97, i8 110, i8 103, i8 117, i8 97, i8 103, i8 101, i8 32, i8 70, i8 111, i8 117, i8 110, i8 100, i8 97, i8 116, i8 105, i8 111, i8 110, i8 32, i8 124, i8 32, i8 108, i8 105, i8 99, i8 101, i8 110, i8 115, i8 101, i8 32, i8 71, i8 80, i8 76, i8 45, i8 51, i8 46, i8 48, i8 32, i8 124, i8 32, i8 98, i8 117, i8 105, i8 108, i8 100, i8 95, i8 117, i8 116, i8 99, i8 32, i8 50, i8 48, i8 50, i8 54, i8 45, i8 48, i8 54, i8 45, i8 50, i8 49, i8 84, i8 48, i8 49, i8 58, i8 53, i8 55, i8 58, i8 51, i8 54, i8 90, i8 0], align 1
@.str1 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str2 = private unnamed_addr constant { i64, i64, [16 x i8] } { i64 1, i64 1, [16 x i8] c"std.core:String\00" }
@.str3 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str4 = private unnamed_addr constant { i64, i64, [21 x i8] } { i64 1, i64 1, [21 x i8] c"std.containers:Array\00" }
@.str5 = private unnamed_addr constant { i64, i64, [12 x i8] } { i64 1, i64 1, [12 x i8] c"would_block\00" }
@.str6 = private unnamed_addr constant { i64, i64, [12 x i8] } { i64 1, i64 1, [12 x i8] c"would_block\00" }
@.str7 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str8 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str9 = private unnamed_addr constant { i64, i64, [19 x i8] } { i64 1, i64 1, [19 x i8] c"std.err:IndexError\00" }
@.str10 = private unnamed_addr constant { i64, i64, [21 x i8] } { i64 1, i64 1, [21 x i8] c"std.containers:Array\00" }
@.str11 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str12 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str13 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str14 = private unnamed_addr constant { i64, i64, [10 x i8] } { i64 1, i64 1, [10 x i8] c"127.0.0.1\00" }
@.str15 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str16 = private unnamed_addr constant { i64, i64, [10 x i8] } { i64 1, i64 1, [10 x i8] c"127.0.0.1\00" }
@.str17 = private unnamed_addr constant { i64, i64, [18 x i8] } { i64 1, i64 1, [18 x i8] c"std.mem:RawBuffer\00" }
@__drift_cb_vtable_e5b105eafca2549d = private constant %DriftCallbackVTable [ ptr @__drift_cb_drop_e5b105eafca2549d, ptr @__drift_cb_thunk_e5b105eafca2549d ]
@.str19 = private unnamed_addr constant { i64, i64, [3 x i8] } { i64 1, i64 1, [3 x i8] c"A1\00" }
@.str20 = private unnamed_addr constant { i64, i64, [3 x i8] } { i64 1, i64 1, [3 x i8] c"A1\00" }
@.str21 = private unnamed_addr constant { i64, i64, [3 x i8] } { i64 1, i64 1, [3 x i8] c"B1\00" }
@.str22 = private unnamed_addr constant { i64, i64, [3 x i8] } { i64 1, i64 1, [3 x i8] c"B1\00" }
@.str23 = private unnamed_addr constant { i64, i64, [3 x i8] } { i64 1, i64 1, [3 x i8] c"A2\00" }
@.str24 = private unnamed_addr constant { i64, i64, [3 x i8] } { i64 1, i64 1, [3 x i8] c"A2\00" }
@.str25 = private unnamed_addr constant { i64, i64, [15 x i8] } { i64 1, i64 1, [15 x i8] c"SPIKE FAIL rc=\00" }
@.str26 = private unnamed_addr constant { i64, i64, [9 x i8] } { i64 1, i64 1, [9 x i8] c"SPIKE OK\00" }
@.str27 = private unnamed_addr constant { i64, i64, [14 x i8] } { i64 1, i64 1, [14 x i8] c"listen failed\00" }
@.str28 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str29 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str30 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str31 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str32 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str33 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str34 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str35 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str36 = private unnamed_addr constant { i64, i64, [31 x i8] } { i64 1, i64 1, [31 x i8] c"std.concurrent:InvalidDuration\00" }
@.str37 = private unnamed_addr constant { i64, i64, [7 x i8] } { i64 1, i64 1, [7 x i8] c"failed\00" }
@.str38 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str39 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str40 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str41 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str42 = private unnamed_addr constant { i64, i64, [8 x i8] } { i64 1, i64 1, [8 x i8] c"timeout\00" }
@.str43 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str44 = private unnamed_addr constant { i64, i64, [2 x i8] } { i64 1, i64 1, [2 x i8] c"{\00" }
@.str45 = private unnamed_addr constant { i64, i64, [8 x i8] } { i64 1, i64 1, [8 x i8] c"\22code\22:\00" }
@.str46 = private unnamed_addr constant { i64, i64, [2 x i8] } { i64 1, i64 1, [2 x i8] c"}\00" }
@.str47 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str48 = private unnamed_addr constant { i64, i64, [2 x i8] } { i64 1, i64 1, [2 x i8] c"{\00" }
@.str49 = private unnamed_addr constant { i64, i64, [10 x i8] } { i64 1, i64 1, [10 x i8] c"\22millis\22:\00" }
@.str50 = private unnamed_addr constant { i64, i64, [2 x i8] } { i64 1, i64 1, [2 x i8] c"}\00" }
@.str51 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str52 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str53 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str54 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str55 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str56 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str57 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str58 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str59 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str60 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str61 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str62 = private unnamed_addr constant { i64, i64, [2 x i8] } { i64 1, i64 1, [2 x i8] c"F\00" }
@.str63 = private unnamed_addr constant { i64, i64, [2 x i8] } { i64 1, i64 1, [2 x i8] c"E\00" }
@.str64 = private unnamed_addr constant { i64, i64, [2 x i8] } { i64 1, i64 1, [2 x i8] c"D\00" }
@.str65 = private unnamed_addr constant { i64, i64, [2 x i8] } { i64 1, i64 1, [2 x i8] c"C\00" }
@.str66 = private unnamed_addr constant { i64, i64, [2 x i8] } { i64 1, i64 1, [2 x i8] c"B\00" }
@.str67 = private unnamed_addr constant { i64, i64, [2 x i8] } { i64 1, i64 1, [2 x i8] c"A\00" }
@.str68 = private unnamed_addr constant { i64, i64, [2 x i8] } { i64 1, i64 1, [2 x i8] c"9\00" }
@.str69 = private unnamed_addr constant { i64, i64, [2 x i8] } { i64 1, i64 1, [2 x i8] c"8\00" }
@.str70 = private unnamed_addr constant { i64, i64, [2 x i8] } { i64 1, i64 1, [2 x i8] c"7\00" }
@.str71 = private unnamed_addr constant { i64, i64, [2 x i8] } { i64 1, i64 1, [2 x i8] c"6\00" }
@.str72 = private unnamed_addr constant { i64, i64, [2 x i8] } { i64 1, i64 1, [2 x i8] c"5\00" }
@.str73 = private unnamed_addr constant { i64, i64, [2 x i8] } { i64 1, i64 1, [2 x i8] c"4\00" }
@.str74 = private unnamed_addr constant { i64, i64, [2 x i8] } { i64 1, i64 1, [2 x i8] c"3\00" }
@.str75 = private unnamed_addr constant { i64, i64, [2 x i8] } { i64 1, i64 1, [2 x i8] c"2\00" }
@.str76 = private unnamed_addr constant { i64, i64, [2 x i8] } { i64 1, i64 1, [2 x i8] c"1\00" }
@.str77 = private unnamed_addr constant { i64, i64, [2 x i8] } { i64 1, i64 1, [2 x i8] c"0\00" }
@.str78 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str79 = private unnamed_addr constant { i64, i64, [2 x i8] } { i64 1, i64 1, [2 x i8] c"\22\00" }
@.str80 = private unnamed_addr constant { i64, i64, [2 x i8] } { i64 1, i64 1, [2 x i8] c"\22\00" }
@.str81 = private unnamed_addr constant { i64, i64, [5 x i8] } { i64 1, i64 1, [5 x i8] c"\5Cu00\00" }
@.str82 = private unnamed_addr constant { i64, i64, [3 x i8] } { i64 1, i64 1, [3 x i8] c"\5Ct\00" }
@.str83 = private unnamed_addr constant { i64, i64, [3 x i8] } { i64 1, i64 1, [3 x i8] c"\5Cr\00" }
@.str84 = private unnamed_addr constant { i64, i64, [3 x i8] } { i64 1, i64 1, [3 x i8] c"\5Cn\00" }
@.str85 = private unnamed_addr constant { i64, i64, [3 x i8] } { i64 1, i64 1, [3 x i8] c"\5Cf\00" }
@.str86 = private unnamed_addr constant { i64, i64, [3 x i8] } { i64 1, i64 1, [3 x i8] c"\5Cb\00" }
@.str87 = private unnamed_addr constant { i64, i64, [3 x i8] } { i64 1, i64 1, [3 x i8] c"\5C\5C\00" }
@.str88 = private unnamed_addr constant { i64, i64, [3 x i8] } { i64 1, i64 1, [3 x i8] c"\5C\22\00" }
@.str89 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str90 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str91 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str92 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str93 = private unnamed_addr constant { i64, i64, [2 x i8] } { i64 1, i64 1, [2 x i8] c"{\00" }
@.str94 = private unnamed_addr constant { i64, i64, [16 x i8] } { i64 1, i64 1, [16 x i8] c"\22container_id\22:\00" }
@.str95 = private unnamed_addr constant { i64, i64, [2 x i8] } { i64 1, i64 1, [2 x i8] c",\00" }
@.str96 = private unnamed_addr constant { i64, i64, [9 x i8] } { i64 1, i64 1, [9 x i8] c"\22index\22:\00" }
@.str97 = private unnamed_addr constant { i64, i64, [2 x i8] } { i64 1, i64 1, [2 x i8] c"}\00" }
@.str98 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str99 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str100 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str101 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str102 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str103 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str104 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str105 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str106 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str107 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str108 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str109 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str110 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str111 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str112 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str113 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str114 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str115 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str116 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str117 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str118 = private unnamed_addr constant { i64, i64, [6 x i8] } { i64 1, i64 1, [6 x i8] c"errno\00" }
@.str119 = private unnamed_addr constant { i64, i64, [6 x i8] } { i64 1, i64 1, [6 x i8] c"errno\00" }
@.str120 = private unnamed_addr constant { i64, i64, [6 x i8] } { i64 1, i64 1, [6 x i8] c"errno\00" }
@.str121 = private unnamed_addr constant { i64, i64, [17 x i8] } { i64 1, i64 1, [17 x i8] c"requires_vthread\00" }
@.str122 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str123 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str124 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str125 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str126 = private unnamed_addr constant { i64, i64, [6 x i8] } { i64 1, i64 1, [6 x i8] c"errno\00" }
@.str127 = private unnamed_addr constant { i64, i64, [12 x i8] } { i64 1, i64 1, [12 x i8] c"would_block\00" }
@.str128 = private unnamed_addr constant { i64, i64, [12 x i8] } { i64 1, i64 1, [12 x i8] c"would_block\00" }
@.str129 = private unnamed_addr constant { i64, i64, [17 x i8] } { i64 1, i64 1, [17 x i8] c"requires_vthread\00" }
@.str130 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str131 = private unnamed_addr constant { i64, i64, [6 x i8] } { i64 1, i64 1, [6 x i8] c"errno\00" }
@.str132 = private unnamed_addr constant { i64, i64, [12 x i8] } { i64 1, i64 1, [12 x i8] c"would_block\00" }
@.str133 = private unnamed_addr constant { i64, i64, [12 x i8] } { i64 1, i64 1, [12 x i8] c"would_block\00" }
@.str134 = private unnamed_addr constant { i64, i64, [17 x i8] } { i64 1, i64 1, [17 x i8] c"requires_vthread\00" }
@.str135 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str136 = private unnamed_addr constant { i64, i64, [6 x i8] } { i64 1, i64 1, [6 x i8] c"errno\00" }
@.str137 = private unnamed_addr constant { i64, i64, [12 x i8] } { i64 1, i64 1, [12 x i8] c"would_block\00" }
@.str138 = private unnamed_addr constant { i64, i64, [12 x i8] } { i64 1, i64 1, [12 x i8] c"would_block\00" }
@.str139 = private unnamed_addr constant { i64, i64, [17 x i8] } { i64 1, i64 1, [17 x i8] c"requires_vthread\00" }
@.str140 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str141 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str142 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str143 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str144 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str145 = private unnamed_addr constant { i64, i64, [6 x i8] } { i64 1, i64 1, [6 x i8] c"errno\00" }
@.str146 = private unnamed_addr constant { i64, i64, [12 x i8] } { i64 1, i64 1, [12 x i8] c"would_block\00" }
@.str147 = private unnamed_addr constant { i64, i64, [12 x i8] } { i64 1, i64 1, [12 x i8] c"would_block\00" }
@.str148 = private unnamed_addr constant { i64, i64, [17 x i8] } { i64 1, i64 1, [17 x i8] c"requires_vthread\00" }
@.str149 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str150 = private unnamed_addr constant { i64, i64, [6 x i8] } { i64 1, i64 1, [6 x i8] c"errno\00" }
@.str151 = private unnamed_addr constant { i64, i64, [12 x i8] } { i64 1, i64 1, [12 x i8] c"would_block\00" }
@.str152 = private unnamed_addr constant { i64, i64, [12 x i8] } { i64 1, i64 1, [12 x i8] c"would_block\00" }
@.str153 = private unnamed_addr constant { i64, i64, [17 x i8] } { i64 1, i64 1, [17 x i8] c"requires_vthread\00" }
@.str154 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str155 = private unnamed_addr constant { i64, i64, [6 x i8] } { i64 1, i64 1, [6 x i8] c"errno\00" }
@.str156 = private unnamed_addr constant { i64, i64, [12 x i8] } { i64 1, i64 1, [12 x i8] c"would_block\00" }
@.str157 = private unnamed_addr constant { i64, i64, [12 x i8] } { i64 1, i64 1, [12 x i8] c"would_block\00" }
@.str158 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str159 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str160 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str161 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str162 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str163 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str164 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str165 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str166 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str167 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str168 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str169 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str170 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str171 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@__drift_cb_vtable_bf7194e0203c57a4 = private constant %DriftCallbackVTable [ ptr @__drift_cb_drop_bf7194e0203c57a4, ptr @__drift_cb_thunk_bf7194e0203c57a4 ]
@.str173 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str174 = private unnamed_addr constant { i64, i64, [10 x i8] } { i64 1, i64 1, [10 x i8] c"cancelled\00" }
@.str175 = private unnamed_addr constant { i64, i64, [32 x i8] } { i64 1, i64 1, [32 x i8] c"std.concurrent:ExecSubmitFailed\00" }
@.str176 = private unnamed_addr constant { i64, i64, [7 x i8] } { i64 1, i64 1, [7 x i8] c"failed\00" }
@.str177 = private unnamed_addr constant { i64, i64, [7 x i8] } { i64 1, i64 1, [7 x i8] c"closed\00" }
@.str178 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@__drift_cb_vtable_2630cdd29808534f = private constant %DriftCallbackVTable [ ptr null, ptr @__drift_cb_thunk_2630cdd29808534f ]
@.str180 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str181 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@__drift_cb_vtable_6ddab27c65ae55c9 = private constant %DriftCallbackVTable [ ptr null, ptr @__drift_cb_thunk_6ddab27c65ae55c9 ]
@.str183 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str184 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@__drift_cb_vtable_c13a8bf15f11890e = private constant %DriftCallbackVTable [ ptr null, ptr @__drift_cb_thunk_c13a8bf15f11890e ]
@.str186 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str187 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str188 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str189 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str190 = private unnamed_addr constant { i64, i64, [32 x i8] } { i64 1, i64 1, [32 x i8] c"std.concurrent@concurrent.drift\00" }
@.str191 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str192 = private unnamed_addr constant { i64, i64, [98 x i8] } { i64 1, i64 1, [98 x i8] c"MutexGuard.get_mut called on unlocked guard (Condvar unlock_for_condvar without matching relock?)\00" }
@.str193 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str194 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str195 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str196 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str197 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str198 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str199 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str200 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str201 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str202 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str203 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str204 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@.str205 = private unnamed_addr constant { i64, i64, [1 x i8] } { i64 1, i64 1, [1 x i8] c"\00" }
@drift_root_argc = internal global i32 0
@drift_root_argv = internal global ptr null

$"std.concurrent::Mutex<T>::lock__inst__2026c6e8047a5d49" = comdat any
$"std.concurrent::MutexGuard<T>::get_mut__inst__8bbc1086c0f79eaa" = comdat any
$"std.concurrent::MutexGuard<T>::std.core.Destructible::destroy__inst__690dc3eee478c1e7" = comdat any
$"std.concurrent::ResultState<T>::std.core.Destructible::destroy__inst__d85c418601eb1d2e" = comdat any
$"std.concurrent::VirtualThread<T>::join__inst__21bbbc8cde113920" = comdat any
$"std.concurrent::VirtualThread<T>::std.core.Destructible::destroy__inst__226883066d11622f" = comdat any
$"std.concurrent::_make_result_state__inst__06225674fb98e7e5" = comdat any
$"std.concurrent::_publish_or_drop__inst__6e175d0504d59ca9" = comdat any
$"std.concurrent::mutex__inst__ad4e1b08d6b01d98" = comdat any
$"std.concurrent::spawn_cb__inst__5634e65d835e6c93" = comdat any
$"std.core.arc::_arc_clone_impl__inst__4c704b39c5bb904c" = comdat any
$"std.core.arc::_arc_clone_impl__inst__d192354fe9e7c4b5" = comdat any
$"std.core.arc::_arc_destroy_impl__inst__0a6d34c7cbe9c09f" = comdat any
$"std.core.arc::_arc_destroy_impl__inst__5c35dfb564641e17" = comdat any
$"std.core.arc::_arc_drop_thunk_for__inst__361a475bfe08ec3d" = comdat any
$"std.core.arc::_arc_drop_thunk_for__inst__d6c21c3166e361db" = comdat any
$"std.core.arc::_arc_get_impl__inst__8fb0d984495d10c9" = comdat any
$"std.core.arc::_arc_get_impl__inst__fc66586b6a63dfdc" = comdat any
$"std.core.arc::arc__inst__64ac3d24898720d1" = comdat any
$"std.core.arc::arc__inst__78ca7f72bfd04c5c" = comdat any
$"std.runtime::GlobalRegistry::set__inst__2f0a2cb7c747e9a4" = comdat any
$"std.runtime::GlobalRegistry::set__inst__79cf2420baaed150" = comdat any
$"std.runtime::GlobalRegistry::set__inst__8e3703659a16d399" = comdat any
$"std.runtime::_typebox_drop_impl__inst__4bf6730b0c402e1c" = comdat any
$"std.runtime::_typebox_drop_impl__inst__c197df4173b25317" = comdat any
$"std.runtime::_typebox_drop_impl__inst__e0682510f2f4b328" = comdat any
$"std.runtime::contains__inst__366e997d63749372" = comdat any
$"std.runtime::contains__inst__a4a44818e3c6431b" = comdat any
$"std.runtime::contains__inst__d6e7556221403df5" = comdat any

declare void @drift_build_argv(ptr, i32, ptr)

declare i64 @drift_run_main_on_vt(ptr)

declare ptr @drift_alloc_array(i64, i64, i64, i64)
declare void @drift_free_array(ptr)
declare void @drift_cb_env_free(ptr)
declare void @drift_bounds_check(%DriftString, i64, i64)
declare void @drift_bounds_check_fail(%DriftString, i64, i64)
declare void @drift_array_byte_commit_init_len(ptr, i64)

declare ptr @malloc(i64)
declare void @free(ptr)
define weak ptr @drift_iface_alloc(i64 %size, i64 %align) {
__bb_entry:
  %p = call ptr @malloc(i64 %size)
  ret ptr %p
}
define weak void @drift_iface_free(ptr %p) {
__bb_entry:
  call void @free(ptr %p)
  ret void
}

declare i1 @drift_string_eq(%DriftString, %DriftString)
declare i32 @drift_string_cmp(%DriftString, %DriftString)
declare %DriftString @drift_string_concat(%DriftString, %DriftString)
declare %DriftString @drift_string_from_int64(i64)
declare %DriftString @drift_string_from_utf8_bytes(ptr, i64)
declare %DriftString @drift_string_retain(%DriftString)
declare void @drift_string_release(%DriftString)

declare i64 @drift_thread_spawn(ptr, i64)
declare void @drift_thread_join(i64)
declare i64 @drift_thread_join_timeout(i64, i64)
declare i64 @drift_thread_is_completed(i64)
declare i64 @drift_thread_cancel(i64)
declare void @drift_thread_drop(i64)
declare void @drift_exec_submit_test_override(i64)
declare i64 @drift_exec_get_running(i64)
declare i64 @drift_thread_current()
declare void @drift_thread_park(i64)
declare void @drift_thread_park_until(i64)
declare void @drift_thread_set_wait(i64, i64)
declare void @drift_thread_unpark(i64)
declare void @drift_thread_yield()
declare i64 @drift_exec_default_get()
declare void @drift_exec_default_set(i64)
declare i64 @drift_exec_create(i64, i64, i64, i64, i64, i64)
declare i64 @drift_exec_submit(i64, i64)
declare i64 @drift_reactor_default_get()
declare void @drift_reactor_default_set(i64)
declare void @drift_reactor_register_io(i64, i64, i64, i64)
declare void @drift_reactor_register_timer(i64, i64)
declare i64 @drift_reactor_check_pending(i64, i64)
declare i64 @drift_reactor_io_charge(i64, i64, i64)
declare i64 @drift_io_open(%DriftString, i64, i64)
declare i64 @drift_io_close(i64)
declare i64 @drift_io_read(i64, ptr, i64)
declare i64 @drift_io_write(i64, ptr, i64)
declare i64 @drift_io_errno()
declare i64 @drift_io_set_nonblocking(i64)
declare i64 @drift_fs_read_dir(%DriftString, i64)
declare i64 @drift_fs_result_status(i64)
declare i64 @drift_fs_result_errno(i64)
declare i64 @drift_fs_result_count(i64)
declare %DriftString @drift_fs_result_name(i64, i64)
declare i64 @drift_fs_result_kind(i64, i64)
declare i64 @drift_fs_result_free(i64)
declare i64 @drift_fs_test_walk_entries()
declare i64 @drift_vt_test_direct_resume_claims()
declare ptr @drift_runtime_global_registry_ptr()
declare ptr @drift_runtime_thread_registry_ptr()
declare i64 @drift_runtime_registry_set(i64, ptr, ptr byval(%DriftIface) align 8)
declare i64 @drift_runtime_registry_contains(i64)
declare ptr @drift_runtime_registry_get(i64)
declare i64 @drift_runtime_thread_registry_set(i64, ptr, ptr byval(%DriftIface) align 8)
declare i64 @drift_runtime_thread_registry_contains(i64)
declare ptr @drift_runtime_thread_registry_get(i64)
declare i64 @drift_net_listen(ptr, i64)
declare i64 @drift_net_accept(i64)
declare i64 @drift_net_connect(ptr, i64, i64)
declare i64 @drift_net_listener_port(i64)
declare i64 @drift_net_set_nodelay(i64, i64)
declare i64 @drift_net_get_nodelay(i64)
declare i64 @drift_net_udp_local_port(i64)
declare i64 @drift_net_udp_bind(ptr, i64)
declare i64 @drift_net_udp_bind_v6(ptr, i64)
declare i64 @drift_net_udp_send_to(i64, ptr, i64, ptr, i64)
declare i64 @drift_net_udp_send_to_v6(i64, ptr, i64, ptr, i64)
declare i64 @drift_net_udp_recv_from(i64, ptr, i64, ptr, ptr)
declare i64 @drift_net_udp_recv_from_v6(i64, ptr, i64, ptr, ptr)
declare i64 @drift_time_now_ms()
declare i64 @drift_time_now_us()
declare i64 @drift_time_now_utc_us()
declare i64 @drift_test_eventfd_create()
declare void @drift_test_eventfd_write(i64, i64)
declare i64 @drift_test_timerfd_create()
declare void @drift_test_timerfd_set(i64, i64)
declare i64 @drift_random_fill(ptr, i64)
declare %DriftString @drift_env_get(%DriftString)
declare i64 @drift_env_has(%DriftString)
declare i64 @drift_signal_await()
declare i64 @drift_thread_vtid()
declare i64 @drift_thread_tid()
declare i64 @drift_thread_is_cancelled()

declare i8 @drift_atomic_load_bool(ptr, i64)
declare void @drift_atomic_store_bool(ptr, i8, i64)
declare i8 @drift_atomic_exchange_bool(ptr, i8, i64)
declare i8 @drift_atomic_compare_exchange_bool(ptr, i8, i8, i64, i64)
declare i8 @drift_atomic_compare_exchange_observed_bool(ptr, i8, i8, i64, i64)
declare i64 @drift_atomic_load_int(ptr, i64)
declare void @drift_atomic_store_int(ptr, i64, i64)
declare i64 @drift_atomic_exchange_int(ptr, i64, i64)
declare i8 @drift_atomic_compare_exchange_int(ptr, i64, i64, i64, i64)
declare i64 @drift_atomic_compare_exchange_observed_int(ptr, i64, i64, i64, i64)
declare i64 @drift_atomic_fetch_add_int(ptr, i64, i64)
declare i64 @drift_atomic_fetch_sub_int(ptr, i64, i64)
declare i64 @drift_atomic_load_uint(ptr, i64)
declare void @drift_atomic_store_uint(ptr, i64, i64)
declare i64 @drift_atomic_exchange_uint(ptr, i64, i64)
declare i8 @drift_atomic_compare_exchange_uint(ptr, i64, i64, i64, i64)
declare i64 @drift_atomic_compare_exchange_observed_uint(ptr, i64, i64, i64, i64)
declare i64 @drift_atomic_fetch_add_uint(ptr, i64, i64)
declare i64 @drift_atomic_fetch_sub_uint(ptr, i64, i64)
declare i64 @drift_atomic_load_uint64(ptr, i64)
declare void @drift_atomic_store_uint64(ptr, i64, i64)
declare i64 @drift_atomic_exchange_uint64(ptr, i64, i64)
declare i8 @drift_atomic_compare_exchange_uint64(ptr, i64, i64, i64, i64)
declare i64 @drift_atomic_compare_exchange_observed_uint64(ptr, i64, i64, i64, i64)
declare i64 @drift_atomic_fetch_add_uint64(ptr, i64, i64)
declare i64 @drift_atomic_fetch_sub_uint64(ptr, i64, i64)
declare void @drift_atomic_thread_fence(i64)
declare void @drift_atomic_signal_fence(i64)

define weak ptr @drift_error_new(i64 %code, %DriftString %event) {
__bb_entry:
  ret ptr null
}
define weak void @drift_error_release(ptr %err) {
__bb_entry:
  ret void
}
declare void @drift_error_raise(ptr)
declare %DriftString @drift_error_get_params_json(ptr)
declare void @drift_error_set_params_json(ptr, %DriftString)
declare %DriftString @drift_error_get_context_json(ptr)
declare void @drift_error_append_context_frame(ptr, %DriftString)

declare void @drift_assert_loc(i1, %DriftString, i64, %DriftString, %DriftString)

declare void @llvm.trap()

declare void @__drift_rt_abi_version_17()

define internal void @__drift_abi_check() {
__bb_entry:
  call void @__drift_rt_abi_version_17()
  ret void
}

@llvm.global_ctors = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 65535, ptr @__drift_abi_check, ptr null }]

@llvm.used = appending global [1 x ptr] [ptr @__drift_compiler_build], section "llvm.metadata"

define %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 @"spike::_to_buf"(ptr %s_1) {
.bb.entry:
  %b__addr = alloca %Struct_std_2Eio_Buffer_e76b5c24b140f2f4
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str1, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = call i64 @"std.core::String::byte_length"(ptr %s_1)
  %.t5 = call %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 @"std.io::buffer"(i64 %.t3)
  store %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %.t5, ptr %b__addr
  %.t6 = add i64 0, 0
  br label %.bb.loop_header
.bb.loop_header:
  %i_2 = phi i64 [ %.t6, %.bb.entry ], [ %.t18, %.bb.if_join ]
  br label %.bb.loop_body
.bb.loop_body:
  %.t9 = icmp slt i64 %i_2, %.t3
  br i1 %.t9, label %.bb.if_then, label %.bb.if_else
.bb.if_else:
  br label %.bb.loop_exit
.bb.loop_exit:
  %.t19 = load %Struct_std_2Eio_Buffer_e76b5c24b140f2f4, ptr %b__addr
  %zero_struct3 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 zeroinitializer, %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c zeroinitializer, 0
  %zero_struct4 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %zero_struct3, i64 0, 1
  %__arc1 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %zero_struct4, i64 0, 2
  store %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %__arc1, ptr %b__addr
  ret %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %.t19
.bb.if_then:
  %.t13 = load %DriftString, ptr %s_1
  %len5 = extractvalue %DriftString %.t13, 0
  %data6 = extractvalue %DriftString %.t13, 1
  %strptr7 = getelementptr inbounds { i64, i64, [16 x i8] }, ptr @.str2, i32 0, i32 2, i32 0
  %str08 = insertvalue %DriftString zeroinitializer, i64 15, 0
  %str9 = insertvalue %DriftString %str08, ptr %strptr7, 1
  call void @drift_bounds_check(%DriftString %str9, i64 %i_2, i64 %len5)
  %ptr10 = getelementptr i8, ptr %data6, i64 %i_2
  %.t15 = load i8, ptr %ptr10
  call void @"std.io::buffer_write"(ptr %b__addr, i64 %i_2, i8 %.t15)
  %.t17 = add i64 0, 1
  %.t18 = add i64 %i_2, %.t17
  br label %.bb.if_join
.bb.if_join:
  br label %.bb.loop_header
}
define void @__drift_array_drop_std__std_core_Result_Void_std__std_net_NetError__9dbf2dcdb5537ee6(i64 %len, ptr %data) {
  %idx_ptr1 = alloca i64
  store i64 0, ptr %idx_ptr1
  br label %arr_drop_cond2
arr_drop_cond2:
  %idx5 = load i64, ptr %idx_ptr1
  %idx_ok6 = icmp slt i64 %idx5, %len
  br i1 %idx_ok6, label %arr_drop_body3, label %arr_drop_done4
arr_drop_body3:
  %idxv7 = load i64, ptr %idx_ptr1
  %eltptr8 = getelementptr inbounds %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6, ptr %data, i64 %idxv7
  %old9 = load %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6, ptr %eltptr8
  %tag10 = extractvalue %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 %old9, 0
  switch i8 %tag10, label %drop_bad12 [ i8 0, label %drop_ok13 i8 1, label %drop_err14 i8 2, label %drop_tombstone15 ]
drop_ok13:
  %variant16 = alloca %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6
  store %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 %old9, ptr %variant16
  %payload_words17 = getelementptr inbounds %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6, ptr %variant16, i32 0, i32 2
  br label %drop_done11
drop_err14:
  %variant18 = alloca %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6
  store %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 %old9, ptr %variant18
  %payload_words19 = getelementptr inbounds %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6, ptr %variant18, i32 0, i32 2
  %fieldptr20 = getelementptr inbounds { %Struct_std_2Enet_NetError_203564604ea2d3a4 }, ptr %payload_words19, i32 0, i32 0
  %field21 = load %Struct_std_2Enet_NetError_203564604ea2d3a4, ptr %fieldptr20
  %field22 = extractvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %field21, 0
  call void @drift_string_release(%DriftString %field22)
  br label %drop_done11
drop_tombstone15:
  br label %drop_done11
drop_bad12:
  call void @llvm.trap()
  unreachable
drop_done11:
  %idx_next23 = add i64 %idxv7, 1
  store i64 %idx_next23, ptr %idx_ptr1
  br label %arr_drop_cond2
arr_drop_done4:
  ret void
}
define void @__drift_array_drop_std__std_core_Result_Void_std__std_concurrent_ConcurrencyError__4861f1d1d2eeba72(i64 %len, ptr %data) {
  %idx_ptr1 = alloca i64
  store i64 0, ptr %idx_ptr1
  br label %arr_drop_cond2
arr_drop_cond2:
  %idx5 = load i64, ptr %idx_ptr1
  %idx_ok6 = icmp slt i64 %idx5, %len
  br i1 %idx_ok6, label %arr_drop_body3, label %arr_drop_done4
arr_drop_body3:
  %idxv7 = load i64, ptr %idx_ptr1
  %eltptr8 = getelementptr inbounds %Variant_std_2Ecore_Result_4861f1d1d2eeba72, ptr %data, i64 %idxv7
  %old9 = load %Variant_std_2Ecore_Result_4861f1d1d2eeba72, ptr %eltptr8
  %tag10 = extractvalue %Variant_std_2Ecore_Result_4861f1d1d2eeba72 %old9, 0
  switch i8 %tag10, label %drop_bad12 [ i8 0, label %drop_ok13 i8 1, label %drop_err14 i8 2, label %drop_tombstone15 ]
drop_ok13:
  %variant16 = alloca %Variant_std_2Ecore_Result_4861f1d1d2eeba72
  store %Variant_std_2Ecore_Result_4861f1d1d2eeba72 %old9, ptr %variant16
  %payload_words17 = getelementptr inbounds %Variant_std_2Ecore_Result_4861f1d1d2eeba72, ptr %variant16, i32 0, i32 2
  br label %drop_done11
drop_err14:
  %variant18 = alloca %Variant_std_2Ecore_Result_4861f1d1d2eeba72
  store %Variant_std_2Ecore_Result_4861f1d1d2eeba72 %old9, ptr %variant18
  %payload_words19 = getelementptr inbounds %Variant_std_2Ecore_Result_4861f1d1d2eeba72, ptr %variant18, i32 0, i32 2
  %fieldptr20 = getelementptr inbounds { %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 }, ptr %payload_words19, i32 0, i32 0
  %field21 = load %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204, ptr %fieldptr20
  %field22 = extractvalue %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 %field21, 0
  call void @drift_string_release(%DriftString %field22)
  br label %drop_done11
drop_tombstone15:
  br label %drop_done11
drop_bad12:
  call void @llvm.trap()
  unreachable
drop_done11:
  %idx_next23 = add i64 %idxv7, 1
  store i64 %idx_next23, ptr %idx_ptr1
  br label %arr_drop_cond2
arr_drop_done4:
  ret void
}
define void @__drift_array_drop_std__std_core_Result_Int_std__std_net_NetError__ccaaf7910bb23f6d(i64 %len, ptr %data) {
  %idx_ptr1 = alloca i64
  store i64 0, ptr %idx_ptr1
  br label %arr_drop_cond2
arr_drop_cond2:
  %idx5 = load i64, ptr %idx_ptr1
  %idx_ok6 = icmp slt i64 %idx5, %len
  br i1 %idx_ok6, label %arr_drop_body3, label %arr_drop_done4
arr_drop_body3:
  %idxv7 = load i64, ptr %idx_ptr1
  %eltptr8 = getelementptr inbounds %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %data, i64 %idxv7
  %old9 = load %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %eltptr8
  %tag10 = extractvalue %Variant_std_2Ecore_Result_ccaaf7910bb23f6d %old9, 0
  switch i8 %tag10, label %drop_bad12 [ i8 0, label %drop_ok13 i8 1, label %drop_err14 i8 2, label %drop_tombstone15 ]
drop_ok13:
  %variant16 = alloca %Variant_std_2Ecore_Result_ccaaf7910bb23f6d
  store %Variant_std_2Ecore_Result_ccaaf7910bb23f6d %old9, ptr %variant16
  %payload_words17 = getelementptr inbounds %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %variant16, i32 0, i32 2
  br label %drop_done11
drop_err14:
  %variant18 = alloca %Variant_std_2Ecore_Result_ccaaf7910bb23f6d
  store %Variant_std_2Ecore_Result_ccaaf7910bb23f6d %old9, ptr %variant18
  %payload_words19 = getelementptr inbounds %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %variant18, i32 0, i32 2
  %fieldptr20 = getelementptr inbounds { %Struct_std_2Enet_NetError_203564604ea2d3a4 }, ptr %payload_words19, i32 0, i32 0
  %field21 = load %Struct_std_2Enet_NetError_203564604ea2d3a4, ptr %fieldptr20
  %field22 = extractvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %field21, 0
  call void @drift_string_release(%DriftString %field22)
  br label %drop_done11
drop_tombstone15:
  br label %drop_done11
drop_bad12:
  call void @llvm.trap()
  unreachable
drop_done11:
  %idx_next23 = add i64 %idxv7, 1
  store i64 %idx_next23, ptr %idx_ptr1
  br label %arr_drop_cond2
arr_drop_done4:
  ret void
}
define i64 @"spike::_echo_serve"(%Struct_std_2Enet_TcpListener_7d3d9b3ee7d65cad %listener, %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba %stopped) {
.bb.entry:
  %listener__addr = alloca %Struct_std_2Enet_TcpListener_7d3d9b3ee7d65cad
  store %Struct_std_2Enet_TcpListener_7d3d9b3ee7d65cad %listener, ptr %listener__addr
  %stopped__addr = alloca %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba
  store %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba %stopped, ptr %stopped__addr
  %streams__addr = alloca %DriftArrayHeader
  %__match_scrut_tmp.t262__addr = alloca %Variant_lang_2Ecore_Optional_0c32631472b0a6e3
  %__match_scrut_tmp.t249__addr = alloca %Variant_lang_2Ecore_Optional_0c32631472b0a6e3
  %st__b28__addr = alloca %Struct_std_2Enet_TcpStream_363317ef680a1400
  %__match_scrut_tmp.t76__addr = alloca %Variant_std_2Ecore_Result_a482b0d00941967a
  %__match_scrut_tmp.t27__addr = alloca %Variant_std_2Ecore_Result_a482b0d00941967a
  %__array_new_cap.t54__addr = alloca i64
  %__array_copy_i.t60__addr = alloca i64
  %rbuf__addr = alloca %Struct_std_2Eio_Buffer_e76b5c24b140f2f4
  %__match_scrut_tmp.t146__addr = alloca %Variant_std_2Ecore_Result_ccaaf7910bb23f6d
  %__match_scrut_tmp.t111__addr = alloca %Variant_std_2Ecore_Result_ccaaf7910bb23f6d
  %wbuf__addr = alloca %Struct_std_2Eio_Buffer_e76b5c24b140f2f4
  %__match_scrut_tmp.t210__addr = alloca %Variant_lang_2Ecore_Optional_0c32631472b0a6e3
  %__match_scrut_tmp.t197__addr = alloca %Variant_lang_2Ecore_Optional_0c32631472b0a6e3
  %st__addr = alloca %Struct_std_2Enet_TcpStream_363317ef680a1400
  %zero_arr1 = insertvalue %DriftArrayHeader zeroinitializer, i64 0, 0
  %zero_arr2 = insertvalue %DriftArrayHeader %zero_arr1, i64 0, 1
  %zero_arr3 = insertvalue %DriftArrayHeader %zero_arr2, i64 0, 2
  %__arc2 = insertvalue %DriftArrayHeader %zero_arr3, ptr null, 3
  store %DriftArrayHeader %__arc2, ptr %streams__addr
  %zero_struct4 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc3 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %zero_struct4, i64 0, 1
  %__arc4 = select i1 1, %Variant_std_2Ecore_Result_ccaaf7910bb23f6d zeroinitializer, %Variant_std_2Ecore_Result_ccaaf7910bb23f6d zeroinitializer
  %zero_struct5 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc5 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %zero_struct5, i64 0, 1
  %strptr6 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str3, i32 0, i32 2, i32 0
  %str07 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str07, ptr %strptr6, 1
  %.t2 = add i64 0, 0
  %.t3 = insertvalue %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 zeroinitializer, i64 %.t2, 0
  %.t5 = add i64 0, 0
  %.t6 = add i64 0, 0
  %.t7 = add i64 0, 0
  %len09 = add i64 0, 0
  %arr8 = call ptr @drift_alloc_array(i64 8, i64 8, i64 %len09, i64 %.t6)
  %arrh010 = insertvalue %DriftArrayHeader zeroinitializer, i64 %len09, 0
  %arrh111 = insertvalue %DriftArrayHeader %arrh010, i64 %.t6, 1
  %arrh212 = insertvalue %DriftArrayHeader %arrh111, i64 0, 2
  %.t4 = insertvalue %DriftArrayHeader %arrh212, ptr %arr8, 3
  %arr_len13 = insertvalue %DriftArrayHeader %.t4, i64 %.t5, 0
  %__arc6 = load %DriftArrayHeader, ptr %streams__addr
  %zero_arr14 = insertvalue %DriftArrayHeader zeroinitializer, i64 0, 0
  %zero_arr15 = insertvalue %DriftArrayHeader %zero_arr14, i64 0, 1
  %zero_arr16 = insertvalue %DriftArrayHeader %zero_arr15, i64 0, 2
  %__arc7 = insertvalue %DriftArrayHeader %zero_arr16, ptr null, 3
  store %DriftArrayHeader %__arc7, ptr %streams__addr
  %len17 = extractvalue %DriftArrayHeader %__arc6, 0
  %data18 = extractvalue %DriftArrayHeader %__arc6, 3
  call void @drift_free_array(ptr %data18)
  store %DriftArrayHeader %arr_len13, ptr %streams__addr
  %.t9 = add i1 0, 1
  %__array_pop_res.t176_1 = select i1 1, %Variant_lang_2Ecore_Optional_0c32631472b0a6e3 zeroinitializer, %Variant_lang_2Ecore_Optional_0c32631472b0a6e3 zeroinitializer
  %j_1 = add i64 0, 0
  %remove_1 = add i1 0, 0
  %__array_cap_grew.t48_1 = add i1 0, 0
  %zero_arr19 = insertvalue %DriftArrayHeader zeroinitializer, i64 0, 0
  %zero_arr20 = insertvalue %DriftArrayHeader %zero_arr19, i64 0, 1
  %zero_arr21 = insertvalue %DriftArrayHeader %zero_arr20, i64 0, 2
  %__array_cap_arr.t47_1 = insertvalue %DriftArrayHeader %zero_arr21, ptr null, 3
  %i_1 = add i64 0, 0
  %progressed_1 = add i1 0, 0
  br label %.bb.loop_header
.bb.loop_header:
  %__array_pop_res.t176_2 = phi %Variant_lang_2Ecore_Optional_0c32631472b0a6e3 [ %__array_pop_res.t176_1, %.bb.entry ], [ %__array_pop_res.t176_8, %.bb.if_join ]
  %j_2 = phi i64 [ %j_1, %.bb.entry ], [ %j_9, %.bb.if_join ]
  %remove_2 = phi i1 [ %remove_1, %.bb.entry ], [ %remove_10, %.bb.if_join ]
  %__array_cap_grew.t48_2 = phi i1 [ %__array_cap_grew.t48_1, %.bb.entry ], [ %__array_cap_grew.t48_7, %.bb.if_join ]
  %__array_cap_arr.t47_2 = phi %DriftArrayHeader [ %__array_cap_arr.t47_1, %.bb.entry ], [ %__array_cap_arr.t47_8, %.bb.if_join ]
  %i_2 = phi i64 [ %i_1, %.bb.entry ], [ %i_7, %.bb.if_join ]
  %progressed_2 = phi i1 [ %progressed_1, %.bb.entry ], [ %progressed_11, %.bb.if_join ]
  %alive_2 = phi i1 [ %.t9, %.bb.entry ], [ %alive_3, %.bb.if_join ]
  %__match_binder_4_e_2 = phi %Struct_std_2Enet_NetError_203564604ea2d3a4 [ %__arc5, %.bb.entry ], [ %__match_binder_4_e_8, %.bb.if_join ]
  %__2 = phi %Variant_std_2Ecore_Result_ccaaf7910bb23f6d [ %__arc4, %.bb.entry ], [ %__9, %.bb.if_join ]
  %__match_binder_2_e_2 = phi %Struct_std_2Enet_NetError_203564604ea2d3a4 [ %__arc3, %.bb.entry ], [ %__match_binder_2_e_7, %.bb.if_join ]
  br label %.bb.loop_body
.bb.loop_body:
  br i1 %alive_2, label %.bb.if_then, label %.bb.if_else
.bb.if_else:
  br label %.bb.loop_exit
.bb.loop_exit:
  %__array_pop_res.t228_1 = select i1 1, %Variant_lang_2Ecore_Optional_0c32631472b0a6e3 zeroinitializer, %Variant_lang_2Ecore_Optional_0c32631472b0a6e3 zeroinitializer
  br label %.bb.loop_header3
.bb.loop_header3:
  %__array_pop_res.t228_2 = phi %Variant_lang_2Ecore_Optional_0c32631472b0a6e3 [ %__array_pop_res.t228_1, %.bb.loop_exit ], [ %__array_pop_res.t228_5, %.bb.if_join10 ]
  br label %.bb.loop_body3
.bb.loop_body3:
  %.t222 = load %DriftArrayHeader, ptr %streams__addr
  %.t223 = extractvalue %DriftArrayHeader %.t222, 0
  %.t224 = add i64 0, 0
  %.t225 = icmp sgt i64 %.t223, %.t224
  br i1 %.t225, label %.bb.if_then10, label %.bb.if_else6
.bb.if_else6:
  br label %.bb.loop_exit3
.bb.loop_exit3:
  %.t266 = add i64 0, 0
  %__cleanup_t9 = load %DriftArrayHeader, ptr %streams__addr
  %zero_arr22 = insertvalue %DriftArrayHeader zeroinitializer, i64 0, 0
  %zero_arr23 = insertvalue %DriftArrayHeader %zero_arr22, i64 0, 1
  %zero_arr24 = insertvalue %DriftArrayHeader %zero_arr23, i64 0, 2
  %__arc16 = insertvalue %DriftArrayHeader %zero_arr24, ptr null, 3
  store %DriftArrayHeader %__arc16, ptr %streams__addr
  %len25 = extractvalue %DriftArrayHeader %__cleanup_t9, 0
  %data26 = extractvalue %DriftArrayHeader %__cleanup_t9, 3
  call void @drift_free_array(ptr %data26)
  %__cleanup_t10 = load %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba, ptr %stopped__addr
  %__arc17 = insertvalue %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba zeroinitializer, %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa zeroinitializer, 0
  store %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba %__arc17, ptr %stopped__addr
  call void @"std.core.arc::_arc_destroy_impl__inst__0a6d34c7cbe9c09f"(%Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba %__cleanup_t10)
  ret i64 %.t266
.bb.if_then10:
  %.t227 = load %DriftArrayHeader, ptr %streams__addr
  %.t229 = extractvalue %DriftArrayHeader %.t227, 0
  %.t230 = add i64 0, 0
  %.t231 = icmp eq i64 %.t229, %.t230
  br i1 %.t231, label %.bb.array_pop_empty1, label %.bb.array_pop_ok1
.bb.array_pop_ok1:
  %.t233 = add i64 0, 1
  %.t234 = sub i64 %.t229, %.t233
  %len27 = extractvalue %DriftArrayHeader %.t227, 0
  %data28 = extractvalue %DriftArrayHeader %.t227, 3
  %strptr29 = getelementptr inbounds { i64, i64, [21 x i8] }, ptr @.str4, i32 0, i32 2, i32 0
  %str030 = insertvalue %DriftString zeroinitializer, i64 20, 0
  %str31 = insertvalue %DriftString %str030, ptr %strptr29, 1
  call void @drift_bounds_check(%DriftString %str31, i64 %.t234, i64 %len27)
  %eltptr32 = getelementptr %Struct_std_2Enet_TcpStream_363317ef680a1400, ptr %data28, i64 %.t234
  %.t235 = load %Struct_std_2Enet_TcpStream_363317ef680a1400, ptr %eltptr32
  %.t236 = sub i64 %.t229, %.t233
  %arr_len33 = insertvalue %DriftArrayHeader %.t227, i64 %.t236, 0
  %.t238 = extractvalue %DriftArrayHeader %.t227, 2
  %.t239 = add i64 0, 1
  %.t240 = add i64 %.t238, %.t239
  %arr_gen34 = insertvalue %DriftArrayHeader %arr_len33, i64 %.t240, 2
  store %DriftArrayHeader %arr_gen34, ptr %streams__addr
  %variant35 = alloca %Variant_lang_2Ecore_Optional_0c32631472b0a6e3
  store %Variant_lang_2Ecore_Optional_0c32631472b0a6e3 zeroinitializer, ptr %variant35
  %tagptr36 = getelementptr inbounds %Variant_lang_2Ecore_Optional_0c32631472b0a6e3, ptr %variant35, i32 0, i32 0
  store i8 1, ptr %tagptr36
  %payload_words37 = getelementptr inbounds %Variant_lang_2Ecore_Optional_0c32631472b0a6e3, ptr %variant35, i32 0, i32 2
  %fieldptr38 = getelementptr inbounds { %Struct_std_2Enet_TcpStream_363317ef680a1400 }, ptr %payload_words37, i32 0, i32 0
  store %Struct_std_2Enet_TcpStream_363317ef680a1400 %.t235, ptr %fieldptr38
  %.t242 = load %Variant_lang_2Ecore_Optional_0c32631472b0a6e3, ptr %variant35
  br label %.bb.array_pop_join1
.bb.array_pop_empty1:
  %.t232 = insertvalue %Variant_lang_2Ecore_Optional_0c32631472b0a6e3 zeroinitializer, i8 0, 0
  br label %.bb.array_pop_join1
.bb.array_pop_join1:
  %__array_pop_res.t228_5 = phi %Variant_lang_2Ecore_Optional_0c32631472b0a6e3 [ %.t232, %.bb.array_pop_empty1 ], [ %.t242, %.bb.array_pop_ok1 ]
  br label %.bb.match_dispatch3
.bb.match_dispatch3:
  %tag839 = extractvalue %Variant_lang_2Ecore_Optional_0c32631472b0a6e3 %__array_pop_res.t228_5, 0
  %.t244 = zext i8 %tag839 to i64
  %.t245 = add i64 0, 1
  %.t246 = icmp eq i64 %.t244, %.t245
  br i1 %.t246, label %.bb.match_arm_03, label %.bb.match_dispatch_next6
.bb.match_dispatch_next6:
  %.t247 = add i64 0, 0
  %.t248 = icmp eq i64 %.t244, %.t247
  br i1 %.t248, label %.bb.match_arm_13, label %.bb.match_dispatch_next7
.bb.match_dispatch_next7:
  unreachable
.bb.match_arm_13:
  %__arc40 = select i1 1, %Variant_lang_2Ecore_Optional_0c32631472b0a6e3 zeroinitializer, %Variant_lang_2Ecore_Optional_0c32631472b0a6e3 zeroinitializer
  store %Variant_lang_2Ecore_Optional_0c32631472b0a6e3 %__array_pop_res.t228_5, ptr %__match_scrut_tmp.t262__addr
  br label %.bb.match_join3
.bb.match_arm_03:
  %__arc27 = select i1 1, %Variant_lang_2Ecore_Optional_0c32631472b0a6e3 zeroinitializer, %Variant_lang_2Ecore_Optional_0c32631472b0a6e3 zeroinitializer
  store %Variant_lang_2Ecore_Optional_0c32631472b0a6e3 %__array_pop_res.t228_5, ptr %__match_scrut_tmp.t249__addr
  %payload_words40 = getelementptr inbounds %Variant_lang_2Ecore_Optional_0c32631472b0a6e3, ptr %__match_scrut_tmp.t249__addr, i32 0, i32 2
  %fieldptr41 = getelementptr inbounds { %Struct_std_2Enet_TcpStream_363317ef680a1400 }, ptr %payload_words40, i32 0, i32 0
  %.t254 = load %Struct_std_2Enet_TcpStream_363317ef680a1400, ptr %fieldptr41
  %__arc28 = insertvalue %Struct_std_2Enet_TcpStream_363317ef680a1400 zeroinitializer, i64 0, 0
  %__arc29 = insertvalue %Struct_std_2Enet_TcpStream_363317ef680a1400 zeroinitializer, i64 0, 0
  store %Struct_std_2Enet_TcpStream_363317ef680a1400 %.t254, ptr %st__b28__addr
  %.t261 = call %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 @"std.net::TcpStream::close"(ptr %st__b28__addr, %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %.t3)
  %__arc30 = select i1 1, %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 zeroinitializer, %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 zeroinitializer
  %drop_variant_ptr42 = alloca %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6
  store %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 %.t261, ptr %drop_variant_ptr42
  call void @__drift_array_drop_std__std_core_Result_Void_std__std_net_NetError__9dbf2dcdb5537ee6(i64 1, ptr %drop_variant_ptr42)
  br label %.bb.match_join3
.bb.match_join3:
  br label %.bb.if_join10
.bb.if_join10:
  br label %.bb.loop_header3
.bb.if_then:
  %.t12 = call ptr @"std.core.arc::_arc_get_impl__inst__fc66586b6a63dfdc"(ptr %stopped__addr)
  %.t14 = insertvalue %Variant_lang_2Eatomic_MemoryOrder_469abe0ace4b6a6f zeroinitializer, i8 1, 0
  %.t15 = call i1 @"std.sync::AtomicBool::load"(ptr %.t12, %Variant_lang_2Eatomic_MemoryOrder_469abe0ace4b6a6f %.t14)
  br i1 %.t15, label %.bb.if_then1, label %.bb.if_join1
.bb.if_then1:
  %.t16 = add i1 0, 0
  br label %.bb.if_join1
.bb.if_join1:
  %alive_3 = phi i1 [ %alive_2, %.bb.if_then ], [ %.t16, %.bb.if_then1 ]
  br i1 %alive_3, label %.bb.if_then2, label %.bb.if_join2
.bb.if_then2:
  %.t18 = add i1 0, 0
  %.t21 = call %Variant_std_2Ecore_Result_a482b0d00941967a @"std.net::TcpListener::accept"(ptr %listener__addr, %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %.t3)
  br label %.bb.match_dispatch
.bb.match_dispatch:
  %tag843 = extractvalue %Variant_std_2Ecore_Result_a482b0d00941967a %.t21, 0
  %.t22 = zext i8 %tag843 to i64
  %.t23 = add i64 0, 0
  %.t24 = icmp eq i64 %.t22, %.t23
  br i1 %.t24, label %.bb.match_arm_0, label %.bb.match_dispatch_next
.bb.match_dispatch_next:
  %.t25 = add i64 0, 1
  %.t26 = icmp eq i64 %.t22, %.t25
  br i1 %.t26, label %.bb.match_arm_1, label %.bb.match_dispatch_next1
.bb.match_dispatch_next1:
  unreachable
.bb.match_arm_1:
  %__arc31 = select i1 1, %Variant_std_2Ecore_Result_a482b0d00941967a zeroinitializer, %Variant_std_2Ecore_Result_a482b0d00941967a zeroinitializer
  store %Variant_std_2Ecore_Result_a482b0d00941967a %.t21, ptr %__match_scrut_tmp.t76__addr
  %payload_words44 = getelementptr inbounds %Variant_std_2Ecore_Result_a482b0d00941967a, ptr %__match_scrut_tmp.t76__addr, i32 0, i32 2
  %fieldptr45 = getelementptr inbounds { %Struct_std_2Enet_NetError_203564604ea2d3a4 }, ptr %payload_words44, i32 0, i32 0
  %.t81 = load %Struct_std_2Enet_NetError_203564604ea2d3a4, ptr %fieldptr45
  %zero_struct46 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc32 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %zero_struct46, i64 0, 1
  %zero_struct47 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc34 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %zero_struct47, i64 0, 1
  %drop_field48 = extractvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %__match_binder_2_e_2, 0
  call void @drift_string_release(%DriftString %drop_field48)
  %.t86 = extractvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %.t81, 0
  %strptr49 = getelementptr inbounds { i64, i64, [12 x i8] }, ptr @.str5, i32 0, i32 2, i32 0
  %str050 = insertvalue %DriftString zeroinitializer, i64 11, 0
  %.t87 = insertvalue %DriftString %str050, ptr %strptr49, 1
  %strcmp51 = call i32 @drift_string_cmp(%DriftString %.t86, %DriftString %.t87)
  %.t89 = sext i32 %strcmp51 to i64
  call void @drift_string_release(%DriftString %.t87)
  %.t90 = add i64 0, 0
  %.t88 = icmp ne i64 %.t89, %.t90
  br i1 %.t88, label %.bb.if_then3, label %.bb.if_join3
.bb.if_then3:
  br label %.bb.if_join3
.bb.if_join3:
  %zero_struct52 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc8 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %zero_struct52, i64 0, 1
  %drop_field53 = extractvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %.t81, 0
  call void @drift_string_release(%DriftString %drop_field53)
  br label %.bb.match_join
.bb.match_arm_0:
  %__arc18 = select i1 1, %Variant_std_2Ecore_Result_a482b0d00941967a zeroinitializer, %Variant_std_2Ecore_Result_a482b0d00941967a zeroinitializer
  store %Variant_std_2Ecore_Result_a482b0d00941967a %.t21, ptr %__match_scrut_tmp.t27__addr
  %payload_words54 = getelementptr inbounds %Variant_std_2Ecore_Result_a482b0d00941967a, ptr %__match_scrut_tmp.t27__addr, i32 0, i32 2
  %fieldptr55 = getelementptr inbounds { %Struct_std_2Enet_TcpStream_363317ef680a1400 }, ptr %payload_words54, i32 0, i32 0
  %.t32 = load %Struct_std_2Enet_TcpStream_363317ef680a1400, ptr %fieldptr55
  %__arc19 = insertvalue %Struct_std_2Enet_TcpStream_363317ef680a1400 zeroinitializer, i64 0, 0
  %.t37 = load %DriftArrayHeader, ptr %streams__addr
  %__arc20 = insertvalue %Struct_std_2Enet_TcpStream_363317ef680a1400 zeroinitializer, i64 0, 0
  %.t39 = extractvalue %DriftArrayHeader %.t37, 0
  %.t40 = extractvalue %DriftArrayHeader %.t37, 1
  %.t41 = extractvalue %DriftArrayHeader %.t37, 2
  %.t42 = add i64 0, 1
  %.t43 = add i64 %.t41, %.t42
  %.t44 = add i64 0, 1
  %.t45 = add i64 %.t39, %.t44
  %.t46 = icmp sle i64 %.t45, %.t40
  br i1 %.t46, label %.bb.array_cap_ok, label %.bb.array_cap_grow
.bb.array_cap_grow:
  %.t50 = add i64 0, 2
  %.t51 = mul i64 %.t40, %.t50
  %.t52 = icmp slt i64 %.t51, %.t45
  %.t53 = add i64 0, 0
  store i64 %.t53, ptr %__array_new_cap.t54__addr
  br i1 %.t52, label %.bb.array_cap_need, label %.bb.array_cap_x2
.bb.array_cap_x2:
  store i64 %.t51, ptr %__array_new_cap.t54__addr
  br label %.bb.array_cap_join
.bb.array_cap_need:
  store i64 %.t45, ptr %__array_new_cap.t54__addr
  br label %.bb.array_cap_join
.bb.array_cap_join:
  %.t56 = load i64, ptr %__array_new_cap.t54__addr
  %.t57 = add i64 0, 0
  %len057 = add i64 0, 0
  %arr56 = call ptr @drift_alloc_array(i64 8, i64 8, i64 %len057, i64 %.t56)
  %arrh058 = insertvalue %DriftArrayHeader zeroinitializer, i64 %len057, 0
  %arrh159 = insertvalue %DriftArrayHeader %arrh058, i64 %.t56, 1
  %arrh260 = insertvalue %DriftArrayHeader %arrh159, i64 0, 2
  %.t58 = insertvalue %DriftArrayHeader %arrh260, ptr %arr56, 3
  %.t59 = add i64 0, 0
  store i64 %.t59, ptr %__array_copy_i.t60__addr
  store i64 %.t57, ptr %__array_copy_i.t60__addr
  br label %.bb.array_copy_cond
.bb.array_copy_cond:
  %.t62 = load i64, ptr %__array_copy_i.t60__addr
  %.t63 = icmp slt i64 %.t62, %.t39
  br i1 %.t63, label %.bb.array_copy_body, label %.bb.array_copy_exit
.bb.array_copy_exit:
  %arr_len61 = insertvalue %DriftArrayHeader %.t58, i64 %.t39, 0
  %arr_len62 = insertvalue %DriftArrayHeader %.t37, i64 %.t57, 0
  %len63 = extractvalue %DriftArrayHeader %arr_len62, 0
  %data64 = extractvalue %DriftArrayHeader %arr_len62, 3
  call void @drift_free_array(ptr %data64)
  %.t69 = add i1 0, 1
  br label %.bb.array_cap_join2
.bb.array_copy_body:
  %len65 = extractvalue %DriftArrayHeader %.t37, 0
  %data66 = extractvalue %DriftArrayHeader %.t37, 3
  %strptr67 = getelementptr inbounds { i64, i64, [21 x i8] }, ptr @.str4, i32 0, i32 2, i32 0
  %str068 = insertvalue %DriftString zeroinitializer, i64 20, 0
  %str69 = insertvalue %DriftString %str068, ptr %strptr67, 1
  call void @drift_bounds_check(%DriftString %str69, i64 %.t62, i64 %len65)
  %eltptr70 = getelementptr %Struct_std_2Enet_TcpStream_363317ef680a1400, ptr %data66, i64 %.t62
  %.t64 = load %Struct_std_2Enet_TcpStream_363317ef680a1400, ptr %eltptr70
  %data71 = extractvalue %DriftArrayHeader %.t58, 3
  %eltptr72 = getelementptr inbounds %Struct_std_2Enet_TcpStream_363317ef680a1400, ptr %data71, i64 %.t62
  store %Struct_std_2Enet_TcpStream_363317ef680a1400 %.t64, ptr %eltptr72
  %.t66 = add i64 0, 1
  %.t65 = add i64 %.t62, %.t66
  store i64 %.t65, ptr %__array_copy_i.t60__addr
  br label %.bb.array_copy_cond
.bb.array_cap_ok:
  %.t49 = add i1 0, 0
  br label %.bb.array_cap_join2
.bb.array_cap_join2:
  %__array_cap_grew.t48_5 = phi i1 [ %.t69, %.bb.array_copy_exit ], [ %.t49, %.bb.array_cap_ok ]
  %__array_cap_arr.t47_5 = phi %DriftArrayHeader [ %arr_len61, %.bb.array_copy_exit ], [ %.t37, %.bb.array_cap_ok ]
  %zero_arr73 = insertvalue %DriftArrayHeader zeroinitializer, i64 0, 0
  %zero_arr74 = insertvalue %DriftArrayHeader %zero_arr73, i64 0, 1
  %zero_arr75 = insertvalue %DriftArrayHeader %zero_arr74, i64 0, 2
  %__arc1 = insertvalue %DriftArrayHeader %zero_arr75, ptr null, 3
  %data76 = extractvalue %DriftArrayHeader %__array_cap_arr.t47_5, 3
  %eltptr77 = getelementptr inbounds %Struct_std_2Enet_TcpStream_363317ef680a1400, ptr %data76, i64 %.t39
  store %Struct_std_2Enet_TcpStream_363317ef680a1400 %.t32, ptr %eltptr77
  %.t72 = add i64 %.t39, %.t44
  %arr_len78 = insertvalue %DriftArrayHeader %__array_cap_arr.t47_5, i64 %.t72, 0
  %arr_gen79 = insertvalue %DriftArrayHeader %arr_len78, i64 %.t43, 2
  store %DriftArrayHeader %arr_gen79, ptr %streams__addr
  %.t75 = add i1 0, 1
  br label %.bb.match_join
.bb.match_join:
  %__array_cap_grew.t48_3 = phi i1 [ %__array_cap_grew.t48_2, %.bb.if_join3 ], [ %__array_cap_grew.t48_5, %.bb.array_cap_join2 ]
  %__array_cap_arr.t47_3 = phi %DriftArrayHeader [ %__array_cap_arr.t47_2, %.bb.if_join3 ], [ %__arc1, %.bb.array_cap_join2 ]
  %progressed_4 = phi i1 [ %.t18, %.bb.if_join3 ], [ %.t75, %.bb.array_cap_join2 ]
  %__match_binder_2_e_6 = phi %Struct_std_2Enet_NetError_203564604ea2d3a4 [ %__arc8, %.bb.if_join3 ], [ %__match_binder_2_e_2, %.bb.array_cap_join2 ]
  %.t91 = add i64 0, 0
  br label %.bb.loop_header1
.bb.loop_header1:
  %__array_pop_res.t176_3 = phi %Variant_lang_2Ecore_Optional_0c32631472b0a6e3 [ %__array_pop_res.t176_2, %.bb.match_join ], [ %__array_pop_res.t176_7, %.bb.if_join4 ]
  %j_3 = phi i64 [ %j_2, %.bb.match_join ], [ %j_8, %.bb.if_join4 ]
  %remove_3 = phi i1 [ %remove_2, %.bb.match_join ], [ %remove_7, %.bb.if_join4 ]
  %i_4 = phi i64 [ %.t91, %.bb.match_join ], [ %i_6, %.bb.if_join4 ]
  %progressed_5 = phi i1 [ %progressed_4, %.bb.match_join ], [ %progressed_9, %.bb.if_join4 ]
  %__match_binder_4_e_3 = phi %Struct_std_2Enet_NetError_203564604ea2d3a4 [ %__match_binder_4_e_2, %.bb.match_join ], [ %__match_binder_4_e_4, %.bb.if_join4 ]
  %__3 = phi %Variant_std_2Ecore_Result_ccaaf7910bb23f6d [ %__2, %.bb.match_join ], [ %__8, %.bb.if_join4 ]
  br label %.bb.loop_body1
.bb.loop_body1:
  %.t93 = load %DriftArrayHeader, ptr %streams__addr
  %.t94 = extractvalue %DriftArrayHeader %.t93, 0
  %.t95 = icmp slt i64 %i_4, %.t94
  br i1 %.t95, label %.bb.if_then4, label %.bb.if_else1
.bb.if_else1:
  br label %.bb.loop_exit1
.bb.loop_exit1:
  %.t218 = xor i1 %progressed_5, true
  br i1 %.t218, label %.bb.if_then9, label %.bb.if_join9
.bb.if_then9:
  %.t219 = add i64 0, 1
  %.t220 = insertvalue %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 zeroinitializer, i64 %.t219, 0
  %.t221 = call %Variant_std_2Ecore_Result_4861f1d1d2eeba72 @"std.concurrent::sleep"(%Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %.t220)
  %__arc11 = select i1 1, %Variant_std_2Ecore_Result_4861f1d1d2eeba72 zeroinitializer, %Variant_std_2Ecore_Result_4861f1d1d2eeba72 zeroinitializer
  %drop_variant_ptr80 = alloca %Variant_std_2Ecore_Result_4861f1d1d2eeba72
  store %Variant_std_2Ecore_Result_4861f1d1d2eeba72 %.t221, ptr %drop_variant_ptr80
  call void @__drift_array_drop_std__std_core_Result_Void_std__std_concurrent_ConcurrencyError__4861f1d1d2eeba72(i64 1, ptr %drop_variant_ptr80)
  br label %.bb.if_join9
.bb.if_join9:
  br label %.bb.if_join2
.bb.if_join2:
  %__array_pop_res.t176_8 = phi %Variant_lang_2Ecore_Optional_0c32631472b0a6e3 [ %__array_pop_res.t176_2, %.bb.if_join1 ], [ %__array_pop_res.t176_3, %.bb.if_join9 ]
  %j_9 = phi i64 [ %j_2, %.bb.if_join1 ], [ %j_3, %.bb.if_join9 ]
  %remove_10 = phi i1 [ %remove_2, %.bb.if_join1 ], [ %remove_3, %.bb.if_join9 ]
  %__array_cap_grew.t48_7 = phi i1 [ %__array_cap_grew.t48_2, %.bb.if_join1 ], [ %__array_cap_grew.t48_3, %.bb.if_join9 ]
  %__array_cap_arr.t47_8 = phi %DriftArrayHeader [ %__array_cap_arr.t47_2, %.bb.if_join1 ], [ %__array_cap_arr.t47_3, %.bb.if_join9 ]
  %i_7 = phi i64 [ %i_2, %.bb.if_join1 ], [ %i_4, %.bb.if_join9 ]
  %progressed_11 = phi i1 [ %progressed_2, %.bb.if_join1 ], [ %progressed_5, %.bb.if_join9 ]
  %__match_binder_4_e_8 = phi %Struct_std_2Enet_NetError_203564604ea2d3a4 [ %__match_binder_4_e_2, %.bb.if_join1 ], [ %__match_binder_4_e_3, %.bb.if_join9 ]
  %__9 = phi %Variant_std_2Ecore_Result_ccaaf7910bb23f6d [ %__2, %.bb.if_join1 ], [ %__3, %.bb.if_join9 ]
  %__match_binder_2_e_7 = phi %Struct_std_2Enet_NetError_203564604ea2d3a4 [ %__match_binder_2_e_2, %.bb.if_join1 ], [ %__match_binder_2_e_6, %.bb.if_join9 ]
  br label %.bb.if_join
.bb.if_join:
  br label %.bb.loop_header
.bb.if_then4:
  %.t96 = add i1 0, 0
  %.t97 = add i64 0, 1024
  %.t98 = call %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 @"std.io::buffer"(i64 %.t97)
  store %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %.t98, ptr %rbuf__addr
  %.t100 = load %DriftArrayHeader, ptr %streams__addr
  %len81 = extractvalue %DriftArrayHeader %.t100, 0
  %data82 = extractvalue %DriftArrayHeader %.t100, 3
  %strptr83 = getelementptr inbounds { i64, i64, [21 x i8] }, ptr @.str4, i32 0, i32 2, i32 0
  %str084 = insertvalue %DriftString zeroinitializer, i64 20, 0
  %str85 = insertvalue %DriftString %str084, ptr %strptr83, 1
  call void @drift_bounds_check(%DriftString %str85, i64 %i_4, i64 %len81)
  %eltptr86 = getelementptr %Struct_std_2Enet_TcpStream_363317ef680a1400, ptr %data82, i64 %i_4
  %.t105 = call %Variant_std_2Ecore_Result_ccaaf7910bb23f6d @"std.net::TcpStream::read"(ptr %eltptr86, ptr %rbuf__addr, %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %.t3)
  br label %.bb.match_dispatch1
.bb.match_dispatch1:
  %tag887 = extractvalue %Variant_std_2Ecore_Result_ccaaf7910bb23f6d %.t105, 0
  %.t106 = zext i8 %tag887 to i64
  %.t107 = add i64 0, 0
  %.t108 = icmp eq i64 %.t106, %.t107
  br i1 %.t108, label %.bb.match_arm_01, label %.bb.match_dispatch_next2
.bb.match_dispatch_next2:
  %.t109 = add i64 0, 1
  %.t110 = icmp eq i64 %.t106, %.t109
  br i1 %.t110, label %.bb.match_arm_11, label %.bb.match_dispatch_next3
.bb.match_dispatch_next3:
  unreachable
.bb.match_arm_11:
  %__arc35 = select i1 1, %Variant_std_2Ecore_Result_ccaaf7910bb23f6d zeroinitializer, %Variant_std_2Ecore_Result_ccaaf7910bb23f6d zeroinitializer
  store %Variant_std_2Ecore_Result_ccaaf7910bb23f6d %.t105, ptr %__match_scrut_tmp.t146__addr
  %payload_words88 = getelementptr inbounds %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %__match_scrut_tmp.t146__addr, i32 0, i32 2
  %fieldptr89 = getelementptr inbounds { %Struct_std_2Enet_NetError_203564604ea2d3a4 }, ptr %payload_words88, i32 0, i32 0
  %.t151 = load %Struct_std_2Enet_NetError_203564604ea2d3a4, ptr %fieldptr89
  %zero_struct90 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc36 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %zero_struct90, i64 0, 1
  %zero_struct91 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc38 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %zero_struct91, i64 0, 1
  %drop_field92 = extractvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %__match_binder_4_e_3, 0
  call void @drift_string_release(%DriftString %drop_field92)
  %.t156 = extractvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %.t151, 0
  %strptr93 = getelementptr inbounds { i64, i64, [12 x i8] }, ptr @.str6, i32 0, i32 2, i32 0
  %str094 = insertvalue %DriftString zeroinitializer, i64 11, 0
  %.t157 = insertvalue %DriftString %str094, ptr %strptr93, 1
  %.t158 = call i1 @drift_string_eq(%DriftString %.t156, %DriftString %.t157)
  call void @drift_string_release(%DriftString %.t157)
  br i1 %.t158, label %.bb.if_then7, label %.bb.if_else4
.bb.if_else4:
  %.t159 = add i1 0, 1
  br label %.bb.if_join7
.bb.if_then7:
  br label %.bb.if_join7
.bb.if_join7:
  %remove_9 = phi i1 [ %.t96, %.bb.if_then7 ], [ %.t159, %.bb.if_else4 ]
  %zero_struct95 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc9 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %zero_struct95, i64 0, 1
  %drop_field96 = extractvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %.t151, 0
  call void @drift_string_release(%DriftString %drop_field96)
  br label %.bb.match_join1
.bb.match_arm_01:
  %__arc21 = select i1 1, %Variant_std_2Ecore_Result_ccaaf7910bb23f6d zeroinitializer, %Variant_std_2Ecore_Result_ccaaf7910bb23f6d zeroinitializer
  store %Variant_std_2Ecore_Result_ccaaf7910bb23f6d %.t105, ptr %__match_scrut_tmp.t111__addr
  %payload_words97 = getelementptr inbounds %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %__match_scrut_tmp.t111__addr, i32 0, i32 2
  %fieldptr98 = getelementptr inbounds { i64 }, ptr %payload_words97, i32 0, i32 0
  %.t116 = load i64, ptr %fieldptr98
  %__cleanup_t2 = load %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %__match_scrut_tmp.t111__addr
  %__arc22 = select i1 1, %Variant_std_2Ecore_Result_ccaaf7910bb23f6d zeroinitializer, %Variant_std_2Ecore_Result_ccaaf7910bb23f6d zeroinitializer
  store %Variant_std_2Ecore_Result_ccaaf7910bb23f6d %__arc22, ptr %__match_scrut_tmp.t111__addr
  %drop_variant_ptr99 = alloca %Variant_std_2Ecore_Result_ccaaf7910bb23f6d
  store %Variant_std_2Ecore_Result_ccaaf7910bb23f6d %__cleanup_t2, ptr %drop_variant_ptr99
  call void @__drift_array_drop_std__std_core_Result_Int_std__std_net_NetError__ccaaf7910bb23f6d(i64 1, ptr %drop_variant_ptr99)
  %.t119 = add i64 0, 0
  %.t120 = icmp eq i64 %.t116, %.t119
  br i1 %.t120, label %.bb.if_then5, label %.bb.if_else2
.bb.if_else2:
  %.t124 = call %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 @"std.io::buffer"(i64 %.t116)
  store %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %.t124, ptr %wbuf__addr
  %.t125 = add i64 0, 0
  br label %.bb.loop_header2
.bb.loop_header2:
  %j_6 = phi i64 [ %.t125, %.bb.if_else2 ], [ %.t136, %.bb.if_join6 ]
  br label %.bb.loop_body2
.bb.loop_body2:
  %.t128 = icmp slt i64 %j_6, %.t116
  br i1 %.t128, label %.bb.if_then6, label %.bb.if_else3
.bb.if_else3:
  br label %.bb.loop_exit2
.bb.loop_exit2:
  %.t138 = load %DriftArrayHeader, ptr %streams__addr
  %len100 = extractvalue %DriftArrayHeader %.t138, 0
  %data101 = extractvalue %DriftArrayHeader %.t138, 3
  %strptr102 = getelementptr inbounds { i64, i64, [21 x i8] }, ptr @.str4, i32 0, i32 2, i32 0
  %str0103 = insertvalue %DriftString zeroinitializer, i64 20, 0
  %str104 = insertvalue %DriftString %str0103, ptr %strptr102, 1
  call void @drift_bounds_check(%DriftString %str104, i64 %i_4, i64 %len100)
  %eltptr105 = getelementptr %Struct_std_2Enet_TcpStream_363317ef680a1400, ptr %data101, i64 %i_4
  %.t142 = add i64 0, 1000
  %.t143 = insertvalue %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 zeroinitializer, i64 %.t142, 0
  %.t144 = call %Variant_std_2Ecore_Result_ccaaf7910bb23f6d @"std.net::TcpStream::write"(ptr %eltptr105, ptr %wbuf__addr, %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %.t143)
  %__arc13 = select i1 1, %Variant_std_2Ecore_Result_ccaaf7910bb23f6d zeroinitializer, %Variant_std_2Ecore_Result_ccaaf7910bb23f6d zeroinitializer
  %drop_variant_ptr106 = alloca %Variant_std_2Ecore_Result_ccaaf7910bb23f6d
  store %Variant_std_2Ecore_Result_ccaaf7910bb23f6d %__3, ptr %drop_variant_ptr106
  call void @__drift_array_drop_std__std_core_Result_Int_std__std_net_NetError__ccaaf7910bb23f6d(i64 1, ptr %drop_variant_ptr106)
  %.t145 = add i1 0, 1
  %__arc14 = select i1 1, %Variant_std_2Ecore_Result_ccaaf7910bb23f6d zeroinitializer, %Variant_std_2Ecore_Result_ccaaf7910bb23f6d zeroinitializer
  %drop_variant_ptr107 = alloca %Variant_std_2Ecore_Result_ccaaf7910bb23f6d
  store %Variant_std_2Ecore_Result_ccaaf7910bb23f6d %.t144, ptr %drop_variant_ptr107
  call void @__drift_array_drop_std__std_core_Result_Int_std__std_net_NetError__ccaaf7910bb23f6d(i64 1, ptr %drop_variant_ptr107)
  %__cleanup_t4 = load %Struct_std_2Eio_Buffer_e76b5c24b140f2f4, ptr %wbuf__addr
  %zero_struct108 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 zeroinitializer, %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c zeroinitializer, 0
  %zero_struct109 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %zero_struct108, i64 0, 1
  %__arc15 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %zero_struct109, i64 0, 2
  store %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %__arc15, ptr %wbuf__addr
  call void @"std.io::Buffer::std.core.Destructible::destroy"(%Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %__cleanup_t4)
  br label %.bb.if_join5
.bb.if_then6:
  %.t133 = call i8 @"std.io::buffer_read"(ptr %rbuf__addr, i64 %j_6)
  call void @"std.io::buffer_write"(ptr %wbuf__addr, i64 %j_6, i8 %.t133)
  %.t135 = add i64 0, 1
  %.t136 = add i64 %j_6, %.t135
  br label %.bb.if_join6
.bb.if_join6:
  br label %.bb.loop_header2
.bb.if_then5:
  %.t121 = add i1 0, 1
  %.t122 = add i1 0, 1
  br label %.bb.if_join5
.bb.if_join5:
  %j_4 = phi i64 [ %j_3, %.bb.if_then5 ], [ %j_6, %.bb.loop_exit2 ]
  %remove_5 = phi i1 [ %.t121, %.bb.if_then5 ], [ %.t96, %.bb.loop_exit2 ]
  %progressed_6 = phi i1 [ %.t122, %.bb.if_then5 ], [ %.t145, %.bb.loop_exit2 ]
  %__4 = phi %Variant_std_2Ecore_Result_ccaaf7910bb23f6d [ %__3, %.bb.if_then5 ], [ %__arc14, %.bb.loop_exit2 ]
  br label %.bb.match_join1
.bb.match_join1:
  %j_8 = phi i64 [ %j_4, %.bb.if_join5 ], [ %j_3, %.bb.if_join7 ]
  %remove_7 = phi i1 [ %remove_5, %.bb.if_join5 ], [ %remove_9, %.bb.if_join7 ]
  %progressed_9 = phi i1 [ %progressed_6, %.bb.if_join5 ], [ %progressed_5, %.bb.if_join7 ]
  %__match_binder_4_e_4 = phi %Struct_std_2Enet_NetError_203564604ea2d3a4 [ %__match_binder_4_e_3, %.bb.if_join5 ], [ %__arc9, %.bb.if_join7 ]
  %__8 = phi %Variant_std_2Ecore_Result_ccaaf7910bb23f6d [ %__4, %.bb.if_join5 ], [ %__3, %.bb.if_join7 ]
  br i1 %remove_7, label %.bb.if_then8, label %.bb.if_else5
.bb.if_else5:
  %.t215 = add i64 0, 1
  %.t216 = add i64 %i_4, %.t215
  br label %.bb.if_join8
.bb.if_then8:
  %.t161 = load %DriftArrayHeader, ptr %streams__addr
  %.t162 = extractvalue %DriftArrayHeader %.t161, 0
  %.t163 = add i64 0, 1
  %.t164 = sub i64 %.t162, %.t163
  %.t166 = load %DriftArrayHeader, ptr %streams__addr
  %len110 = extractvalue %DriftArrayHeader %.t166, 0
  %data111 = extractvalue %DriftArrayHeader %.t166, 3
  %strptr112 = getelementptr inbounds { i64, i64, [21 x i8] }, ptr @.str4, i32 0, i32 2, i32 0
  %str0113 = insertvalue %DriftString zeroinitializer, i64 20, 0
  %str114 = insertvalue %DriftString %str0113, ptr %strptr112, 1
  call void @drift_bounds_check(%DriftString %str114, i64 %i_4, i64 %len110)
  %eltptr115 = getelementptr %Struct_std_2Enet_TcpStream_363317ef680a1400, ptr %data111, i64 %i_4
  %len116 = extractvalue %DriftArrayHeader %.t166, 0
  %data117 = extractvalue %DriftArrayHeader %.t166, 3
  %strptr118 = getelementptr inbounds { i64, i64, [21 x i8] }, ptr @.str4, i32 0, i32 2, i32 0
  %str0119 = insertvalue %DriftString zeroinitializer, i64 20, 0
  %str120 = insertvalue %DriftString %str0119, ptr %strptr118, 1
  call void @drift_bounds_check(%DriftString %str120, i64 %.t164, i64 %len116)
  %eltptr121 = getelementptr %Struct_std_2Enet_TcpStream_363317ef680a1400, ptr %data117, i64 %.t164
  %.t171 = icmp eq i64 %i_4, %.t164
  br i1 %.t171, label %.bb.array_swap_same, label %.bb.array_swap_do
.bb.array_swap_do:
  %len122 = extractvalue %DriftArrayHeader %.t166, 0
  %data123 = extractvalue %DriftArrayHeader %.t166, 3
  %strptr124 = getelementptr inbounds { i64, i64, [21 x i8] }, ptr @.str4, i32 0, i32 2, i32 0
  %str0125 = insertvalue %DriftString zeroinitializer, i64 20, 0
  %str126 = insertvalue %DriftString %str0125, ptr %strptr124, 1
  call void @drift_bounds_check(%DriftString %str126, i64 %i_4, i64 %len122)
  %eltptr127 = getelementptr %Struct_std_2Enet_TcpStream_363317ef680a1400, ptr %data123, i64 %i_4
  %.t172 = load %Struct_std_2Enet_TcpStream_363317ef680a1400, ptr %eltptr127
  %len128 = extractvalue %DriftArrayHeader %.t166, 0
  %data129 = extractvalue %DriftArrayHeader %.t166, 3
  %strptr130 = getelementptr inbounds { i64, i64, [21 x i8] }, ptr @.str4, i32 0, i32 2, i32 0
  %str0131 = insertvalue %DriftString zeroinitializer, i64 20, 0
  %str132 = insertvalue %DriftString %str0131, ptr %strptr130, 1
  call void @drift_bounds_check(%DriftString %str132, i64 %.t164, i64 %len128)
  %eltptr133 = getelementptr %Struct_std_2Enet_TcpStream_363317ef680a1400, ptr %data129, i64 %.t164
  %.t173 = load %Struct_std_2Enet_TcpStream_363317ef680a1400, ptr %eltptr133
  %data134 = extractvalue %DriftArrayHeader %.t166, 3
  %eltptr135 = getelementptr inbounds %Struct_std_2Enet_TcpStream_363317ef680a1400, ptr %data134, i64 %i_4
  store %Struct_std_2Enet_TcpStream_363317ef680a1400 %.t173, ptr %eltptr135
  %data136 = extractvalue %DriftArrayHeader %.t166, 3
  %eltptr137 = getelementptr inbounds %Struct_std_2Enet_TcpStream_363317ef680a1400, ptr %data136, i64 %.t164
  store %Struct_std_2Enet_TcpStream_363317ef680a1400 %.t172, ptr %eltptr137
  br label %.bb.array_swap_join
.bb.array_swap_same:
  br label %.bb.array_swap_join
.bb.array_swap_join:
  %.t175 = load %DriftArrayHeader, ptr %streams__addr
  %.t177 = extractvalue %DriftArrayHeader %.t175, 0
  %.t178 = add i64 0, 0
  %.t179 = icmp eq i64 %.t177, %.t178
  br i1 %.t179, label %.bb.array_pop_empty, label %.bb.array_pop_ok
.bb.array_pop_ok:
  %.t181 = add i64 0, 1
  %.t182 = sub i64 %.t177, %.t181
  %len138 = extractvalue %DriftArrayHeader %.t175, 0
  %data139 = extractvalue %DriftArrayHeader %.t175, 3
  %strptr140 = getelementptr inbounds { i64, i64, [21 x i8] }, ptr @.str4, i32 0, i32 2, i32 0
  %str0141 = insertvalue %DriftString zeroinitializer, i64 20, 0
  %str142 = insertvalue %DriftString %str0141, ptr %strptr140, 1
  call void @drift_bounds_check(%DriftString %str142, i64 %.t182, i64 %len138)
  %eltptr143 = getelementptr %Struct_std_2Enet_TcpStream_363317ef680a1400, ptr %data139, i64 %.t182
  %.t183 = load %Struct_std_2Enet_TcpStream_363317ef680a1400, ptr %eltptr143
  %.t184 = sub i64 %.t177, %.t181
  %arr_len144 = insertvalue %DriftArrayHeader %.t175, i64 %.t184, 0
  %.t186 = extractvalue %DriftArrayHeader %.t175, 2
  %.t187 = add i64 0, 1
  %.t188 = add i64 %.t186, %.t187
  %arr_gen145 = insertvalue %DriftArrayHeader %arr_len144, i64 %.t188, 2
  store %DriftArrayHeader %arr_gen145, ptr %streams__addr
  %variant146 = alloca %Variant_lang_2Ecore_Optional_0c32631472b0a6e3
  store %Variant_lang_2Ecore_Optional_0c32631472b0a6e3 zeroinitializer, ptr %variant146
  %tagptr147 = getelementptr inbounds %Variant_lang_2Ecore_Optional_0c32631472b0a6e3, ptr %variant146, i32 0, i32 0
  store i8 1, ptr %tagptr147
  %payload_words148 = getelementptr inbounds %Variant_lang_2Ecore_Optional_0c32631472b0a6e3, ptr %variant146, i32 0, i32 2
  %fieldptr149 = getelementptr inbounds { %Struct_std_2Enet_TcpStream_363317ef680a1400 }, ptr %payload_words148, i32 0, i32 0
  store %Struct_std_2Enet_TcpStream_363317ef680a1400 %.t183, ptr %fieldptr149
  %.t190 = load %Variant_lang_2Ecore_Optional_0c32631472b0a6e3, ptr %variant146
  br label %.bb.array_pop_join
.bb.array_pop_empty:
  %.t180 = insertvalue %Variant_lang_2Ecore_Optional_0c32631472b0a6e3 zeroinitializer, i8 0, 0
  br label %.bb.array_pop_join
.bb.array_pop_join:
  %__array_pop_res.t176_5 = phi %Variant_lang_2Ecore_Optional_0c32631472b0a6e3 [ %.t180, %.bb.array_pop_empty ], [ %.t190, %.bb.array_pop_ok ]
  br label %.bb.match_dispatch2
.bb.match_dispatch2:
  %tag8150 = extractvalue %Variant_lang_2Ecore_Optional_0c32631472b0a6e3 %__array_pop_res.t176_5, 0
  %.t192 = zext i8 %tag8150 to i64
  %.t193 = add i64 0, 1
  %.t194 = icmp eq i64 %.t192, %.t193
  br i1 %.t194, label %.bb.match_arm_02, label %.bb.match_dispatch_next4
.bb.match_dispatch_next4:
  %.t195 = add i64 0, 0
  %.t196 = icmp eq i64 %.t192, %.t195
  br i1 %.t196, label %.bb.match_arm_12, label %.bb.match_dispatch_next5
.bb.match_dispatch_next5:
  unreachable
.bb.match_arm_12:
  %__arc39 = select i1 1, %Variant_lang_2Ecore_Optional_0c32631472b0a6e3 zeroinitializer, %Variant_lang_2Ecore_Optional_0c32631472b0a6e3 zeroinitializer
  store %Variant_lang_2Ecore_Optional_0c32631472b0a6e3 %__array_pop_res.t176_5, ptr %__match_scrut_tmp.t210__addr
  br label %.bb.match_join2
.bb.match_arm_02:
  %__arc23 = select i1 1, %Variant_lang_2Ecore_Optional_0c32631472b0a6e3 zeroinitializer, %Variant_lang_2Ecore_Optional_0c32631472b0a6e3 zeroinitializer
  store %Variant_lang_2Ecore_Optional_0c32631472b0a6e3 %__array_pop_res.t176_5, ptr %__match_scrut_tmp.t197__addr
  %payload_words151 = getelementptr inbounds %Variant_lang_2Ecore_Optional_0c32631472b0a6e3, ptr %__match_scrut_tmp.t197__addr, i32 0, i32 2
  %fieldptr152 = getelementptr inbounds { %Struct_std_2Enet_TcpStream_363317ef680a1400 }, ptr %payload_words151, i32 0, i32 0
  %.t202 = load %Struct_std_2Enet_TcpStream_363317ef680a1400, ptr %fieldptr152
  %__arc24 = insertvalue %Struct_std_2Enet_TcpStream_363317ef680a1400 zeroinitializer, i64 0, 0
  %__arc25 = insertvalue %Struct_std_2Enet_TcpStream_363317ef680a1400 zeroinitializer, i64 0, 0
  store %Struct_std_2Enet_TcpStream_363317ef680a1400 %.t202, ptr %st__addr
  %.t209 = call %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 @"std.net::TcpStream::close"(ptr %st__addr, %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %.t3)
  %__arc26 = select i1 1, %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 zeroinitializer, %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 zeroinitializer
  %drop_variant_ptr153 = alloca %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6
  store %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 %.t209, ptr %drop_variant_ptr153
  call void @__drift_array_drop_std__std_core_Result_Void_std__std_net_NetError__9dbf2dcdb5537ee6(i64 1, ptr %drop_variant_ptr153)
  br label %.bb.match_join2
.bb.match_join2:
  br label %.bb.if_join8
.bb.if_join8:
  %__array_pop_res.t176_7 = phi %Variant_lang_2Ecore_Optional_0c32631472b0a6e3 [ %__array_pop_res.t176_3, %.bb.if_else5 ], [ %__array_pop_res.t176_5, %.bb.match_join2 ]
  %i_6 = phi i64 [ %.t216, %.bb.if_else5 ], [ %i_4, %.bb.match_join2 ]
  %__cleanup_t6 = load %Struct_std_2Eio_Buffer_e76b5c24b140f2f4, ptr %rbuf__addr
  %zero_struct154 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 zeroinitializer, %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c zeroinitializer, 0
  %zero_struct155 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %zero_struct154, i64 0, 1
  %__arc10 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %zero_struct155, i64 0, 2
  store %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %__arc10, ptr %rbuf__addr
  call void @"std.io::Buffer::std.core.Destructible::destroy"(%Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %__cleanup_t6)
  br label %.bb.if_join4
.bb.if_join4:
  br label %.bb.loop_header1
}
define i1 @"spike::_send"(ptr %stream_1, ptr %s_1) {
.bb.entry:
  %b__addr = alloca %Struct_std_2Eio_Buffer_e76b5c24b140f2f4
  %__match_scrut_tmp.t22__addr = alloca %Variant_std_2Ecore_Result_ccaaf7910bb23f6d
  %__match_scrut_tmp.t14__addr = alloca %Variant_std_2Ecore_Result_ccaaf7910bb23f6d
  %zero_struct1 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc1 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %zero_struct1, i64 0, 1
  %strptr2 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str7, i32 0, i32 2, i32 0
  %str03 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str03, ptr %strptr2, 1
  %.t3 = call %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 @"spike::_to_buf"(ptr %s_1)
  store %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %.t3, ptr %b__addr
  %.t6 = add i64 0, 2000
  %.t7 = insertvalue %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 zeroinitializer, i64 %.t6, 0
  %.t8 = call %Variant_std_2Ecore_Result_ccaaf7910bb23f6d @"std.net::TcpStream::write"(ptr %stream_1, ptr %b__addr, %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %.t7)
  br label %.bb.match_dispatch
.bb.match_dispatch:
  %tag84 = extractvalue %Variant_std_2Ecore_Result_ccaaf7910bb23f6d %.t8, 0
  %.t9 = zext i8 %tag84 to i64
  %.t10 = add i64 0, 0
  %.t11 = icmp eq i64 %.t9, %.t10
  br i1 %.t11, label %.bb.match_arm_0, label %.bb.match_dispatch_next
.bb.match_dispatch_next:
  %.t12 = add i64 0, 1
  %.t13 = icmp eq i64 %.t9, %.t12
  br i1 %.t13, label %.bb.match_arm_1, label %.bb.match_dispatch_next1
.bb.match_dispatch_next1:
  unreachable
.bb.match_arm_1:
  %__arc5 = select i1 1, %Variant_std_2Ecore_Result_ccaaf7910bb23f6d zeroinitializer, %Variant_std_2Ecore_Result_ccaaf7910bb23f6d zeroinitializer
  store %Variant_std_2Ecore_Result_ccaaf7910bb23f6d %.t8, ptr %__match_scrut_tmp.t22__addr
  %payload_words5 = getelementptr inbounds %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %__match_scrut_tmp.t22__addr, i32 0, i32 2
  %fieldptr6 = getelementptr inbounds { %Struct_std_2Enet_NetError_203564604ea2d3a4 }, ptr %payload_words5, i32 0, i32 0
  %.t27 = load %Struct_std_2Enet_NetError_203564604ea2d3a4, ptr %fieldptr6
  %zero_struct7 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc6 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %zero_struct7, i64 0, 1
  %zero_struct8 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc8 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %zero_struct8, i64 0, 1
  %drop_field9 = extractvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %__arc1, 0
  call void @drift_string_release(%DriftString %drop_field9)
  %.t31 = add i1 0, 0
  %zero_struct10 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc9 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %zero_struct10, i64 0, 1
  %drop_field11 = extractvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %.t27, 0
  call void @drift_string_release(%DriftString %drop_field11)
  %__cleanup_t4 = load %Struct_std_2Eio_Buffer_e76b5c24b140f2f4, ptr %b__addr
  %zero_struct12 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 zeroinitializer, %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c zeroinitializer, 0
  %zero_struct13 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %zero_struct12, i64 0, 1
  %__arc10 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %zero_struct13, i64 0, 2
  store %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %__arc10, ptr %b__addr
  call void @"std.io::Buffer::std.core.Destructible::destroy"(%Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %__cleanup_t4)
  ret i1 %.t31
.bb.match_arm_0:
  %__arc2 = select i1 1, %Variant_std_2Ecore_Result_ccaaf7910bb23f6d zeroinitializer, %Variant_std_2Ecore_Result_ccaaf7910bb23f6d zeroinitializer
  store %Variant_std_2Ecore_Result_ccaaf7910bb23f6d %.t8, ptr %__match_scrut_tmp.t14__addr
  %payload_words14 = getelementptr inbounds %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %__match_scrut_tmp.t14__addr, i32 0, i32 2
  %fieldptr15 = getelementptr inbounds { i64 }, ptr %payload_words14, i32 0, i32 0
  %.t19 = load i64, ptr %fieldptr15
  %__cleanup_t1 = load %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %__match_scrut_tmp.t14__addr
  %__arc3 = select i1 1, %Variant_std_2Ecore_Result_ccaaf7910bb23f6d zeroinitializer, %Variant_std_2Ecore_Result_ccaaf7910bb23f6d zeroinitializer
  store %Variant_std_2Ecore_Result_ccaaf7910bb23f6d %__arc3, ptr %__match_scrut_tmp.t14__addr
  %drop_variant_ptr16 = alloca %Variant_std_2Ecore_Result_ccaaf7910bb23f6d
  store %Variant_std_2Ecore_Result_ccaaf7910bb23f6d %__cleanup_t1, ptr %drop_variant_ptr16
  call void @__drift_array_drop_std__std_core_Result_Int_std__std_net_NetError__ccaaf7910bb23f6d(i64 1, ptr %drop_variant_ptr16)
  %.t21 = add i1 0, 1
  %__cleanup_t2 = load %Struct_std_2Eio_Buffer_e76b5c24b140f2f4, ptr %b__addr
  %zero_struct17 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 zeroinitializer, %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c zeroinitializer, 0
  %zero_struct18 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %zero_struct17, i64 0, 1
  %__arc4 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %zero_struct18, i64 0, 2
  store %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %__arc4, ptr %b__addr
  call void @"std.io::Buffer::std.core.Destructible::destroy"(%Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %__cleanup_t2)
  ret i1 %.t21
}
define %DriftString @"spike::_recv"(ptr %stream_1, i64 %expect_len_1) {
.bb.entry:
  %got__addr = alloca %DriftArrayHeader
  %ob__addr = alloca %Struct_std_2Eio_Buffer_e76b5c24b140f2f4
  %__throw_diag_.t116__addr = alloca %Struct_std_2Eerr_IndexError_db7149950235ecbd
  %rbuf__addr = alloca %Struct_std_2Eio_Buffer_e76b5c24b140f2f4
  %__match_scrut_tmp.t34__addr = alloca %Variant_std_2Ecore_Result_ccaaf7910bb23f6d
  %__array_new_cap.t69__addr = alloca i64
  %__array_copy_i.t75__addr = alloca i64
  %__match_scrut_tmp.t24__addr = alloca %Variant_std_2Ecore_Result_ccaaf7910bb23f6d
  %zero_arr1 = insertvalue %DriftArrayHeader zeroinitializer, i64 0, 0
  %zero_arr2 = insertvalue %DriftArrayHeader %zero_arr1, i64 0, 1
  %zero_arr3 = insertvalue %DriftArrayHeader %zero_arr2, i64 0, 2
  %__arc2 = insertvalue %DriftArrayHeader %zero_arr3, ptr null, 3
  store %DriftArrayHeader %__arc2, ptr %got__addr
  %zero_struct4 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc3 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %zero_struct4, i64 0, 1
  %strptr5 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str8, i32 0, i32 2, i32 0
  %str06 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str06, ptr %strptr5, 1
  %.t3 = add i64 0, 0
  %.t4 = add i64 0, 0
  %.t5 = add i64 0, 0
  %len08 = add i64 0, 0
  %arr7 = call ptr @drift_alloc_array(i64 1, i64 1, i64 %len08, i64 %.t4)
  %arrh09 = insertvalue %DriftArrayHeader zeroinitializer, i64 %len08, 0
  %arrh110 = insertvalue %DriftArrayHeader %arrh09, i64 %.t4, 1
  %arrh211 = insertvalue %DriftArrayHeader %arrh110, i64 0, 2
  %.t2 = insertvalue %DriftArrayHeader %arrh211, ptr %arr7, 3
  %arr_len12 = insertvalue %DriftArrayHeader %.t2, i64 %.t3, 0
  %__arc4 = load %DriftArrayHeader, ptr %got__addr
  %zero_arr13 = insertvalue %DriftArrayHeader zeroinitializer, i64 0, 0
  %zero_arr14 = insertvalue %DriftArrayHeader %zero_arr13, i64 0, 1
  %zero_arr15 = insertvalue %DriftArrayHeader %zero_arr14, i64 0, 2
  %__arc5 = insertvalue %DriftArrayHeader %zero_arr15, ptr null, 3
  store %DriftArrayHeader %__arc5, ptr %got__addr
  %len16 = extractvalue %DriftArrayHeader %__arc4, 0
  %data17 = extractvalue %DriftArrayHeader %__arc4, 3
  call void @drift_free_array(ptr %data17)
  store %DriftArrayHeader %arr_len12, ptr %got__addr
  %.t7 = add i64 0, 2000
  %.t8 = insertvalue %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 zeroinitializer, i64 %.t7, 0
  %__array_cap_grew.t63_1 = add i1 0, 0
  %zero_arr18 = insertvalue %DriftArrayHeader zeroinitializer, i64 0, 0
  %zero_arr19 = insertvalue %DriftArrayHeader %zero_arr18, i64 0, 1
  %zero_arr20 = insertvalue %DriftArrayHeader %zero_arr19, i64 0, 2
  %__array_cap_arr.t62_1 = insertvalue %DriftArrayHeader %zero_arr20, ptr null, 3
  %j_1 = add i64 0, 0
  br label %.bb.loop_header
.bb.loop_header:
  %__array_cap_grew.t63_2 = phi i1 [ %__array_cap_grew.t63_1, %.bb.entry ], [ %__array_cap_grew.t63_3, %.bb.if_join ]
  %__array_cap_arr.t62_2 = phi %DriftArrayHeader [ %__array_cap_arr.t62_1, %.bb.entry ], [ %__array_cap_arr.t62_3, %.bb.if_join ]
  %j_2 = phi i64 [ %j_1, %.bb.entry ], [ %j_4, %.bb.if_join ]
  br label %.bb.loop_body
.bb.loop_body:
  %.t9 = load %DriftArrayHeader, ptr %got__addr
  %.t10 = extractvalue %DriftArrayHeader %.t9, 0
  %.t12 = icmp slt i64 %.t10, %expect_len_1
  br i1 %.t12, label %.bb.if_then, label %.bb.if_else
.bb.if_else:
  br label %.bb.loop_exit
.bb.loop_exit:
  %.t93 = load %DriftArrayHeader, ptr %got__addr
  %.t94 = extractvalue %DriftArrayHeader %.t93, 0
  %.t95 = call %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 @"std.io::buffer"(i64 %.t94)
  store %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %.t95, ptr %ob__addr
  %.t96 = add i64 0, 0
  br label %.bb.loop_header2
.bb.loop_header2:
  %k_2 = phi i64 [ %.t96, %.bb.loop_exit ], [ %.t125, %.bb.if_join3 ]
  br label %.bb.loop_body2
.bb.loop_body2:
  %.t98 = load %DriftArrayHeader, ptr %got__addr
  %.t99 = extractvalue %DriftArrayHeader %.t98, 0
  %.t100 = icmp slt i64 %k_2, %.t99
  br i1 %.t100, label %.bb.if_then3, label %.bb.if_else2
.bb.if_else2:
  br label %.bb.loop_exit2
.bb.loop_exit2:
  %.t127 = call ptr @"std.io::buffer_ptr"(ptr %ob__addr)
  %.t128 = load %DriftArrayHeader, ptr %got__addr
  %.t129 = extractvalue %DriftArrayHeader %.t128, 0
  %.t130 = call %DriftString @drift_string_from_utf8_bytes(ptr %.t127, i64 %.t129)
  %__cleanup_t8 = load %Struct_std_2Eio_Buffer_e76b5c24b140f2f4, ptr %ob__addr
  %zero_struct21 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 zeroinitializer, %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c zeroinitializer, 0
  %zero_struct22 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %zero_struct21, i64 0, 1
  %__arc8 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %zero_struct22, i64 0, 2
  store %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %__arc8, ptr %ob__addr
  call void @"std.io::Buffer::std.core.Destructible::destroy"(%Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %__cleanup_t8)
  %__cleanup_t9 = load %DriftArrayHeader, ptr %got__addr
  %zero_arr23 = insertvalue %DriftArrayHeader zeroinitializer, i64 0, 0
  %zero_arr24 = insertvalue %DriftArrayHeader %zero_arr23, i64 0, 1
  %zero_arr25 = insertvalue %DriftArrayHeader %zero_arr24, i64 0, 2
  %__arc9 = insertvalue %DriftArrayHeader %zero_arr25, ptr null, 3
  store %DriftArrayHeader %__arc9, ptr %got__addr
  %len26 = extractvalue %DriftArrayHeader %__cleanup_t9, 0
  %data27 = extractvalue %DriftArrayHeader %__cleanup_t9, 3
  call void @drift_free_array(ptr %data27)
  ret %DriftString %.t130
.bb.if_then3:
  %.t103 = load %DriftArrayHeader, ptr %got__addr
  %.t105 = extractvalue %DriftArrayHeader %.t103, 0
  %.t106 = add i64 0, 0
  %.t107 = icmp slt i64 %k_2, %.t106
  %.t108 = icmp sge i64 %k_2, %.t105
  %.t109 = or i1 %.t107, %.t108
  br i1 %.t109, label %.bb.idx_err, label %.bb.idx_ok
.bb.idx_ok:
  %len28 = extractvalue %DriftArrayHeader %.t103, 0
  %data29 = extractvalue %DriftArrayHeader %.t103, 3
  %eltptr30 = getelementptr i8, ptr %data29, i64 %k_2
  %.t120 = load i8, ptr %eltptr30
  br label %.bb.idx_join
.bb.idx_join:
  call void @"std.io::buffer_write"(ptr %ob__addr, i64 %k_2, i8 %.t120)
  %.t124 = add i64 0, 1
  %.t125 = add i64 %k_2, %.t124
  br label %.bb.if_join3
.bb.if_join3:
  br label %.bb.loop_header2
.bb.idx_err:
  %.t111 = add i64 0, 1726084857549659354
  %strptr31 = getelementptr inbounds { i64, i64, [19 x i8] }, ptr @.str9, i32 0, i32 2, i32 0
  %str032 = insertvalue %DriftString zeroinitializer, i64 18, 0
  %.t112 = insertvalue %DriftString %str032, ptr %strptr31, 1
  %strptr33 = getelementptr inbounds { i64, i64, [21 x i8] }, ptr @.str10, i32 0, i32 2, i32 0
  %str034 = insertvalue %DriftString zeroinitializer, i64 20, 0
  %.t113 = insertvalue %DriftString %str034, ptr %strptr33, 1
  %struct35 = insertvalue %Struct_std_2Eerr_IndexError_db7149950235ecbd zeroinitializer, %DriftString %.t113, 0
  %.t115 = insertvalue %Struct_std_2Eerr_IndexError_db7149950235ecbd %struct35, i64 %k_2, 1
  store %Struct_std_2Eerr_IndexError_db7149950235ecbd %.t115, ptr %__throw_diag_.t116__addr
  %.t118 = call %DriftString @"std.err::std.err.IndexError::std.core.Diagnostic::to_json_text"(ptr %__throw_diag_.t116__addr)
  %.t114 = call ptr @drift_error_new(i64 %.t111, %DriftString %.t112)
  call void @drift_error_set_params_json(ptr %.t114, %DriftString %.t118)
  %.t119 = load %Struct_std_2Eerr_IndexError_db7149950235ecbd, ptr %__throw_diag_.t116__addr
  %drop_field36 = extractvalue %Struct_std_2Eerr_IndexError_db7149950235ecbd %.t119, 0
  call void @drift_string_release(%DriftString %drop_field36)
  call void @drift_error_raise(ptr %.t114)
  unreachable
.bb.if_then:
  %.t13 = add i64 0, 1024
  %.t14 = call %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 @"std.io::buffer"(i64 %.t13)
  store %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %.t14, ptr %rbuf__addr
  %.t18 = call %Variant_std_2Ecore_Result_ccaaf7910bb23f6d @"std.net::TcpStream::read"(ptr %stream_1, ptr %rbuf__addr, %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %.t8)
  br label %.bb.match_dispatch
.bb.match_dispatch:
  %tag837 = extractvalue %Variant_std_2Ecore_Result_ccaaf7910bb23f6d %.t18, 0
  %.t19 = zext i8 %tag837 to i64
  %.t20 = add i64 0, 1
  %.t21 = icmp eq i64 %.t19, %.t20
  br i1 %.t21, label %.bb.match_arm_0, label %.bb.match_dispatch_next
.bb.match_dispatch_next:
  %.t22 = add i64 0, 0
  %.t23 = icmp eq i64 %.t19, %.t22
  br i1 %.t23, label %.bb.match_arm_1, label %.bb.match_dispatch_next1
.bb.match_dispatch_next1:
  unreachable
.bb.match_arm_1:
  %__arc17 = select i1 1, %Variant_std_2Ecore_Result_ccaaf7910bb23f6d zeroinitializer, %Variant_std_2Ecore_Result_ccaaf7910bb23f6d zeroinitializer
  store %Variant_std_2Ecore_Result_ccaaf7910bb23f6d %.t18, ptr %__match_scrut_tmp.t34__addr
  %payload_words38 = getelementptr inbounds %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %__match_scrut_tmp.t34__addr, i32 0, i32 2
  %fieldptr39 = getelementptr inbounds { i64 }, ptr %payload_words38, i32 0, i32 0
  %.t39 = load i64, ptr %fieldptr39
  %__cleanup_t5 = load %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %__match_scrut_tmp.t34__addr
  %__arc18 = select i1 1, %Variant_std_2Ecore_Result_ccaaf7910bb23f6d zeroinitializer, %Variant_std_2Ecore_Result_ccaaf7910bb23f6d zeroinitializer
  store %Variant_std_2Ecore_Result_ccaaf7910bb23f6d %__arc18, ptr %__match_scrut_tmp.t34__addr
  %drop_variant_ptr40 = alloca %Variant_std_2Ecore_Result_ccaaf7910bb23f6d
  store %Variant_std_2Ecore_Result_ccaaf7910bb23f6d %__cleanup_t5, ptr %drop_variant_ptr40
  call void @__drift_array_drop_std__std_core_Result_Int_std__std_net_NetError__ccaaf7910bb23f6d(i64 1, ptr %drop_variant_ptr40)
  %.t42 = add i64 0, 0
  %.t43 = icmp eq i64 %.t39, %.t42
  br i1 %.t43, label %.bb.if_then1, label %.bb.if_join1
.bb.if_join1:
  %.t45 = add i64 0, 0
  br label %.bb.loop_header1
.bb.loop_header1:
  %__array_cap_grew.t63_3 = phi i1 [ %__array_cap_grew.t63_2, %.bb.if_join1 ], [ %__array_cap_grew.t63_5, %.bb.if_join2 ]
  %__array_cap_arr.t62_3 = phi %DriftArrayHeader [ %__array_cap_arr.t62_2, %.bb.if_join1 ], [ %__arc1, %.bb.if_join2 ]
  %j_4 = phi i64 [ %.t45, %.bb.if_join1 ], [ %.t92, %.bb.if_join2 ]
  br label %.bb.loop_body1
.bb.loop_body1:
  %.t48 = icmp slt i64 %j_4, %.t39
  br i1 %.t48, label %.bb.if_then2, label %.bb.if_else1
.bb.if_else1:
  br label %.bb.loop_exit1
.bb.loop_exit1:
  br label %.bb.match_join
.bb.match_join:
  %__cleanup_t1 = load %Struct_std_2Eio_Buffer_e76b5c24b140f2f4, ptr %rbuf__addr
  %zero_struct41 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 zeroinitializer, %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c zeroinitializer, 0
  %zero_struct42 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %zero_struct41, i64 0, 1
  %__arc19 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %zero_struct42, i64 0, 2
  store %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %__arc19, ptr %rbuf__addr
  call void @"std.io::Buffer::std.core.Destructible::destroy"(%Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %__cleanup_t1)
  br label %.bb.if_join
.bb.if_join:
  br label %.bb.loop_header
.bb.if_then2:
  %.t50 = load %DriftArrayHeader, ptr %got__addr
  %.t53 = call i8 @"std.io::buffer_read"(ptr %rbuf__addr, i64 %j_4)
  %.t54 = extractvalue %DriftArrayHeader %.t50, 0
  %.t55 = extractvalue %DriftArrayHeader %.t50, 1
  %.t56 = extractvalue %DriftArrayHeader %.t50, 2
  %.t57 = add i64 0, 1
  %.t58 = add i64 %.t56, %.t57
  %.t59 = add i64 0, 1
  %.t60 = add i64 %.t54, %.t59
  %.t61 = icmp sle i64 %.t60, %.t55
  br i1 %.t61, label %.bb.array_cap_ok, label %.bb.array_cap_grow
.bb.array_cap_grow:
  %.t65 = add i64 0, 2
  %.t66 = mul i64 %.t55, %.t65
  %.t67 = icmp slt i64 %.t66, %.t60
  %.t68 = add i64 0, 0
  store i64 %.t68, ptr %__array_new_cap.t69__addr
  br i1 %.t67, label %.bb.array_cap_need, label %.bb.array_cap_x2
.bb.array_cap_x2:
  store i64 %.t66, ptr %__array_new_cap.t69__addr
  br label %.bb.array_cap_join
.bb.array_cap_need:
  store i64 %.t60, ptr %__array_new_cap.t69__addr
  br label %.bb.array_cap_join
.bb.array_cap_join:
  %.t71 = load i64, ptr %__array_new_cap.t69__addr
  %.t72 = add i64 0, 0
  %len044 = add i64 0, 0
  %arr43 = call ptr @drift_alloc_array(i64 1, i64 1, i64 %len044, i64 %.t71)
  %arrh045 = insertvalue %DriftArrayHeader zeroinitializer, i64 %len044, 0
  %arrh146 = insertvalue %DriftArrayHeader %arrh045, i64 %.t71, 1
  %arrh247 = insertvalue %DriftArrayHeader %arrh146, i64 0, 2
  %.t73 = insertvalue %DriftArrayHeader %arrh247, ptr %arr43, 3
  %.t74 = add i64 0, 0
  store i64 %.t74, ptr %__array_copy_i.t75__addr
  store i64 %.t72, ptr %__array_copy_i.t75__addr
  br label %.bb.array_copy_cond
.bb.array_copy_cond:
  %.t77 = load i64, ptr %__array_copy_i.t75__addr
  %.t78 = icmp slt i64 %.t77, %.t54
  br i1 %.t78, label %.bb.array_copy_body, label %.bb.array_copy_exit
.bb.array_copy_exit:
  %arr_len48 = insertvalue %DriftArrayHeader %.t73, i64 %.t54, 0
  %arr_len49 = insertvalue %DriftArrayHeader %.t50, i64 %.t72, 0
  %len50 = extractvalue %DriftArrayHeader %arr_len49, 0
  %data51 = extractvalue %DriftArrayHeader %arr_len49, 3
  call void @drift_free_array(ptr %data51)
  %.t84 = add i1 0, 1
  br label %.bb.array_cap_join2
.bb.array_copy_body:
  %len52 = extractvalue %DriftArrayHeader %.t50, 0
  %data53 = extractvalue %DriftArrayHeader %.t50, 3
  %strptr54 = getelementptr inbounds { i64, i64, [21 x i8] }, ptr @.str4, i32 0, i32 2, i32 0
  %str055 = insertvalue %DriftString zeroinitializer, i64 20, 0
  %str56 = insertvalue %DriftString %str055, ptr %strptr54, 1
  call void @drift_bounds_check(%DriftString %str56, i64 %.t77, i64 %len52)
  %eltptr57 = getelementptr i8, ptr %data53, i64 %.t77
  %.t79 = load i8, ptr %eltptr57
  %data58 = extractvalue %DriftArrayHeader %.t73, 3
  %eltptr59 = getelementptr inbounds i8, ptr %data58, i64 %.t77
  store i8 %.t79, ptr %eltptr59
  %.t81 = add i64 0, 1
  %.t80 = add i64 %.t77, %.t81
  store i64 %.t80, ptr %__array_copy_i.t75__addr
  br label %.bb.array_copy_cond
.bb.array_cap_ok:
  %.t64 = add i1 0, 0
  br label %.bb.array_cap_join2
.bb.array_cap_join2:
  %__array_cap_grew.t63_5 = phi i1 [ %.t84, %.bb.array_copy_exit ], [ %.t64, %.bb.array_cap_ok ]
  %__array_cap_arr.t62_5 = phi %DriftArrayHeader [ %arr_len48, %.bb.array_copy_exit ], [ %.t50, %.bb.array_cap_ok ]
  %zero_arr60 = insertvalue %DriftArrayHeader zeroinitializer, i64 0, 0
  %zero_arr61 = insertvalue %DriftArrayHeader %zero_arr60, i64 0, 1
  %zero_arr62 = insertvalue %DriftArrayHeader %zero_arr61, i64 0, 2
  %__arc1 = insertvalue %DriftArrayHeader %zero_arr62, ptr null, 3
  %data63 = extractvalue %DriftArrayHeader %__array_cap_arr.t62_5, 3
  %eltptr64 = getelementptr inbounds i8, ptr %data63, i64 %.t54
  store i8 %.t53, ptr %eltptr64
  %.t87 = add i64 %.t54, %.t59
  %arr_len65 = insertvalue %DriftArrayHeader %__array_cap_arr.t62_5, i64 %.t87, 0
  %arr_gen66 = insertvalue %DriftArrayHeader %arr_len65, i64 %.t58, 2
  store %DriftArrayHeader %arr_gen66, ptr %got__addr
  %.t91 = add i64 0, 1
  %.t92 = add i64 %j_4, %.t91
  br label %.bb.if_join2
.bb.if_join2:
  br label %.bb.loop_header1
.bb.if_then1:
  %strptr67 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str11, i32 0, i32 2, i32 0
  %str068 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t44 = insertvalue %DriftString %str068, ptr %strptr67, 1
  %__cleanup_t6 = load %Struct_std_2Eio_Buffer_e76b5c24b140f2f4, ptr %rbuf__addr
  %zero_struct69 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 zeroinitializer, %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c zeroinitializer, 0
  %zero_struct70 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %zero_struct69, i64 0, 1
  %__arc6 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %zero_struct70, i64 0, 2
  store %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %__arc6, ptr %rbuf__addr
  call void @"std.io::Buffer::std.core.Destructible::destroy"(%Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %__cleanup_t6)
  %__cleanup_t7 = load %DriftArrayHeader, ptr %got__addr
  %zero_arr71 = insertvalue %DriftArrayHeader zeroinitializer, i64 0, 0
  %zero_arr72 = insertvalue %DriftArrayHeader %zero_arr71, i64 0, 1
  %zero_arr73 = insertvalue %DriftArrayHeader %zero_arr72, i64 0, 2
  %__arc7 = insertvalue %DriftArrayHeader %zero_arr73, ptr null, 3
  store %DriftArrayHeader %__arc7, ptr %got__addr
  %len74 = extractvalue %DriftArrayHeader %__cleanup_t7, 0
  %data75 = extractvalue %DriftArrayHeader %__cleanup_t7, 3
  call void @drift_free_array(ptr %data75)
  ret %DriftString %.t44
.bb.match_arm_0:
  %__arc10 = select i1 1, %Variant_std_2Ecore_Result_ccaaf7910bb23f6d zeroinitializer, %Variant_std_2Ecore_Result_ccaaf7910bb23f6d zeroinitializer
  store %Variant_std_2Ecore_Result_ccaaf7910bb23f6d %.t18, ptr %__match_scrut_tmp.t24__addr
  %payload_words76 = getelementptr inbounds %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %__match_scrut_tmp.t24__addr, i32 0, i32 2
  %fieldptr77 = getelementptr inbounds { %Struct_std_2Enet_NetError_203564604ea2d3a4 }, ptr %payload_words76, i32 0, i32 0
  %.t29 = load %Struct_std_2Enet_NetError_203564604ea2d3a4, ptr %fieldptr77
  %zero_struct78 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc11 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %zero_struct78, i64 0, 1
  %zero_struct79 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc13 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %zero_struct79, i64 0, 1
  %drop_field80 = extractvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %__arc3, 0
  call void @drift_string_release(%DriftString %drop_field80)
  %strptr81 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str12, i32 0, i32 2, i32 0
  %str082 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t33 = insertvalue %DriftString %str082, ptr %strptr81, 1
  %zero_struct83 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc14 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %zero_struct83, i64 0, 1
  %drop_field84 = extractvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %.t29, 0
  call void @drift_string_release(%DriftString %drop_field84)
  %__cleanup_t3 = load %Struct_std_2Eio_Buffer_e76b5c24b140f2f4, ptr %rbuf__addr
  %zero_struct85 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 zeroinitializer, %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c zeroinitializer, 0
  %zero_struct86 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %zero_struct85, i64 0, 1
  %__arc15 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %zero_struct86, i64 0, 2
  store %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %__arc15, ptr %rbuf__addr
  call void @"std.io::Buffer::std.core.Destructible::destroy"(%Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %__cleanup_t3)
  %__cleanup_t4 = load %DriftArrayHeader, ptr %got__addr
  %zero_arr87 = insertvalue %DriftArrayHeader zeroinitializer, i64 0, 0
  %zero_arr88 = insertvalue %DriftArrayHeader %zero_arr87, i64 0, 1
  %zero_arr89 = insertvalue %DriftArrayHeader %zero_arr88, i64 0, 2
  %__arc16 = insertvalue %DriftArrayHeader %zero_arr89, ptr null, 3
  store %DriftArrayHeader %__arc16, ptr %got__addr
  %len90 = extractvalue %DriftArrayHeader %__cleanup_t4, 0
  %data91 = extractvalue %DriftArrayHeader %__cleanup_t4, 3
  call void @drift_free_array(ptr %data91)
  ret %DriftString %.t33
}
define %Variant_std_2Ecore_Result_8541acbd074aaf8c @"spike::_open"(i64 %port_1) {
.bb.entry:
  %addr__addr = alloca %Struct_std_2Enet_SocketAddr_461bcf04e30af211
  %__match_scrut_tmp.t25__addr = alloca %Variant_std_2Ecore_Result_a482b0d00941967a
  %__match_scrut_tmp.t14__addr = alloca %Variant_std_2Ecore_Result_a482b0d00941967a
  %zero_struct1 = insertvalue %Struct_std_2Enet_SocketAddr_461bcf04e30af211 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc1 = insertvalue %Struct_std_2Enet_SocketAddr_461bcf04e30af211 %zero_struct1, i64 0, 1
  store %Struct_std_2Enet_SocketAddr_461bcf04e30af211 %__arc1, ptr %addr__addr
  %zero_struct2 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc2 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %zero_struct2, i64 0, 1
  %strptr3 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str13, i32 0, i32 2, i32 0
  %str04 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str04, ptr %strptr3, 1
  %strptr5 = getelementptr inbounds { i64, i64, [10 x i8] }, ptr @.str14, i32 0, i32 2, i32 0
  %str06 = insertvalue %DriftString zeroinitializer, i64 9, 0
  %.t2 = insertvalue %DriftString %str06, ptr %strptr5, 1
  %.t4 = call %Struct_std_2Enet_SocketAddr_461bcf04e30af211 @"std.net::socket_addr"(%DriftString %.t2, i64 %port_1)
  %__arc3 = load %Struct_std_2Enet_SocketAddr_461bcf04e30af211, ptr %addr__addr
  %zero_struct7 = insertvalue %Struct_std_2Enet_SocketAddr_461bcf04e30af211 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc4 = insertvalue %Struct_std_2Enet_SocketAddr_461bcf04e30af211 %zero_struct7, i64 0, 1
  store %Struct_std_2Enet_SocketAddr_461bcf04e30af211 %__arc4, ptr %addr__addr
  %drop_field8 = extractvalue %Struct_std_2Enet_SocketAddr_461bcf04e30af211 %__arc3, 0
  call void @drift_string_release(%DriftString %drop_field8)
  store %Struct_std_2Enet_SocketAddr_461bcf04e30af211 %.t4, ptr %addr__addr
  %.t6 = add i64 0, 2000
  %.t7 = insertvalue %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 zeroinitializer, i64 %.t6, 0
  %.t8 = call %Variant_std_2Ecore_Result_a482b0d00941967a @"std.net::connect"(ptr %addr__addr, %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %.t7)
  br label %.bb.match_dispatch
.bb.match_dispatch:
  %tag89 = extractvalue %Variant_std_2Ecore_Result_a482b0d00941967a %.t8, 0
  %.t9 = zext i8 %tag89 to i64
  %.t10 = add i64 0, 1
  %.t11 = icmp eq i64 %.t9, %.t10
  br i1 %.t11, label %.bb.match_arm_0, label %.bb.match_dispatch_next
.bb.match_dispatch_next:
  %.t12 = add i64 0, 0
  %.t13 = icmp eq i64 %.t9, %.t12
  br i1 %.t13, label %.bb.match_arm_1, label %.bb.match_dispatch_next1
.bb.match_dispatch_next1:
  unreachable
.bb.match_arm_1:
  %__arc11 = select i1 1, %Variant_std_2Ecore_Result_a482b0d00941967a zeroinitializer, %Variant_std_2Ecore_Result_a482b0d00941967a zeroinitializer
  store %Variant_std_2Ecore_Result_a482b0d00941967a %.t8, ptr %__match_scrut_tmp.t25__addr
  %payload_words10 = getelementptr inbounds %Variant_std_2Ecore_Result_a482b0d00941967a, ptr %__match_scrut_tmp.t25__addr, i32 0, i32 2
  %fieldptr11 = getelementptr inbounds { %Struct_std_2Enet_TcpStream_363317ef680a1400 }, ptr %payload_words10, i32 0, i32 0
  %.t30 = load %Struct_std_2Enet_TcpStream_363317ef680a1400, ptr %fieldptr11
  %__arc12 = insertvalue %Struct_std_2Enet_TcpStream_363317ef680a1400 zeroinitializer, i64 0, 0
  %__arc13 = insertvalue %Struct_std_2Enet_TcpStream_363317ef680a1400 zeroinitializer, i64 0, 0
  %variant12 = alloca %Variant_std_2Ecore_Result_8541acbd074aaf8c
  store %Variant_std_2Ecore_Result_8541acbd074aaf8c zeroinitializer, ptr %variant12
  %tagptr13 = getelementptr inbounds %Variant_std_2Ecore_Result_8541acbd074aaf8c, ptr %variant12, i32 0, i32 0
  store i8 0, ptr %tagptr13
  %payload_words14 = getelementptr inbounds %Variant_std_2Ecore_Result_8541acbd074aaf8c, ptr %variant12, i32 0, i32 2
  %fieldptr15 = getelementptr inbounds { %Struct_std_2Enet_TcpStream_363317ef680a1400 }, ptr %payload_words14, i32 0, i32 0
  store %Struct_std_2Enet_TcpStream_363317ef680a1400 %.t30, ptr %fieldptr15
  %.t35 = load %Variant_std_2Ecore_Result_8541acbd074aaf8c, ptr %variant12
  %__cleanup_t3 = load %Struct_std_2Enet_SocketAddr_461bcf04e30af211, ptr %addr__addr
  %zero_struct16 = insertvalue %Struct_std_2Enet_SocketAddr_461bcf04e30af211 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc14 = insertvalue %Struct_std_2Enet_SocketAddr_461bcf04e30af211 %zero_struct16, i64 0, 1
  store %Struct_std_2Enet_SocketAddr_461bcf04e30af211 %__arc14, ptr %addr__addr
  %drop_field17 = extractvalue %Struct_std_2Enet_SocketAddr_461bcf04e30af211 %__cleanup_t3, 0
  call void @drift_string_release(%DriftString %drop_field17)
  ret %Variant_std_2Ecore_Result_8541acbd074aaf8c %.t35
.bb.match_arm_0:
  %__arc5 = select i1 1, %Variant_std_2Ecore_Result_a482b0d00941967a zeroinitializer, %Variant_std_2Ecore_Result_a482b0d00941967a zeroinitializer
  store %Variant_std_2Ecore_Result_a482b0d00941967a %.t8, ptr %__match_scrut_tmp.t14__addr
  %payload_words18 = getelementptr inbounds %Variant_std_2Ecore_Result_a482b0d00941967a, ptr %__match_scrut_tmp.t14__addr, i32 0, i32 2
  %fieldptr19 = getelementptr inbounds { %Struct_std_2Enet_NetError_203564604ea2d3a4 }, ptr %payload_words18, i32 0, i32 0
  %.t19 = load %Struct_std_2Enet_NetError_203564604ea2d3a4, ptr %fieldptr19
  %zero_struct20 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc6 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %zero_struct20, i64 0, 1
  %zero_struct21 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc8 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %zero_struct21, i64 0, 1
  %drop_field22 = extractvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %__arc2, 0
  call void @drift_string_release(%DriftString %drop_field22)
  %.t23 = add i64 0, 1
  %variant23 = alloca %Variant_std_2Ecore_Result_8541acbd074aaf8c
  store %Variant_std_2Ecore_Result_8541acbd074aaf8c zeroinitializer, ptr %variant23
  %tagptr24 = getelementptr inbounds %Variant_std_2Ecore_Result_8541acbd074aaf8c, ptr %variant23, i32 0, i32 0
  store i8 1, ptr %tagptr24
  %payload_words25 = getelementptr inbounds %Variant_std_2Ecore_Result_8541acbd074aaf8c, ptr %variant23, i32 0, i32 2
  %fieldptr26 = getelementptr inbounds { i64 }, ptr %payload_words25, i32 0, i32 0
  store i64 %.t23, ptr %fieldptr26
  %.t24 = load %Variant_std_2Ecore_Result_8541acbd074aaf8c, ptr %variant23
  %zero_struct27 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc9 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %zero_struct27, i64 0, 1
  %drop_field28 = extractvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %.t19, 0
  call void @drift_string_release(%DriftString %drop_field28)
  %__cleanup_t2 = load %Struct_std_2Enet_SocketAddr_461bcf04e30af211, ptr %addr__addr
  %zero_struct29 = insertvalue %Struct_std_2Enet_SocketAddr_461bcf04e30af211 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc10 = insertvalue %Struct_std_2Enet_SocketAddr_461bcf04e30af211 %zero_struct29, i64 0, 1
  store %Struct_std_2Enet_SocketAddr_461bcf04e30af211 %__arc10, ptr %addr__addr
  %drop_field30 = extractvalue %Struct_std_2Enet_SocketAddr_461bcf04e30af211 %__cleanup_t2, 0
  call void @drift_string_release(%DriftString %drop_field30)
  ret %Variant_std_2Ecore_Result_8541acbd074aaf8c %.t24
}
define internal i64 @__drift_cb_thunk_e5b105eafca2549d(ptr %data) {
__bb_entry:
  %res = call i64 @"spike::__lambda_cb_main_0_0"(ptr %data)
  ret i64 %res
}
define internal void @__drift_cb_drop_e5b105eafca2549d(ptr %data) {
__bb_entry:
  %env_val25 = load %Struct_spike___lambda_env_cb_main_0_0_7b89ae1f0169a0da, ptr %data
  %drop_field26 = extractvalue %Struct_spike___lambda_env_cb_main_0_0_7b89ae1f0169a0da %env_val25, 1
  call void @"std.core.arc::_arc_destroy_impl__inst__0a6d34c7cbe9c09f"(%Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba %drop_field26)
  call void @drift_cb_env_free(ptr %data)
  ret void
}
define void @__drift_array_drop_std__std_core_Result_Int_std__std_concurrent_ConcurrencyError__37335149f7faff82(i64 %len, ptr %data) {
  %idx_ptr1 = alloca i64
  store i64 0, ptr %idx_ptr1
  br label %arr_drop_cond2
arr_drop_cond2:
  %idx5 = load i64, ptr %idx_ptr1
  %idx_ok6 = icmp slt i64 %idx5, %len
  br i1 %idx_ok6, label %arr_drop_body3, label %arr_drop_done4
arr_drop_body3:
  %idxv7 = load i64, ptr %idx_ptr1
  %eltptr8 = getelementptr inbounds %Variant_std_2Ecore_Result_37335149f7faff82, ptr %data, i64 %idxv7
  %old9 = load %Variant_std_2Ecore_Result_37335149f7faff82, ptr %eltptr8
  %tag10 = extractvalue %Variant_std_2Ecore_Result_37335149f7faff82 %old9, 0
  switch i8 %tag10, label %drop_bad12 [ i8 0, label %drop_ok13 i8 1, label %drop_err14 i8 2, label %drop_tombstone15 ]
drop_ok13:
  %variant16 = alloca %Variant_std_2Ecore_Result_37335149f7faff82
  store %Variant_std_2Ecore_Result_37335149f7faff82 %old9, ptr %variant16
  %payload_words17 = getelementptr inbounds %Variant_std_2Ecore_Result_37335149f7faff82, ptr %variant16, i32 0, i32 2
  br label %drop_done11
drop_err14:
  %variant18 = alloca %Variant_std_2Ecore_Result_37335149f7faff82
  store %Variant_std_2Ecore_Result_37335149f7faff82 %old9, ptr %variant18
  %payload_words19 = getelementptr inbounds %Variant_std_2Ecore_Result_37335149f7faff82, ptr %variant18, i32 0, i32 2
  %fieldptr20 = getelementptr inbounds { %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 }, ptr %payload_words19, i32 0, i32 0
  %field21 = load %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204, ptr %fieldptr20
  %field22 = extractvalue %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 %field21, 0
  call void @drift_string_release(%DriftString %field22)
  br label %drop_done11
drop_tombstone15:
  br label %drop_done11
drop_bad12:
  call void @llvm.trap()
  unreachable
drop_done11:
  %idx_next23 = add i64 %idxv7, 1
  store i64 %idx_next23, ptr %idx_ptr1
  br label %arr_drop_cond2
arr_drop_done4:
  ret void
}
define void @__drift_array_drop_String(i64 %len, ptr %data) {
  %idx_ptr1 = alloca i64
  store i64 0, ptr %idx_ptr1
  br label %arr_drop_cond2
arr_drop_cond2:
  %idx5 = load i64, ptr %idx_ptr1
  %idx_ok6 = icmp slt i64 %idx5, %len
  br i1 %idx_ok6, label %arr_drop_body3, label %arr_drop_done4
arr_drop_body3:
  %idxv7 = load i64, ptr %idx_ptr1
  %eltptr8 = getelementptr inbounds %DriftString, ptr %data, i64 %idxv7
  %old9 = load %DriftString, ptr %eltptr8
  call void @drift_string_release(%DriftString %old9)
  %idx_next10 = add i64 %idxv7, 1
  store i64 %idx_next10, ptr %idx_ptr1
  br label %arr_drop_cond2
arr_drop_done4:
  ret void
}
define i64 @drift_main(%DriftArrayHeader %argv_1) {
.bb.entry:
  %m1__addr = alloca %DriftString
  store %DriftString zeroinitializer, ptr %m1__addr
  %m2__addr = alloca %DriftString
  store %DriftString zeroinitializer, ptr %m2__addr
  %m3__addr = alloca %DriftString
  store %DriftString zeroinitializer, ptr %m3__addr
  %addr__addr = alloca %Struct_std_2Enet_SocketAddr_461bcf04e30af211
  %__match_scrut_tmp.t27__addr = alloca %Variant_std_2Ecore_Result_f9949363b6b29c23
  %listener__addr = alloca %Struct_std_2Enet_TcpListener_7d3d9b3ee7d65cad
  %stopped__addr = alloca %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba
  %iface_tmp_entry27 = alloca %DriftIface
  %sv__addr = alloca %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0
  %__match_scrut_tmp.t69__addr = alloca %Variant_std_2Ecore_Result_8541acbd074aaf8c
  %a__addr = alloca %Struct_std_2Enet_TcpStream_363317ef680a1400
  %__match_scrut_tmp.t108__addr = alloca %Variant_std_2Ecore_Result_8541acbd074aaf8c
  %bs__addr = alloca %Struct_std_2Enet_TcpStream_363317ef680a1400
  %__match_scrut_tmp.t100__addr = alloca %Variant_std_2Ecore_Result_8541acbd074aaf8c
  %__match_scrut_tmp.t61__addr = alloca %Variant_std_2Ecore_Result_8541acbd074aaf8c
  %__match_scrut_tmp.t16__addr = alloca %Variant_std_2Ecore_Result_f9949363b6b29c23
  %zero_str1 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %__arc1 = insertvalue %DriftString %zero_str1, ptr null, 1
  store %DriftString %__arc1, ptr %m1__addr
  %zero_str2 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %__arc2 = insertvalue %DriftString %zero_str2, ptr null, 1
  store %DriftString %__arc2, ptr %m2__addr
  %zero_str3 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %__arc3 = insertvalue %DriftString %zero_str3, ptr null, 1
  store %DriftString %__arc3, ptr %m3__addr
  %zero_struct4 = insertvalue %Struct_std_2Enet_SocketAddr_461bcf04e30af211 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc4 = insertvalue %Struct_std_2Enet_SocketAddr_461bcf04e30af211 %zero_struct4, i64 0, 1
  store %Struct_std_2Enet_SocketAddr_461bcf04e30af211 %__arc4, ptr %addr__addr
  %zero_struct5 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc5 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %zero_struct5, i64 0, 1
  %__arc6 = select i1 1, %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 zeroinitializer, %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 zeroinitializer
  %strptr6 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str15, i32 0, i32 2, i32 0
  %str07 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str07, ptr %strptr6, 1
  %.t2 = add i64 0, 0
  %.t3 = insertvalue %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 zeroinitializer, i64 %.t2, 0
  %strptr8 = getelementptr inbounds { i64, i64, [10 x i8] }, ptr @.str16, i32 0, i32 2, i32 0
  %str09 = insertvalue %DriftString zeroinitializer, i64 9, 0
  %.t4 = insertvalue %DriftString %str09, ptr %strptr8, 1
  %.t5 = add i64 0, 0
  %.t6 = call %Struct_std_2Enet_SocketAddr_461bcf04e30af211 @"std.net::socket_addr"(%DriftString %.t4, i64 %.t5)
  %__arc7 = load %Struct_std_2Enet_SocketAddr_461bcf04e30af211, ptr %addr__addr
  %zero_struct10 = insertvalue %Struct_std_2Enet_SocketAddr_461bcf04e30af211 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc8 = insertvalue %Struct_std_2Enet_SocketAddr_461bcf04e30af211 %zero_struct10, i64 0, 1
  store %Struct_std_2Enet_SocketAddr_461bcf04e30af211 %__arc8, ptr %addr__addr
  %drop_field11 = extractvalue %Struct_std_2Enet_SocketAddr_461bcf04e30af211 %__arc7, 0
  call void @drift_string_release(%DriftString %drop_field11)
  store %Struct_std_2Enet_SocketAddr_461bcf04e30af211 %.t6, ptr %addr__addr
  %.t8 = add i64 0, 2000
  %.t9 = insertvalue %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 zeroinitializer, i64 %.t8, 0
  %.t10 = call %Variant_std_2Ecore_Result_f9949363b6b29c23 @"std.net::listen"(ptr %addr__addr, %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %.t9)
  br label %.bb.match_dispatch
.bb.match_dispatch:
  %tag812 = extractvalue %Variant_std_2Ecore_Result_f9949363b6b29c23 %.t10, 0
  %.t11 = zext i8 %tag812 to i64
  %.t12 = add i64 0, 1
  %.t13 = icmp eq i64 %.t11, %.t12
  br i1 %.t13, label %.bb.match_arm_0, label %.bb.match_dispatch_next
.bb.match_dispatch_next:
  %.t14 = add i64 0, 0
  %.t15 = icmp eq i64 %.t11, %.t14
  br i1 %.t15, label %.bb.match_arm_1, label %.bb.match_dispatch_next1
.bb.match_dispatch_next1:
  unreachable
.bb.match_arm_1:
  %__arc44 = select i1 1, %Variant_std_2Ecore_Result_f9949363b6b29c23 zeroinitializer, %Variant_std_2Ecore_Result_f9949363b6b29c23 zeroinitializer
  store %Variant_std_2Ecore_Result_f9949363b6b29c23 %.t10, ptr %__match_scrut_tmp.t27__addr
  %payload_words13 = getelementptr inbounds %Variant_std_2Ecore_Result_f9949363b6b29c23, ptr %__match_scrut_tmp.t27__addr, i32 0, i32 2
  %fieldptr14 = getelementptr inbounds { %Struct_std_2Enet_TcpListener_7d3d9b3ee7d65cad }, ptr %payload_words13, i32 0, i32 0
  %.t32 = load %Struct_std_2Enet_TcpListener_7d3d9b3ee7d65cad, ptr %fieldptr14
  %__arc45 = insertvalue %Struct_std_2Enet_TcpListener_7d3d9b3ee7d65cad zeroinitializer, i64 0, 0
  %__arc46 = insertvalue %Struct_std_2Enet_TcpListener_7d3d9b3ee7d65cad zeroinitializer, i64 0, 0
  store %Struct_std_2Enet_TcpListener_7d3d9b3ee7d65cad %.t32, ptr %listener__addr
  %.t38 = call i64 @"std.net::TcpListener::local_port"(ptr %listener__addr)
  %.t39 = add i1 0, 0
  %.t40 = call %Struct_std_2Esync_AtomicBool_881cc492ae8213fb @"std.sync::atomic_bool"(i1 %.t39)
  %.t41 = call %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba @"std.core.arc::arc__inst__64ac3d24898720d1"(%Struct_std_2Esync_AtomicBool_881cc492ae8213fb %.t40)
  store %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba %.t41, ptr %stopped__addr
  %.t43 = call %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba @"std.core.arc::_arc_clone_impl__inst__d192354fe9e7c4b5"(ptr %stopped__addr)
  %.t45 = load %Struct_std_2Enet_TcpListener_7d3d9b3ee7d65cad, ptr %listener__addr
  %__arc47 = insertvalue %Struct_std_2Enet_TcpListener_7d3d9b3ee7d65cad zeroinitializer, i64 0, 0
  store %Struct_std_2Enet_TcpListener_7d3d9b3ee7d65cad %__arc47, ptr %listener__addr
  %__arc48 = insertvalue %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba zeroinitializer, %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa zeroinitializer, 0
  %struct15 = insertvalue %Struct_spike___lambda_env_cb_main_0_0_7b89ae1f0169a0da zeroinitializer, %Struct_std_2Enet_TcpListener_7d3d9b3ee7d65cad %.t45, 0
  %.t47 = insertvalue %Struct_spike___lambda_env_cb_main_0_0_7b89ae1f0169a0da %struct15, %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba %.t43, 1
  %.t49 = add i64 0, 1
  %len017 = add i64 0, 0
  %raw16 = call ptr @drift_alloc_array(i64 24, i64 8, i64 %len017, i64 %.t49)
  %raw018 = insertvalue %Struct_std_2Emem_RawBuffer_b2b1ad1dcb634bff zeroinitializer, ptr %raw16, 0
  %raw119 = insertvalue %Struct_std_2Emem_RawBuffer_b2b1ad1dcb634bff %raw018, i64 %.t49, 1
  %.t50 = add i64 0, 0
  %rawptr20 = extractvalue %Struct_std_2Emem_RawBuffer_b2b1ad1dcb634bff %raw119, 0
  %rawcap21 = extractvalue %Struct_std_2Emem_RawBuffer_b2b1ad1dcb634bff %raw119, 1
  %strptr22 = getelementptr inbounds { i64, i64, [18 x i8] }, ptr @.str17, i32 0, i32 2, i32 0
  %str023 = insertvalue %DriftString zeroinitializer, i64 17, 0
  %str24 = insertvalue %DriftString %str023, ptr %strptr22, 1
  call void @drift_bounds_check(%DriftString %str24, i64 %.t50, i64 %rawcap21)
  %.t51 = getelementptr %Struct_spike___lambda_env_cb_main_0_0_7b89ae1f0169a0da, ptr %rawptr20, i64 %.t50
  store %Struct_spike___lambda_env_cb_main_0_0_7b89ae1f0169a0da %.t47, ptr %.t51
  store %DriftIface zeroinitializer, ptr %iface_tmp_entry27
  %iface_data_ptr28 = getelementptr inbounds %DriftIface, ptr %iface_tmp_entry27, i32 0, i32 0
  store ptr %.t51, ptr %iface_data_ptr28
  %iface_vtable_ptr29 = getelementptr inbounds %DriftIface, ptr %iface_tmp_entry27, i32 0, i32 1
  store ptr @__drift_cb_vtable_e5b105eafca2549d, ptr %iface_vtable_ptr29
  %iface_flag_ptr30 = getelementptr inbounds %DriftIface, ptr %iface_tmp_entry27, i32 0, i32 3
  store i8 0, ptr %iface_flag_ptr30
  %.t44 = load %DriftIface, ptr %iface_tmp_entry27
  %.t52 = call %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 @"std.concurrent::spawn_cb__inst__5634e65d835e6c93"(%DriftIface %.t44)
  store %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %.t52, ptr %sv__addr
  %.t53 = add i64 0, 0
  %.t55 = call %Variant_std_2Ecore_Result_8541acbd074aaf8c @"spike::_open"(i64 %.t38)
  br label %.bb.match_dispatch1
.bb.match_dispatch1:
  %tag831 = extractvalue %Variant_std_2Ecore_Result_8541acbd074aaf8c %.t55, 0
  %.t56 = zext i8 %tag831 to i64
  %.t57 = add i64 0, 1
  %.t58 = icmp eq i64 %.t56, %.t57
  br i1 %.t58, label %.bb.match_arm_01, label %.bb.match_dispatch_next2
.bb.match_dispatch_next2:
  %.t59 = add i64 0, 0
  %.t60 = icmp eq i64 %.t56, %.t59
  br i1 %.t60, label %.bb.match_arm_11, label %.bb.match_dispatch_next3
.bb.match_dispatch_next3:
  unreachable
.bb.match_arm_11:
  %__arc49 = select i1 1, %Variant_std_2Ecore_Result_8541acbd074aaf8c zeroinitializer, %Variant_std_2Ecore_Result_8541acbd074aaf8c zeroinitializer
  store %Variant_std_2Ecore_Result_8541acbd074aaf8c %.t55, ptr %__match_scrut_tmp.t69__addr
  %payload_words32 = getelementptr inbounds %Variant_std_2Ecore_Result_8541acbd074aaf8c, ptr %__match_scrut_tmp.t69__addr, i32 0, i32 2
  %fieldptr33 = getelementptr inbounds { %Struct_std_2Enet_TcpStream_363317ef680a1400 }, ptr %payload_words32, i32 0, i32 0
  %.t74 = load %Struct_std_2Enet_TcpStream_363317ef680a1400, ptr %fieldptr33
  %__arc50 = insertvalue %Struct_std_2Enet_TcpStream_363317ef680a1400 zeroinitializer, i64 0, 0
  %__arc51 = insertvalue %Struct_std_2Enet_TcpStream_363317ef680a1400 zeroinitializer, i64 0, 0
  store %Struct_std_2Enet_TcpStream_363317ef680a1400 %.t74, ptr %a__addr
  %strptr34 = getelementptr inbounds { i64, i64, [3 x i8] }, ptr @.str19, i32 0, i32 2, i32 0
  %str035 = insertvalue %DriftString zeroinitializer, i64 2, 0
  %.t79 = insertvalue %DriftString %str035, ptr %strptr34, 1
  %__arc52 = load %DriftString, ptr %m1__addr
  %zero_str36 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %__arc53 = insertvalue %DriftString %zero_str36, ptr null, 1
  store %DriftString %__arc53, ptr %m1__addr
  call void @drift_string_release(%DriftString %__arc52)
  store %DriftString %.t79, ptr %m1__addr
  %.t82 = call i1 @"spike::_send"(ptr %a__addr, ptr %m1__addr)
  %.t83 = xor i1 %.t82, true
  br i1 %.t83, label %.bb.if_then, label %.bb.if_else
.bb.if_else:
  %.t86 = add i64 0, 2
  %.t87 = call %DriftString @"spike::_recv"(ptr %a__addr, i64 %.t86)
  %strptr37 = getelementptr inbounds { i64, i64, [3 x i8] }, ptr @.str20, i32 0, i32 2, i32 0
  %str038 = insertvalue %DriftString zeroinitializer, i64 2, 0
  %.t88 = insertvalue %DriftString %str038, ptr %strptr37, 1
  %strcmp39 = call i32 @drift_string_cmp(%DriftString %.t87, %DriftString %.t88)
  %.t90 = sext i32 %strcmp39 to i64
  call void @drift_string_release(%DriftString %.t87)
  call void @drift_string_release(%DriftString %.t88)
  %.t91 = add i64 0, 0
  %.t89 = icmp ne i64 %.t90, %.t91
  br i1 %.t89, label %.bb.if_then1, label %.bb.if_else1
.bb.if_else1:
  %.t94 = call %Variant_std_2Ecore_Result_8541acbd074aaf8c @"spike::_open"(i64 %.t38)
  br label %.bb.match_dispatch2
.bb.match_dispatch2:
  %tag840 = extractvalue %Variant_std_2Ecore_Result_8541acbd074aaf8c %.t94, 0
  %.t95 = zext i8 %tag840 to i64
  %.t96 = add i64 0, 1
  %.t97 = icmp eq i64 %.t95, %.t96
  br i1 %.t97, label %.bb.match_arm_02, label %.bb.match_dispatch_next4
.bb.match_dispatch_next4:
  %.t98 = add i64 0, 0
  %.t99 = icmp eq i64 %.t95, %.t98
  br i1 %.t99, label %.bb.match_arm_12, label %.bb.match_dispatch_next5
.bb.match_dispatch_next5:
  unreachable
.bb.match_arm_12:
  %__arc54 = select i1 1, %Variant_std_2Ecore_Result_8541acbd074aaf8c zeroinitializer, %Variant_std_2Ecore_Result_8541acbd074aaf8c zeroinitializer
  store %Variant_std_2Ecore_Result_8541acbd074aaf8c %.t94, ptr %__match_scrut_tmp.t108__addr
  %payload_words41 = getelementptr inbounds %Variant_std_2Ecore_Result_8541acbd074aaf8c, ptr %__match_scrut_tmp.t108__addr, i32 0, i32 2
  %fieldptr42 = getelementptr inbounds { %Struct_std_2Enet_TcpStream_363317ef680a1400 }, ptr %payload_words41, i32 0, i32 0
  %.t113 = load %Struct_std_2Enet_TcpStream_363317ef680a1400, ptr %fieldptr42
  %__arc55 = insertvalue %Struct_std_2Enet_TcpStream_363317ef680a1400 zeroinitializer, i64 0, 0
  %__arc56 = insertvalue %Struct_std_2Enet_TcpStream_363317ef680a1400 zeroinitializer, i64 0, 0
  store %Struct_std_2Enet_TcpStream_363317ef680a1400 %.t113, ptr %bs__addr
  %strptr43 = getelementptr inbounds { i64, i64, [3 x i8] }, ptr @.str21, i32 0, i32 2, i32 0
  %str044 = insertvalue %DriftString zeroinitializer, i64 2, 0
  %.t118 = insertvalue %DriftString %str044, ptr %strptr43, 1
  %__arc57 = load %DriftString, ptr %m2__addr
  %zero_str45 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %__arc58 = insertvalue %DriftString %zero_str45, ptr null, 1
  store %DriftString %__arc58, ptr %m2__addr
  call void @drift_string_release(%DriftString %__arc57)
  store %DriftString %.t118, ptr %m2__addr
  %.t121 = call i1 @"spike::_send"(ptr %bs__addr, ptr %m2__addr)
  %.t122 = xor i1 %.t121, true
  br i1 %.t122, label %.bb.if_then2, label %.bb.if_else2
.bb.if_else2:
  %.t125 = add i64 0, 2
  %.t126 = call %DriftString @"spike::_recv"(ptr %bs__addr, i64 %.t125)
  %strptr46 = getelementptr inbounds { i64, i64, [3 x i8] }, ptr @.str22, i32 0, i32 2, i32 0
  %str047 = insertvalue %DriftString zeroinitializer, i64 2, 0
  %.t127 = insertvalue %DriftString %str047, ptr %strptr46, 1
  %strcmp48 = call i32 @drift_string_cmp(%DriftString %.t126, %DriftString %.t127)
  %.t129 = sext i32 %strcmp48 to i64
  call void @drift_string_release(%DriftString %.t126)
  call void @drift_string_release(%DriftString %.t127)
  %.t130 = add i64 0, 0
  %.t128 = icmp ne i64 %.t129, %.t130
  br i1 %.t128, label %.bb.if_then3, label %.bb.if_else3
.bb.if_else3:
  %strptr49 = getelementptr inbounds { i64, i64, [3 x i8] }, ptr @.str23, i32 0, i32 2, i32 0
  %str050 = insertvalue %DriftString zeroinitializer, i64 2, 0
  %.t132 = insertvalue %DriftString %str050, ptr %strptr49, 1
  %__arc9 = load %DriftString, ptr %m3__addr
  %zero_str51 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %__arc10 = insertvalue %DriftString %zero_str51, ptr null, 1
  store %DriftString %__arc10, ptr %m3__addr
  call void @drift_string_release(%DriftString %__arc9)
  store %DriftString %.t132, ptr %m3__addr
  %.t135 = call i1 @"spike::_send"(ptr %a__addr, ptr %m3__addr)
  %.t136 = xor i1 %.t135, true
  br i1 %.t136, label %.bb.if_then4, label %.bb.if_else4
.bb.if_else4:
  %.t139 = add i64 0, 2
  %.t140 = call %DriftString @"spike::_recv"(ptr %a__addr, i64 %.t139)
  %strptr52 = getelementptr inbounds { i64, i64, [3 x i8] }, ptr @.str24, i32 0, i32 2, i32 0
  %str053 = insertvalue %DriftString zeroinitializer, i64 2, 0
  %.t141 = insertvalue %DriftString %str053, ptr %strptr52, 1
  %strcmp54 = call i32 @drift_string_cmp(%DriftString %.t140, %DriftString %.t141)
  %.t143 = sext i32 %strcmp54 to i64
  call void @drift_string_release(%DriftString %.t140)
  call void @drift_string_release(%DriftString %.t141)
  %.t144 = add i64 0, 0
  %.t142 = icmp ne i64 %.t143, %.t144
  br i1 %.t142, label %.bb.if_then5, label %.bb.if_join5
.bb.if_then5:
  %.t145 = add i64 0, 32
  br label %.bb.if_join5
.bb.if_join5:
  %rc_9 = phi i64 [ %.t53, %.bb.if_else4 ], [ %.t145, %.bb.if_then5 ]
  br label %.bb.if_join4
.bb.if_then4:
  %.t137 = add i64 0, 31
  br label %.bb.if_join4
.bb.if_join4:
  %rc_11 = phi i64 [ %rc_9, %.bb.if_join5 ], [ %.t137, %.bb.if_then4 ]
  %__cleanup_t8 = load %DriftString, ptr %m3__addr
  %zero_str55 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %__arc17 = insertvalue %DriftString %zero_str55, ptr null, 1
  store %DriftString %__arc17, ptr %m3__addr
  call void @drift_string_release(%DriftString %__cleanup_t8)
  br label %.bb.if_join3
.bb.if_then3:
  %.t131 = add i64 0, 22
  br label %.bb.if_join3
.bb.if_join3:
  %rc_14 = phi i64 [ %rc_11, %.bb.if_join4 ], [ %.t131, %.bb.if_then3 ]
  br label %.bb.if_join2
.bb.if_then2:
  %.t123 = add i64 0, 21
  br label %.bb.if_join2
.bb.if_join2:
  %rc_15 = phi i64 [ %.t123, %.bb.if_then2 ], [ %rc_14, %.bb.if_join3 ]
  %.t148 = call %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 @"std.net::TcpStream::close"(ptr %bs__addr, %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %.t3)
  %__arc14 = select i1 1, %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 zeroinitializer, %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 zeroinitializer
  %drop_variant_ptr56 = alloca %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6
  store %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 %__arc6, ptr %drop_variant_ptr56
  call void @__drift_array_drop_std__std_core_Result_Void_std__std_net_NetError__9dbf2dcdb5537ee6(i64 1, ptr %drop_variant_ptr56)
  %__arc15 = select i1 1, %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 zeroinitializer, %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 zeroinitializer
  %drop_variant_ptr57 = alloca %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6
  store %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 %.t148, ptr %drop_variant_ptr57
  call void @__drift_array_drop_std__std_core_Result_Void_std__std_net_NetError__9dbf2dcdb5537ee6(i64 1, ptr %drop_variant_ptr57)
  %__cleanup_t7 = load %DriftString, ptr %m2__addr
  %zero_str58 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %__arc16 = insertvalue %DriftString %zero_str58, ptr null, 1
  store %DriftString %__arc16, ptr %m2__addr
  call void @drift_string_release(%DriftString %__cleanup_t7)
  br label %.bb.match_join2
.bb.match_arm_02:
  %__arc43 = select i1 1, %Variant_std_2Ecore_Result_8541acbd074aaf8c zeroinitializer, %Variant_std_2Ecore_Result_8541acbd074aaf8c zeroinitializer
  store %Variant_std_2Ecore_Result_8541acbd074aaf8c %.t94, ptr %__match_scrut_tmp.t100__addr
  %payload_words59 = getelementptr inbounds %Variant_std_2Ecore_Result_8541acbd074aaf8c, ptr %__match_scrut_tmp.t100__addr, i32 0, i32 2
  %fieldptr60 = getelementptr inbounds { i64 }, ptr %payload_words59, i32 0, i32 0
  %.t105 = load i64, ptr %fieldptr60
  %.t107 = add i64 0, 20
  br label %.bb.match_join2
.bb.match_join2:
  %rc_17 = phi i64 [ %rc_15, %.bb.if_join2 ], [ %.t107, %.bb.match_arm_02 ]
  %__8 = phi %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 [ %__arc15, %.bb.if_join2 ], [ %__arc6, %.bb.match_arm_02 ]
  br label %.bb.if_join1
.bb.if_then1:
  %.t92 = add i64 0, 12
  br label %.bb.if_join1
.bb.if_join1:
  %rc_6 = phi i64 [ %.t92, %.bb.if_then1 ], [ %rc_17, %.bb.match_join2 ]
  %__4 = phi %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 [ %__arc6, %.bb.if_then1 ], [ %__8, %.bb.match_join2 ]
  br label %.bb.if_join
.bb.if_then:
  %.t84 = add i64 0, 11
  br label %.bb.if_join
.bb.if_join:
  %rc_4 = phi i64 [ %.t84, %.bb.if_then ], [ %rc_6, %.bb.if_join1 ]
  %__3 = phi %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 [ %__arc6, %.bb.if_then ], [ %__4, %.bb.if_join1 ]
  %.t151 = call %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 @"std.net::TcpStream::close"(ptr %a__addr, %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %.t3)
  %__arc11 = select i1 1, %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 zeroinitializer, %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 zeroinitializer
  %drop_variant_ptr61 = alloca %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6
  store %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 %.t151, ptr %drop_variant_ptr61
  call void @__drift_array_drop_std__std_core_Result_Void_std__std_net_NetError__9dbf2dcdb5537ee6(i64 1, ptr %drop_variant_ptr61)
  %__cleanup_t5 = load %DriftString, ptr %m1__addr
  %zero_str62 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %__arc12 = insertvalue %DriftString %zero_str62, ptr null, 1
  store %DriftString %__arc12, ptr %m1__addr
  call void @drift_string_release(%DriftString %__cleanup_t5)
  br label %.bb.match_join1
.bb.match_arm_01:
  %__arc42 = select i1 1, %Variant_std_2Ecore_Result_8541acbd074aaf8c zeroinitializer, %Variant_std_2Ecore_Result_8541acbd074aaf8c zeroinitializer
  store %Variant_std_2Ecore_Result_8541acbd074aaf8c %.t55, ptr %__match_scrut_tmp.t61__addr
  %payload_words63 = getelementptr inbounds %Variant_std_2Ecore_Result_8541acbd074aaf8c, ptr %__match_scrut_tmp.t61__addr, i32 0, i32 2
  %fieldptr64 = getelementptr inbounds { i64 }, ptr %payload_words63, i32 0, i32 0
  %.t66 = load i64, ptr %fieldptr64
  %.t68 = add i64 0, 10
  br label %.bb.match_join1
.bb.match_join1:
  %rc_3 = phi i64 [ %.t68, %.bb.match_arm_01 ], [ %rc_4, %.bb.if_join ]
  %__2 = phi %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 [ %__arc6, %.bb.match_arm_01 ], [ %__3, %.bb.if_join ]
  %.t153 = call ptr @"std.core.arc::_arc_get_impl__inst__fc66586b6a63dfdc"(ptr %stopped__addr)
  %.t155 = add i1 0, 1
  %.t156 = insertvalue %Variant_lang_2Eatomic_MemoryOrder_469abe0ace4b6a6f zeroinitializer, i8 2, 0
  call void @"std.sync::AtomicBool::store"(ptr %.t153, i1 %.t155, %Variant_lang_2Eatomic_MemoryOrder_469abe0ace4b6a6f %.t156)
  %.t158 = call %Variant_std_2Ecore_Result_37335149f7faff82 @"std.concurrent::VirtualThread<T>::join__inst__21bbbc8cde113920"(ptr %sv__addr)
  %.t160 = add i64 0, 0
  %.t161 = icmp eq i64 %rc_3, %.t160
  br i1 %.t161, label %.bb.if_then6, label %.bb.if_else5
.bb.if_else5:
  %strptr65 = getelementptr inbounds { i64, i64, [15 x i8] }, ptr @.str25, i32 0, i32 2, i32 0
  %str066 = insertvalue %DriftString zeroinitializer, i64 14, 0
  %.t163 = insertvalue %DriftString %str066, ptr %strptr65, 1
  %.t165 = call %DriftString @"std.format::format_int"(i64 %rc_3)
  %.t166 = call %DriftString @drift_string_concat(%DriftString %.t163, %DriftString %.t165)
  call void @drift_string_release(%DriftString %.t163)
  call void @drift_string_release(%DriftString %.t165)
  call void @"std.console::println"(%DriftString %.t166)
  br label %.bb.if_join6
.bb.if_then6:
  %strptr67 = getelementptr inbounds { i64, i64, [9 x i8] }, ptr @.str26, i32 0, i32 2, i32 0
  %str068 = insertvalue %DriftString zeroinitializer, i64 8, 0
  %.t162 = insertvalue %DriftString %str068, ptr %strptr67, 1
  call void @"std.console::println"(%DriftString %.t162)
  br label %.bb.if_join6
.bb.if_join6:
  %__arc18 = select i1 1, %Variant_std_2Ecore_Result_37335149f7faff82 zeroinitializer, %Variant_std_2Ecore_Result_37335149f7faff82 zeroinitializer
  %drop_variant_ptr69 = alloca %Variant_std_2Ecore_Result_37335149f7faff82
  store %Variant_std_2Ecore_Result_37335149f7faff82 %.t158, ptr %drop_variant_ptr69
  call void @__drift_array_drop_std__std_core_Result_Int_std__std_concurrent_ConcurrencyError__37335149f7faff82(i64 1, ptr %drop_variant_ptr69)
  %__cleanup_t10 = load %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0, ptr %sv__addr
  %zero_struct70 = insertvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 zeroinitializer, i8 0, 0
  %zero_struct71 = insertvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %zero_struct70, i64 0, 1
  %zero_struct72 = insertvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %zero_struct71, %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb zeroinitializer, 2
  %zero_struct73 = insertvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %zero_struct72, i8 0, 3
  %__arc19 = insertvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %zero_struct73, i64 0, 4
  store %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %__arc19, ptr %sv__addr
  call void @"std.concurrent::VirtualThread<T>::std.core.Destructible::destroy__inst__226883066d11622f"(%Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %__cleanup_t10)
  %__cleanup_t11 = load %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba, ptr %stopped__addr
  %__arc20 = insertvalue %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba zeroinitializer, %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa zeroinitializer, 0
  store %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba %__arc20, ptr %stopped__addr
  call void @"std.core.arc::_arc_destroy_impl__inst__0a6d34c7cbe9c09f"(%Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba %__cleanup_t11)
  %__cleanup_t12 = load %Struct_std_2Enet_SocketAddr_461bcf04e30af211, ptr %addr__addr
  %zero_struct74 = insertvalue %Struct_std_2Enet_SocketAddr_461bcf04e30af211 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc21 = insertvalue %Struct_std_2Enet_SocketAddr_461bcf04e30af211 %zero_struct74, i64 0, 1
  store %Struct_std_2Enet_SocketAddr_461bcf04e30af211 %__arc21, ptr %addr__addr
  %drop_field75 = extractvalue %Struct_std_2Enet_SocketAddr_461bcf04e30af211 %__cleanup_t12, 0
  call void @drift_string_release(%DriftString %drop_field75)
  %zero_arr76 = insertvalue %DriftArrayHeader zeroinitializer, i64 0, 0
  %zero_arr77 = insertvalue %DriftArrayHeader %zero_arr76, i64 0, 1
  %zero_arr78 = insertvalue %DriftArrayHeader %zero_arr77, i64 0, 2
  %__arc22 = insertvalue %DriftArrayHeader %zero_arr78, ptr null, 3
  %len79 = extractvalue %DriftArrayHeader %argv_1, 0
  %data80 = extractvalue %DriftArrayHeader %argv_1, 3
  call void @__drift_array_drop_String(i64 %len79, ptr %data80)
  call void @drift_free_array(ptr %data80)
  %__arc23 = load %DriftString, ptr %m1__addr
  %zero_str81 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %__arc24 = insertvalue %DriftString %zero_str81, ptr null, 1
  store %DriftString %__arc24, ptr %m1__addr
  call void @drift_string_release(%DriftString %__arc23)
  %__arc25 = load %DriftString, ptr %m2__addr
  %zero_str82 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %__arc26 = insertvalue %DriftString %zero_str82, ptr null, 1
  store %DriftString %__arc26, ptr %m2__addr
  call void @drift_string_release(%DriftString %__arc25)
  %__arc27 = load %DriftString, ptr %m3__addr
  %zero_str83 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %__arc28 = insertvalue %DriftString %zero_str83, ptr null, 1
  store %DriftString %__arc28, ptr %m3__addr
  call void @drift_string_release(%DriftString %__arc27)
  ret i64 %rc_3
.bb.match_arm_0:
  %__arc29 = select i1 1, %Variant_std_2Ecore_Result_f9949363b6b29c23 zeroinitializer, %Variant_std_2Ecore_Result_f9949363b6b29c23 zeroinitializer
  store %Variant_std_2Ecore_Result_f9949363b6b29c23 %.t10, ptr %__match_scrut_tmp.t16__addr
  %payload_words84 = getelementptr inbounds %Variant_std_2Ecore_Result_f9949363b6b29c23, ptr %__match_scrut_tmp.t16__addr, i32 0, i32 2
  %fieldptr85 = getelementptr inbounds { %Struct_std_2Enet_NetError_203564604ea2d3a4 }, ptr %payload_words84, i32 0, i32 0
  %.t21 = load %Struct_std_2Enet_NetError_203564604ea2d3a4, ptr %fieldptr85
  %zero_struct86 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc30 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %zero_struct86, i64 0, 1
  %zero_struct87 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc32 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %zero_struct87, i64 0, 1
  %drop_field88 = extractvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %__arc5, 0
  call void @drift_string_release(%DriftString %drop_field88)
  %strptr89 = getelementptr inbounds { i64, i64, [14 x i8] }, ptr @.str27, i32 0, i32 2, i32 0
  %str090 = insertvalue %DriftString zeroinitializer, i64 13, 0
  %.t25 = insertvalue %DriftString %str090, ptr %strptr89, 1
  call void @"std.console::println"(%DriftString %.t25)
  %.t26 = add i64 0, 99
  %zero_struct91 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc33 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %zero_struct91, i64 0, 1
  %drop_field92 = extractvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %.t21, 0
  call void @drift_string_release(%DriftString %drop_field92)
  %__cleanup_t2 = load %Struct_std_2Enet_SocketAddr_461bcf04e30af211, ptr %addr__addr
  %zero_struct93 = insertvalue %Struct_std_2Enet_SocketAddr_461bcf04e30af211 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc34 = insertvalue %Struct_std_2Enet_SocketAddr_461bcf04e30af211 %zero_struct93, i64 0, 1
  store %Struct_std_2Enet_SocketAddr_461bcf04e30af211 %__arc34, ptr %addr__addr
  %drop_field94 = extractvalue %Struct_std_2Enet_SocketAddr_461bcf04e30af211 %__cleanup_t2, 0
  call void @drift_string_release(%DriftString %drop_field94)
  %zero_arr95 = insertvalue %DriftArrayHeader zeroinitializer, i64 0, 0
  %zero_arr96 = insertvalue %DriftArrayHeader %zero_arr95, i64 0, 1
  %zero_arr97 = insertvalue %DriftArrayHeader %zero_arr96, i64 0, 2
  %__arc35 = insertvalue %DriftArrayHeader %zero_arr97, ptr null, 3
  %len98 = extractvalue %DriftArrayHeader %argv_1, 0
  %data99 = extractvalue %DriftArrayHeader %argv_1, 3
  call void @__drift_array_drop_String(i64 %len98, ptr %data99)
  call void @drift_free_array(ptr %data99)
  %__arc36 = load %DriftString, ptr %m1__addr
  %zero_str100 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %__arc37 = insertvalue %DriftString %zero_str100, ptr null, 1
  store %DriftString %__arc37, ptr %m1__addr
  call void @drift_string_release(%DriftString %__arc36)
  %__arc38 = load %DriftString, ptr %m2__addr
  %zero_str101 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %__arc39 = insertvalue %DriftString %zero_str101, ptr null, 1
  store %DriftString %__arc39, ptr %m2__addr
  call void @drift_string_release(%DriftString %__arc38)
  %__arc40 = load %DriftString, ptr %m3__addr
  %zero_str102 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %__arc41 = insertvalue %DriftString %zero_str102, ptr null, 1
  store %DriftString %__arc41, ptr %m3__addr
  call void @drift_string_release(%DriftString %__arc40)
  ret i64 %.t26
}
define i1 @"lang.atomic::AtomicBool::load"(ptr %self, %Variant_lang_2Eatomic_MemoryOrder_469abe0ace4b6a6f %order) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str28, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t4 = call i64 @"lang.atomic::_order_code"(%Variant_lang_2Eatomic_MemoryOrder_469abe0ace4b6a6f %order)
  %atomic_ptr3 = getelementptr inbounds %Struct_lang_2Eatomic_AtomicBool_4466cda2157b83d3, ptr %self, i32 0, i32 0
  %abool4 = call i8 @drift_atomic_load_bool(ptr %atomic_ptr3, i64 %.t4)
  %.t5 = icmp ne i8 %abool4, 0
  ret i1 %.t5
}
define void @"lang.atomic::AtomicBool::store"(ptr %self, i1 %v, %Variant_lang_2Eatomic_MemoryOrder_469abe0ace4b6a6f %order) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str29, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t5 = call i64 @"lang.atomic::_order_code"(%Variant_lang_2Eatomic_MemoryOrder_469abe0ace4b6a6f %order)
  %atomic_ptr3 = getelementptr inbounds %Struct_lang_2Eatomic_AtomicBool_4466cda2157b83d3, ptr %self, i32 0, i32 0
  %bool84 = zext i1 %v to i8
  call void @drift_atomic_store_bool(ptr %atomic_ptr3, i8 %bool84, i64 %.t5)
  ret void
}
define i64 @"lang.atomic::_order_code"(%Variant_lang_2Eatomic_MemoryOrder_469abe0ace4b6a6f %order_1) {
.bb.entry:
  %__match_scrut_tmp.t29__addr = alloca %Variant_lang_2Eatomic_MemoryOrder_469abe0ace4b6a6f
  %__match_scrut_tmp.t26__addr = alloca %Variant_lang_2Eatomic_MemoryOrder_469abe0ace4b6a6f
  %__match_scrut_tmp.t23__addr = alloca %Variant_lang_2Eatomic_MemoryOrder_469abe0ace4b6a6f
  %__match_scrut_tmp.t20__addr = alloca %Variant_lang_2Eatomic_MemoryOrder_469abe0ace4b6a6f
  %__match_scrut_tmp.t17__addr = alloca %Variant_lang_2Eatomic_MemoryOrder_469abe0ace4b6a6f
  %__match_scrut_tmp.t14__addr = alloca %Variant_lang_2Eatomic_MemoryOrder_469abe0ace4b6a6f
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str30, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  br label %.bb.match_dispatch
.bb.match_dispatch:
  %tag83 = extractvalue %Variant_lang_2Eatomic_MemoryOrder_469abe0ace4b6a6f %order_1, 0
  %.t3 = zext i8 %tag83 to i64
  %.t4 = add i64 0, 0
  %.t5 = icmp eq i64 %.t3, %.t4
  br i1 %.t5, label %.bb.match_arm_0, label %.bb.match_dispatch_next
.bb.match_dispatch_next:
  %.t6 = add i64 0, 1
  %.t7 = icmp eq i64 %.t3, %.t6
  br i1 %.t7, label %.bb.match_arm_1, label %.bb.match_dispatch_next1
.bb.match_dispatch_next1:
  %.t8 = add i64 0, 2
  %.t9 = icmp eq i64 %.t3, %.t8
  br i1 %.t9, label %.bb.match_arm_2, label %.bb.match_dispatch_next2
.bb.match_dispatch_next2:
  %.t10 = add i64 0, 3
  %.t11 = icmp eq i64 %.t3, %.t10
  br i1 %.t11, label %.bb.match_arm_3, label %.bb.match_dispatch_next3
.bb.match_dispatch_next3:
  %.t12 = add i64 0, 4
  %.t13 = icmp eq i64 %.t3, %.t12
  br i1 %.t13, label %.bb.match_arm_4, label %.bb.match_dispatch_next4
.bb.match_dispatch_next4:
  br label %.bb.match_arm_5
.bb.match_arm_5:
  store %Variant_lang_2Eatomic_MemoryOrder_469abe0ace4b6a6f %order_1, ptr %__match_scrut_tmp.t29__addr
  %.t31 = add i64 0, 0
  ret i64 %.t31
.bb.match_arm_4:
  store %Variant_lang_2Eatomic_MemoryOrder_469abe0ace4b6a6f %order_1, ptr %__match_scrut_tmp.t26__addr
  %.t28 = add i64 0, 4
  ret i64 %.t28
.bb.match_arm_3:
  store %Variant_lang_2Eatomic_MemoryOrder_469abe0ace4b6a6f %order_1, ptr %__match_scrut_tmp.t23__addr
  %.t25 = add i64 0, 3
  ret i64 %.t25
.bb.match_arm_2:
  store %Variant_lang_2Eatomic_MemoryOrder_469abe0ace4b6a6f %order_1, ptr %__match_scrut_tmp.t20__addr
  %.t22 = add i64 0, 2
  ret i64 %.t22
.bb.match_arm_1:
  store %Variant_lang_2Eatomic_MemoryOrder_469abe0ace4b6a6f %order_1, ptr %__match_scrut_tmp.t17__addr
  %.t19 = add i64 0, 1
  ret i64 %.t19
.bb.match_arm_0:
  store %Variant_lang_2Eatomic_MemoryOrder_469abe0ace4b6a6f %order_1, ptr %__match_scrut_tmp.t14__addr
  %.t16 = add i64 0, 0
  ret i64 %.t16
}
define %Struct_lang_2Eatomic_AtomicBool_4466cda2157b83d3 @"lang.atomic::atomic_bool"(i1 %v) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str31, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %bool83 = zext i1 %v to i8
  %.t3 = insertvalue %Struct_lang_2Eatomic_AtomicBool_4466cda2157b83d3 zeroinitializer, i8 %bool83, 0
  ret %Struct_lang_2Eatomic_AtomicBool_4466cda2157b83d3 %.t3
}
define %Struct_lang_2Eatomic_AtomicInt_4a3cfd9b16e4d07c @"lang.atomic::atomic_int"(i64 %v) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str32, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = insertvalue %Struct_lang_2Eatomic_AtomicInt_4a3cfd9b16e4d07c zeroinitializer, i64 %v, 0
  ret %Struct_lang_2Eatomic_AtomicInt_4a3cfd9b16e4d07c %.t3
}
define %Struct_std_2Econcurrent_ExecutorPolicy_d47ca96967314fb7 @"std.concurrent::ExecutorPolicyBuilder::build"(ptr %self) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str33, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = load %Struct_std_2Econcurrent_ExecutorPolicyBuilder_540c134815cc862b, ptr %self
  %.t4 = extractvalue %Struct_std_2Econcurrent_ExecutorPolicyBuilder_540c134815cc862b %.t3, 0
  %.t6 = load %Struct_std_2Econcurrent_ExecutorPolicyBuilder_540c134815cc862b, ptr %self
  %.t7 = extractvalue %Struct_std_2Econcurrent_ExecutorPolicyBuilder_540c134815cc862b %.t6, 1
  %.t9 = load %Struct_std_2Econcurrent_ExecutorPolicyBuilder_540c134815cc862b, ptr %self
  %.t10 = extractvalue %Struct_std_2Econcurrent_ExecutorPolicyBuilder_540c134815cc862b %.t9, 2
  %.t12 = load %Struct_std_2Econcurrent_ExecutorPolicyBuilder_540c134815cc862b, ptr %self
  %.t13 = extractvalue %Struct_std_2Econcurrent_ExecutorPolicyBuilder_540c134815cc862b %.t12, 3
  %.t15 = load %Struct_std_2Econcurrent_ExecutorPolicyBuilder_540c134815cc862b, ptr %self
  %.t16 = extractvalue %Struct_std_2Econcurrent_ExecutorPolicyBuilder_540c134815cc862b %.t15, 4
  %var_tag3 = extractvalue %Variant_std_2Econcurrent_SaturationPolicy_360793185eb004ed %.t16, 0
  %var_copy4 = alloca %Variant_std_2Econcurrent_SaturationPolicy_360793185eb004ed
  switch i8 %var_tag3, label %var_bad6 [ i8 0, label %var_arm_block7 i8 1, label %var_arm_returnbusy8 ]
var_arm_block7:
  %variant9 = alloca %Variant_std_2Econcurrent_SaturationPolicy_360793185eb004ed
  store %Variant_std_2Econcurrent_SaturationPolicy_360793185eb004ed %.t16, ptr %variant9
  %variant10 = alloca %Variant_std_2Econcurrent_SaturationPolicy_360793185eb004ed
  store %Variant_std_2Econcurrent_SaturationPolicy_360793185eb004ed zeroinitializer, ptr %variant10
  %tagptr11 = getelementptr inbounds %Variant_std_2Econcurrent_SaturationPolicy_360793185eb004ed, ptr %variant10, i32 0, i32 0
  store i8 0, ptr %tagptr11
  %variant_val12 = load %Variant_std_2Econcurrent_SaturationPolicy_360793185eb004ed, ptr %variant10
  store %Variant_std_2Econcurrent_SaturationPolicy_360793185eb004ed %variant_val12, ptr %var_copy4
  br label %var_done5
var_arm_returnbusy8:
  %variant13 = alloca %Variant_std_2Econcurrent_SaturationPolicy_360793185eb004ed
  store %Variant_std_2Econcurrent_SaturationPolicy_360793185eb004ed %.t16, ptr %variant13
  %variant14 = alloca %Variant_std_2Econcurrent_SaturationPolicy_360793185eb004ed
  store %Variant_std_2Econcurrent_SaturationPolicy_360793185eb004ed zeroinitializer, ptr %variant14
  %tagptr15 = getelementptr inbounds %Variant_std_2Econcurrent_SaturationPolicy_360793185eb004ed, ptr %variant14, i32 0, i32 0
  store i8 1, ptr %tagptr15
  %variant_val16 = load %Variant_std_2Econcurrent_SaturationPolicy_360793185eb004ed, ptr %variant14
  store %Variant_std_2Econcurrent_SaturationPolicy_360793185eb004ed %variant_val16, ptr %var_copy4
  br label %var_done5
var_bad6:
  call void @llvm.trap()
  unreachable
var_done5:
  %var_out17 = load %Variant_std_2Econcurrent_SaturationPolicy_360793185eb004ed, ptr %var_copy4
  %.t19 = load %Struct_std_2Econcurrent_ExecutorPolicyBuilder_540c134815cc862b, ptr %self
  %.t20 = extractvalue %Struct_std_2Econcurrent_ExecutorPolicyBuilder_540c134815cc862b %.t19, 5
  %struct18 = insertvalue %Struct_std_2Econcurrent_ExecutorPolicy_d47ca96967314fb7 zeroinitializer, i64 %.t4, 0
  %struct19 = insertvalue %Struct_std_2Econcurrent_ExecutorPolicy_d47ca96967314fb7 %struct18, i64 %.t7, 1
  %struct20 = insertvalue %Struct_std_2Econcurrent_ExecutorPolicy_d47ca96967314fb7 %struct19, i64 %.t10, 2
  %struct21 = insertvalue %Struct_std_2Econcurrent_ExecutorPolicy_d47ca96967314fb7 %struct20, %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %.t13, 3
  %struct22 = insertvalue %Struct_std_2Econcurrent_ExecutorPolicy_d47ca96967314fb7 %struct21, %Variant_std_2Econcurrent_SaturationPolicy_360793185eb004ed %var_out17, 4
  %.t21 = insertvalue %Struct_std_2Econcurrent_ExecutorPolicy_d47ca96967314fb7 %struct22, i64 %.t20, 5
  ret %Struct_std_2Econcurrent_ExecutorPolicy_d47ca96967314fb7 %.t21
}
define %Struct_std_2Econcurrent_Executor_c4c2a3d6fade171d @"std.concurrent::ExecutorPolicyBuilder::build_executor"(ptr %self_1) {
.bb.entry:
  %policy__addr = alloca %Struct_std_2Econcurrent_ExecutorPolicy_d47ca96967314fb7
  %__match_scrut_tmp.t18__addr = alloca %Variant_std_2Econcurrent_SaturationPolicy_360793185eb004ed
  %__match_scrut_tmp.t13__addr = alloca %Variant_std_2Econcurrent_SaturationPolicy_360793185eb004ed
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str34, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = call %Struct_std_2Econcurrent_ExecutorPolicy_d47ca96967314fb7 @"std.concurrent::ExecutorPolicyBuilder::build"(ptr %self_1)
  store %Struct_std_2Econcurrent_ExecutorPolicy_d47ca96967314fb7 %.t3, ptr %policy__addr
  %.t4 = add i64 0, 0
  %.t5 = load %Struct_std_2Econcurrent_ExecutorPolicy_d47ca96967314fb7, ptr %policy__addr
  %.t6 = extractvalue %Struct_std_2Econcurrent_ExecutorPolicy_d47ca96967314fb7 %.t5, 4
  %.t8 = getelementptr inbounds %Struct_std_2Econcurrent_ExecutorPolicy_d47ca96967314fb7, ptr %policy__addr, i32 0, i32 4
  %.t9 = select i1 1, %Variant_std_2Econcurrent_SaturationPolicy_360793185eb004ed zeroinitializer, %Variant_std_2Econcurrent_SaturationPolicy_360793185eb004ed zeroinitializer
  store %Variant_std_2Econcurrent_SaturationPolicy_360793185eb004ed %.t9, ptr %.t8
  br label %.bb.match_dispatch
.bb.match_dispatch:
  %tag83 = extractvalue %Variant_std_2Econcurrent_SaturationPolicy_360793185eb004ed %.t6, 0
  %.t10 = zext i8 %tag83 to i64
  %.t11 = add i64 0, 1
  %.t12 = icmp eq i64 %.t10, %.t11
  br i1 %.t12, label %.bb.match_arm_0, label %.bb.match_dispatch_next
.bb.match_dispatch_next:
  br label %.bb.match_arm_1
.bb.match_arm_1:
  %__arc2 = select i1 1, %Variant_std_2Econcurrent_SaturationPolicy_360793185eb004ed zeroinitializer, %Variant_std_2Econcurrent_SaturationPolicy_360793185eb004ed zeroinitializer
  store %Variant_std_2Econcurrent_SaturationPolicy_360793185eb004ed %.t6, ptr %__match_scrut_tmp.t18__addr
  %.t22 = add i64 0, 0
  br label %.bb.match_join
.bb.match_arm_0:
  %__arc1 = select i1 1, %Variant_std_2Econcurrent_SaturationPolicy_360793185eb004ed zeroinitializer, %Variant_std_2Econcurrent_SaturationPolicy_360793185eb004ed zeroinitializer
  store %Variant_std_2Econcurrent_SaturationPolicy_360793185eb004ed %.t6, ptr %__match_scrut_tmp.t13__addr
  %.t17 = add i64 0, 1
  br label %.bb.match_join
.bb.match_join:
  %sat_3 = phi i64 [ %.t22, %.bb.match_arm_1 ], [ %.t17, %.bb.match_arm_0 ]
  %.t23 = load %Struct_std_2Econcurrent_ExecutorPolicy_d47ca96967314fb7, ptr %policy__addr
  %.t24 = extractvalue %Struct_std_2Econcurrent_ExecutorPolicy_d47ca96967314fb7 %.t23, 0
  %.t25 = load %Struct_std_2Econcurrent_ExecutorPolicy_d47ca96967314fb7, ptr %policy__addr
  %.t26 = extractvalue %Struct_std_2Econcurrent_ExecutorPolicy_d47ca96967314fb7 %.t25, 1
  %.t27 = load %Struct_std_2Econcurrent_ExecutorPolicy_d47ca96967314fb7, ptr %policy__addr
  %.t28 = extractvalue %Struct_std_2Econcurrent_ExecutorPolicy_d47ca96967314fb7 %.t27, 2
  %.t29 = load %Struct_std_2Econcurrent_ExecutorPolicy_d47ca96967314fb7, ptr %policy__addr
  %.t30 = extractvalue %Struct_std_2Econcurrent_ExecutorPolicy_d47ca96967314fb7 %.t29, 3
  %.t31 = extractvalue %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %.t30, 0
  %.t33 = load %Struct_std_2Econcurrent_ExecutorPolicy_d47ca96967314fb7, ptr %policy__addr
  %.t34 = extractvalue %Struct_std_2Econcurrent_ExecutorPolicy_d47ca96967314fb7 %.t33, 5
  %.t35 = call i64 @drift_exec_create(i64 %.t24, i64 %.t26, i64 %.t28, i64 %.t31, i64 %sat_3, i64 %.t34)
  %.t36 = load %Struct_std_2Econcurrent_ExecutorPolicy_d47ca96967314fb7, ptr %policy__addr
  %struct4 = insertvalue %Struct_std_2Econcurrent_Executor_c4c2a3d6fade171d zeroinitializer, %Struct_std_2Econcurrent_ExecutorPolicy_d47ca96967314fb7 %.t36, 0
  %.t38 = insertvalue %Struct_std_2Econcurrent_Executor_c4c2a3d6fade171d %struct4, i64 %.t35, 1
  ret %Struct_std_2Econcurrent_Executor_c4c2a3d6fade171d %.t38
}
define %Variant_std_2Ecore_Result_4861f1d1d2eeba72 @"std.concurrent::_check_duration"(%Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %d_1) {
.bb.entry:
  %__throw_diag_.t14__addr = alloca %Struct_std_2Econcurrent_InvalidDuration_a4e3fb5850f7f182
  %__arc1 = select i1 1, ptr null, ptr null
  %__arc2 = select i1 1, ptr null, ptr null
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str35, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = extractvalue %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %d_1, 0
  %.t4 = add i64 0, 0
  %.t5 = icmp slt i64 %.t3, %.t4
  br i1 %.t5, label %.bb.if_then, label %.bb.if_join
.bb.if_join:
  call void @"std.core::void_value"()
  %.t27 = add i8 0, 0
  %variant3 = alloca %Variant_std_2Ecore_Result_4861f1d1d2eeba72
  store %Variant_std_2Ecore_Result_4861f1d1d2eeba72 zeroinitializer, ptr %variant3
  %tagptr4 = getelementptr inbounds %Variant_std_2Ecore_Result_4861f1d1d2eeba72, ptr %variant3, i32 0, i32 0
  store i8 0, ptr %tagptr4
  %payload_words5 = getelementptr inbounds %Variant_std_2Ecore_Result_4861f1d1d2eeba72, ptr %variant3, i32 0, i32 2
  %fieldptr6 = getelementptr inbounds { i8 }, ptr %payload_words5, i32 0, i32 0
  store i8 %.t27, ptr %fieldptr6
  %.t28 = load %Variant_std_2Ecore_Result_4861f1d1d2eeba72, ptr %variant3
  ret %Variant_std_2Ecore_Result_4861f1d1d2eeba72 %.t28
.bb.if_then:
  %.t7 = select i1 1, ptr null, ptr null
  %__arc4 = select i1 1, ptr null, ptr null
  call void @drift_error_release(ptr %__arc1)
  br label %.bb.try_body
.bb.try_body:
  %.t9 = add i64 0, 2036322554585620490
  %strptr7 = getelementptr inbounds { i64, i64, [31 x i8] }, ptr @.str36, i32 0, i32 2, i32 0
  %str08 = insertvalue %DriftString zeroinitializer, i64 30, 0
  %.t10 = insertvalue %DriftString %str08, ptr %strptr7, 1
  %.t12 = extractvalue %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %d_1, 0
  %.t13 = insertvalue %Struct_std_2Econcurrent_InvalidDuration_a4e3fb5850f7f182 zeroinitializer, i64 %.t12, 0
  store %Struct_std_2Econcurrent_InvalidDuration_a4e3fb5850f7f182 %.t13, ptr %__throw_diag_.t14__addr
  %.t16 = call %DriftString @"std.concurrent::std.concurrent.InvalidDuration::std.core.Diagnostic::to_json_text"(ptr %__throw_diag_.t14__addr)
  %.t8 = call ptr @drift_error_new(i64 %.t9, %DriftString %.t10)
  call void @drift_error_set_params_json(ptr %.t8, %DriftString %.t16)
  %.t17 = load %Struct_std_2Econcurrent_InvalidDuration_a4e3fb5850f7f182, ptr %__throw_diag_.t14__addr
  %__arc6 = select i1 1, ptr null, ptr null
  call void @drift_error_release(ptr %.t7)
  br label %.bb.try_dispatch
.bb.try_dispatch:
  %err_val9 = load %DriftError, ptr %.t8
  %.t19 = extractvalue %DriftError %err_val9, 0
  br label %.bb.try_catch_0
.bb.try_catch_0:
  %__arc7 = select i1 1, ptr null, ptr null
  %__arc9 = select i1 1, ptr null, ptr null
  call void @drift_error_release(ptr %__arc2)
  %err_val10 = load %DriftError, ptr %.t8
  %.t21 = extractvalue %DriftError %err_val10, 0
  %strptr11 = getelementptr inbounds { i64, i64, [7 x i8] }, ptr @.str37, i32 0, i32 2, i32 0
  %str012 = insertvalue %DriftString zeroinitializer, i64 6, 0
  %.t22 = insertvalue %DriftString %str012, ptr %strptr11, 1
  %.t23 = add i64 0, 5
  %.t24 = sub i64 0, %.t23
  %struct13 = insertvalue %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 zeroinitializer, %DriftString %.t22, 0
  %.t25 = insertvalue %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 %struct13, i64 %.t24, 1
  %variant14 = alloca %Variant_std_2Ecore_Result_4861f1d1d2eeba72
  store %Variant_std_2Ecore_Result_4861f1d1d2eeba72 zeroinitializer, ptr %variant14
  %tagptr15 = getelementptr inbounds %Variant_std_2Ecore_Result_4861f1d1d2eeba72, ptr %variant14, i32 0, i32 0
  store i8 1, ptr %tagptr15
  %payload_words16 = getelementptr inbounds %Variant_std_2Ecore_Result_4861f1d1d2eeba72, ptr %variant14, i32 0, i32 2
  %fieldptr17 = getelementptr inbounds { %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 }, ptr %payload_words16, i32 0, i32 0
  store %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 %.t25, ptr %fieldptr17
  %.t26 = load %Variant_std_2Ecore_Result_4861f1d1d2eeba72, ptr %variant14
  %__arc11 = select i1 1, ptr null, ptr null
  call void @drift_error_release(ptr %.t8)
  ret %Variant_std_2Ecore_Result_4861f1d1d2eeba72 %.t26
}
define %Struct_lang_2Eatomic_AtomicBool_4466cda2157b83d3 @"std.concurrent::atomic_bool"(i1 %v) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str38, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = call %Struct_lang_2Eatomic_AtomicBool_4466cda2157b83d3 @"lang.atomic::atomic_bool"(i1 %v)
  ret %Struct_lang_2Eatomic_AtomicBool_4466cda2157b83d3 %.t3
}
define %Struct_std_2Econcurrent_Executor_c4c2a3d6fade171d @"std.concurrent::default_executor"() {
.bb.entry:
  %b__addr = alloca %Struct_std_2Econcurrent_ExecutorPolicyBuilder_540c134815cc862b
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str39, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t2 = call %Struct_std_2Econcurrent_ExecutorPolicyBuilder_540c134815cc862b @"std.concurrent::executor_policy_builder"()
  store %Struct_std_2Econcurrent_ExecutorPolicyBuilder_540c134815cc862b %.t2, ptr %b__addr
  %.t3 = call i64 @drift_exec_default_get()
  %.t5 = add i64 0, 0
  %.t6 = icmp eq i64 %.t3, %.t5
  br i1 %.t6, label %.bb.if_then, label %.bb.if_join
.bb.if_join:
  %.t13 = call %Struct_std_2Econcurrent_ExecutorPolicy_d47ca96967314fb7 @"std.concurrent::ExecutorPolicyBuilder::build"(ptr %b__addr)
  %struct3 = insertvalue %Struct_std_2Econcurrent_Executor_c4c2a3d6fade171d zeroinitializer, %Struct_std_2Econcurrent_ExecutorPolicy_d47ca96967314fb7 %.t13, 0
  %.t15 = insertvalue %Struct_std_2Econcurrent_Executor_c4c2a3d6fade171d %struct3, i64 %.t3, 1
  ret %Struct_std_2Econcurrent_Executor_c4c2a3d6fade171d %.t15
.bb.if_then:
  %.t8 = call %Struct_std_2Econcurrent_Executor_c4c2a3d6fade171d @"std.concurrent::ExecutorPolicyBuilder::build_executor"(ptr %b__addr)
  %.t10 = extractvalue %Struct_std_2Econcurrent_Executor_c4c2a3d6fade171d %.t8, 1
  call void @drift_exec_default_set(i64 %.t10)
  ret %Struct_std_2Econcurrent_Executor_c4c2a3d6fade171d %.t8
}
define %Struct_std_2Econcurrent_ExecutorPolicyBuilder_540c134815cc862b @"std.concurrent::executor_policy_builder"() {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str40, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t2 = add i64 0, 1
  %.t3 = add i64 0, 1
  %.t4 = add i64 0, 0
  %.t5 = add i64 0, 0
  %.t6 = insertvalue %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 zeroinitializer, i64 %.t5, 0
  %.t7 = insertvalue %Variant_std_2Econcurrent_SaturationPolicy_360793185eb004ed zeroinitializer, i8 1, 0
  %.t8 = add i64 0, 262144
  %struct3 = insertvalue %Struct_std_2Econcurrent_ExecutorPolicyBuilder_540c134815cc862b zeroinitializer, i64 %.t2, 0
  %struct4 = insertvalue %Struct_std_2Econcurrent_ExecutorPolicyBuilder_540c134815cc862b %struct3, i64 %.t3, 1
  %struct5 = insertvalue %Struct_std_2Econcurrent_ExecutorPolicyBuilder_540c134815cc862b %struct4, i64 %.t4, 2
  %struct6 = insertvalue %Struct_std_2Econcurrent_ExecutorPolicyBuilder_540c134815cc862b %struct5, %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %.t6, 3
  %struct7 = insertvalue %Struct_std_2Econcurrent_ExecutorPolicyBuilder_540c134815cc862b %struct6, %Variant_std_2Econcurrent_SaturationPolicy_360793185eb004ed %.t7, 4
  %.t9 = insertvalue %Struct_std_2Econcurrent_ExecutorPolicyBuilder_540c134815cc862b %struct7, i64 %.t8, 5
  ret %Struct_std_2Econcurrent_ExecutorPolicyBuilder_540c134815cc862b %.t9
}
define %Variant_std_2Ecore_Result_4861f1d1d2eeba72 @"std.concurrent::sleep"(%Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %d_1) {
.bb.entry:
  %__match_scrut_tmp.t20__addr = alloca %Variant_std_2Ecore_Result_4861f1d1d2eeba72
  %__match_scrut_tmp.t10__addr = alloca %Variant_std_2Ecore_Result_4861f1d1d2eeba72
  %__arc1 = select i1 1, %Variant_std_2Ecore_Result_4861f1d1d2eeba72 zeroinitializer, %Variant_std_2Ecore_Result_4861f1d1d2eeba72 zeroinitializer
  %zero_struct1 = insertvalue %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc2 = insertvalue %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 %zero_struct1, i64 0, 1
  %strptr2 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str41, i32 0, i32 2, i32 0
  %str03 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str03, ptr %strptr2, 1
  %.t3 = call %Variant_std_2Ecore_Result_4861f1d1d2eeba72 @"std.concurrent::_check_duration"(%Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %d_1)
  %__arc4 = select i1 1, %Variant_std_2Ecore_Result_4861f1d1d2eeba72 zeroinitializer, %Variant_std_2Ecore_Result_4861f1d1d2eeba72 zeroinitializer
  %drop_variant_ptr4 = alloca %Variant_std_2Ecore_Result_4861f1d1d2eeba72
  store %Variant_std_2Ecore_Result_4861f1d1d2eeba72 %__arc1, ptr %drop_variant_ptr4
  call void @__drift_array_drop_std__std_core_Result_Void_std__std_concurrent_ConcurrencyError__4861f1d1d2eeba72(i64 1, ptr %drop_variant_ptr4)
  br label %.bb.match_dispatch
.bb.match_dispatch:
  %tag85 = extractvalue %Variant_std_2Ecore_Result_4861f1d1d2eeba72 %.t3, 0
  %.t5 = zext i8 %tag85 to i64
  %.t6 = add i64 0, 1
  %.t7 = icmp eq i64 %.t5, %.t6
  br i1 %.t7, label %.bb.match_arm_0, label %.bb.match_dispatch_next
.bb.match_dispatch_next:
  %.t8 = add i64 0, 0
  %.t9 = icmp eq i64 %.t5, %.t8
  br i1 %.t9, label %.bb.match_arm_1, label %.bb.match_dispatch_next1
.bb.match_dispatch_next1:
  unreachable
.bb.match_arm_1:
  %__arc10 = select i1 1, %Variant_std_2Ecore_Result_4861f1d1d2eeba72 zeroinitializer, %Variant_std_2Ecore_Result_4861f1d1d2eeba72 zeroinitializer
  store %Variant_std_2Ecore_Result_4861f1d1d2eeba72 %.t3, ptr %__match_scrut_tmp.t20__addr
  %payload_words6 = getelementptr inbounds %Variant_std_2Ecore_Result_4861f1d1d2eeba72, ptr %__match_scrut_tmp.t20__addr, i32 0, i32 2
  %fieldptr7 = getelementptr inbounds { i8 }, ptr %payload_words6, i32 0, i32 0
  %.t24 = load i8, ptr %fieldptr7
  %__cleanup_t1 = load %Variant_std_2Ecore_Result_4861f1d1d2eeba72, ptr %__match_scrut_tmp.t20__addr
  %__arc11 = select i1 1, %Variant_std_2Ecore_Result_4861f1d1d2eeba72 zeroinitializer, %Variant_std_2Ecore_Result_4861f1d1d2eeba72 zeroinitializer
  store %Variant_std_2Ecore_Result_4861f1d1d2eeba72 %__arc11, ptr %__match_scrut_tmp.t20__addr
  %drop_variant_ptr8 = alloca %Variant_std_2Ecore_Result_4861f1d1d2eeba72
  store %Variant_std_2Ecore_Result_4861f1d1d2eeba72 %__cleanup_t1, ptr %drop_variant_ptr8
  call void @__drift_array_drop_std__std_core_Result_Void_std__std_concurrent_ConcurrencyError__4861f1d1d2eeba72(i64 1, ptr %drop_variant_ptr8)
  br label %.bb.match_join
.bb.match_join:
  %.t27 = extractvalue %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %d_1, 0
  %.t28 = add i64 0, 0
  %.t29 = icmp eq i64 %.t27, %.t28
  br i1 %.t29, label %.bb.if_then, label %.bb.if_join
.bb.if_join:
  %.t35 = call i64 @drift_time_now_ms()
  %.t37 = extractvalue %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %d_1, 0
  %.t38 = add i64 %.t35, %.t37
  %.t39 = call i64 @drift_thread_current()
  %.t41 = add i64 0, 0
  %.t42 = icmp eq i64 %.t39, %.t41
  br i1 %.t42, label %.bb.if_then1, label %.bb.if_join1
.bb.if_join1:
  call void @drift_reactor_register_timer(i64 %.t38, i64 %.t39)
  br label %.bb.loop_header
.bb.loop_header:
  br label %.bb.loop_body
.bb.loop_body:
  %.t49 = call i64 @drift_time_now_ms()
  %.t51 = icmp slt i64 %.t49, %.t38
  br i1 %.t51, label %.bb.if_then2, label %.bb.if_else
.bb.if_else:
  br label %.bb.loop_exit
.bb.if_then2:
  %.t52 = call i64 @drift_thread_is_cancelled()
  %.t53 = add i64 0, 0
  %.t54 = icmp ne i64 %.t52, %.t53
  br i1 %.t54, label %.bb.if_then3, label %.bb.if_join3
.bb.if_join3:
  %.t55 = add i64 0, 1
  %.t56 = add i64 0, 0
  call void @drift_thread_set_wait(i64 %.t55, i64 %.t56)
  %.t57 = add i64 0, 0
  call void @drift_thread_park(i64 %.t57)
  br label %.bb.if_join2
.bb.if_join2:
  br label %.bb.loop_header
.bb.if_then3:
  br label %.bb.loop_exit
.bb.loop_exit:
  call void @"std.core::void_value"()
  %.t58 = add i8 0, 0
  %variant9 = alloca %Variant_std_2Ecore_Result_4861f1d1d2eeba72
  store %Variant_std_2Ecore_Result_4861f1d1d2eeba72 zeroinitializer, ptr %variant9
  %tagptr10 = getelementptr inbounds %Variant_std_2Ecore_Result_4861f1d1d2eeba72, ptr %variant9, i32 0, i32 0
  store i8 0, ptr %tagptr10
  %payload_words11 = getelementptr inbounds %Variant_std_2Ecore_Result_4861f1d1d2eeba72, ptr %variant9, i32 0, i32 2
  %fieldptr12 = getelementptr inbounds { i8 }, ptr %payload_words11, i32 0, i32 0
  store i8 %.t58, ptr %fieldptr12
  %.t59 = load %Variant_std_2Ecore_Result_4861f1d1d2eeba72, ptr %variant9
  ret %Variant_std_2Ecore_Result_4861f1d1d2eeba72 %.t59
.bb.if_then1:
  %.t44 = extractvalue %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %d_1, 0
  call void @drift_thread_park_until(i64 %.t44)
  call void @"std.core::void_value"()
  %.t45 = add i8 0, 0
  %variant13 = alloca %Variant_std_2Ecore_Result_4861f1d1d2eeba72
  store %Variant_std_2Ecore_Result_4861f1d1d2eeba72 zeroinitializer, ptr %variant13
  %tagptr14 = getelementptr inbounds %Variant_std_2Ecore_Result_4861f1d1d2eeba72, ptr %variant13, i32 0, i32 0
  store i8 0, ptr %tagptr14
  %payload_words15 = getelementptr inbounds %Variant_std_2Ecore_Result_4861f1d1d2eeba72, ptr %variant13, i32 0, i32 2
  %fieldptr16 = getelementptr inbounds { i8 }, ptr %payload_words15, i32 0, i32 0
  store i8 %.t45, ptr %fieldptr16
  %.t46 = load %Variant_std_2Ecore_Result_4861f1d1d2eeba72, ptr %variant13
  ret %Variant_std_2Ecore_Result_4861f1d1d2eeba72 %.t46
.bb.if_then:
  %strptr17 = getelementptr inbounds { i64, i64, [8 x i8] }, ptr @.str42, i32 0, i32 2, i32 0
  %str018 = insertvalue %DriftString zeroinitializer, i64 7, 0
  %.t30 = insertvalue %DriftString %str018, ptr %strptr17, 1
  %.t31 = add i64 0, 1
  %.t32 = sub i64 0, %.t31
  %struct19 = insertvalue %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 zeroinitializer, %DriftString %.t30, 0
  %.t33 = insertvalue %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 %struct19, i64 %.t32, 1
  %variant20 = alloca %Variant_std_2Ecore_Result_4861f1d1d2eeba72
  store %Variant_std_2Ecore_Result_4861f1d1d2eeba72 zeroinitializer, ptr %variant20
  %tagptr21 = getelementptr inbounds %Variant_std_2Ecore_Result_4861f1d1d2eeba72, ptr %variant20, i32 0, i32 0
  store i8 1, ptr %tagptr21
  %payload_words22 = getelementptr inbounds %Variant_std_2Ecore_Result_4861f1d1d2eeba72, ptr %variant20, i32 0, i32 2
  %fieldptr23 = getelementptr inbounds { %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 }, ptr %payload_words22, i32 0, i32 0
  store %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 %.t33, ptr %fieldptr23
  %.t34 = load %Variant_std_2Ecore_Result_4861f1d1d2eeba72, ptr %variant20
  ret %Variant_std_2Ecore_Result_4861f1d1d2eeba72 %.t34
.bb.match_arm_0:
  %__arc5 = select i1 1, %Variant_std_2Ecore_Result_4861f1d1d2eeba72 zeroinitializer, %Variant_std_2Ecore_Result_4861f1d1d2eeba72 zeroinitializer
  store %Variant_std_2Ecore_Result_4861f1d1d2eeba72 %.t3, ptr %__match_scrut_tmp.t10__addr
  %payload_words24 = getelementptr inbounds %Variant_std_2Ecore_Result_4861f1d1d2eeba72, ptr %__match_scrut_tmp.t10__addr, i32 0, i32 2
  %fieldptr25 = getelementptr inbounds { %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 }, ptr %payload_words24, i32 0, i32 0
  %.t14 = load %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204, ptr %fieldptr25
  %zero_struct26 = insertvalue %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc6 = insertvalue %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 %zero_struct26, i64 0, 1
  %zero_struct27 = insertvalue %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc8 = insertvalue %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 %zero_struct27, i64 0, 1
  %drop_field28 = extractvalue %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 %__arc2, 0
  call void @drift_string_release(%DriftString %drop_field28)
  %zero_struct29 = insertvalue %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 zeroinitializer, %DriftString zeroinitializer, 0
  %__arc9 = insertvalue %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 %zero_struct29, i64 0, 1
  %variant30 = alloca %Variant_std_2Ecore_Result_4861f1d1d2eeba72
  store %Variant_std_2Ecore_Result_4861f1d1d2eeba72 zeroinitializer, ptr %variant30
  %tagptr31 = getelementptr inbounds %Variant_std_2Ecore_Result_4861f1d1d2eeba72, ptr %variant30, i32 0, i32 0
  store i8 1, ptr %tagptr31
  %payload_words32 = getelementptr inbounds %Variant_std_2Ecore_Result_4861f1d1d2eeba72, ptr %variant30, i32 0, i32 2
  %fieldptr33 = getelementptr inbounds { %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 }, ptr %payload_words32, i32 0, i32 0
  store %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 %.t14, ptr %fieldptr33
  %.t19 = load %Variant_std_2Ecore_Result_4861f1d1d2eeba72, ptr %variant30
  ret %Variant_std_2Ecore_Result_4861f1d1d2eeba72 %.t19
}
define %DriftString @"std.concurrent::std.concurrent.ExecSubmitFailed::std.core.Diagnostic::to_json_text"(ptr %self) {
.bb.entry:
  %self__addr = alloca ptr
  store ptr %self, ptr %self__addr
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str43, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %strptr3 = getelementptr inbounds { i64, i64, [2 x i8] }, ptr @.str44, i32 0, i32 2, i32 0
  %str04 = insertvalue %DriftString zeroinitializer, i64 1, 0
  %.t2 = insertvalue %DriftString %str04, ptr %strptr3, 1
  %strptr5 = getelementptr inbounds { i64, i64, [8 x i8] }, ptr @.str45, i32 0, i32 2, i32 0
  %str06 = insertvalue %DriftString zeroinitializer, i64 7, 0
  %.t3 = insertvalue %DriftString %str06, ptr %strptr5, 1
  %.t4 = call %DriftString @drift_string_concat(%DriftString %.t2, %DriftString %.t3)
  call void @drift_string_release(%DriftString %.t2)
  call void @drift_string_release(%DriftString %.t3)
  %.t6 = load ptr, ptr %self__addr
  %.t7 = getelementptr inbounds %Struct_std_2Econcurrent_ExecSubmitFailed_1afe4ac0bfe13e54, ptr %.t6, i32 0, i32 0
  %.t8 = call %DriftString @"std.core::Int::Diagnostic::to_json_text"(ptr %.t7)
  %.t9 = call %DriftString @drift_string_concat(%DriftString %.t4, %DriftString %.t8)
  call void @drift_string_release(%DriftString %.t4)
  call void @drift_string_release(%DriftString %.t8)
  %strptr7 = getelementptr inbounds { i64, i64, [2 x i8] }, ptr @.str46, i32 0, i32 2, i32 0
  %str08 = insertvalue %DriftString zeroinitializer, i64 1, 0
  %.t10 = insertvalue %DriftString %str08, ptr %strptr7, 1
  %.t11 = call %DriftString @drift_string_concat(%DriftString %.t9, %DriftString %.t10)
  call void @drift_string_release(%DriftString %.t9)
  call void @drift_string_release(%DriftString %.t10)
  ret %DriftString %.t11
}
define %DriftString @"std.concurrent::std.concurrent.InvalidDuration::std.core.Diagnostic::to_json_text"(ptr %self) {
.bb.entry:
  %self__addr = alloca ptr
  store ptr %self, ptr %self__addr
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str47, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %strptr3 = getelementptr inbounds { i64, i64, [2 x i8] }, ptr @.str48, i32 0, i32 2, i32 0
  %str04 = insertvalue %DriftString zeroinitializer, i64 1, 0
  %.t2 = insertvalue %DriftString %str04, ptr %strptr3, 1
  %strptr5 = getelementptr inbounds { i64, i64, [10 x i8] }, ptr @.str49, i32 0, i32 2, i32 0
  %str06 = insertvalue %DriftString zeroinitializer, i64 9, 0
  %.t3 = insertvalue %DriftString %str06, ptr %strptr5, 1
  %.t4 = call %DriftString @drift_string_concat(%DriftString %.t2, %DriftString %.t3)
  call void @drift_string_release(%DriftString %.t2)
  call void @drift_string_release(%DriftString %.t3)
  %.t6 = load ptr, ptr %self__addr
  %.t7 = getelementptr inbounds %Struct_std_2Econcurrent_InvalidDuration_a4e3fb5850f7f182, ptr %.t6, i32 0, i32 0
  %.t8 = call %DriftString @"std.core::Int::Diagnostic::to_json_text"(ptr %.t7)
  %.t9 = call %DriftString @drift_string_concat(%DriftString %.t4, %DriftString %.t8)
  call void @drift_string_release(%DriftString %.t4)
  call void @drift_string_release(%DriftString %.t8)
  %strptr7 = getelementptr inbounds { i64, i64, [2 x i8] }, ptr @.str50, i32 0, i32 2, i32 0
  %str08 = insertvalue %DriftString zeroinitializer, i64 1, 0
  %.t10 = insertvalue %DriftString %str08, ptr %strptr7, 1
  %.t11 = call %DriftString @drift_string_concat(%DriftString %.t9, %DriftString %.t10)
  call void @drift_string_release(%DriftString %.t9)
  call void @drift_string_release(%DriftString %.t10)
  ret %DriftString %.t11
}
define void @"std.console::_fill_chunk"(ptr %dst_1, ptr %text_1, i64 %start_1, i64 %total_len_1, i1 %with_newline_1) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str51, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t2 = add i64 0, 0
  %.t4 = call i64 @"std.io::buffer_capacity_mut"(ptr %dst_1)
  %__logic_tmp.t22_1 = add i1 0, 0
  br label %.bb.loop_header
.bb.loop_header:
  %__logic_tmp.t22_2 = phi i1 [ %__logic_tmp.t22_1, %.bb.entry ], [ %__logic_tmp.t22_3, %.bb.if_join ]
  %i_2 = phi i64 [ %.t2, %.bb.entry ], [ %.t33, %.bb.if_join ]
  br label %.bb.loop_body
.bb.loop_body:
  %.t7 = icmp slt i64 %i_2, %.t4
  br i1 %.t7, label %.bb.if_then, label %.bb.if_else
.bb.if_else:
  br label %.bb.loop_exit
.bb.loop_exit:
  ret void
.bb.if_then:
  %.t10 = add i64 %start_1, %i_2
  %.t13 = icmp slt i64 %.t10, %total_len_1
  br i1 %.t13, label %.bb.if_then1, label %.bb.if_else1
.bb.if_else1:
  br i1 %with_newline_1, label %.bb.logic_rhs, label %.bb.logic_short
.bb.logic_short:
  %.t23 = add i1 0, 0
  br label %.bb.logic_join
.bb.logic_rhs:
  %.t26 = icmp eq i64 %.t10, %total_len_1
  br label %.bb.logic_join
.bb.logic_join:
  %__logic_tmp.t22_5 = phi i1 [ %.t23, %.bb.logic_short ], [ %.t26, %.bb.logic_rhs ]
  br i1 %__logic_tmp.t22_5, label %.bb.if_then2, label %.bb.if_join2
.bb.if_then2:
  %.t30 = add i8 0, 10
  call void @"std.io::buffer_write"(ptr %dst_1, i64 %i_2, i8 %.t30)
  br label %.bb.if_join2
.bb.if_join2:
  br label %.bb.if_join1
.bb.if_then1:
  %.t15 = load %DriftString, ptr %text_1
  %len3 = extractvalue %DriftString %.t15, 0
  %data4 = extractvalue %DriftString %.t15, 1
  %strptr5 = getelementptr inbounds { i64, i64, [16 x i8] }, ptr @.str2, i32 0, i32 2, i32 0
  %str06 = insertvalue %DriftString zeroinitializer, i64 15, 0
  %str7 = insertvalue %DriftString %str06, ptr %strptr5, 1
  call void @drift_bounds_check(%DriftString %str7, i64 %.t10, i64 %len3)
  %ptr8 = getelementptr i8, ptr %data4, i64 %.t10
  %.t17 = load i8, ptr %ptr8
  call void @"std.io::buffer_write"(ptr %dst_1, i64 %i_2, i8 %.t17)
  br label %.bb.if_join1
.bb.if_join1:
  %__logic_tmp.t22_3 = phi i1 [ %__logic_tmp.t22_2, %.bb.if_then1 ], [ %__logic_tmp.t22_5, %.bb.if_join2 ]
  %.t31 = add i64 0, 1
  %.t33 = add i64 %i_2, %.t31
  br label %.bb.if_join
.bb.if_join:
  br label %.bb.loop_header
}
define i64 @"std.console::_min"(i64 %a_1, i64 %b_1) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str52, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t4 = icmp slt i64 %a_1, %b_1
  br i1 %.t4, label %.bb.if_then, label %.bb.if_join
.bb.if_join:
  ret i64 %b_1
.bb.if_then:
  ret i64 %a_1
}
define void @__drift_array_drop_std__std_core_Result_Int_std__std_io_IoError__91c2f7f96a418c4d(i64 %len, ptr %data) {
  %idx_ptr1 = alloca i64
  store i64 0, ptr %idx_ptr1
  br label %arr_drop_cond2
arr_drop_cond2:
  %idx5 = load i64, ptr %idx_ptr1
  %idx_ok6 = icmp slt i64 %idx5, %len
  br i1 %idx_ok6, label %arr_drop_body3, label %arr_drop_done4
arr_drop_body3:
  %idxv7 = load i64, ptr %idx_ptr1
  %eltptr8 = getelementptr inbounds %Variant_std_2Ecore_Result_91c2f7f96a418c4d, ptr %data, i64 %idxv7
  %old9 = load %Variant_std_2Ecore_Result_91c2f7f96a418c4d, ptr %eltptr8
  %tag10 = extractvalue %Variant_std_2Ecore_Result_91c2f7f96a418c4d %old9, 0
  switch i8 %tag10, label %drop_bad12 [ i8 0, label %drop_ok13 i8 1, label %drop_err14 i8 2, label %drop_tombstone15 ]
drop_ok13:
  %variant16 = alloca %Variant_std_2Ecore_Result_91c2f7f96a418c4d
  store %Variant_std_2Ecore_Result_91c2f7f96a418c4d %old9, ptr %variant16
  %payload_words17 = getelementptr inbounds %Variant_std_2Ecore_Result_91c2f7f96a418c4d, ptr %variant16, i32 0, i32 2
  br label %drop_done11
drop_err14:
  %variant18 = alloca %Variant_std_2Ecore_Result_91c2f7f96a418c4d
  store %Variant_std_2Ecore_Result_91c2f7f96a418c4d %old9, ptr %variant18
  %payload_words19 = getelementptr inbounds %Variant_std_2Ecore_Result_91c2f7f96a418c4d, ptr %variant18, i32 0, i32 2
  %fieldptr20 = getelementptr inbounds { %Struct_std_2Eio_IoError_7415ea6adc7a82aa }, ptr %payload_words19, i32 0, i32 0
  %field21 = load %Struct_std_2Eio_IoError_7415ea6adc7a82aa, ptr %fieldptr20
  %field22 = extractvalue %Struct_std_2Eio_IoError_7415ea6adc7a82aa %field21, 0
  call void @drift_string_release(%DriftString %field22)
  br label %drop_done11
drop_tombstone15:
  br label %drop_done11
drop_bad12:
  call void @llvm.trap()
  unreachable
drop_done11:
  %idx_next23 = add i64 %idxv7, 1
  store i64 %idx_next23, ptr %idx_ptr1
  br label %arr_drop_cond2
arr_drop_done4:
  ret void
}
define void @"std.console::_write_all_stream"(ptr %out_1, %DriftString %text, i1 %with_newline_1) {
.bb.entry:
  %text__addr = alloca %DriftString
  store %DriftString zeroinitializer, ptr %text__addr
  store %DriftString %text, ptr %text__addr
  %chunk__addr = alloca %Struct_std_2Eio_Buffer_e76b5c24b140f2f4
  %__match_scrut_tmp.t58__addr = alloca %Variant_std_2Ecore_Result_91c2f7f96a418c4d
  %__match_scrut_tmp.t50__addr = alloca %Variant_std_2Ecore_Result_91c2f7f96a418c4d
  %__match_scrut_tmp.t38__addr = alloca %Variant_std_2Ecore_Result_91c2f7f96a418c4d
  %__arc1 = select i1 1, %Variant_std_2Ecore_Result_91c2f7f96a418c4d zeroinitializer, %Variant_std_2Ecore_Result_91c2f7f96a418c4d zeroinitializer
  %zero_struct1 = insertvalue %Struct_std_2Eio_IoError_7415ea6adc7a82aa zeroinitializer, %DriftString zeroinitializer, 0
  %__arc2 = insertvalue %Struct_std_2Eio_IoError_7415ea6adc7a82aa %zero_struct1, i64 0, 1
  %strptr2 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str53, i32 0, i32 2, i32 0
  %str03 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str03, ptr %strptr2, 1
  %.t3 = call i64 @"std.core::String::byte_length"(ptr %text__addr)
  br i1 %with_newline_1, label %.bb.tern_then, label %.bb.tern_else
.bb.tern_else:
  %.t7 = add i64 0, 0
  br label %.bb.tern_join
.bb.tern_then:
  %.t6 = add i64 0, 1
  br label %.bb.tern_join
.bb.tern_join:
  %__tern_tmp.t4_2 = phi i64 [ %.t7, %.bb.tern_else ], [ %.t6, %.bb.tern_then ]
  %.t11 = add i64 %.t3, %__tern_tmp.t4_2
  %.t12 = add i64 0, 0
  br label %.bb.loop_header
.bb.loop_header:
  %offset_2 = phi i64 [ %.t12, %.bb.tern_join ], [ %.t49, %.bb.if_join ]
  %r_2 = phi %Variant_std_2Ecore_Result_91c2f7f96a418c4d [ %__arc1, %.bb.tern_join ], [ %__arc8, %.bb.if_join ]
  br label %.bb.loop_body
.bb.loop_body:
  %.t15 = icmp slt i64 %offset_2, %.t11
  br i1 %.t15, label %.bb.if_then, label %.bb.if_else
.bb.if_else:
  br label %.bb.loop_exit
.bb.loop_exit:
  %__cleanup_t1 = load %DriftString, ptr %text__addr
  %zero_str4 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %__arc7 = insertvalue %DriftString %zero_str4, ptr null, 1
  store %DriftString %__arc7, ptr %text__addr
  call void @drift_string_release(%DriftString %__cleanup_t1)
  ret void
.bb.if_then:
  %.t18 = sub i64 %.t11, %offset_2
  %.t20 = add i64 0, 4096
  %.t21 = call i64 @"std.console::_min"(i64 %.t18, i64 %.t20)
  %.t23 = call %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 @"std.io::buffer"(i64 %.t21)
  store %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %.t23, ptr %chunk__addr
  call void @"std.console::_fill_chunk"(ptr %chunk__addr, ptr %text__addr, i64 %offset_2, i64 %.t3, i1 %with_newline_1)
  %.t31 = call %Variant_std_2Ecore_Result_91c2f7f96a418c4d @"std.io::ConfiguredOutputStream::write"(ptr %out_1, ptr %chunk__addr)
  %__arc4 = select i1 1, %Variant_std_2Ecore_Result_91c2f7f96a418c4d zeroinitializer, %Variant_std_2Ecore_Result_91c2f7f96a418c4d zeroinitializer
  %drop_variant_ptr5 = alloca %Variant_std_2Ecore_Result_91c2f7f96a418c4d
  store %Variant_std_2Ecore_Result_91c2f7f96a418c4d %r_2, ptr %drop_variant_ptr5
  call void @__drift_array_drop_std__std_core_Result_Int_std__std_io_IoError__91c2f7f96a418c4d(i64 1, ptr %drop_variant_ptr5)
  br label %.bb.match_dispatch
.bb.match_dispatch:
  %tag86 = extractvalue %Variant_std_2Ecore_Result_91c2f7f96a418c4d %.t31, 0
  %.t33 = zext i8 %tag86 to i64
  %.t34 = add i64 0, 0
  %.t35 = icmp eq i64 %.t33, %.t34
  br i1 %.t35, label %.bb.match_arm_0, label %.bb.match_dispatch_next
.bb.match_dispatch_next:
  %.t36 = add i64 0, 1
  %.t37 = icmp eq i64 %.t33, %.t36
  br i1 %.t37, label %.bb.match_arm_1, label %.bb.match_dispatch_next1
.bb.match_dispatch_next1:
  br label %.bb.match_arm_2
.bb.match_arm_2:
  %__arc17 = select i1 1, %Variant_std_2Ecore_Result_91c2f7f96a418c4d zeroinitializer, %Variant_std_2Ecore_Result_91c2f7f96a418c4d zeroinitializer
  store %Variant_std_2Ecore_Result_91c2f7f96a418c4d %.t31, ptr %__match_scrut_tmp.t58__addr
  %__cleanup_t7 = load %Variant_std_2Ecore_Result_91c2f7f96a418c4d, ptr %__match_scrut_tmp.t58__addr
  %__arc18 = select i1 1, %Variant_std_2Ecore_Result_91c2f7f96a418c4d zeroinitializer, %Variant_std_2Ecore_Result_91c2f7f96a418c4d zeroinitializer
  store %Variant_std_2Ecore_Result_91c2f7f96a418c4d %__arc18, ptr %__match_scrut_tmp.t58__addr
  %drop_variant_ptr7 = alloca %Variant_std_2Ecore_Result_91c2f7f96a418c4d
  store %Variant_std_2Ecore_Result_91c2f7f96a418c4d %__cleanup_t7, ptr %drop_variant_ptr7
  call void @__drift_array_drop_std__std_core_Result_Int_std__std_io_IoError__91c2f7f96a418c4d(i64 1, ptr %drop_variant_ptr7)
  %__cleanup_t8 = load %Struct_std_2Eio_Buffer_e76b5c24b140f2f4, ptr %chunk__addr
  %zero_struct8 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 zeroinitializer, %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c zeroinitializer, 0
  %zero_struct9 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %zero_struct8, i64 0, 1
  %__arc19 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %zero_struct9, i64 0, 2
  store %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %__arc19, ptr %chunk__addr
  call void @"std.io::Buffer::std.core.Destructible::destroy"(%Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %__cleanup_t8)
  %__cleanup_t9 = load %DriftString, ptr %text__addr
  %zero_str10 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %__arc20 = insertvalue %DriftString %zero_str10, ptr null, 1
  store %DriftString %__arc20, ptr %text__addr
  call void @drift_string_release(%DriftString %__cleanup_t9)
  ret void
.bb.match_arm_1:
  %__arc10 = select i1 1, %Variant_std_2Ecore_Result_91c2f7f96a418c4d zeroinitializer, %Variant_std_2Ecore_Result_91c2f7f96a418c4d zeroinitializer
  store %Variant_std_2Ecore_Result_91c2f7f96a418c4d %.t31, ptr %__match_scrut_tmp.t50__addr
  %payload_words11 = getelementptr inbounds %Variant_std_2Ecore_Result_91c2f7f96a418c4d, ptr %__match_scrut_tmp.t50__addr, i32 0, i32 2
  %fieldptr12 = getelementptr inbounds { %Struct_std_2Eio_IoError_7415ea6adc7a82aa }, ptr %payload_words11, i32 0, i32 0
  %.t54 = load %Struct_std_2Eio_IoError_7415ea6adc7a82aa, ptr %fieldptr12
  %zero_struct13 = insertvalue %Struct_std_2Eio_IoError_7415ea6adc7a82aa zeroinitializer, %DriftString zeroinitializer, 0
  %__arc11 = insertvalue %Struct_std_2Eio_IoError_7415ea6adc7a82aa %zero_struct13, i64 0, 1
  %zero_struct14 = insertvalue %Struct_std_2Eio_IoError_7415ea6adc7a82aa zeroinitializer, %DriftString zeroinitializer, 0
  %__arc13 = insertvalue %Struct_std_2Eio_IoError_7415ea6adc7a82aa %zero_struct14, i64 0, 1
  %drop_field15 = extractvalue %Struct_std_2Eio_IoError_7415ea6adc7a82aa %__arc2, 0
  call void @drift_string_release(%DriftString %drop_field15)
  %zero_struct16 = insertvalue %Struct_std_2Eio_IoError_7415ea6adc7a82aa zeroinitializer, %DriftString zeroinitializer, 0
  %__arc14 = insertvalue %Struct_std_2Eio_IoError_7415ea6adc7a82aa %zero_struct16, i64 0, 1
  %drop_field17 = extractvalue %Struct_std_2Eio_IoError_7415ea6adc7a82aa %.t54, 0
  call void @drift_string_release(%DriftString %drop_field17)
  %__cleanup_t5 = load %Struct_std_2Eio_Buffer_e76b5c24b140f2f4, ptr %chunk__addr
  %zero_struct18 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 zeroinitializer, %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c zeroinitializer, 0
  %zero_struct19 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %zero_struct18, i64 0, 1
  %__arc15 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %zero_struct19, i64 0, 2
  store %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %__arc15, ptr %chunk__addr
  call void @"std.io::Buffer::std.core.Destructible::destroy"(%Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %__cleanup_t5)
  %__cleanup_t6 = load %DriftString, ptr %text__addr
  %zero_str20 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %__arc16 = insertvalue %DriftString %zero_str20, ptr null, 1
  store %DriftString %__arc16, ptr %text__addr
  call void @drift_string_release(%DriftString %__cleanup_t6)
  ret void
.bb.match_arm_0:
  %__arc8 = select i1 1, %Variant_std_2Ecore_Result_91c2f7f96a418c4d zeroinitializer, %Variant_std_2Ecore_Result_91c2f7f96a418c4d zeroinitializer
  store %Variant_std_2Ecore_Result_91c2f7f96a418c4d %.t31, ptr %__match_scrut_tmp.t38__addr
  %payload_words21 = getelementptr inbounds %Variant_std_2Ecore_Result_91c2f7f96a418c4d, ptr %__match_scrut_tmp.t38__addr, i32 0, i32 2
  %fieldptr22 = getelementptr inbounds { i64 }, ptr %payload_words21, i32 0, i32 0
  %.t42 = load i64, ptr %fieldptr22
  %__cleanup_t3 = load %Variant_std_2Ecore_Result_91c2f7f96a418c4d, ptr %__match_scrut_tmp.t38__addr
  %__arc9 = select i1 1, %Variant_std_2Ecore_Result_91c2f7f96a418c4d zeroinitializer, %Variant_std_2Ecore_Result_91c2f7f96a418c4d zeroinitializer
  store %Variant_std_2Ecore_Result_91c2f7f96a418c4d %__arc9, ptr %__match_scrut_tmp.t38__addr
  %drop_variant_ptr23 = alloca %Variant_std_2Ecore_Result_91c2f7f96a418c4d
  store %Variant_std_2Ecore_Result_91c2f7f96a418c4d %__cleanup_t3, ptr %drop_variant_ptr23
  call void @__drift_array_drop_std__std_core_Result_Int_std__std_io_IoError__91c2f7f96a418c4d(i64 1, ptr %drop_variant_ptr23)
  %.t45 = add i64 0, 0
  %.t46 = icmp sle i64 %.t42, %.t45
  br i1 %.t46, label %.bb.if_then1, label %.bb.if_join1
.bb.if_join1:
  %.t49 = add i64 %offset_2, %.t42
  br label %.bb.match_join
.bb.match_join:
  %__cleanup_t2 = load %Struct_std_2Eio_Buffer_e76b5c24b140f2f4, ptr %chunk__addr
  %zero_struct24 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 zeroinitializer, %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c zeroinitializer, 0
  %zero_struct25 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %zero_struct24, i64 0, 1
  %__arc21 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %zero_struct25, i64 0, 2
  store %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %__arc21, ptr %chunk__addr
  call void @"std.io::Buffer::std.core.Destructible::destroy"(%Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %__cleanup_t2)
  br label %.bb.if_join
.bb.if_join:
  br label %.bb.loop_header
.bb.if_then1:
  %__cleanup_t10 = load %Struct_std_2Eio_Buffer_e76b5c24b140f2f4, ptr %chunk__addr
  %zero_struct26 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 zeroinitializer, %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c zeroinitializer, 0
  %zero_struct27 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %zero_struct26, i64 0, 1
  %__arc5 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %zero_struct27, i64 0, 2
  store %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %__arc5, ptr %chunk__addr
  call void @"std.io::Buffer::std.core.Destructible::destroy"(%Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %__cleanup_t10)
  %__cleanup_t11 = load %DriftString, ptr %text__addr
  %zero_str28 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %__arc6 = insertvalue %DriftString %zero_str28, ptr null, 1
  store %DriftString %__arc6, ptr %text__addr
  call void @drift_string_release(%DriftString %__cleanup_t11)
  ret void
}
define %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 @"std.console::_write_timeout"() {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str54, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t2 = add i64 0, 60000
  %.t3 = insertvalue %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 zeroinitializer, i64 %.t2, 0
  ret %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %.t3
}
define void @"std.console::println"(%DriftString %text) {
.bb.entry:
  %b__addr = alloca %Struct_std_2Eio_OutputStreamBuilder_3e71da12881637f4
  %b2__addr = alloca %Struct_std_2Eio_OutputStreamBuilder_3e71da12881637f4
  %out__addr = alloca %Struct_std_2Eio_ConfiguredOutputStream_bdad74f25b0e3ac5
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str55, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t2 = call %Struct_std_2Eio_OutputStreamBuilder_3e71da12881637f4 @"std.io::stdout_builder"()
  store %Struct_std_2Eio_OutputStreamBuilder_3e71da12881637f4 %.t2, ptr %b__addr
  %.t4 = call %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 @"std.console::_write_timeout"()
  %.t5 = call %Struct_std_2Eio_OutputStreamBuilder_3e71da12881637f4 @"std.io::OutputStreamBuilder::timeout"(ptr %b__addr, %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %.t4)
  store %Struct_std_2Eio_OutputStreamBuilder_3e71da12881637f4 %.t5, ptr %b2__addr
  %.t7 = call %Struct_std_2Eio_ConfiguredOutputStream_bdad74f25b0e3ac5 @"std.io::OutputStreamBuilder::build"(ptr %b2__addr)
  store %Struct_std_2Eio_ConfiguredOutputStream_bdad74f25b0e3ac5 %.t7, ptr %out__addr
  %.t10 = add i1 0, 1
  %__arc1 = call %DriftString @drift_string_retain(%DriftString %text)
  call void @"std.console::_write_all_stream"(ptr %out__addr, %DriftString %__arc1, i1 %.t10)
  %zero_str3 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %__arc2 = insertvalue %DriftString %zero_str3, ptr null, 1
  call void @drift_string_release(%DriftString %text)
  ret void
}
define %DriftString @"std.core::Int::Diagnostic::to_json_text"(ptr %self) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str56, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = load i64, ptr %self
  %.t4 = call %DriftString @"std.core::diagnostic_json_int"(i64 %.t3)
  ret %DriftString %.t4
}
define %DriftString @"std.core::String::Diagnostic::to_json_text"(ptr %self) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str57, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = call %DriftString @"std.core::diagnostic_json_string"(ptr %self)
  ret %DriftString %.t3
}
define i64 @"std.core::String::byte_length"(ptr %self) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str58, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t4 = load %DriftString, ptr %self
  %.t3 = extractvalue %DriftString %.t4, 0
  ret i64 %.t3
}
define %DriftString @"std.core::_byte_hex2"(i8 %b) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str59, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = zext i8 %b to i64
  %.t5 = add i64 0, 16
  %.t6 = sdiv i64 %.t3, %.t5
  %.t8 = add i64 0, 16
  %.t9 = srem i64 %.t3, %.t8
  %.t11 = call %DriftString @"std.core::_hex_digit"(i64 %.t6)
  %.t13 = call %DriftString @"std.core::_hex_digit"(i64 %.t9)
  %.t14 = call %DriftString @drift_string_concat(%DriftString %.t11, %DriftString %.t13)
  call void @drift_string_release(%DriftString %.t11)
  call void @drift_string_release(%DriftString %.t13)
  ret %DriftString %.t14
}
define %DriftString @"std.core::_byte_to_string"(i8 %b) {
.bb.entry:
  %raw__addr = alloca %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c
  %zero_str1 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %__arc1 = insertvalue %DriftString %zero_str1, ptr null, 1
  %strptr2 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str60, i32 0, i32 2, i32 0
  %str03 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str03, ptr %strptr2, 1
  %.t2 = add i64 0, 1
  %len05 = add i64 0, 0
  %raw4 = call ptr @drift_alloc_array(i64 1, i64 1, i64 %len05, i64 %.t2)
  %raw06 = insertvalue %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c zeroinitializer, ptr %raw4, 0
  %raw17 = insertvalue %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c %raw06, i64 %.t2, 1
  store %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c %raw17, ptr %raw__addr
  %.t5 = add i64 0, 0
  %rawbuf8 = load %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c, ptr %raw__addr
  %rawptr9 = extractvalue %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c %rawbuf8, 0
  %rawcap10 = extractvalue %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c %rawbuf8, 1
  %strptr11 = getelementptr inbounds { i64, i64, [18 x i8] }, ptr @.str17, i32 0, i32 2, i32 0
  %str012 = insertvalue %DriftString zeroinitializer, i64 17, 0
  %str13 = insertvalue %DriftString %str012, ptr %strptr11, 1
  call void @drift_bounds_check(%DriftString %str13, i64 %.t5, i64 %rawcap10)
  %rawgep14 = getelementptr i8, ptr %rawptr9, i64 %.t5
  store i8 %b, ptr %rawgep14
  %.t8 = load %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c, ptr %raw__addr
  %.t9 = extractvalue %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c %.t8, 0
  %.t10 = add i64 0, 1
  %.t11 = call %DriftString @drift_string_from_utf8_bytes(ptr %.t9, i64 %.t10)
  %zero_str15 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %__arc3 = insertvalue %DriftString %zero_str15, ptr null, 1
  call void @drift_string_release(%DriftString %__arc1)
  %.t12 = load %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c, ptr %raw__addr
  %rawptr16 = extractvalue %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c %.t12, 0
  call void @drift_free_array(ptr %rawptr16)
  ret %DriftString %.t11
}
define %DriftString @"std.core::_hex_digit"(i64 %v_1) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str61, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = add i64 0, 0
  %.t4 = icmp eq i64 %v_1, %.t3
  br i1 %.t4, label %.bb.if_then, label %.bb.if_join
.bb.if_join:
  %.t7 = add i64 0, 1
  %.t8 = icmp eq i64 %v_1, %.t7
  br i1 %.t8, label %.bb.if_then1, label %.bb.if_join1
.bb.if_join1:
  %.t11 = add i64 0, 2
  %.t12 = icmp eq i64 %v_1, %.t11
  br i1 %.t12, label %.bb.if_then2, label %.bb.if_join2
.bb.if_join2:
  %.t15 = add i64 0, 3
  %.t16 = icmp eq i64 %v_1, %.t15
  br i1 %.t16, label %.bb.if_then3, label %.bb.if_join3
.bb.if_join3:
  %.t19 = add i64 0, 4
  %.t20 = icmp eq i64 %v_1, %.t19
  br i1 %.t20, label %.bb.if_then4, label %.bb.if_join4
.bb.if_join4:
  %.t23 = add i64 0, 5
  %.t24 = icmp eq i64 %v_1, %.t23
  br i1 %.t24, label %.bb.if_then5, label %.bb.if_join5
.bb.if_join5:
  %.t27 = add i64 0, 6
  %.t28 = icmp eq i64 %v_1, %.t27
  br i1 %.t28, label %.bb.if_then6, label %.bb.if_join6
.bb.if_join6:
  %.t31 = add i64 0, 7
  %.t32 = icmp eq i64 %v_1, %.t31
  br i1 %.t32, label %.bb.if_then7, label %.bb.if_join7
.bb.if_join7:
  %.t35 = add i64 0, 8
  %.t36 = icmp eq i64 %v_1, %.t35
  br i1 %.t36, label %.bb.if_then8, label %.bb.if_join8
.bb.if_join8:
  %.t39 = add i64 0, 9
  %.t40 = icmp eq i64 %v_1, %.t39
  br i1 %.t40, label %.bb.if_then9, label %.bb.if_join9
.bb.if_join9:
  %.t43 = add i64 0, 10
  %.t44 = icmp eq i64 %v_1, %.t43
  br i1 %.t44, label %.bb.if_then10, label %.bb.if_join10
.bb.if_join10:
  %.t47 = add i64 0, 11
  %.t48 = icmp eq i64 %v_1, %.t47
  br i1 %.t48, label %.bb.if_then11, label %.bb.if_join11
.bb.if_join11:
  %.t51 = add i64 0, 12
  %.t52 = icmp eq i64 %v_1, %.t51
  br i1 %.t52, label %.bb.if_then12, label %.bb.if_join12
.bb.if_join12:
  %.t55 = add i64 0, 13
  %.t56 = icmp eq i64 %v_1, %.t55
  br i1 %.t56, label %.bb.if_then13, label %.bb.if_join13
.bb.if_join13:
  %.t59 = add i64 0, 14
  %.t60 = icmp eq i64 %v_1, %.t59
  br i1 %.t60, label %.bb.if_then14, label %.bb.if_join14
.bb.if_join14:
  %strptr3 = getelementptr inbounds { i64, i64, [2 x i8] }, ptr @.str62, i32 0, i32 2, i32 0
  %str04 = insertvalue %DriftString zeroinitializer, i64 1, 0
  %.t62 = insertvalue %DriftString %str04, ptr %strptr3, 1
  ret %DriftString %.t62
.bb.if_then14:
  %strptr5 = getelementptr inbounds { i64, i64, [2 x i8] }, ptr @.str63, i32 0, i32 2, i32 0
  %str06 = insertvalue %DriftString zeroinitializer, i64 1, 0
  %.t61 = insertvalue %DriftString %str06, ptr %strptr5, 1
  ret %DriftString %.t61
.bb.if_then13:
  %strptr7 = getelementptr inbounds { i64, i64, [2 x i8] }, ptr @.str64, i32 0, i32 2, i32 0
  %str08 = insertvalue %DriftString zeroinitializer, i64 1, 0
  %.t57 = insertvalue %DriftString %str08, ptr %strptr7, 1
  ret %DriftString %.t57
.bb.if_then12:
  %strptr9 = getelementptr inbounds { i64, i64, [2 x i8] }, ptr @.str65, i32 0, i32 2, i32 0
  %str010 = insertvalue %DriftString zeroinitializer, i64 1, 0
  %.t53 = insertvalue %DriftString %str010, ptr %strptr9, 1
  ret %DriftString %.t53
.bb.if_then11:
  %strptr11 = getelementptr inbounds { i64, i64, [2 x i8] }, ptr @.str66, i32 0, i32 2, i32 0
  %str012 = insertvalue %DriftString zeroinitializer, i64 1, 0
  %.t49 = insertvalue %DriftString %str012, ptr %strptr11, 1
  ret %DriftString %.t49
.bb.if_then10:
  %strptr13 = getelementptr inbounds { i64, i64, [2 x i8] }, ptr @.str67, i32 0, i32 2, i32 0
  %str014 = insertvalue %DriftString zeroinitializer, i64 1, 0
  %.t45 = insertvalue %DriftString %str014, ptr %strptr13, 1
  ret %DriftString %.t45
.bb.if_then9:
  %strptr15 = getelementptr inbounds { i64, i64, [2 x i8] }, ptr @.str68, i32 0, i32 2, i32 0
  %str016 = insertvalue %DriftString zeroinitializer, i64 1, 0
  %.t41 = insertvalue %DriftString %str016, ptr %strptr15, 1
  ret %DriftString %.t41
.bb.if_then8:
  %strptr17 = getelementptr inbounds { i64, i64, [2 x i8] }, ptr @.str69, i32 0, i32 2, i32 0
  %str018 = insertvalue %DriftString zeroinitializer, i64 1, 0
  %.t37 = insertvalue %DriftString %str018, ptr %strptr17, 1
  ret %DriftString %.t37
.bb.if_then7:
  %strptr19 = getelementptr inbounds { i64, i64, [2 x i8] }, ptr @.str70, i32 0, i32 2, i32 0
  %str020 = insertvalue %DriftString zeroinitializer, i64 1, 0
  %.t33 = insertvalue %DriftString %str020, ptr %strptr19, 1
  ret %DriftString %.t33
.bb.if_then6:
  %strptr21 = getelementptr inbounds { i64, i64, [2 x i8] }, ptr @.str71, i32 0, i32 2, i32 0
  %str022 = insertvalue %DriftString zeroinitializer, i64 1, 0
  %.t29 = insertvalue %DriftString %str022, ptr %strptr21, 1
  ret %DriftString %.t29
.bb.if_then5:
  %strptr23 = getelementptr inbounds { i64, i64, [2 x i8] }, ptr @.str72, i32 0, i32 2, i32 0
  %str024 = insertvalue %DriftString zeroinitializer, i64 1, 0
  %.t25 = insertvalue %DriftString %str024, ptr %strptr23, 1
  ret %DriftString %.t25
.bb.if_then4:
  %strptr25 = getelementptr inbounds { i64, i64, [2 x i8] }, ptr @.str73, i32 0, i32 2, i32 0
  %str026 = insertvalue %DriftString zeroinitializer, i64 1, 0
  %.t21 = insertvalue %DriftString %str026, ptr %strptr25, 1
  ret %DriftString %.t21
.bb.if_then3:
  %strptr27 = getelementptr inbounds { i64, i64, [2 x i8] }, ptr @.str74, i32 0, i32 2, i32 0
  %str028 = insertvalue %DriftString zeroinitializer, i64 1, 0
  %.t17 = insertvalue %DriftString %str028, ptr %strptr27, 1
  ret %DriftString %.t17
.bb.if_then2:
  %strptr29 = getelementptr inbounds { i64, i64, [2 x i8] }, ptr @.str75, i32 0, i32 2, i32 0
  %str030 = insertvalue %DriftString zeroinitializer, i64 1, 0
  %.t13 = insertvalue %DriftString %str030, ptr %strptr29, 1
  ret %DriftString %.t13
.bb.if_then1:
  %strptr31 = getelementptr inbounds { i64, i64, [2 x i8] }, ptr @.str76, i32 0, i32 2, i32 0
  %str032 = insertvalue %DriftString zeroinitializer, i64 1, 0
  %.t9 = insertvalue %DriftString %str032, ptr %strptr31, 1
  ret %DriftString %.t9
.bb.if_then:
  %strptr33 = getelementptr inbounds { i64, i64, [2 x i8] }, ptr @.str77, i32 0, i32 2, i32 0
  %str034 = insertvalue %DriftString zeroinitializer, i64 1, 0
  %.t5 = insertvalue %DriftString %str034, ptr %strptr33, 1
  ret %DriftString %.t5
}
define %DriftString @"std.core::_json_quote_string"(ptr %s_1) {
.bb.entry:
  %zero_str1 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %__arc1 = insertvalue %DriftString %zero_str1, ptr null, 1
  %strptr2 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str78, i32 0, i32 2, i32 0
  %str03 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str03, ptr %strptr2, 1
  %strptr4 = getelementptr inbounds { i64, i64, [2 x i8] }, ptr @.str79, i32 0, i32 2, i32 0
  %str05 = insertvalue %DriftString zeroinitializer, i64 1, 0
  %.t2 = insertvalue %DriftString %str05, ptr %strptr4, 1
  %zero_str6 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %__arc3 = insertvalue %DriftString %zero_str6, ptr null, 1
  call void @drift_string_release(%DriftString %__arc1)
  %.t4 = call i64 @"std.core::String::byte_length"(ptr %s_1)
  %.t5 = add i64 0, 0
  br label %.bb.loop_header
.bb.loop_header:
  %i_2 = phi i64 [ %.t5, %.bb.entry ], [ %.t70, %.bb.if_join ]
  %out_4 = phi %DriftString [ %.t2, %.bb.entry ], [ %out_5, %.bb.if_join ]
  br label %.bb.loop_body
.bb.loop_body:
  %.t8 = icmp slt i64 %i_2, %.t4
  br i1 %.t8, label %.bb.if_then, label %.bb.if_else
.bb.if_else:
  br label %.bb.loop_exit
.bb.loop_exit:
  %strptr7 = getelementptr inbounds { i64, i64, [2 x i8] }, ptr @.str80, i32 0, i32 2, i32 0
  %str08 = insertvalue %DriftString zeroinitializer, i64 1, 0
  %.t72 = insertvalue %DriftString %str08, ptr %strptr7, 1
  %.t73 = call %DriftString @drift_string_concat(%DriftString %out_4, %DriftString %.t72)
  call void @drift_string_release(%DriftString %.t72)
  %zero_str9 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %__arc22 = insertvalue %DriftString %zero_str9, ptr null, 1
  call void @drift_string_release(%DriftString %out_4)
  ret %DriftString %.t73
.bb.if_then:
  %.t10 = load %DriftString, ptr %s_1
  %len10 = extractvalue %DriftString %.t10, 0
  %data11 = extractvalue %DriftString %.t10, 1
  %strptr12 = getelementptr inbounds { i64, i64, [16 x i8] }, ptr @.str2, i32 0, i32 2, i32 0
  %str013 = insertvalue %DriftString zeroinitializer, i64 15, 0
  %str14 = insertvalue %DriftString %str013, ptr %strptr12, 1
  call void @drift_bounds_check(%DriftString %str14, i64 %i_2, i64 %len10)
  %ptr15 = getelementptr i8, ptr %data11, i64 %i_2
  %.t12 = load i8, ptr %ptr15
  %.t14 = add i8 0, 34
  %.t15 = icmp eq i8 %.t12, %.t14
  br i1 %.t15, label %.bb.if_then1, label %.bb.if_else1
.bb.if_else1:
  %.t20 = add i8 0, 92
  %.t21 = icmp eq i8 %.t12, %.t20
  br i1 %.t21, label %.bb.if_then2, label %.bb.if_else2
.bb.if_else2:
  %.t26 = add i8 0, 8
  %.t27 = icmp eq i8 %.t12, %.t26
  br i1 %.t27, label %.bb.if_then3, label %.bb.if_else3
.bb.if_else3:
  %.t32 = add i8 0, 12
  %.t33 = icmp eq i8 %.t12, %.t32
  br i1 %.t33, label %.bb.if_then4, label %.bb.if_else4
.bb.if_else4:
  %.t38 = add i8 0, 10
  %.t39 = icmp eq i8 %.t12, %.t38
  br i1 %.t39, label %.bb.if_then5, label %.bb.if_else5
.bb.if_else5:
  %.t44 = add i8 0, 13
  %.t45 = icmp eq i8 %.t12, %.t44
  br i1 %.t45, label %.bb.if_then6, label %.bb.if_else6
.bb.if_else6:
  %.t50 = add i8 0, 9
  %.t51 = icmp eq i8 %.t12, %.t50
  br i1 %.t51, label %.bb.if_then7, label %.bb.if_else7
.bb.if_else7:
  %.t56 = add i8 0, 32
  %.t57 = icmp ult i8 %.t12, %.t56
  br i1 %.t57, label %.bb.if_then8, label %.bb.if_else8
.bb.if_else8:
  %.t66 = call %DriftString @"std.core::_byte_to_string"(i8 %.t12)
  %.t67 = call %DriftString @drift_string_concat(%DriftString %out_4, %DriftString %.t66)
  call void @drift_string_release(%DriftString %.t66)
  %zero_str16 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %__arc5 = insertvalue %DriftString %zero_str16, ptr null, 1
  call void @drift_string_release(%DriftString %out_4)
  br label %.bb.if_join8
.bb.if_then8:
  %strptr17 = getelementptr inbounds { i64, i64, [5 x i8] }, ptr @.str81, i32 0, i32 2, i32 0
  %str018 = insertvalue %DriftString zeroinitializer, i64 4, 0
  %.t59 = insertvalue %DriftString %str018, ptr %strptr17, 1
  %.t60 = call %DriftString @drift_string_concat(%DriftString %out_4, %DriftString %.t59)
  call void @drift_string_release(%DriftString %.t59)
  %.t62 = call %DriftString @"std.core::_byte_hex2"(i8 %.t12)
  %.t63 = call %DriftString @drift_string_concat(%DriftString %.t60, %DriftString %.t62)
  call void @drift_string_release(%DriftString %.t60)
  call void @drift_string_release(%DriftString %.t62)
  %zero_str19 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %__arc21 = insertvalue %DriftString %zero_str19, ptr null, 1
  call void @drift_string_release(%DriftString %out_4)
  br label %.bb.if_join8
.bb.if_join8:
  %out_15 = phi %DriftString [ %.t63, %.bb.if_then8 ], [ %.t67, %.bb.if_else8 ]
  br label %.bb.if_join7
.bb.if_then7:
  %strptr20 = getelementptr inbounds { i64, i64, [3 x i8] }, ptr @.str82, i32 0, i32 2, i32 0
  %str021 = insertvalue %DriftString zeroinitializer, i64 2, 0
  %.t53 = insertvalue %DriftString %str021, ptr %strptr20, 1
  %.t54 = call %DriftString @drift_string_concat(%DriftString %out_4, %DriftString %.t53)
  call void @drift_string_release(%DriftString %.t53)
  %zero_str22 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %__arc19 = insertvalue %DriftString %zero_str22, ptr null, 1
  call void @drift_string_release(%DriftString %out_4)
  br label %.bb.if_join7
.bb.if_join7:
  %out_12 = phi %DriftString [ %.t54, %.bb.if_then7 ], [ %out_15, %.bb.if_join8 ]
  br label %.bb.if_join6
.bb.if_then6:
  %strptr23 = getelementptr inbounds { i64, i64, [3 x i8] }, ptr @.str83, i32 0, i32 2, i32 0
  %str024 = insertvalue %DriftString zeroinitializer, i64 2, 0
  %.t47 = insertvalue %DriftString %str024, ptr %strptr23, 1
  %.t48 = call %DriftString @drift_string_concat(%DriftString %out_4, %DriftString %.t47)
  call void @drift_string_release(%DriftString %.t47)
  %zero_str25 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %__arc17 = insertvalue %DriftString %zero_str25, ptr null, 1
  call void @drift_string_release(%DriftString %out_4)
  br label %.bb.if_join6
.bb.if_join6:
  %out_20 = phi %DriftString [ %out_12, %.bb.if_join7 ], [ %.t48, %.bb.if_then6 ]
  br label %.bb.if_join5
.bb.if_then5:
  %strptr26 = getelementptr inbounds { i64, i64, [3 x i8] }, ptr @.str84, i32 0, i32 2, i32 0
  %str027 = insertvalue %DriftString zeroinitializer, i64 2, 0
  %.t41 = insertvalue %DriftString %str027, ptr %strptr26, 1
  %.t42 = call %DriftString @drift_string_concat(%DriftString %out_4, %DriftString %.t41)
  call void @drift_string_release(%DriftString %.t41)
  %zero_str28 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %__arc15 = insertvalue %DriftString %zero_str28, ptr null, 1
  call void @drift_string_release(%DriftString %out_4)
  br label %.bb.if_join5
.bb.if_join5:
  %out_23 = phi %DriftString [ %out_20, %.bb.if_join6 ], [ %.t42, %.bb.if_then5 ]
  br label %.bb.if_join4
.bb.if_then4:
  %strptr29 = getelementptr inbounds { i64, i64, [3 x i8] }, ptr @.str85, i32 0, i32 2, i32 0
  %str030 = insertvalue %DriftString zeroinitializer, i64 2, 0
  %.t35 = insertvalue %DriftString %str030, ptr %strptr29, 1
  %.t36 = call %DriftString @drift_string_concat(%DriftString %out_4, %DriftString %.t35)
  call void @drift_string_release(%DriftString %.t35)
  %zero_str31 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %__arc13 = insertvalue %DriftString %zero_str31, ptr null, 1
  call void @drift_string_release(%DriftString %out_4)
  br label %.bb.if_join4
.bb.if_join4:
  %out_24 = phi %DriftString [ %out_23, %.bb.if_join5 ], [ %.t36, %.bb.if_then4 ]
  br label %.bb.if_join3
.bb.if_then3:
  %strptr32 = getelementptr inbounds { i64, i64, [3 x i8] }, ptr @.str86, i32 0, i32 2, i32 0
  %str033 = insertvalue %DriftString zeroinitializer, i64 2, 0
  %.t29 = insertvalue %DriftString %str033, ptr %strptr32, 1
  %.t30 = call %DriftString @drift_string_concat(%DriftString %out_4, %DriftString %.t29)
  call void @drift_string_release(%DriftString %.t29)
  %zero_str34 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %__arc11 = insertvalue %DriftString %zero_str34, ptr null, 1
  call void @drift_string_release(%DriftString %out_4)
  br label %.bb.if_join3
.bb.if_join3:
  %out_29 = phi %DriftString [ %out_24, %.bb.if_join4 ], [ %.t30, %.bb.if_then3 ]
  br label %.bb.if_join2
.bb.if_then2:
  %strptr35 = getelementptr inbounds { i64, i64, [3 x i8] }, ptr @.str87, i32 0, i32 2, i32 0
  %str036 = insertvalue %DriftString zeroinitializer, i64 2, 0
  %.t23 = insertvalue %DriftString %str036, ptr %strptr35, 1
  %.t24 = call %DriftString @drift_string_concat(%DriftString %out_4, %DriftString %.t23)
  call void @drift_string_release(%DriftString %.t23)
  %zero_str37 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %__arc9 = insertvalue %DriftString %zero_str37, ptr null, 1
  call void @drift_string_release(%DriftString %out_4)
  br label %.bb.if_join2
.bb.if_join2:
  %out_30 = phi %DriftString [ %.t24, %.bb.if_then2 ], [ %out_29, %.bb.if_join3 ]
  br label %.bb.if_join1
.bb.if_then1:
  %strptr38 = getelementptr inbounds { i64, i64, [3 x i8] }, ptr @.str88, i32 0, i32 2, i32 0
  %str039 = insertvalue %DriftString zeroinitializer, i64 2, 0
  %.t17 = insertvalue %DriftString %str039, ptr %strptr38, 1
  %.t18 = call %DriftString @drift_string_concat(%DriftString %out_4, %DriftString %.t17)
  call void @drift_string_release(%DriftString %.t17)
  %zero_str40 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %__arc7 = insertvalue %DriftString %zero_str40, ptr null, 1
  call void @drift_string_release(%DriftString %out_4)
  br label %.bb.if_join1
.bb.if_join1:
  %out_5 = phi %DriftString [ %.t18, %.bb.if_then1 ], [ %out_30, %.bb.if_join2 ]
  %.t69 = add i64 0, 1
  %.t70 = add i64 %i_2, %.t69
  br label %.bb.if_join
.bb.if_join:
  br label %.bb.loop_header
}
define %DriftString @"std.core::diagnostic_json_int"(i64 %n) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str89, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = call %DriftString @drift_string_from_int64(i64 %n)
  %.t4 = call %DriftString @drift_string_concat(%DriftString %.t1, %DriftString %.t3)
  call void @drift_string_release(%DriftString %.t1)
  call void @drift_string_release(%DriftString %.t3)
  ret %DriftString %.t4
}
define %DriftString @"std.core::diagnostic_json_string"(ptr %s) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str90, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = call %DriftString @"std.core::_json_quote_string"(ptr %s)
  ret %DriftString %.t3
}
define void @"std.core::void_value"() {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str91, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  ret void
}
define %DriftString @"std.err::std.err.IndexError::std.core.Diagnostic::to_json_text"(ptr %self) {
.bb.entry:
  %self__addr = alloca ptr
  store ptr %self, ptr %self__addr
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str92, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %strptr3 = getelementptr inbounds { i64, i64, [2 x i8] }, ptr @.str93, i32 0, i32 2, i32 0
  %str04 = insertvalue %DriftString zeroinitializer, i64 1, 0
  %.t2 = insertvalue %DriftString %str04, ptr %strptr3, 1
  %strptr5 = getelementptr inbounds { i64, i64, [16 x i8] }, ptr @.str94, i32 0, i32 2, i32 0
  %str06 = insertvalue %DriftString zeroinitializer, i64 15, 0
  %.t3 = insertvalue %DriftString %str06, ptr %strptr5, 1
  %.t4 = call %DriftString @drift_string_concat(%DriftString %.t2, %DriftString %.t3)
  call void @drift_string_release(%DriftString %.t2)
  call void @drift_string_release(%DriftString %.t3)
  %.t6 = load ptr, ptr %self__addr
  %.t7 = getelementptr inbounds %Struct_std_2Eerr_IndexError_db7149950235ecbd, ptr %.t6, i32 0, i32 0
  %.t8 = call %DriftString @"std.core::String::Diagnostic::to_json_text"(ptr %.t7)
  %.t9 = call %DriftString @drift_string_concat(%DriftString %.t4, %DriftString %.t8)
  call void @drift_string_release(%DriftString %.t4)
  call void @drift_string_release(%DriftString %.t8)
  %strptr7 = getelementptr inbounds { i64, i64, [2 x i8] }, ptr @.str95, i32 0, i32 2, i32 0
  %str08 = insertvalue %DriftString zeroinitializer, i64 1, 0
  %.t10 = insertvalue %DriftString %str08, ptr %strptr7, 1
  %.t11 = call %DriftString @drift_string_concat(%DriftString %.t9, %DriftString %.t10)
  call void @drift_string_release(%DriftString %.t9)
  call void @drift_string_release(%DriftString %.t10)
  %strptr9 = getelementptr inbounds { i64, i64, [9 x i8] }, ptr @.str96, i32 0, i32 2, i32 0
  %str010 = insertvalue %DriftString zeroinitializer, i64 8, 0
  %.t12 = insertvalue %DriftString %str010, ptr %strptr9, 1
  %.t13 = call %DriftString @drift_string_concat(%DriftString %.t11, %DriftString %.t12)
  call void @drift_string_release(%DriftString %.t11)
  call void @drift_string_release(%DriftString %.t12)
  %.t15 = load ptr, ptr %self__addr
  %.t16 = getelementptr inbounds %Struct_std_2Eerr_IndexError_db7149950235ecbd, ptr %.t15, i32 0, i32 1
  %.t17 = call %DriftString @"std.core::Int::Diagnostic::to_json_text"(ptr %.t16)
  %.t18 = call %DriftString @drift_string_concat(%DriftString %.t13, %DriftString %.t17)
  call void @drift_string_release(%DriftString %.t13)
  call void @drift_string_release(%DriftString %.t17)
  %strptr11 = getelementptr inbounds { i64, i64, [2 x i8] }, ptr @.str97, i32 0, i32 2, i32 0
  %str012 = insertvalue %DriftString zeroinitializer, i64 1, 0
  %.t19 = insertvalue %DriftString %str012, ptr %strptr11, 1
  %.t20 = call %DriftString @drift_string_concat(%DriftString %.t18, %DriftString %.t19)
  call void @drift_string_release(%DriftString %.t18)
  call void @drift_string_release(%DriftString %.t19)
  ret %DriftString %.t20
}
define %DriftString @"std.format::format_int"(i64 %v) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str98, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = call %DriftString @drift_string_from_int64(i64 %v)
  %.t4 = call %DriftString @drift_string_concat(%DriftString %.t1, %DriftString %.t3)
  call void @drift_string_release(%DriftString %.t1)
  call void @drift_string_release(%DriftString %.t3)
  ret %DriftString %.t4
}
define void @"std.io::Buffer::std.core.Destructible::destroy"(%Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %self) {
.bb.entry:
  %self__addr = alloca %Struct_std_2Eio_Buffer_e76b5c24b140f2f4
  store %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %self, ptr %self__addr
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str99, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = getelementptr inbounds %Struct_std_2Eio_Buffer_e76b5c24b140f2f4, ptr %self__addr, i32 0, i32 0
  %.t4 = load %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c, ptr %.t3
  %.t5 = extractvalue %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c %.t4, 0
  %.t7 = getelementptr inbounds %Struct_std_2Eio_Buffer_e76b5c24b140f2f4, ptr %self__addr, i32 0, i32 0
  %.t8 = load %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c, ptr %.t7
  %.t9 = extractvalue %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c %.t8, 1
  %struct3 = insertvalue %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c zeroinitializer, ptr %.t5, 0
  %.t12 = insertvalue %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c %struct3, i64 %.t9, 1
  %rawptr4 = extractvalue %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c %.t12, 0
  call void @drift_free_array(ptr %rawptr4)
  %__cleanup_t1 = load %Struct_std_2Eio_Buffer_e76b5c24b140f2f4, ptr %self__addr
  %zero_struct5 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 zeroinitializer, %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c zeroinitializer, 0
  %zero_struct6 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %zero_struct5, i64 0, 1
  %__arc1 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %zero_struct6, i64 0, 2
  store %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %__arc1, ptr %self__addr
  ret void
}
define %Variant_std_2Ecore_Result_91c2f7f96a418c4d @"std.io::ConfiguredOutputStream::write"(ptr %self, ptr %buf) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str100, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t4 = call %Variant_std_2Ecore_Result_91c2f7f96a418c4d @"std.io::configured_output_write"(ptr %self, ptr %buf)
  ret %Variant_std_2Ecore_Result_91c2f7f96a418c4d %.t4
}
define %Struct_std_2Eio_ConfiguredOutputStream_bdad74f25b0e3ac5 @"std.io::OutputStreamBuilder::build"(ptr %self) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str101, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = load %Struct_std_2Eio_OutputStreamBuilder_3e71da12881637f4, ptr %self
  %.t4 = extractvalue %Struct_std_2Eio_OutputStreamBuilder_3e71da12881637f4 %.t3, 0
  %.t6 = load %Struct_std_2Eio_OutputStreamBuilder_3e71da12881637f4, ptr %self
  %.t7 = extractvalue %Struct_std_2Eio_OutputStreamBuilder_3e71da12881637f4 %.t6, 1
  %struct3 = insertvalue %Struct_std_2Eio_ConfiguredOutputStream_bdad74f25b0e3ac5 zeroinitializer, i64 %.t4, 0
  %.t8 = insertvalue %Struct_std_2Eio_ConfiguredOutputStream_bdad74f25b0e3ac5 %struct3, %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %.t7, 1
  ret %Struct_std_2Eio_ConfiguredOutputStream_bdad74f25b0e3ac5 %.t8
}
define %Struct_std_2Eio_OutputStreamBuilder_3e71da12881637f4 @"std.io::OutputStreamBuilder::timeout"(ptr %self, %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %timeout) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str102, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = load %Struct_std_2Eio_OutputStreamBuilder_3e71da12881637f4, ptr %self
  %.t4 = extractvalue %Struct_std_2Eio_OutputStreamBuilder_3e71da12881637f4 %.t3, 0
  %struct3 = insertvalue %Struct_std_2Eio_OutputStreamBuilder_3e71da12881637f4 zeroinitializer, i64 %.t4, 0
  %.t6 = insertvalue %Struct_std_2Eio_OutputStreamBuilder_3e71da12881637f4 %struct3, %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %timeout, 1
  ret %Struct_std_2Eio_OutputStreamBuilder_3e71da12881637f4 %.t6
}
define void @"std.io::_block_on_io"(i64 %fd_1, i64 %interest_1, i64 %deadline_ms_1) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str103, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = add i64 0, 0
  %.t4 = icmp sle i64 %deadline_ms_1, %.t3
  br i1 %.t4, label %.bb.if_then, label %.bb.if_join
.bb.if_join:
  %.t5 = call i64 @drift_thread_current()
  %.t7 = add i64 0, 0
  %.t8 = icmp eq i64 %.t5, %.t7
  br i1 %.t8, label %.bb.if_then1, label %.bb.if_join1
.bb.if_join1:
  %.t11 = call i64 @drift_reactor_check_pending(i64 %fd_1, i64 %interest_1)
  %.t12 = add i64 0, 0
  %.t13 = icmp ne i64 %.t11, %.t12
  br i1 %.t13, label %.bb.if_then2, label %.bb.if_join2
.bb.if_join2:
  call void @drift_reactor_register_io(i64 %fd_1, i64 %interest_1, i64 %.t5, i64 %deadline_ms_1)
  call void @drift_thread_park_until(i64 %deadline_ms_1)
  ret void
.bb.if_then2:
  ret void
.bb.if_then1:
  ret void
.bb.if_then:
  ret void
}
define i64 @"std.io::_deadline_from_timeout"(%Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %timeout_1) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str104, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = extractvalue %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %timeout_1, 0
  %.t4 = add i64 0, 0
  %.t5 = icmp sle i64 %.t3, %.t4
  br i1 %.t5, label %.bb.if_then, label %.bb.if_join
.bb.if_join:
  %.t7 = call i64 @drift_time_now_ms()
  %.t9 = extractvalue %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %timeout_1, 0
  %.t10 = add i64 %.t7, %.t9
  ret i64 %.t10
.bb.if_then:
  %.t6 = add i64 0, 0
  ret i64 %.t6
}
define i64 @"std.io::_remaining_ms"(i64 %deadline_ms_1) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str105, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = add i64 0, 0
  %.t4 = icmp sle i64 %deadline_ms_1, %.t3
  br i1 %.t4, label %.bb.if_then, label %.bb.if_join
.bb.if_join:
  %.t6 = call i64 @drift_time_now_ms()
  %.t9 = icmp sge i64 %.t6, %deadline_ms_1
  br i1 %.t9, label %.bb.if_then1, label %.bb.if_join1
.bb.if_join1:
  %.t13 = sub i64 %deadline_ms_1, %.t6
  ret i64 %.t13
.bb.if_then1:
  %.t10 = add i64 0, 0
  ret i64 %.t10
.bb.if_then:
  %.t5 = add i64 0, 0
  ret i64 %.t5
}
define %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 @"std.io::buffer"(i64 %len) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str106, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %len04 = add i64 0, 0
  %raw3 = call ptr @drift_alloc_array(i64 1, i64 1, i64 %len04, i64 %len)
  %raw05 = insertvalue %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c zeroinitializer, ptr %raw3, 0
  %raw16 = insertvalue %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c %raw05, i64 %len, 1
  %zero_struct7 = insertvalue %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c zeroinitializer, ptr null, 0
  %__arc1 = insertvalue %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c %zero_struct7, i64 0, 1
  %.t6 = add i64 0, 0
  %struct8 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 zeroinitializer, %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c %raw16, 0
  %struct9 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %struct8, i64 %len, 1
  %.t7 = insertvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %struct9, i64 %.t6, 2
  ret %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %.t7
}
define i64 @"std.io::buffer_capacity_mut"(ptr %self) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str107, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = load %Struct_std_2Eio_Buffer_e76b5c24b140f2f4, ptr %self
  %.t4 = extractvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %.t3, 1
  ret i64 %.t4
}
define void @"std.io::buffer_commit_read"(ptr %self, i64 %len_1) {
.bb.entry:
  %self__addr = alloca ptr
  store ptr %self, ptr %self__addr
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str108, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t4 = add i64 0, 0
  %.t5 = icmp slt i64 %len_1, %.t4
  br i1 %.t5, label %.bb.if_then, label %.bb.if_join
.bb.if_then:
  %.t6 = add i64 0, 0
  br label %.bb.if_join
.bb.if_join:
  %target_2 = phi i64 [ %len_1, %.bb.entry ], [ %.t6, %.bb.if_then ]
  %.t8 = load ptr, ptr %self__addr
  %.t9 = load %Struct_std_2Eio_Buffer_e76b5c24b140f2f4, ptr %.t8
  %.t10 = extractvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %.t9, 1
  %.t11 = icmp sgt i64 %target_2, %.t10
  br i1 %.t11, label %.bb.if_then1, label %.bb.if_join1
.bb.if_then1:
  %.t12 = load ptr, ptr %self__addr
  %.t13 = load %Struct_std_2Eio_Buffer_e76b5c24b140f2f4, ptr %.t12
  %.t14 = extractvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %.t13, 1
  br label %.bb.if_join1
.bb.if_join1:
  %target_3 = phi i64 [ %target_2, %.bb.if_join ], [ %.t14, %.bb.if_then1 ]
  %.t17 = load ptr, ptr %self__addr
  %.t18 = getelementptr inbounds %Struct_std_2Eio_Buffer_e76b5c24b140f2f4, ptr %.t17, i32 0, i32 2
  store i64 %target_3, ptr %.t18
  ret void
}
define i64 @"std.io::buffer_len"(ptr %self) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str109, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = load %Struct_std_2Eio_Buffer_e76b5c24b140f2f4, ptr %self
  %.t4 = extractvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %.t3, 2
  ret i64 %.t4
}
define ptr @"std.io::buffer_ptr"(ptr %self) {
.bb.entry:
  %self__addr = alloca ptr
  store ptr %self, ptr %self__addr
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str110, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = load ptr, ptr %self__addr
  %.t4 = getelementptr inbounds %Struct_std_2Eio_Buffer_e76b5c24b140f2f4, ptr %.t3, i32 0, i32 0
  %.t5 = load %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c, ptr %.t4
  %.t6 = extractvalue %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c %.t5, 0
  ret ptr %.t6
}
define ptr @"std.io::buffer_ptr_mut"(ptr %self) {
.bb.entry:
  %self__addr = alloca ptr
  store ptr %self, ptr %self__addr
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str111, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = load ptr, ptr %self__addr
  %.t4 = getelementptr inbounds %Struct_std_2Eio_Buffer_e76b5c24b140f2f4, ptr %.t3, i32 0, i32 0
  %.t5 = load %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c, ptr %.t4
  %.t6 = extractvalue %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c %.t5, 0
  ret ptr %.t6
}
define i8 @"std.io::buffer_read"(ptr %self, i64 %i) {
.bb.entry:
  %self__addr = alloca ptr
  store ptr %self, ptr %self__addr
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str112, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = load ptr, ptr %self__addr
  %.t4 = getelementptr inbounds %Struct_std_2Eio_Buffer_e76b5c24b140f2f4, ptr %.t3, i32 0, i32 0
  %rawbuf3 = load %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c, ptr %.t4
  %rawptr4 = extractvalue %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c %rawbuf3, 0
  %rawcap5 = extractvalue %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c %rawbuf3, 1
  %strptr6 = getelementptr inbounds { i64, i64, [18 x i8] }, ptr @.str17, i32 0, i32 2, i32 0
  %str07 = insertvalue %DriftString zeroinitializer, i64 17, 0
  %str8 = insertvalue %DriftString %str07, ptr %strptr6, 1
  call void @drift_bounds_check(%DriftString %str8, i64 %i, i64 %rawcap5)
  %rawgep9 = getelementptr i8, ptr %rawptr4, i64 %i
  %.t6 = load i8, ptr %rawgep9
  ret i8 %.t6
}
define void @"std.io::buffer_write"(ptr %self, i64 %i_1, i8 %v_1) {
.bb.entry:
  %self__addr = alloca ptr
  store ptr %self, ptr %self__addr
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str113, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = load ptr, ptr %self__addr
  %.t4 = load %Struct_std_2Eio_Buffer_e76b5c24b140f2f4, ptr %.t3
  %.t5 = extractvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %.t4, 2
  %.t6 = icmp sgt i64 %i_1, %.t5
  %j_1 = add i64 0, 0
  br i1 %.t6, label %.bb.if_then, label %.bb.if_join
.bb.if_then:
  %.t7 = load ptr, ptr %self__addr
  %.t8 = load %Struct_std_2Eio_Buffer_e76b5c24b140f2f4, ptr %.t7
  %.t9 = extractvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %.t8, 2
  br label %.bb.loop_header
.bb.loop_header:
  %j_4 = phi i64 [ %.t9, %.bb.if_then ], [ %.t20, %.bb.if_join1 ]
  br label %.bb.loop_body
.bb.loop_body:
  %.t12 = icmp slt i64 %j_4, %i_1
  br i1 %.t12, label %.bb.if_then1, label %.bb.if_else
.bb.if_else:
  br label %.bb.loop_exit
.bb.loop_exit:
  br label %.bb.if_join
.bb.if_join:
  %j_2 = phi i64 [ %j_1, %.bb.entry ], [ %j_4, %.bb.loop_exit ]
  %.t22 = load ptr, ptr %self__addr
  %.t23 = getelementptr inbounds %Struct_std_2Eio_Buffer_e76b5c24b140f2f4, ptr %.t22, i32 0, i32 0
  %rawbuf3 = load %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c, ptr %.t23
  %rawptr4 = extractvalue %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c %rawbuf3, 0
  %rawcap5 = extractvalue %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c %rawbuf3, 1
  %strptr6 = getelementptr inbounds { i64, i64, [18 x i8] }, ptr @.str17, i32 0, i32 2, i32 0
  %str07 = insertvalue %DriftString zeroinitializer, i64 17, 0
  %str8 = insertvalue %DriftString %str07, ptr %strptr6, 1
  call void @drift_bounds_check(%DriftString %str8, i64 %i_1, i64 %rawcap5)
  %rawgep9 = getelementptr i8, ptr %rawptr4, i64 %i_1
  store i8 %v_1, ptr %rawgep9
  %.t27 = add i64 0, 1
  %.t28 = add i64 %i_1, %.t27
  %.t30 = load ptr, ptr %self__addr
  %.t31 = load %Struct_std_2Eio_Buffer_e76b5c24b140f2f4, ptr %.t30
  %.t32 = extractvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %.t31, 2
  %.t33 = icmp sgt i64 %.t28, %.t32
  br i1 %.t33, label %.bb.if_then2, label %.bb.if_join2
.bb.if_then2:
  %.t36 = load ptr, ptr %self__addr
  %.t37 = getelementptr inbounds %Struct_std_2Eio_Buffer_e76b5c24b140f2f4, ptr %.t36, i32 0, i32 2
  store i64 %.t28, ptr %.t37
  br label %.bb.if_join2
.bb.if_join2:
  ret void
.bb.if_then1:
  %.t14 = load ptr, ptr %self__addr
  %.t15 = getelementptr inbounds %Struct_std_2Eio_Buffer_e76b5c24b140f2f4, ptr %.t14, i32 0, i32 0
  %.t17 = add i8 0, 0
  %rawbuf10 = load %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c, ptr %.t15
  %rawptr11 = extractvalue %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c %rawbuf10, 0
  %rawcap12 = extractvalue %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c %rawbuf10, 1
  %strptr13 = getelementptr inbounds { i64, i64, [18 x i8] }, ptr @.str17, i32 0, i32 2, i32 0
  %str014 = insertvalue %DriftString zeroinitializer, i64 17, 0
  %str15 = insertvalue %DriftString %str014, ptr %strptr13, 1
  call void @drift_bounds_check(%DriftString %str15, i64 %j_4, i64 %rawcap12)
  %rawgep16 = getelementptr i8, ptr %rawptr11, i64 %j_4
  store i8 %.t17, ptr %rawgep16
  %.t19 = add i64 0, 1
  %.t20 = add i64 %j_4, %.t19
  br label %.bb.if_join1
.bb.if_join1:
  br label %.bb.loop_header
}
define %Variant_std_2Ecore_Result_91c2f7f96a418c4d @"std.io::configured_output_write"(ptr %self, ptr %buf) {
.bb.entry:
  %stream__addr = alloca %Struct_std_2Eio_OutputStream_d623f446e1cca610
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str114, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = load %Struct_std_2Eio_ConfiguredOutputStream_bdad74f25b0e3ac5, ptr %self
  %.t4 = extractvalue %Struct_std_2Eio_ConfiguredOutputStream_bdad74f25b0e3ac5 %.t3, 0
  %.t5 = insertvalue %Struct_std_2Eio_OutputStream_d623f446e1cca610 zeroinitializer, i64 %.t4, 0
  store %Struct_std_2Eio_OutputStream_d623f446e1cca610 %.t5, ptr %stream__addr
  %.t9 = load %Struct_std_2Eio_ConfiguredOutputStream_bdad74f25b0e3ac5, ptr %self
  %.t10 = extractvalue %Struct_std_2Eio_ConfiguredOutputStream_bdad74f25b0e3ac5 %.t9, 1
  %.t11 = call %Variant_std_2Ecore_Result_91c2f7f96a418c4d @"std.io::output_write"(ptr %stream__addr, ptr %buf, %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %.t10)
  ret %Variant_std_2Ecore_Result_91c2f7f96a418c4d %.t11
}
define i1 @"std.io::install_process_preamble__impl"() {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str115, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t2 = call ptr @"std.runtime::global_registry"()
  %.t4 = call i1 @"std.io::install_process_stdio"(ptr %.t2)
  ret i1 %.t4
}
define i1 @"std.io::install_process_stdio"(ptr %reg_1) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str116, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t2 = add i64 0, 0
  %.t3 = insertvalue %Struct_std_2Eio_ProcessStdinCapability_59452a2d778d5df1 zeroinitializer, i64 %.t2, 0
  %.t6 = call i1 @"std.runtime::GlobalRegistry::set__inst__8e3703659a16d399"(ptr %reg_1, %Struct_std_2Eio_ProcessStdinCapability_59452a2d778d5df1 %.t3)
  %.t7 = xor i1 %.t6, true
  br i1 %.t7, label %.bb.if_then, label %.bb.if_join
.bb.if_then:
  %.t9 = call i1 @"std.runtime::contains__inst__a4a44818e3c6431b"(ptr %reg_1)
  %.t10 = xor i1 %.t9, true
  br i1 %.t10, label %.bb.if_then1, label %.bb.if_join1
.bb.if_join1:
  br label %.bb.if_join
.bb.if_join:
  %.t12 = add i64 0, 1
  %.t13 = insertvalue %Struct_std_2Eio_ProcessStdoutCapability_55cff55291ea241c zeroinitializer, i64 %.t12, 0
  %.t16 = call i1 @"std.runtime::GlobalRegistry::set__inst__79cf2420baaed150"(ptr %reg_1, %Struct_std_2Eio_ProcessStdoutCapability_55cff55291ea241c %.t13)
  %.t17 = xor i1 %.t16, true
  br i1 %.t17, label %.bb.if_then2, label %.bb.if_join2
.bb.if_then2:
  %.t19 = call i1 @"std.runtime::contains__inst__d6e7556221403df5"(ptr %reg_1)
  %.t20 = xor i1 %.t19, true
  br i1 %.t20, label %.bb.if_then3, label %.bb.if_join3
.bb.if_join3:
  br label %.bb.if_join2
.bb.if_join2:
  %.t22 = add i64 0, 2
  %.t23 = insertvalue %Struct_std_2Eio_ProcessStderrCapability_d600e110b9a19e1e zeroinitializer, i64 %.t22, 0
  %.t26 = call i1 @"std.runtime::GlobalRegistry::set__inst__2f0a2cb7c747e9a4"(ptr %reg_1, %Struct_std_2Eio_ProcessStderrCapability_d600e110b9a19e1e %.t23)
  %.t27 = xor i1 %.t26, true
  br i1 %.t27, label %.bb.if_then4, label %.bb.if_join4
.bb.if_then4:
  %.t29 = call i1 @"std.runtime::contains__inst__366e997d63749372"(ptr %reg_1)
  %.t30 = xor i1 %.t29, true
  br i1 %.t30, label %.bb.if_then5, label %.bb.if_join5
.bb.if_join5:
  br label %.bb.if_join4
.bb.if_join4:
  %.t32 = add i1 0, 1
  ret i1 %.t32
.bb.if_then5:
  %.t31 = add i1 0, 0
  ret i1 %.t31
.bb.if_then3:
  %.t21 = add i1 0, 0
  ret i1 %.t21
.bb.if_then1:
  %.t11 = add i1 0, 0
  ret i1 %.t11
}
define %Variant_std_2Ecore_Result_91c2f7f96a418c4d @"std.io::output_write"(ptr %self_1, ptr %buf, %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %timeout_1) {
.bb.entry:
  %buf__addr = alloca ptr
  store ptr %buf, ptr %buf__addr
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str117, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t2 = call i64 @drift_thread_current()
  %.t3 = add i64 0, 0
  %.t4 = icmp eq i64 %.t2, %.t3
  br i1 %.t4, label %.bb.if_then, label %.bb.if_join
.bb.if_join:
  %.t11 = load ptr, ptr %buf__addr
  %.t12 = getelementptr inbounds %Struct_std_2Eio_Buffer_e76b5c24b140f2f4, ptr %.t11, i32 0, i32 0
  %.t13 = load %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c, ptr %.t12
  %.t14 = extractvalue %Struct_std_2Emem_RawBuffer_10d8760b6c6b011c %.t13, 0
  %.t15 = load ptr, ptr %buf__addr
  %.t16 = load %Struct_std_2Eio_Buffer_e76b5c24b140f2f4, ptr %.t15
  %.t17 = extractvalue %Struct_std_2Eio_Buffer_e76b5c24b140f2f4 %.t16, 2
  %.t19 = call i64 @"std.io::_deadline_from_timeout"(%Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %timeout_1)
  br label %.bb.loop_header
.bb.loop_header:
  br label %.bb.loop_body
.bb.loop_body:
  %.t21 = load %Struct_std_2Eio_OutputStream_d623f446e1cca610, ptr %self_1
  %.t22 = extractvalue %Struct_std_2Eio_OutputStream_d623f446e1cca610 %.t21, 0
  %.t25 = call i64 @drift_io_write(i64 %.t22, ptr %.t14, i64 %.t17)
  %.t27 = add i64 0, 0
  %.t28 = icmp sge i64 %.t25, %.t27
  br i1 %.t28, label %.bb.if_then1, label %.bb.if_join1
.bb.if_join1:
  %.t37 = call i64 @drift_io_errno()
  %.t39 = add i64 0, 4
  %.t40 = icmp eq i64 %.t37, %.t39
  br i1 %.t40, label %.bb.if_then2, label %.bb.if_join2
.bb.if_join2:
  %.t42 = add i64 0, 11
  %.t43 = icmp eq i64 %.t37, %.t42
  br i1 %.t43, label %.bb.if_then3, label %.bb.if_join3
.bb.if_join3:
  %strptr3 = getelementptr inbounds { i64, i64, [6 x i8] }, ptr @.str118, i32 0, i32 2, i32 0
  %str04 = insertvalue %DriftString zeroinitializer, i64 5, 0
  %.t65 = insertvalue %DriftString %str04, ptr %strptr3, 1
  %struct5 = insertvalue %Struct_std_2Eio_IoError_7415ea6adc7a82aa zeroinitializer, %DriftString %.t65, 0
  %.t67 = insertvalue %Struct_std_2Eio_IoError_7415ea6adc7a82aa %struct5, i64 %.t37, 1
  %variant6 = alloca %Variant_std_2Ecore_Result_91c2f7f96a418c4d
  store %Variant_std_2Ecore_Result_91c2f7f96a418c4d zeroinitializer, ptr %variant6
  %tagptr7 = getelementptr inbounds %Variant_std_2Ecore_Result_91c2f7f96a418c4d, ptr %variant6, i32 0, i32 0
  store i8 1, ptr %tagptr7
  %payload_words8 = getelementptr inbounds %Variant_std_2Ecore_Result_91c2f7f96a418c4d, ptr %variant6, i32 0, i32 2
  %fieldptr9 = getelementptr inbounds { %Struct_std_2Eio_IoError_7415ea6adc7a82aa }, ptr %payload_words8, i32 0, i32 0
  store %Struct_std_2Eio_IoError_7415ea6adc7a82aa %.t67, ptr %fieldptr9
  %.t68 = load %Variant_std_2Ecore_Result_91c2f7f96a418c4d, ptr %variant6
  ret %Variant_std_2Ecore_Result_91c2f7f96a418c4d %.t68
.bb.if_then3:
  %.t45 = add i64 0, 0
  %.t46 = icmp sle i64 %.t19, %.t45
  br i1 %.t46, label %.bb.if_then4, label %.bb.if_join4
.bb.if_join4:
  %.t52 = call i64 @"std.io::_remaining_ms"(i64 %.t19)
  %.t54 = add i64 0, 0
  %.t55 = icmp sle i64 %.t52, %.t54
  br i1 %.t55, label %.bb.if_then5, label %.bb.if_join5
.bb.if_join5:
  %.t61 = load %Struct_std_2Eio_OutputStream_d623f446e1cca610, ptr %self_1
  %.t62 = extractvalue %Struct_std_2Eio_OutputStream_d623f446e1cca610 %.t61, 0
  %.t63 = add i64 0, 4
  call void @"std.io::_block_on_io"(i64 %.t62, i64 %.t63, i64 %.t19)
  br label %.bb.loop_header
.bb.if_then5:
  %strptr10 = getelementptr inbounds { i64, i64, [6 x i8] }, ptr @.str119, i32 0, i32 2, i32 0
  %str011 = insertvalue %DriftString zeroinitializer, i64 5, 0
  %.t56 = insertvalue %DriftString %str011, ptr %strptr10, 1
  %.t57 = add i64 0, -4095
  %struct12 = insertvalue %Struct_std_2Eio_IoError_7415ea6adc7a82aa zeroinitializer, %DriftString %.t56, 0
  %.t58 = insertvalue %Struct_std_2Eio_IoError_7415ea6adc7a82aa %struct12, i64 %.t57, 1
  %variant13 = alloca %Variant_std_2Ecore_Result_91c2f7f96a418c4d
  store %Variant_std_2Ecore_Result_91c2f7f96a418c4d zeroinitializer, ptr %variant13
  %tagptr14 = getelementptr inbounds %Variant_std_2Ecore_Result_91c2f7f96a418c4d, ptr %variant13, i32 0, i32 0
  store i8 1, ptr %tagptr14
  %payload_words15 = getelementptr inbounds %Variant_std_2Ecore_Result_91c2f7f96a418c4d, ptr %variant13, i32 0, i32 2
  %fieldptr16 = getelementptr inbounds { %Struct_std_2Eio_IoError_7415ea6adc7a82aa }, ptr %payload_words15, i32 0, i32 0
  store %Struct_std_2Eio_IoError_7415ea6adc7a82aa %.t58, ptr %fieldptr16
  %.t59 = load %Variant_std_2Ecore_Result_91c2f7f96a418c4d, ptr %variant13
  ret %Variant_std_2Ecore_Result_91c2f7f96a418c4d %.t59
.bb.if_then4:
  %strptr17 = getelementptr inbounds { i64, i64, [6 x i8] }, ptr @.str120, i32 0, i32 2, i32 0
  %str018 = insertvalue %DriftString zeroinitializer, i64 5, 0
  %.t47 = insertvalue %DriftString %str018, ptr %strptr17, 1
  %.t48 = add i64 0, -4095
  %struct19 = insertvalue %Struct_std_2Eio_IoError_7415ea6adc7a82aa zeroinitializer, %DriftString %.t47, 0
  %.t49 = insertvalue %Struct_std_2Eio_IoError_7415ea6adc7a82aa %struct19, i64 %.t48, 1
  %variant20 = alloca %Variant_std_2Ecore_Result_91c2f7f96a418c4d
  store %Variant_std_2Ecore_Result_91c2f7f96a418c4d zeroinitializer, ptr %variant20
  %tagptr21 = getelementptr inbounds %Variant_std_2Ecore_Result_91c2f7f96a418c4d, ptr %variant20, i32 0, i32 0
  store i8 1, ptr %tagptr21
  %payload_words22 = getelementptr inbounds %Variant_std_2Ecore_Result_91c2f7f96a418c4d, ptr %variant20, i32 0, i32 2
  %fieldptr23 = getelementptr inbounds { %Struct_std_2Eio_IoError_7415ea6adc7a82aa }, ptr %payload_words22, i32 0, i32 0
  store %Struct_std_2Eio_IoError_7415ea6adc7a82aa %.t49, ptr %fieldptr23
  %.t50 = load %Variant_std_2Ecore_Result_91c2f7f96a418c4d, ptr %variant20
  ret %Variant_std_2Ecore_Result_91c2f7f96a418c4d %.t50
.bb.if_then2:
  br label %.bb.loop_header
.bb.if_then1:
  %.t30 = load %Struct_std_2Eio_OutputStream_d623f446e1cca610, ptr %self_1
  %.t31 = extractvalue %Struct_std_2Eio_OutputStream_d623f446e1cca610 %.t30, 0
  %.t32 = add i64 0, 4
  %.t34 = call i64 @drift_reactor_io_charge(i64 %.t31, i64 %.t32, i64 %.t25)
  %variant24 = alloca %Variant_std_2Ecore_Result_91c2f7f96a418c4d
  store %Variant_std_2Ecore_Result_91c2f7f96a418c4d zeroinitializer, ptr %variant24
  %tagptr25 = getelementptr inbounds %Variant_std_2Ecore_Result_91c2f7f96a418c4d, ptr %variant24, i32 0, i32 0
  store i8 0, ptr %tagptr25
  %payload_words26 = getelementptr inbounds %Variant_std_2Ecore_Result_91c2f7f96a418c4d, ptr %variant24, i32 0, i32 2
  %fieldptr27 = getelementptr inbounds { i64 }, ptr %payload_words26, i32 0, i32 0
  store i64 %.t25, ptr %fieldptr27
  %.t36 = load %Variant_std_2Ecore_Result_91c2f7f96a418c4d, ptr %variant24
  ret %Variant_std_2Ecore_Result_91c2f7f96a418c4d %.t36
.bb.if_then:
  %strptr28 = getelementptr inbounds { i64, i64, [17 x i8] }, ptr @.str121, i32 0, i32 2, i32 0
  %str029 = insertvalue %DriftString zeroinitializer, i64 16, 0
  %.t5 = insertvalue %DriftString %str029, ptr %strptr28, 1
  %.t6 = add i64 0, 2
  %.t7 = sub i64 0, %.t6
  %struct30 = insertvalue %Struct_std_2Eio_IoError_7415ea6adc7a82aa zeroinitializer, %DriftString %.t5, 0
  %.t8 = insertvalue %Struct_std_2Eio_IoError_7415ea6adc7a82aa %struct30, i64 %.t7, 1
  %variant31 = alloca %Variant_std_2Ecore_Result_91c2f7f96a418c4d
  store %Variant_std_2Ecore_Result_91c2f7f96a418c4d zeroinitializer, ptr %variant31
  %tagptr32 = getelementptr inbounds %Variant_std_2Ecore_Result_91c2f7f96a418c4d, ptr %variant31, i32 0, i32 0
  store i8 1, ptr %tagptr32
  %payload_words33 = getelementptr inbounds %Variant_std_2Ecore_Result_91c2f7f96a418c4d, ptr %variant31, i32 0, i32 2
  %fieldptr34 = getelementptr inbounds { %Struct_std_2Eio_IoError_7415ea6adc7a82aa }, ptr %payload_words33, i32 0, i32 0
  store %Struct_std_2Eio_IoError_7415ea6adc7a82aa %.t8, ptr %fieldptr34
  %.t9 = load %Variant_std_2Ecore_Result_91c2f7f96a418c4d, ptr %variant31
  ret %Variant_std_2Ecore_Result_91c2f7f96a418c4d %.t9
}
define %Struct_std_2Eio_OutputStreamBuilder_3e71da12881637f4 @"std.io::stdout_builder"() {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str122, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t2 = add i64 0, 1
  %.t3 = call i64 @drift_io_set_nonblocking(i64 %.t2)
  %.t4 = add i64 0, 1
  %.t5 = add i64 0, 60000
  %.t6 = insertvalue %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 zeroinitializer, i64 %.t5, 0
  %struct3 = insertvalue %Struct_std_2Eio_OutputStreamBuilder_3e71da12881637f4 zeroinitializer, i64 %.t4, 0
  %.t7 = insertvalue %Struct_std_2Eio_OutputStreamBuilder_3e71da12881637f4 %struct3, %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %.t6, 1
  ret %Struct_std_2Eio_OutputStreamBuilder_3e71da12881637f4 %.t7
}
define %Variant_std_2Ecore_Result_a482b0d00941967a @"std.net::TcpListener::accept"(ptr %self, %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %timeout) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str123, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t4 = call %Variant_std_2Ecore_Result_a482b0d00941967a @"std.net::accept"(ptr %self, %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %timeout)
  ret %Variant_std_2Ecore_Result_a482b0d00941967a %.t4
}
define i64 @"std.net::TcpListener::local_port"(ptr %self) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str124, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = load %Struct_std_2Enet_TcpListener_7d3d9b3ee7d65cad, ptr %self
  %.t4 = extractvalue %Struct_std_2Enet_TcpListener_7d3d9b3ee7d65cad %.t3, 0
  %.t5 = call i64 @drift_net_listener_port(i64 %.t4)
  ret i64 %.t5
}
define %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 @"std.net::TcpStream::close"(ptr %self_1, %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %timeout_1) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str125, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t2 = call i64 @drift_thread_current()
  %.t3 = add i64 0, 0
  %.t4 = icmp eq i64 %.t2, %.t3
  br i1 %.t4, label %.bb.if_then, label %.bb.if_join
.bb.if_join:
  %.t10 = call i64 @"std.net::_deadline_from_timeout"(%Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %timeout_1)
  br label %.bb.loop_header
.bb.loop_header:
  br label %.bb.loop_body
.bb.loop_body:
  %.t12 = load %Struct_std_2Enet_TcpStream_363317ef680a1400, ptr %self_1
  %.t13 = extractvalue %Struct_std_2Enet_TcpStream_363317ef680a1400 %.t12, 0
  %.t14 = call i64 @drift_io_close(i64 %.t13)
  %.t16 = add i64 0, 0
  %.t17 = icmp sge i64 %.t14, %.t16
  br i1 %.t17, label %.bb.if_then1, label %.bb.if_join1
.bb.if_join1:
  %.t20 = call i64 @drift_io_errno()
  %.t22 = add i64 0, 4
  %.t23 = icmp eq i64 %.t20, %.t22
  br i1 %.t23, label %.bb.if_then2, label %.bb.if_join2
.bb.if_join2:
  %.t25 = add i64 0, 11
  %.t26 = icmp eq i64 %.t20, %.t25
  br i1 %.t26, label %.bb.if_then3, label %.bb.if_join3
.bb.if_join3:
  %strptr3 = getelementptr inbounds { i64, i64, [6 x i8] }, ptr @.str126, i32 0, i32 2, i32 0
  %str04 = insertvalue %DriftString zeroinitializer, i64 5, 0
  %.t48 = insertvalue %DriftString %str04, ptr %strptr3, 1
  %struct5 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString %.t48, 0
  %.t50 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %struct5, i64 %.t20, 1
  %variant6 = alloca %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6
  store %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 zeroinitializer, ptr %variant6
  %tagptr7 = getelementptr inbounds %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6, ptr %variant6, i32 0, i32 0
  store i8 1, ptr %tagptr7
  %payload_words8 = getelementptr inbounds %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6, ptr %variant6, i32 0, i32 2
  %fieldptr9 = getelementptr inbounds { %Struct_std_2Enet_NetError_203564604ea2d3a4 }, ptr %payload_words8, i32 0, i32 0
  store %Struct_std_2Enet_NetError_203564604ea2d3a4 %.t50, ptr %fieldptr9
  %.t51 = load %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6, ptr %variant6
  ret %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 %.t51
.bb.if_then3:
  %.t28 = add i64 0, 0
  %.t29 = icmp sle i64 %.t10, %.t28
  br i1 %.t29, label %.bb.if_then4, label %.bb.if_join4
.bb.if_join4:
  %.t35 = call i64 @"std.net::_remaining_ms"(i64 %.t10)
  %.t37 = add i64 0, 0
  %.t38 = icmp sle i64 %.t35, %.t37
  br i1 %.t38, label %.bb.if_then5, label %.bb.if_join5
.bb.if_join5:
  %.t44 = load %Struct_std_2Enet_TcpStream_363317ef680a1400, ptr %self_1
  %.t45 = extractvalue %Struct_std_2Enet_TcpStream_363317ef680a1400 %.t44, 0
  %.t46 = add i64 0, 4
  call void @"std.net::_block_on_io"(i64 %.t45, i64 %.t46, i64 %.t10)
  br label %.bb.loop_header
.bb.if_then5:
  %strptr10 = getelementptr inbounds { i64, i64, [12 x i8] }, ptr @.str127, i32 0, i32 2, i32 0
  %str011 = insertvalue %DriftString zeroinitializer, i64 11, 0
  %.t39 = insertvalue %DriftString %str011, ptr %strptr10, 1
  %.t40 = add i64 0, 0
  %struct12 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString %.t39, 0
  %.t41 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %struct12, i64 %.t40, 1
  %variant13 = alloca %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6
  store %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 zeroinitializer, ptr %variant13
  %tagptr14 = getelementptr inbounds %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6, ptr %variant13, i32 0, i32 0
  store i8 1, ptr %tagptr14
  %payload_words15 = getelementptr inbounds %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6, ptr %variant13, i32 0, i32 2
  %fieldptr16 = getelementptr inbounds { %Struct_std_2Enet_NetError_203564604ea2d3a4 }, ptr %payload_words15, i32 0, i32 0
  store %Struct_std_2Enet_NetError_203564604ea2d3a4 %.t41, ptr %fieldptr16
  %.t42 = load %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6, ptr %variant13
  ret %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 %.t42
.bb.if_then4:
  %strptr17 = getelementptr inbounds { i64, i64, [12 x i8] }, ptr @.str128, i32 0, i32 2, i32 0
  %str018 = insertvalue %DriftString zeroinitializer, i64 11, 0
  %.t30 = insertvalue %DriftString %str018, ptr %strptr17, 1
  %.t31 = add i64 0, 0
  %struct19 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString %.t30, 0
  %.t32 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %struct19, i64 %.t31, 1
  %variant20 = alloca %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6
  store %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 zeroinitializer, ptr %variant20
  %tagptr21 = getelementptr inbounds %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6, ptr %variant20, i32 0, i32 0
  store i8 1, ptr %tagptr21
  %payload_words22 = getelementptr inbounds %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6, ptr %variant20, i32 0, i32 2
  %fieldptr23 = getelementptr inbounds { %Struct_std_2Enet_NetError_203564604ea2d3a4 }, ptr %payload_words22, i32 0, i32 0
  store %Struct_std_2Enet_NetError_203564604ea2d3a4 %.t32, ptr %fieldptr23
  %.t33 = load %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6, ptr %variant20
  ret %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 %.t33
.bb.if_then2:
  br label %.bb.loop_header
.bb.if_then1:
  call void @"std.core::void_value"()
  %.t18 = add i8 0, 0
  %variant24 = alloca %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6
  store %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 zeroinitializer, ptr %variant24
  %tagptr25 = getelementptr inbounds %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6, ptr %variant24, i32 0, i32 0
  store i8 0, ptr %tagptr25
  %payload_words26 = getelementptr inbounds %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6, ptr %variant24, i32 0, i32 2
  %fieldptr27 = getelementptr inbounds { i8 }, ptr %payload_words26, i32 0, i32 0
  store i8 %.t18, ptr %fieldptr27
  %.t19 = load %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6, ptr %variant24
  ret %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 %.t19
.bb.if_then:
  %strptr28 = getelementptr inbounds { i64, i64, [17 x i8] }, ptr @.str129, i32 0, i32 2, i32 0
  %str029 = insertvalue %DriftString zeroinitializer, i64 16, 0
  %.t5 = insertvalue %DriftString %str029, ptr %strptr28, 1
  %.t6 = add i64 0, 0
  %struct30 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString %.t5, 0
  %.t7 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %struct30, i64 %.t6, 1
  %variant31 = alloca %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6
  store %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 zeroinitializer, ptr %variant31
  %tagptr32 = getelementptr inbounds %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6, ptr %variant31, i32 0, i32 0
  store i8 1, ptr %tagptr32
  %payload_words33 = getelementptr inbounds %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6, ptr %variant31, i32 0, i32 2
  %fieldptr34 = getelementptr inbounds { %Struct_std_2Enet_NetError_203564604ea2d3a4 }, ptr %payload_words33, i32 0, i32 0
  store %Struct_std_2Enet_NetError_203564604ea2d3a4 %.t7, ptr %fieldptr34
  %.t8 = load %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6, ptr %variant31
  ret %Variant_std_2Ecore_Result_9dbf2dcdb5537ee6 %.t8
}
define %Variant_std_2Ecore_Result_ccaaf7910bb23f6d @"std.net::TcpStream::read"(ptr %self_1, ptr %buf_1, %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %timeout_1) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str130, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t2 = call i64 @drift_thread_current()
  %.t3 = add i64 0, 0
  %.t4 = icmp eq i64 %.t2, %.t3
  br i1 %.t4, label %.bb.if_then, label %.bb.if_join
.bb.if_join:
  %.t10 = call ptr @"std.io::buffer_ptr_mut"(ptr %buf_1)
  %.t12 = call i64 @"std.io::buffer_capacity_mut"(ptr %buf_1)
  %.t14 = call i64 @"std.net::_deadline_from_timeout"(%Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %timeout_1)
  br label %.bb.loop_header
.bb.loop_header:
  br label %.bb.loop_body
.bb.loop_body:
  %.t16 = load %Struct_std_2Enet_TcpStream_363317ef680a1400, ptr %self_1
  %.t17 = extractvalue %Struct_std_2Enet_TcpStream_363317ef680a1400 %.t16, 0
  %.t20 = call i64 @drift_io_read(i64 %.t17, ptr %.t10, i64 %.t12)
  %.t22 = add i64 0, 0
  %.t23 = icmp sge i64 %.t20, %.t22
  br i1 %.t23, label %.bb.if_then1, label %.bb.if_join1
.bb.if_join1:
  %.t34 = call i64 @drift_io_errno()
  %.t36 = add i64 0, 4
  %.t37 = icmp eq i64 %.t34, %.t36
  br i1 %.t37, label %.bb.if_then2, label %.bb.if_join2
.bb.if_join2:
  %.t39 = add i64 0, 11
  %.t40 = icmp eq i64 %.t34, %.t39
  br i1 %.t40, label %.bb.if_then3, label %.bb.if_join3
.bb.if_join3:
  %strptr3 = getelementptr inbounds { i64, i64, [6 x i8] }, ptr @.str131, i32 0, i32 2, i32 0
  %str04 = insertvalue %DriftString zeroinitializer, i64 5, 0
  %.t62 = insertvalue %DriftString %str04, ptr %strptr3, 1
  %struct5 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString %.t62, 0
  %.t64 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %struct5, i64 %.t34, 1
  %variant6 = alloca %Variant_std_2Ecore_Result_ccaaf7910bb23f6d
  store %Variant_std_2Ecore_Result_ccaaf7910bb23f6d zeroinitializer, ptr %variant6
  %tagptr7 = getelementptr inbounds %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %variant6, i32 0, i32 0
  store i8 1, ptr %tagptr7
  %payload_words8 = getelementptr inbounds %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %variant6, i32 0, i32 2
  %fieldptr9 = getelementptr inbounds { %Struct_std_2Enet_NetError_203564604ea2d3a4 }, ptr %payload_words8, i32 0, i32 0
  store %Struct_std_2Enet_NetError_203564604ea2d3a4 %.t64, ptr %fieldptr9
  %.t65 = load %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %variant6
  ret %Variant_std_2Ecore_Result_ccaaf7910bb23f6d %.t65
.bb.if_then3:
  %.t42 = add i64 0, 0
  %.t43 = icmp sle i64 %.t14, %.t42
  br i1 %.t43, label %.bb.if_then4, label %.bb.if_join4
.bb.if_join4:
  %.t49 = call i64 @"std.net::_remaining_ms"(i64 %.t14)
  %.t51 = add i64 0, 0
  %.t52 = icmp sle i64 %.t49, %.t51
  br i1 %.t52, label %.bb.if_then5, label %.bb.if_join5
.bb.if_join5:
  %.t58 = load %Struct_std_2Enet_TcpStream_363317ef680a1400, ptr %self_1
  %.t59 = extractvalue %Struct_std_2Enet_TcpStream_363317ef680a1400 %.t58, 0
  %.t60 = add i64 0, 1
  call void @"std.net::_block_on_io"(i64 %.t59, i64 %.t60, i64 %.t14)
  br label %.bb.loop_header
.bb.if_then5:
  %strptr10 = getelementptr inbounds { i64, i64, [12 x i8] }, ptr @.str132, i32 0, i32 2, i32 0
  %str011 = insertvalue %DriftString zeroinitializer, i64 11, 0
  %.t53 = insertvalue %DriftString %str011, ptr %strptr10, 1
  %.t54 = add i64 0, 0
  %struct12 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString %.t53, 0
  %.t55 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %struct12, i64 %.t54, 1
  %variant13 = alloca %Variant_std_2Ecore_Result_ccaaf7910bb23f6d
  store %Variant_std_2Ecore_Result_ccaaf7910bb23f6d zeroinitializer, ptr %variant13
  %tagptr14 = getelementptr inbounds %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %variant13, i32 0, i32 0
  store i8 1, ptr %tagptr14
  %payload_words15 = getelementptr inbounds %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %variant13, i32 0, i32 2
  %fieldptr16 = getelementptr inbounds { %Struct_std_2Enet_NetError_203564604ea2d3a4 }, ptr %payload_words15, i32 0, i32 0
  store %Struct_std_2Enet_NetError_203564604ea2d3a4 %.t55, ptr %fieldptr16
  %.t56 = load %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %variant13
  ret %Variant_std_2Ecore_Result_ccaaf7910bb23f6d %.t56
.bb.if_then4:
  %strptr17 = getelementptr inbounds { i64, i64, [12 x i8] }, ptr @.str133, i32 0, i32 2, i32 0
  %str018 = insertvalue %DriftString zeroinitializer, i64 11, 0
  %.t44 = insertvalue %DriftString %str018, ptr %strptr17, 1
  %.t45 = add i64 0, 0
  %struct19 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString %.t44, 0
  %.t46 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %struct19, i64 %.t45, 1
  %variant20 = alloca %Variant_std_2Ecore_Result_ccaaf7910bb23f6d
  store %Variant_std_2Ecore_Result_ccaaf7910bb23f6d zeroinitializer, ptr %variant20
  %tagptr21 = getelementptr inbounds %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %variant20, i32 0, i32 0
  store i8 1, ptr %tagptr21
  %payload_words22 = getelementptr inbounds %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %variant20, i32 0, i32 2
  %fieldptr23 = getelementptr inbounds { %Struct_std_2Enet_NetError_203564604ea2d3a4 }, ptr %payload_words22, i32 0, i32 0
  store %Struct_std_2Enet_NetError_203564604ea2d3a4 %.t46, ptr %fieldptr23
  %.t47 = load %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %variant20
  ret %Variant_std_2Ecore_Result_ccaaf7910bb23f6d %.t47
.bb.if_then2:
  br label %.bb.loop_header
.bb.if_then1:
  call void @"std.io::buffer_commit_read"(ptr %buf_1, i64 %.t20)
  %.t27 = load %Struct_std_2Enet_TcpStream_363317ef680a1400, ptr %self_1
  %.t28 = extractvalue %Struct_std_2Enet_TcpStream_363317ef680a1400 %.t27, 0
  %.t29 = add i64 0, 1
  %.t31 = call i64 @drift_reactor_io_charge(i64 %.t28, i64 %.t29, i64 %.t20)
  %variant24 = alloca %Variant_std_2Ecore_Result_ccaaf7910bb23f6d
  store %Variant_std_2Ecore_Result_ccaaf7910bb23f6d zeroinitializer, ptr %variant24
  %tagptr25 = getelementptr inbounds %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %variant24, i32 0, i32 0
  store i8 0, ptr %tagptr25
  %payload_words26 = getelementptr inbounds %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %variant24, i32 0, i32 2
  %fieldptr27 = getelementptr inbounds { i64 }, ptr %payload_words26, i32 0, i32 0
  store i64 %.t20, ptr %fieldptr27
  %.t33 = load %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %variant24
  ret %Variant_std_2Ecore_Result_ccaaf7910bb23f6d %.t33
.bb.if_then:
  %strptr28 = getelementptr inbounds { i64, i64, [17 x i8] }, ptr @.str134, i32 0, i32 2, i32 0
  %str029 = insertvalue %DriftString zeroinitializer, i64 16, 0
  %.t5 = insertvalue %DriftString %str029, ptr %strptr28, 1
  %.t6 = add i64 0, 0
  %struct30 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString %.t5, 0
  %.t7 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %struct30, i64 %.t6, 1
  %variant31 = alloca %Variant_std_2Ecore_Result_ccaaf7910bb23f6d
  store %Variant_std_2Ecore_Result_ccaaf7910bb23f6d zeroinitializer, ptr %variant31
  %tagptr32 = getelementptr inbounds %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %variant31, i32 0, i32 0
  store i8 1, ptr %tagptr32
  %payload_words33 = getelementptr inbounds %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %variant31, i32 0, i32 2
  %fieldptr34 = getelementptr inbounds { %Struct_std_2Enet_NetError_203564604ea2d3a4 }, ptr %payload_words33, i32 0, i32 0
  store %Struct_std_2Enet_NetError_203564604ea2d3a4 %.t7, ptr %fieldptr34
  %.t8 = load %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %variant31
  ret %Variant_std_2Ecore_Result_ccaaf7910bb23f6d %.t8
}
define %Variant_std_2Ecore_Result_ccaaf7910bb23f6d @"std.net::TcpStream::write"(ptr %self_1, ptr %buf_1, %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %timeout_1) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str135, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t2 = call i64 @drift_thread_current()
  %.t3 = add i64 0, 0
  %.t4 = icmp eq i64 %.t2, %.t3
  br i1 %.t4, label %.bb.if_then, label %.bb.if_join
.bb.if_join:
  %.t10 = call ptr @"std.io::buffer_ptr"(ptr %buf_1)
  %.t12 = call i64 @"std.io::buffer_len"(ptr %buf_1)
  %.t14 = call i64 @"std.net::_deadline_from_timeout"(%Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %timeout_1)
  br label %.bb.loop_header
.bb.loop_header:
  br label %.bb.loop_body
.bb.loop_body:
  %.t16 = load %Struct_std_2Enet_TcpStream_363317ef680a1400, ptr %self_1
  %.t17 = extractvalue %Struct_std_2Enet_TcpStream_363317ef680a1400 %.t16, 0
  %.t20 = call i64 @drift_io_write(i64 %.t17, ptr %.t10, i64 %.t12)
  %.t22 = add i64 0, 0
  %.t23 = icmp sge i64 %.t20, %.t22
  br i1 %.t23, label %.bb.if_then1, label %.bb.if_join1
.bb.if_join1:
  %.t32 = call i64 @drift_io_errno()
  %.t34 = add i64 0, 4
  %.t35 = icmp eq i64 %.t32, %.t34
  br i1 %.t35, label %.bb.if_then2, label %.bb.if_join2
.bb.if_join2:
  %.t37 = add i64 0, 11
  %.t38 = icmp eq i64 %.t32, %.t37
  br i1 %.t38, label %.bb.if_then3, label %.bb.if_join3
.bb.if_join3:
  %strptr3 = getelementptr inbounds { i64, i64, [6 x i8] }, ptr @.str136, i32 0, i32 2, i32 0
  %str04 = insertvalue %DriftString zeroinitializer, i64 5, 0
  %.t60 = insertvalue %DriftString %str04, ptr %strptr3, 1
  %struct5 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString %.t60, 0
  %.t62 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %struct5, i64 %.t32, 1
  %variant6 = alloca %Variant_std_2Ecore_Result_ccaaf7910bb23f6d
  store %Variant_std_2Ecore_Result_ccaaf7910bb23f6d zeroinitializer, ptr %variant6
  %tagptr7 = getelementptr inbounds %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %variant6, i32 0, i32 0
  store i8 1, ptr %tagptr7
  %payload_words8 = getelementptr inbounds %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %variant6, i32 0, i32 2
  %fieldptr9 = getelementptr inbounds { %Struct_std_2Enet_NetError_203564604ea2d3a4 }, ptr %payload_words8, i32 0, i32 0
  store %Struct_std_2Enet_NetError_203564604ea2d3a4 %.t62, ptr %fieldptr9
  %.t63 = load %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %variant6
  ret %Variant_std_2Ecore_Result_ccaaf7910bb23f6d %.t63
.bb.if_then3:
  %.t40 = add i64 0, 0
  %.t41 = icmp sle i64 %.t14, %.t40
  br i1 %.t41, label %.bb.if_then4, label %.bb.if_join4
.bb.if_join4:
  %.t47 = call i64 @"std.net::_remaining_ms"(i64 %.t14)
  %.t49 = add i64 0, 0
  %.t50 = icmp sle i64 %.t47, %.t49
  br i1 %.t50, label %.bb.if_then5, label %.bb.if_join5
.bb.if_join5:
  %.t56 = load %Struct_std_2Enet_TcpStream_363317ef680a1400, ptr %self_1
  %.t57 = extractvalue %Struct_std_2Enet_TcpStream_363317ef680a1400 %.t56, 0
  %.t58 = add i64 0, 4
  call void @"std.net::_block_on_io"(i64 %.t57, i64 %.t58, i64 %.t14)
  br label %.bb.loop_header
.bb.if_then5:
  %strptr10 = getelementptr inbounds { i64, i64, [12 x i8] }, ptr @.str137, i32 0, i32 2, i32 0
  %str011 = insertvalue %DriftString zeroinitializer, i64 11, 0
  %.t51 = insertvalue %DriftString %str011, ptr %strptr10, 1
  %.t52 = add i64 0, 0
  %struct12 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString %.t51, 0
  %.t53 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %struct12, i64 %.t52, 1
  %variant13 = alloca %Variant_std_2Ecore_Result_ccaaf7910bb23f6d
  store %Variant_std_2Ecore_Result_ccaaf7910bb23f6d zeroinitializer, ptr %variant13
  %tagptr14 = getelementptr inbounds %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %variant13, i32 0, i32 0
  store i8 1, ptr %tagptr14
  %payload_words15 = getelementptr inbounds %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %variant13, i32 0, i32 2
  %fieldptr16 = getelementptr inbounds { %Struct_std_2Enet_NetError_203564604ea2d3a4 }, ptr %payload_words15, i32 0, i32 0
  store %Struct_std_2Enet_NetError_203564604ea2d3a4 %.t53, ptr %fieldptr16
  %.t54 = load %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %variant13
  ret %Variant_std_2Ecore_Result_ccaaf7910bb23f6d %.t54
.bb.if_then4:
  %strptr17 = getelementptr inbounds { i64, i64, [12 x i8] }, ptr @.str138, i32 0, i32 2, i32 0
  %str018 = insertvalue %DriftString zeroinitializer, i64 11, 0
  %.t42 = insertvalue %DriftString %str018, ptr %strptr17, 1
  %.t43 = add i64 0, 0
  %struct19 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString %.t42, 0
  %.t44 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %struct19, i64 %.t43, 1
  %variant20 = alloca %Variant_std_2Ecore_Result_ccaaf7910bb23f6d
  store %Variant_std_2Ecore_Result_ccaaf7910bb23f6d zeroinitializer, ptr %variant20
  %tagptr21 = getelementptr inbounds %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %variant20, i32 0, i32 0
  store i8 1, ptr %tagptr21
  %payload_words22 = getelementptr inbounds %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %variant20, i32 0, i32 2
  %fieldptr23 = getelementptr inbounds { %Struct_std_2Enet_NetError_203564604ea2d3a4 }, ptr %payload_words22, i32 0, i32 0
  store %Struct_std_2Enet_NetError_203564604ea2d3a4 %.t44, ptr %fieldptr23
  %.t45 = load %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %variant20
  ret %Variant_std_2Ecore_Result_ccaaf7910bb23f6d %.t45
.bb.if_then2:
  br label %.bb.loop_header
.bb.if_then1:
  %.t25 = load %Struct_std_2Enet_TcpStream_363317ef680a1400, ptr %self_1
  %.t26 = extractvalue %Struct_std_2Enet_TcpStream_363317ef680a1400 %.t25, 0
  %.t27 = add i64 0, 4
  %.t29 = call i64 @drift_reactor_io_charge(i64 %.t26, i64 %.t27, i64 %.t20)
  %variant24 = alloca %Variant_std_2Ecore_Result_ccaaf7910bb23f6d
  store %Variant_std_2Ecore_Result_ccaaf7910bb23f6d zeroinitializer, ptr %variant24
  %tagptr25 = getelementptr inbounds %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %variant24, i32 0, i32 0
  store i8 0, ptr %tagptr25
  %payload_words26 = getelementptr inbounds %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %variant24, i32 0, i32 2
  %fieldptr27 = getelementptr inbounds { i64 }, ptr %payload_words26, i32 0, i32 0
  store i64 %.t20, ptr %fieldptr27
  %.t31 = load %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %variant24
  ret %Variant_std_2Ecore_Result_ccaaf7910bb23f6d %.t31
.bb.if_then:
  %strptr28 = getelementptr inbounds { i64, i64, [17 x i8] }, ptr @.str139, i32 0, i32 2, i32 0
  %str029 = insertvalue %DriftString zeroinitializer, i64 16, 0
  %.t5 = insertvalue %DriftString %str029, ptr %strptr28, 1
  %.t6 = add i64 0, 0
  %struct30 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString %.t5, 0
  %.t7 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %struct30, i64 %.t6, 1
  %variant31 = alloca %Variant_std_2Ecore_Result_ccaaf7910bb23f6d
  store %Variant_std_2Ecore_Result_ccaaf7910bb23f6d zeroinitializer, ptr %variant31
  %tagptr32 = getelementptr inbounds %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %variant31, i32 0, i32 0
  store i8 1, ptr %tagptr32
  %payload_words33 = getelementptr inbounds %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %variant31, i32 0, i32 2
  %fieldptr34 = getelementptr inbounds { %Struct_std_2Enet_NetError_203564604ea2d3a4 }, ptr %payload_words33, i32 0, i32 0
  store %Struct_std_2Enet_NetError_203564604ea2d3a4 %.t7, ptr %fieldptr34
  %.t8 = load %Variant_std_2Ecore_Result_ccaaf7910bb23f6d, ptr %variant31
  ret %Variant_std_2Ecore_Result_ccaaf7910bb23f6d %.t8
}
define void @"std.net::_block_on_io"(i64 %fd_1, i64 %interest_1, i64 %deadline_ms_1) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str140, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = add i64 0, 0
  %.t4 = icmp sle i64 %deadline_ms_1, %.t3
  br i1 %.t4, label %.bb.if_then, label %.bb.if_join
.bb.if_join:
  %.t5 = call i64 @drift_thread_current()
  %.t7 = add i64 0, 0
  %.t8 = icmp eq i64 %.t5, %.t7
  br i1 %.t8, label %.bb.if_then1, label %.bb.if_join1
.bb.if_join1:
  %.t11 = call i64 @drift_reactor_check_pending(i64 %fd_1, i64 %interest_1)
  %.t12 = add i64 0, 0
  %.t13 = icmp ne i64 %.t11, %.t12
  br i1 %.t13, label %.bb.if_then2, label %.bb.if_join2
.bb.if_join2:
  call void @drift_reactor_register_io(i64 %fd_1, i64 %interest_1, i64 %.t5, i64 %deadline_ms_1)
  call void @drift_thread_park_until(i64 %deadline_ms_1)
  ret void
.bb.if_then2:
  ret void
.bb.if_then1:
  ret void
.bb.if_then:
  ret void
}
define i64 @"std.net::_deadline_from_timeout"(%Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %timeout_1) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str141, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = extractvalue %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %timeout_1, 0
  %.t4 = add i64 0, 0
  %.t5 = icmp sle i64 %.t3, %.t4
  br i1 %.t5, label %.bb.if_then, label %.bb.if_join
.bb.if_join:
  %.t7 = call i64 @drift_time_now_ms()
  %.t9 = extractvalue %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %timeout_1, 0
  %.t10 = add i64 %.t7, %.t9
  ret i64 %.t10
.bb.if_then:
  %.t6 = add i64 0, 0
  ret i64 %.t6
}
define void @"std.net::_park_main_thread_io"(i64 %remaining_1) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str142, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = add i64 0, 0
  %.t4 = icmp sle i64 %remaining_1, %.t3
  br i1 %.t4, label %.bb.if_then, label %.bb.if_join
.bb.if_join:
  %.t7 = add i64 0, 10
  %.t8 = icmp sgt i64 %remaining_1, %.t7
  br i1 %.t8, label %.bb.if_then1, label %.bb.if_join1
.bb.if_then1:
  %.t9 = add i64 0, 10
  br label %.bb.if_join1
.bb.if_join1:
  %slice_2 = phi i64 [ %remaining_1, %.bb.if_join ], [ %.t9, %.bb.if_then1 ]
  call void @drift_thread_park_until(i64 %slice_2)
  ret void
.bb.if_then:
  ret void
}
define i64 @"std.net::_remaining_ms"(i64 %deadline_ms_1) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str143, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = add i64 0, 0
  %.t4 = icmp sle i64 %deadline_ms_1, %.t3
  br i1 %.t4, label %.bb.if_then, label %.bb.if_join
.bb.if_join:
  %.t6 = call i64 @drift_time_now_ms()
  %.t9 = icmp sge i64 %.t6, %deadline_ms_1
  br i1 %.t9, label %.bb.if_then1, label %.bb.if_join1
.bb.if_join1:
  %.t13 = sub i64 %deadline_ms_1, %.t6
  ret i64 %.t13
.bb.if_then1:
  %.t10 = add i64 0, 0
  ret i64 %.t10
.bb.if_then:
  %.t5 = add i64 0, 0
  ret i64 %.t5
}
define %Variant_std_2Ecore_Result_a482b0d00941967a @"std.net::accept"(ptr %self_1, %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %timeout_1) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str144, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t2 = call i64 @drift_thread_current()
  %.t3 = add i64 0, 0
  %.t4 = icmp eq i64 %.t2, %.t3
  br i1 %.t4, label %.bb.if_then, label %.bb.if_join
.bb.if_join:
  %.t10 = call i64 @"std.net::_deadline_from_timeout"(%Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %timeout_1)
  br label %.bb.loop_header
.bb.loop_header:
  br label %.bb.loop_body
.bb.loop_body:
  %.t12 = load %Struct_std_2Enet_TcpListener_7d3d9b3ee7d65cad, ptr %self_1
  %.t13 = extractvalue %Struct_std_2Enet_TcpListener_7d3d9b3ee7d65cad %.t12, 0
  %.t14 = call i64 @drift_net_accept(i64 %.t13)
  %.t16 = add i64 0, 0
  %.t17 = icmp sge i64 %.t14, %.t16
  br i1 %.t17, label %.bb.if_then1, label %.bb.if_join1
.bb.if_join1:
  %.t21 = call i64 @drift_io_errno()
  %.t23 = add i64 0, 4
  %.t24 = icmp eq i64 %.t21, %.t23
  br i1 %.t24, label %.bb.if_then2, label %.bb.if_join2
.bb.if_join2:
  %.t26 = add i64 0, 11
  %.t27 = icmp eq i64 %.t21, %.t26
  br i1 %.t27, label %.bb.if_then3, label %.bb.if_join3
.bb.if_join3:
  %strptr3 = getelementptr inbounds { i64, i64, [6 x i8] }, ptr @.str145, i32 0, i32 2, i32 0
  %str04 = insertvalue %DriftString zeroinitializer, i64 5, 0
  %.t49 = insertvalue %DriftString %str04, ptr %strptr3, 1
  %struct5 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString %.t49, 0
  %.t51 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %struct5, i64 %.t21, 1
  %variant6 = alloca %Variant_std_2Ecore_Result_a482b0d00941967a
  store %Variant_std_2Ecore_Result_a482b0d00941967a zeroinitializer, ptr %variant6
  %tagptr7 = getelementptr inbounds %Variant_std_2Ecore_Result_a482b0d00941967a, ptr %variant6, i32 0, i32 0
  store i8 1, ptr %tagptr7
  %payload_words8 = getelementptr inbounds %Variant_std_2Ecore_Result_a482b0d00941967a, ptr %variant6, i32 0, i32 2
  %fieldptr9 = getelementptr inbounds { %Struct_std_2Enet_NetError_203564604ea2d3a4 }, ptr %payload_words8, i32 0, i32 0
  store %Struct_std_2Enet_NetError_203564604ea2d3a4 %.t51, ptr %fieldptr9
  %.t52 = load %Variant_std_2Ecore_Result_a482b0d00941967a, ptr %variant6
  ret %Variant_std_2Ecore_Result_a482b0d00941967a %.t52
.bb.if_then3:
  %.t29 = add i64 0, 0
  %.t30 = icmp sle i64 %.t10, %.t29
  br i1 %.t30, label %.bb.if_then4, label %.bb.if_join4
.bb.if_join4:
  %.t36 = call i64 @"std.net::_remaining_ms"(i64 %.t10)
  %.t38 = add i64 0, 0
  %.t39 = icmp sle i64 %.t36, %.t38
  br i1 %.t39, label %.bb.if_then5, label %.bb.if_join5
.bb.if_join5:
  %.t45 = load %Struct_std_2Enet_TcpListener_7d3d9b3ee7d65cad, ptr %self_1
  %.t46 = extractvalue %Struct_std_2Enet_TcpListener_7d3d9b3ee7d65cad %.t45, 0
  %.t47 = add i64 0, 1
  call void @"std.net::_block_on_io"(i64 %.t46, i64 %.t47, i64 %.t10)
  br label %.bb.loop_header
.bb.if_then5:
  %strptr10 = getelementptr inbounds { i64, i64, [12 x i8] }, ptr @.str146, i32 0, i32 2, i32 0
  %str011 = insertvalue %DriftString zeroinitializer, i64 11, 0
  %.t40 = insertvalue %DriftString %str011, ptr %strptr10, 1
  %.t41 = add i64 0, 0
  %struct12 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString %.t40, 0
  %.t42 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %struct12, i64 %.t41, 1
  %variant13 = alloca %Variant_std_2Ecore_Result_a482b0d00941967a
  store %Variant_std_2Ecore_Result_a482b0d00941967a zeroinitializer, ptr %variant13
  %tagptr14 = getelementptr inbounds %Variant_std_2Ecore_Result_a482b0d00941967a, ptr %variant13, i32 0, i32 0
  store i8 1, ptr %tagptr14
  %payload_words15 = getelementptr inbounds %Variant_std_2Ecore_Result_a482b0d00941967a, ptr %variant13, i32 0, i32 2
  %fieldptr16 = getelementptr inbounds { %Struct_std_2Enet_NetError_203564604ea2d3a4 }, ptr %payload_words15, i32 0, i32 0
  store %Struct_std_2Enet_NetError_203564604ea2d3a4 %.t42, ptr %fieldptr16
  %.t43 = load %Variant_std_2Ecore_Result_a482b0d00941967a, ptr %variant13
  ret %Variant_std_2Ecore_Result_a482b0d00941967a %.t43
.bb.if_then4:
  %strptr17 = getelementptr inbounds { i64, i64, [12 x i8] }, ptr @.str147, i32 0, i32 2, i32 0
  %str018 = insertvalue %DriftString zeroinitializer, i64 11, 0
  %.t31 = insertvalue %DriftString %str018, ptr %strptr17, 1
  %.t32 = add i64 0, 0
  %struct19 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString %.t31, 0
  %.t33 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %struct19, i64 %.t32, 1
  %variant20 = alloca %Variant_std_2Ecore_Result_a482b0d00941967a
  store %Variant_std_2Ecore_Result_a482b0d00941967a zeroinitializer, ptr %variant20
  %tagptr21 = getelementptr inbounds %Variant_std_2Ecore_Result_a482b0d00941967a, ptr %variant20, i32 0, i32 0
  store i8 1, ptr %tagptr21
  %payload_words22 = getelementptr inbounds %Variant_std_2Ecore_Result_a482b0d00941967a, ptr %variant20, i32 0, i32 2
  %fieldptr23 = getelementptr inbounds { %Struct_std_2Enet_NetError_203564604ea2d3a4 }, ptr %payload_words22, i32 0, i32 0
  store %Struct_std_2Enet_NetError_203564604ea2d3a4 %.t33, ptr %fieldptr23
  %.t34 = load %Variant_std_2Ecore_Result_a482b0d00941967a, ptr %variant20
  ret %Variant_std_2Ecore_Result_a482b0d00941967a %.t34
.bb.if_then2:
  br label %.bb.loop_header
.bb.if_then1:
  %.t19 = insertvalue %Struct_std_2Enet_TcpStream_363317ef680a1400 zeroinitializer, i64 %.t14, 0
  %variant24 = alloca %Variant_std_2Ecore_Result_a482b0d00941967a
  store %Variant_std_2Ecore_Result_a482b0d00941967a zeroinitializer, ptr %variant24
  %tagptr25 = getelementptr inbounds %Variant_std_2Ecore_Result_a482b0d00941967a, ptr %variant24, i32 0, i32 0
  store i8 0, ptr %tagptr25
  %payload_words26 = getelementptr inbounds %Variant_std_2Ecore_Result_a482b0d00941967a, ptr %variant24, i32 0, i32 2
  %fieldptr27 = getelementptr inbounds { %Struct_std_2Enet_TcpStream_363317ef680a1400 }, ptr %payload_words26, i32 0, i32 0
  store %Struct_std_2Enet_TcpStream_363317ef680a1400 %.t19, ptr %fieldptr27
  %.t20 = load %Variant_std_2Ecore_Result_a482b0d00941967a, ptr %variant24
  ret %Variant_std_2Ecore_Result_a482b0d00941967a %.t20
.bb.if_then:
  %strptr28 = getelementptr inbounds { i64, i64, [17 x i8] }, ptr @.str148, i32 0, i32 2, i32 0
  %str029 = insertvalue %DriftString zeroinitializer, i64 16, 0
  %.t5 = insertvalue %DriftString %str029, ptr %strptr28, 1
  %.t6 = add i64 0, 0
  %struct30 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString %.t5, 0
  %.t7 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %struct30, i64 %.t6, 1
  %variant31 = alloca %Variant_std_2Ecore_Result_a482b0d00941967a
  store %Variant_std_2Ecore_Result_a482b0d00941967a zeroinitializer, ptr %variant31
  %tagptr32 = getelementptr inbounds %Variant_std_2Ecore_Result_a482b0d00941967a, ptr %variant31, i32 0, i32 0
  store i8 1, ptr %tagptr32
  %payload_words33 = getelementptr inbounds %Variant_std_2Ecore_Result_a482b0d00941967a, ptr %variant31, i32 0, i32 2
  %fieldptr34 = getelementptr inbounds { %Struct_std_2Enet_NetError_203564604ea2d3a4 }, ptr %payload_words33, i32 0, i32 0
  store %Struct_std_2Enet_NetError_203564604ea2d3a4 %.t7, ptr %fieldptr34
  %.t8 = load %Variant_std_2Ecore_Result_a482b0d00941967a, ptr %variant31
  ret %Variant_std_2Ecore_Result_a482b0d00941967a %.t8
}
define %Variant_std_2Ecore_Result_a482b0d00941967a @"std.net::connect"(ptr %addr, %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %timeout_1) {
.bb.entry:
  %addr__addr = alloca ptr
  store ptr %addr, ptr %addr__addr
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str149, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t2 = call i64 @drift_thread_current()
  %.t3 = add i64 0, 0
  %.t4 = icmp eq i64 %.t2, %.t3
  br i1 %.t4, label %.bb.if_then, label %.bb.if_join
.bb.if_join:
  %.t10 = call i64 @"std.net::_deadline_from_timeout"(%Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %timeout_1)
  br label %.bb.loop_header
.bb.loop_header:
  br label %.bb.loop_body
.bb.loop_body:
  %.t12 = load ptr, ptr %addr__addr
  %.t13 = getelementptr inbounds %Struct_std_2Enet_SocketAddr_461bcf04e30af211, ptr %.t12, i32 0, i32 0
  %.t14 = load ptr, ptr %addr__addr
  %.t15 = load %Struct_std_2Enet_SocketAddr_461bcf04e30af211, ptr %.t14
  %.t16 = extractvalue %Struct_std_2Enet_SocketAddr_461bcf04e30af211 %.t15, 1
  %.t18 = call i64 @drift_net_connect(ptr %.t13, i64 %.t16, i64 %.t10)
  %.t20 = add i64 0, 0
  %.t21 = icmp sge i64 %.t18, %.t20
  br i1 %.t21, label %.bb.if_then1, label %.bb.if_join1
.bb.if_join1:
  %.t25 = call i64 @drift_io_errno()
  %.t27 = add i64 0, 4
  %.t28 = icmp eq i64 %.t25, %.t27
  br i1 %.t28, label %.bb.if_then2, label %.bb.if_join2
.bb.if_join2:
  %.t30 = add i64 0, 11
  %.t31 = icmp eq i64 %.t25, %.t30
  br i1 %.t31, label %.bb.if_then3, label %.bb.if_join3
.bb.if_join3:
  %strptr3 = getelementptr inbounds { i64, i64, [6 x i8] }, ptr @.str150, i32 0, i32 2, i32 0
  %str04 = insertvalue %DriftString zeroinitializer, i64 5, 0
  %.t48 = insertvalue %DriftString %str04, ptr %strptr3, 1
  %struct5 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString %.t48, 0
  %.t50 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %struct5, i64 %.t25, 1
  %variant6 = alloca %Variant_std_2Ecore_Result_a482b0d00941967a
  store %Variant_std_2Ecore_Result_a482b0d00941967a zeroinitializer, ptr %variant6
  %tagptr7 = getelementptr inbounds %Variant_std_2Ecore_Result_a482b0d00941967a, ptr %variant6, i32 0, i32 0
  store i8 1, ptr %tagptr7
  %payload_words8 = getelementptr inbounds %Variant_std_2Ecore_Result_a482b0d00941967a, ptr %variant6, i32 0, i32 2
  %fieldptr9 = getelementptr inbounds { %Struct_std_2Enet_NetError_203564604ea2d3a4 }, ptr %payload_words8, i32 0, i32 0
  store %Struct_std_2Enet_NetError_203564604ea2d3a4 %.t50, ptr %fieldptr9
  %.t51 = load %Variant_std_2Ecore_Result_a482b0d00941967a, ptr %variant6
  ret %Variant_std_2Ecore_Result_a482b0d00941967a %.t51
.bb.if_then3:
  %.t33 = add i64 0, 0
  %.t34 = icmp sle i64 %.t10, %.t33
  br i1 %.t34, label %.bb.if_then4, label %.bb.if_join4
.bb.if_join4:
  %.t40 = call i64 @"std.net::_remaining_ms"(i64 %.t10)
  %.t42 = add i64 0, 0
  %.t43 = icmp sle i64 %.t40, %.t42
  br i1 %.t43, label %.bb.if_then5, label %.bb.if_join5
.bb.if_join5:
  call void @drift_thread_yield()
  br label %.bb.loop_header
.bb.if_then5:
  %strptr10 = getelementptr inbounds { i64, i64, [12 x i8] }, ptr @.str151, i32 0, i32 2, i32 0
  %str011 = insertvalue %DriftString zeroinitializer, i64 11, 0
  %.t44 = insertvalue %DriftString %str011, ptr %strptr10, 1
  %.t45 = add i64 0, 0
  %struct12 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString %.t44, 0
  %.t46 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %struct12, i64 %.t45, 1
  %variant13 = alloca %Variant_std_2Ecore_Result_a482b0d00941967a
  store %Variant_std_2Ecore_Result_a482b0d00941967a zeroinitializer, ptr %variant13
  %tagptr14 = getelementptr inbounds %Variant_std_2Ecore_Result_a482b0d00941967a, ptr %variant13, i32 0, i32 0
  store i8 1, ptr %tagptr14
  %payload_words15 = getelementptr inbounds %Variant_std_2Ecore_Result_a482b0d00941967a, ptr %variant13, i32 0, i32 2
  %fieldptr16 = getelementptr inbounds { %Struct_std_2Enet_NetError_203564604ea2d3a4 }, ptr %payload_words15, i32 0, i32 0
  store %Struct_std_2Enet_NetError_203564604ea2d3a4 %.t46, ptr %fieldptr16
  %.t47 = load %Variant_std_2Ecore_Result_a482b0d00941967a, ptr %variant13
  ret %Variant_std_2Ecore_Result_a482b0d00941967a %.t47
.bb.if_then4:
  %strptr17 = getelementptr inbounds { i64, i64, [12 x i8] }, ptr @.str152, i32 0, i32 2, i32 0
  %str018 = insertvalue %DriftString zeroinitializer, i64 11, 0
  %.t35 = insertvalue %DriftString %str018, ptr %strptr17, 1
  %.t36 = add i64 0, 0
  %struct19 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString %.t35, 0
  %.t37 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %struct19, i64 %.t36, 1
  %variant20 = alloca %Variant_std_2Ecore_Result_a482b0d00941967a
  store %Variant_std_2Ecore_Result_a482b0d00941967a zeroinitializer, ptr %variant20
  %tagptr21 = getelementptr inbounds %Variant_std_2Ecore_Result_a482b0d00941967a, ptr %variant20, i32 0, i32 0
  store i8 1, ptr %tagptr21
  %payload_words22 = getelementptr inbounds %Variant_std_2Ecore_Result_a482b0d00941967a, ptr %variant20, i32 0, i32 2
  %fieldptr23 = getelementptr inbounds { %Struct_std_2Enet_NetError_203564604ea2d3a4 }, ptr %payload_words22, i32 0, i32 0
  store %Struct_std_2Enet_NetError_203564604ea2d3a4 %.t37, ptr %fieldptr23
  %.t38 = load %Variant_std_2Ecore_Result_a482b0d00941967a, ptr %variant20
  ret %Variant_std_2Ecore_Result_a482b0d00941967a %.t38
.bb.if_then2:
  br label %.bb.loop_header
.bb.if_then1:
  %.t23 = insertvalue %Struct_std_2Enet_TcpStream_363317ef680a1400 zeroinitializer, i64 %.t18, 0
  %variant24 = alloca %Variant_std_2Ecore_Result_a482b0d00941967a
  store %Variant_std_2Ecore_Result_a482b0d00941967a zeroinitializer, ptr %variant24
  %tagptr25 = getelementptr inbounds %Variant_std_2Ecore_Result_a482b0d00941967a, ptr %variant24, i32 0, i32 0
  store i8 0, ptr %tagptr25
  %payload_words26 = getelementptr inbounds %Variant_std_2Ecore_Result_a482b0d00941967a, ptr %variant24, i32 0, i32 2
  %fieldptr27 = getelementptr inbounds { %Struct_std_2Enet_TcpStream_363317ef680a1400 }, ptr %payload_words26, i32 0, i32 0
  store %Struct_std_2Enet_TcpStream_363317ef680a1400 %.t23, ptr %fieldptr27
  %.t24 = load %Variant_std_2Ecore_Result_a482b0d00941967a, ptr %variant24
  ret %Variant_std_2Ecore_Result_a482b0d00941967a %.t24
.bb.if_then:
  %strptr28 = getelementptr inbounds { i64, i64, [17 x i8] }, ptr @.str153, i32 0, i32 2, i32 0
  %str029 = insertvalue %DriftString zeroinitializer, i64 16, 0
  %.t5 = insertvalue %DriftString %str029, ptr %strptr28, 1
  %.t6 = add i64 0, 0
  %struct30 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString %.t5, 0
  %.t7 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %struct30, i64 %.t6, 1
  %variant31 = alloca %Variant_std_2Ecore_Result_a482b0d00941967a
  store %Variant_std_2Ecore_Result_a482b0d00941967a zeroinitializer, ptr %variant31
  %tagptr32 = getelementptr inbounds %Variant_std_2Ecore_Result_a482b0d00941967a, ptr %variant31, i32 0, i32 0
  store i8 1, ptr %tagptr32
  %payload_words33 = getelementptr inbounds %Variant_std_2Ecore_Result_a482b0d00941967a, ptr %variant31, i32 0, i32 2
  %fieldptr34 = getelementptr inbounds { %Struct_std_2Enet_NetError_203564604ea2d3a4 }, ptr %payload_words33, i32 0, i32 0
  store %Struct_std_2Enet_NetError_203564604ea2d3a4 %.t7, ptr %fieldptr34
  %.t8 = load %Variant_std_2Ecore_Result_a482b0d00941967a, ptr %variant31
  ret %Variant_std_2Ecore_Result_a482b0d00941967a %.t8
}
define %Variant_std_2Ecore_Result_f9949363b6b29c23 @"std.net::listen"(ptr %addr, %Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %timeout_1) {
.bb.entry:
  %addr__addr = alloca ptr
  store ptr %addr, ptr %addr__addr
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str154, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = call i64 @"std.net::_deadline_from_timeout"(%Struct_std_2Econcurrent_Duration_0e0d63ae01c6ed42 %timeout_1)
  br label %.bb.loop_header
.bb.loop_header:
  br label %.bb.loop_body
.bb.loop_body:
  %.t5 = load ptr, ptr %addr__addr
  %.t6 = getelementptr inbounds %Struct_std_2Enet_SocketAddr_461bcf04e30af211, ptr %.t5, i32 0, i32 0
  %.t7 = load ptr, ptr %addr__addr
  %.t8 = load %Struct_std_2Enet_SocketAddr_461bcf04e30af211, ptr %.t7
  %.t9 = extractvalue %Struct_std_2Enet_SocketAddr_461bcf04e30af211 %.t8, 1
  %.t10 = call i64 @drift_net_listen(ptr %.t6, i64 %.t9)
  %.t12 = add i64 0, 0
  %.t13 = icmp sge i64 %.t10, %.t12
  br i1 %.t13, label %.bb.if_then, label %.bb.if_join
.bb.if_join:
  %.t17 = call i64 @drift_io_errno()
  %.t19 = add i64 0, 4
  %.t20 = icmp eq i64 %.t17, %.t19
  br i1 %.t20, label %.bb.if_then1, label %.bb.if_join1
.bb.if_join1:
  %.t22 = add i64 0, 11
  %.t23 = icmp eq i64 %.t17, %.t22
  br i1 %.t23, label %.bb.if_then2, label %.bb.if_join2
.bb.if_join2:
  %strptr3 = getelementptr inbounds { i64, i64, [6 x i8] }, ptr @.str155, i32 0, i32 2, i32 0
  %str04 = insertvalue %DriftString zeroinitializer, i64 5, 0
  %.t41 = insertvalue %DriftString %str04, ptr %strptr3, 1
  %struct5 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString %.t41, 0
  %.t43 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %struct5, i64 %.t17, 1
  %variant6 = alloca %Variant_std_2Ecore_Result_f9949363b6b29c23
  store %Variant_std_2Ecore_Result_f9949363b6b29c23 zeroinitializer, ptr %variant6
  %tagptr7 = getelementptr inbounds %Variant_std_2Ecore_Result_f9949363b6b29c23, ptr %variant6, i32 0, i32 0
  store i8 1, ptr %tagptr7
  %payload_words8 = getelementptr inbounds %Variant_std_2Ecore_Result_f9949363b6b29c23, ptr %variant6, i32 0, i32 2
  %fieldptr9 = getelementptr inbounds { %Struct_std_2Enet_NetError_203564604ea2d3a4 }, ptr %payload_words8, i32 0, i32 0
  store %Struct_std_2Enet_NetError_203564604ea2d3a4 %.t43, ptr %fieldptr9
  %.t44 = load %Variant_std_2Ecore_Result_f9949363b6b29c23, ptr %variant6
  ret %Variant_std_2Ecore_Result_f9949363b6b29c23 %.t44
.bb.if_then2:
  %.t25 = add i64 0, 0
  %.t26 = icmp sle i64 %.t3, %.t25
  br i1 %.t26, label %.bb.if_then3, label %.bb.if_join3
.bb.if_join3:
  %.t32 = call i64 @"std.net::_remaining_ms"(i64 %.t3)
  %.t34 = add i64 0, 0
  %.t35 = icmp sle i64 %.t32, %.t34
  br i1 %.t35, label %.bb.if_then4, label %.bb.if_join4
.bb.if_join4:
  call void @"std.net::_park_main_thread_io"(i64 %.t32)
  br label %.bb.loop_header
.bb.if_then4:
  %strptr10 = getelementptr inbounds { i64, i64, [12 x i8] }, ptr @.str156, i32 0, i32 2, i32 0
  %str011 = insertvalue %DriftString zeroinitializer, i64 11, 0
  %.t36 = insertvalue %DriftString %str011, ptr %strptr10, 1
  %.t37 = add i64 0, 0
  %struct12 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString %.t36, 0
  %.t38 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %struct12, i64 %.t37, 1
  %variant13 = alloca %Variant_std_2Ecore_Result_f9949363b6b29c23
  store %Variant_std_2Ecore_Result_f9949363b6b29c23 zeroinitializer, ptr %variant13
  %tagptr14 = getelementptr inbounds %Variant_std_2Ecore_Result_f9949363b6b29c23, ptr %variant13, i32 0, i32 0
  store i8 1, ptr %tagptr14
  %payload_words15 = getelementptr inbounds %Variant_std_2Ecore_Result_f9949363b6b29c23, ptr %variant13, i32 0, i32 2
  %fieldptr16 = getelementptr inbounds { %Struct_std_2Enet_NetError_203564604ea2d3a4 }, ptr %payload_words15, i32 0, i32 0
  store %Struct_std_2Enet_NetError_203564604ea2d3a4 %.t38, ptr %fieldptr16
  %.t39 = load %Variant_std_2Ecore_Result_f9949363b6b29c23, ptr %variant13
  ret %Variant_std_2Ecore_Result_f9949363b6b29c23 %.t39
.bb.if_then3:
  %strptr17 = getelementptr inbounds { i64, i64, [12 x i8] }, ptr @.str157, i32 0, i32 2, i32 0
  %str018 = insertvalue %DriftString zeroinitializer, i64 11, 0
  %.t27 = insertvalue %DriftString %str018, ptr %strptr17, 1
  %.t28 = add i64 0, 0
  %struct19 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 zeroinitializer, %DriftString %.t27, 0
  %.t29 = insertvalue %Struct_std_2Enet_NetError_203564604ea2d3a4 %struct19, i64 %.t28, 1
  %variant20 = alloca %Variant_std_2Ecore_Result_f9949363b6b29c23
  store %Variant_std_2Ecore_Result_f9949363b6b29c23 zeroinitializer, ptr %variant20
  %tagptr21 = getelementptr inbounds %Variant_std_2Ecore_Result_f9949363b6b29c23, ptr %variant20, i32 0, i32 0
  store i8 1, ptr %tagptr21
  %payload_words22 = getelementptr inbounds %Variant_std_2Ecore_Result_f9949363b6b29c23, ptr %variant20, i32 0, i32 2
  %fieldptr23 = getelementptr inbounds { %Struct_std_2Enet_NetError_203564604ea2d3a4 }, ptr %payload_words22, i32 0, i32 0
  store %Struct_std_2Enet_NetError_203564604ea2d3a4 %.t29, ptr %fieldptr23
  %.t30 = load %Variant_std_2Ecore_Result_f9949363b6b29c23, ptr %variant20
  ret %Variant_std_2Ecore_Result_f9949363b6b29c23 %.t30
.bb.if_then1:
  br label %.bb.loop_header
.bb.if_then:
  %.t15 = insertvalue %Struct_std_2Enet_TcpListener_7d3d9b3ee7d65cad zeroinitializer, i64 %.t10, 0
  %variant24 = alloca %Variant_std_2Ecore_Result_f9949363b6b29c23
  store %Variant_std_2Ecore_Result_f9949363b6b29c23 zeroinitializer, ptr %variant24
  %tagptr25 = getelementptr inbounds %Variant_std_2Ecore_Result_f9949363b6b29c23, ptr %variant24, i32 0, i32 0
  store i8 0, ptr %tagptr25
  %payload_words26 = getelementptr inbounds %Variant_std_2Ecore_Result_f9949363b6b29c23, ptr %variant24, i32 0, i32 2
  %fieldptr27 = getelementptr inbounds { %Struct_std_2Enet_TcpListener_7d3d9b3ee7d65cad }, ptr %payload_words26, i32 0, i32 0
  store %Struct_std_2Enet_TcpListener_7d3d9b3ee7d65cad %.t15, ptr %fieldptr27
  %.t16 = load %Variant_std_2Ecore_Result_f9949363b6b29c23, ptr %variant24
  ret %Variant_std_2Ecore_Result_f9949363b6b29c23 %.t16
}
define %Struct_std_2Enet_SocketAddr_461bcf04e30af211 @"std.net::socket_addr"(%DriftString %ip, i64 %port) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str158, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %__arc1 = call %DriftString @drift_string_retain(%DriftString %ip)
  %struct3 = insertvalue %Struct_std_2Enet_SocketAddr_461bcf04e30af211 zeroinitializer, %DriftString %__arc1, 0
  %.t4 = insertvalue %Struct_std_2Enet_SocketAddr_461bcf04e30af211 %struct3, i64 %port, 1
  %zero_str4 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %__arc3 = insertvalue %DriftString %zero_str4, ptr null, 1
  call void @drift_string_release(%DriftString %ip)
  ret %Struct_std_2Enet_SocketAddr_461bcf04e30af211 %.t4
}
define i1 @"std.runtime::GlobalRegistry::contains_type"(ptr %self, i64 %type_tag) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str159, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t4 = call i64 @drift_runtime_registry_contains(i64 %type_tag)
  %.t5 = add i64 0, 1
  %.t6 = icmp eq i64 %.t4, %.t5
  ret i1 %.t6
}
define ptr @"std.runtime::global_registry"() {
.bb.entry:
  %raw__addr = alloca %Struct_std_2Emem_RawBuffer_eb7c8c85e66bfc2f
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str160, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t2 = call ptr @drift_runtime_global_registry_ptr()
  %.t4 = add i64 0, 1
  %struct3 = insertvalue %Struct_std_2Emem_RawBuffer_eb7c8c85e66bfc2f zeroinitializer, ptr %.t2, 0
  %.t5 = insertvalue %Struct_std_2Emem_RawBuffer_eb7c8c85e66bfc2f %struct3, i64 %.t4, 1
  store %Struct_std_2Emem_RawBuffer_eb7c8c85e66bfc2f %.t5, ptr %raw__addr
  %.t7 = add i64 0, 0
  %rawbuf4 = load %Struct_std_2Emem_RawBuffer_eb7c8c85e66bfc2f, ptr %raw__addr
  %rawptr5 = extractvalue %Struct_std_2Emem_RawBuffer_eb7c8c85e66bfc2f %rawbuf4, 0
  %rawcap6 = extractvalue %Struct_std_2Emem_RawBuffer_eb7c8c85e66bfc2f %rawbuf4, 1
  %strptr7 = getelementptr inbounds { i64, i64, [18 x i8] }, ptr @.str17, i32 0, i32 2, i32 0
  %str08 = insertvalue %DriftString zeroinitializer, i64 17, 0
  %str9 = insertvalue %DriftString %str08, ptr %strptr7, 1
  call void @drift_bounds_check(%DriftString %str9, i64 %.t7, i64 %rawcap6)
  %.t8 = getelementptr %Struct_std_2Eruntime_GlobalRegistry_4806c2e3110dbbee, ptr %rawptr5, i64 %.t7
  ret ptr %.t8
}
define i1 @"std.sync::AtomicBool::load"(ptr %self, %Variant_lang_2Eatomic_MemoryOrder_469abe0ace4b6a6f %order) {
.bb.entry:
  %self__addr = alloca ptr
  store ptr %self, ptr %self__addr
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str161, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = load ptr, ptr %self__addr
  %.t4 = getelementptr inbounds %Struct_std_2Esync_AtomicBool_881cc492ae8213fb, ptr %.t3, i32 0, i32 0
  %.t6 = call i1 @"lang.atomic::AtomicBool::load"(ptr %.t4, %Variant_lang_2Eatomic_MemoryOrder_469abe0ace4b6a6f %order)
  ret i1 %.t6
}
define void @"std.sync::AtomicBool::store"(ptr %self, i1 %v, %Variant_lang_2Eatomic_MemoryOrder_469abe0ace4b6a6f %order) {
.bb.entry:
  %self__addr = alloca ptr
  store ptr %self, ptr %self__addr
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str162, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = load ptr, ptr %self__addr
  %.t4 = getelementptr inbounds %Struct_std_2Esync_AtomicBool_881cc492ae8213fb, ptr %.t3, i32 0, i32 0
  call void @"lang.atomic::AtomicBool::store"(ptr %.t4, i1 %v, %Variant_lang_2Eatomic_MemoryOrder_469abe0ace4b6a6f %order)
  ret void
}
define %Struct_std_2Esync_AtomicBool_881cc492ae8213fb @"std.sync::atomic_bool"(i1 %v) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str163, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = call %Struct_lang_2Eatomic_AtomicBool_4466cda2157b83d3 @"lang.atomic::atomic_bool"(i1 %v)
  %.t4 = insertvalue %Struct_std_2Esync_AtomicBool_881cc492ae8213fb zeroinitializer, %Struct_lang_2Eatomic_AtomicBool_4466cda2157b83d3 %.t3, 0
  ret %Struct_std_2Esync_AtomicBool_881cc492ae8213fb %.t4
}
define linkonce_odr void @"std.concurrent::ResultState<T>::std.core.Destructible::destroy__inst__d85c418601eb1d2e"(%Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79 %self) comdat {
.bb.entry:
  %self__addr = alloca %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79
  store %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79 %self, ptr %self__addr
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str164, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t2 = load %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79, ptr %self__addr
  %field83 = extractvalue %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79 %.t2, 1
  %.t3 = icmp ne i8 %field83, 0
  br i1 %.t3, label %.bb.if_then, label %.bb.if_join
.bb.if_then:
  %.t5 = getelementptr inbounds %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79, ptr %self__addr, i32 0, i32 0
  %.t6 = add i64 0, 0
  %rawbuf4 = load %Struct_std_2Emem_RawBuffer_d10426ae10844bad, ptr %.t5
  %rawptr5 = extractvalue %Struct_std_2Emem_RawBuffer_d10426ae10844bad %rawbuf4, 0
  %rawcap6 = extractvalue %Struct_std_2Emem_RawBuffer_d10426ae10844bad %rawbuf4, 1
  %strptr7 = getelementptr inbounds { i64, i64, [18 x i8] }, ptr @.str17, i32 0, i32 2, i32 0
  %str08 = insertvalue %DriftString zeroinitializer, i64 17, 0
  %str9 = insertvalue %DriftString %str08, ptr %strptr7, 1
  call void @drift_bounds_check(%DriftString %str9, i64 %.t6, i64 %rawcap6)
  %rawgep10 = getelementptr i64, ptr %rawptr5, i64 %.t6
  %.t7 = load i64, ptr %rawgep10
  %__arc2 = add i64 0, 0
  br label %.bb.if_join
.bb.if_join:
  %.t10 = getelementptr inbounds %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79, ptr %self__addr, i32 0, i32 0
  %.t11 = load %Struct_std_2Emem_RawBuffer_d10426ae10844bad, ptr %.t10
  %.t12 = extractvalue %Struct_std_2Emem_RawBuffer_d10426ae10844bad %.t11, 0
  %.t14 = getelementptr inbounds %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79, ptr %self__addr, i32 0, i32 0
  %.t15 = load %Struct_std_2Emem_RawBuffer_d10426ae10844bad, ptr %.t14
  %.t16 = extractvalue %Struct_std_2Emem_RawBuffer_d10426ae10844bad %.t15, 1
  %struct11 = insertvalue %Struct_std_2Emem_RawBuffer_d10426ae10844bad zeroinitializer, ptr %.t12, 0
  %.t19 = insertvalue %Struct_std_2Emem_RawBuffer_d10426ae10844bad %struct11, i64 %.t16, 1
  %rawptr12 = extractvalue %Struct_std_2Emem_RawBuffer_d10426ae10844bad %.t19, 0
  call void @drift_free_array(ptr %rawptr12)
  %__cleanup_t1 = load %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79, ptr %self__addr
  %zero_struct13 = insertvalue %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79 zeroinitializer, %Struct_std_2Emem_RawBuffer_d10426ae10844bad zeroinitializer, 0
  %zero_struct14 = insertvalue %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79 %zero_struct13, i8 0, 1
  %__arc1 = insertvalue %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79 %zero_struct14, i8 0, 2
  store %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79 %__arc1, ptr %self__addr
  ret void
}
define linkonce_odr void @"std.concurrent::VirtualThread<T>::std.core.Destructible::destroy__inst__226883066d11622f"(%Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %self) comdat {
.bb.entry:
  %self__addr = alloca %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0
  store %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %self, ptr %self__addr
  %guard__addr = alloca %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b
  %rs__addr = alloca ptr
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str165, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t2 = load %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0, ptr %self__addr
  %field83 = extractvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %.t2, 0
  %.t3 = icmp ne i8 %field83, 0
  br i1 %.t3, label %.bb.if_then, label %.bb.if_join
.bb.if_join:
  %.t5 = getelementptr inbounds %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0, ptr %self__addr, i32 0, i32 2
  %.t6 = call ptr @"std.core.arc::_arc_get_impl__inst__8fb0d984495d10c9"(ptr %.t5)
  %.t7 = call %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b @"std.concurrent::Mutex<T>::lock__inst__2026c6e8047a5d49"(ptr %.t6)
  store %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b %.t7, ptr %guard__addr
  %.t9 = call ptr @"std.concurrent::MutexGuard<T>::get_mut__inst__8bbc1086c0f79eaa"(ptr %guard__addr)
  store ptr %.t9, ptr %rs__addr
  %.t10 = add i1 0, 1
  %.t12 = load ptr, ptr %rs__addr
  %.t13 = getelementptr inbounds %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79, ptr %.t12, i32 0, i32 2
  %bool84 = zext i1 %.t10 to i8
  store i8 %bool84, ptr %.t13
  %.t14 = load ptr, ptr %rs__addr
  %.t15 = load %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79, ptr %.t14
  %field85 = extractvalue %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79 %.t15, 1
  %.t16 = icmp ne i8 %field85, 0
  br i1 %.t16, label %.bb.if_then1, label %.bb.if_join1
.bb.if_then1:
  %.t18 = load ptr, ptr %rs__addr
  %.t19 = getelementptr inbounds %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79, ptr %.t18, i32 0, i32 0
  %.t20 = add i64 0, 0
  %rawbuf6 = load %Struct_std_2Emem_RawBuffer_d10426ae10844bad, ptr %.t19
  %rawptr7 = extractvalue %Struct_std_2Emem_RawBuffer_d10426ae10844bad %rawbuf6, 0
  %rawcap8 = extractvalue %Struct_std_2Emem_RawBuffer_d10426ae10844bad %rawbuf6, 1
  %strptr9 = getelementptr inbounds { i64, i64, [18 x i8] }, ptr @.str17, i32 0, i32 2, i32 0
  %str010 = insertvalue %DriftString zeroinitializer, i64 17, 0
  %str11 = insertvalue %DriftString %str010, ptr %strptr9, 1
  call void @drift_bounds_check(%DriftString %str11, i64 %.t20, i64 %rawcap8)
  %rawgep12 = getelementptr i64, ptr %rawptr7, i64 %.t20
  %.t21 = load i64, ptr %rawgep12
  %__arc4 = add i64 0, 0
  %.t23 = add i1 0, 0
  %.t25 = load ptr, ptr %rs__addr
  %.t26 = getelementptr inbounds %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79, ptr %.t25, i32 0, i32 1
  %bool813 = zext i1 %.t23 to i8
  store i8 %bool813, ptr %.t26
  br label %.bb.if_join1
.bb.if_join1:
  %__cleanup_t2 = load %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b, ptr %guard__addr
  %zero_struct14 = insertvalue %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b zeroinitializer, ptr null, 0
  %zero_struct15 = insertvalue %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b %zero_struct14, ptr null, 1
  %__arc1 = insertvalue %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b %zero_struct15, i8 0, 2
  store %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b %__arc1, ptr %guard__addr
  call void @"std.concurrent::MutexGuard<T>::std.core.Destructible::destroy__inst__690dc3eee478c1e7"(%Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b %__cleanup_t2)
  %.t27 = load %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0, ptr %self__addr
  %.t28 = extractvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %.t27, 1
  %.t29 = add i64 0, 0
  %.t30 = icmp ne i64 %.t28, %.t29
  br i1 %.t30, label %.bb.if_then2, label %.bb.if_join2
.bb.if_then2:
  %.t31 = load %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0, ptr %self__addr
  %.t32 = extractvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %.t31, 1
  call void @drift_thread_drop(i64 %.t32)
  br label %.bb.if_join2
.bb.if_join2:
  %__cleanup_t3 = load %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0, ptr %self__addr
  %zero_struct16 = insertvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 zeroinitializer, i8 0, 0
  %zero_struct17 = insertvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %zero_struct16, i64 0, 1
  %zero_struct18 = insertvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %zero_struct17, %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb zeroinitializer, 2
  %zero_struct19 = insertvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %zero_struct18, i8 0, 3
  %__arc2 = insertvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %zero_struct19, i64 0, 4
  store %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %__arc2, ptr %self__addr
  %drop_field20 = extractvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %__cleanup_t3, 2
  call void @"std.core.arc::_arc_destroy_impl__inst__5c35dfb564641e17"(%Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb %drop_field20)
  ret void
.bb.if_then:
  %__cleanup_t1 = load %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0, ptr %self__addr
  %zero_struct21 = insertvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 zeroinitializer, i8 0, 0
  %zero_struct22 = insertvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %zero_struct21, i64 0, 1
  %zero_struct23 = insertvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %zero_struct22, %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb zeroinitializer, 2
  %zero_struct24 = insertvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %zero_struct23, i8 0, 3
  %__arc3 = insertvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %zero_struct24, i64 0, 4
  store %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %__arc3, ptr %self__addr
  %drop_field25 = extractvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %__cleanup_t1, 2
  call void @"std.core.arc::_arc_destroy_impl__inst__5c35dfb564641e17"(%Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb %drop_field25)
  ret void
}
define linkonce_odr void @"std.core.arc::_arc_destroy_impl__inst__0a6d34c7cbe9c09f"(%Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba %self) comdat {
.bb.entry:
  %self__addr = alloca %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba
  store %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba %self, ptr %self__addr
  %slot__addr = alloca ptr
  %slot__b32__addr = alloca ptr
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str166, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = getelementptr inbounds %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba, ptr %self__addr, i32 0, i32 0
  %.t4 = load %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa, ptr %.t3
  %.t5 = extractvalue %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa %.t4, 0
  %.t7 = icmp eq ptr %.t5, null
  br i1 %.t7, label %.bb.if_then, label %.bb.if_join
.bb.if_join:
  %.t8 = add i64 0, 0
  %.t10 = getelementptr inbounds %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba, ptr %self__addr, i32 0, i32 0
  %.t11 = add i64 0, 0
  %rawbuf3 = load %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa, ptr %.t10
  %rawptr4 = extractvalue %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa %rawbuf3, 0
  %rawcap5 = extractvalue %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa %rawbuf3, 1
  %strptr6 = getelementptr inbounds { i64, i64, [18 x i8] }, ptr @.str17, i32 0, i32 2, i32 0
  %str07 = insertvalue %DriftString zeroinitializer, i64 17, 0
  %str8 = insertvalue %DriftString %str07, ptr %strptr6, 1
  call void @drift_bounds_check(%DriftString %str8, i64 %.t11, i64 %rawcap5)
  %.t12 = getelementptr %Struct_std_2Ecore_2Earc_ArcBox_53a4e98f36ae3d4e, ptr %rawptr4, i64 %.t11
  store ptr %.t12, ptr %slot__addr
  %.t14 = load ptr, ptr %slot__addr
  %.t15 = getelementptr inbounds %Struct_std_2Ecore_2Earc_ArcBox_53a4e98f36ae3d4e, ptr %.t14, i32 0, i32 0
  %.t16 = getelementptr inbounds %Struct_std_2Ecore_2Earc_ArcHeader_363bcf8619c06fdd, ptr %.t15, i32 0, i32 0
  %.t17 = add i64 0, 1
  %.t18 = add i64 0, 2
  %atomic_ptr9 = getelementptr inbounds %Struct_lang_2Eatomic_AtomicInt_4a3cfd9b16e4d07c, ptr %.t16, i32 0, i32 0
  %.t19 = call i64 @drift_atomic_fetch_sub_int(ptr %atomic_ptr9, i64 %.t17, i64 %.t18)
  %.t21 = add i64 0, 1
  %.t22 = icmp eq i64 %.t19, %.t21
  br i1 %.t22, label %.bb.if_then1, label %.bb.if_join1
.bb.if_then1:
  %.t24 = getelementptr inbounds %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba, ptr %self__addr, i32 0, i32 0
  %.t25 = add i64 0, 0
  %rawbuf10 = load %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa, ptr %.t24
  %rawptr11 = extractvalue %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa %rawbuf10, 0
  %rawcap12 = extractvalue %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa %rawbuf10, 1
  %strptr13 = getelementptr inbounds { i64, i64, [18 x i8] }, ptr @.str17, i32 0, i32 2, i32 0
  %str014 = insertvalue %DriftString zeroinitializer, i64 17, 0
  %str15 = insertvalue %DriftString %str014, ptr %strptr13, 1
  call void @drift_bounds_check(%DriftString %str15, i64 %.t25, i64 %rawcap12)
  %.t26 = getelementptr %Struct_std_2Ecore_2Earc_ArcBox_53a4e98f36ae3d4e, ptr %rawptr11, i64 %.t25
  store ptr %.t26, ptr %slot__b32__addr
  %.t28 = load ptr, ptr %slot__b32__addr
  %.t29 = getelementptr inbounds %Struct_std_2Ecore_2Earc_ArcBox_53a4e98f36ae3d4e, ptr %.t28, i32 0, i32 0
  %.t30 = getelementptr inbounds %Struct_std_2Ecore_2Earc_ArcHeader_363bcf8619c06fdd, ptr %.t29, i32 0, i32 0
  %.t31 = add i64 0, 1
  %atomic_ptr16 = getelementptr inbounds %Struct_lang_2Eatomic_AtomicInt_4a3cfd9b16e4d07c, ptr %.t30, i32 0, i32 0
  %.t32 = call i64 @drift_atomic_load_int(ptr %atomic_ptr16, i64 %.t31)
  %.t33 = load ptr, ptr %slot__b32__addr
  %.t34 = load %Struct_std_2Ecore_2Earc_ArcBox_53a4e98f36ae3d4e, ptr %.t33
  %.t35 = extractvalue %Struct_std_2Ecore_2Earc_ArcBox_53a4e98f36ae3d4e %.t34, 0
  %.t36 = extractvalue %Struct_std_2Ecore_2Earc_ArcHeader_363bcf8619c06fdd %.t35, 2
  %.t38 = getelementptr inbounds %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba, ptr %self__addr, i32 0, i32 0
  %.t39 = load %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa, ptr %.t38
  %.t40 = extractvalue %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa %.t39, 0
  call void (ptr) %.t36(ptr %.t40)
  br label %.bb.if_join1
.bb.if_join1:
  %__cleanup_t2 = load %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba, ptr %self__addr
  %__arc1 = insertvalue %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba zeroinitializer, %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa zeroinitializer, 0
  store %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba %__arc1, ptr %self__addr
  ret void
.bb.if_then:
  %__cleanup_t1 = load %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba, ptr %self__addr
  %__arc2 = insertvalue %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba zeroinitializer, %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa zeroinitializer, 0
  store %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba %__arc2, ptr %self__addr
  ret void
}
define linkonce_odr void @"std.core.arc::_arc_destroy_impl__inst__5c35dfb564641e17"(%Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb %self) comdat {
.bb.entry:
  %self__addr = alloca %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb
  store %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb %self, ptr %self__addr
  %slot__addr = alloca ptr
  %slot__b32__addr = alloca ptr
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str167, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = getelementptr inbounds %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb, ptr %self__addr, i32 0, i32 0
  %.t4 = load %Struct_std_2Emem_RawBuffer_864958797bafab1a, ptr %.t3
  %.t5 = extractvalue %Struct_std_2Emem_RawBuffer_864958797bafab1a %.t4, 0
  %.t7 = icmp eq ptr %.t5, null
  br i1 %.t7, label %.bb.if_then, label %.bb.if_join
.bb.if_join:
  %.t8 = add i64 0, 0
  %.t10 = getelementptr inbounds %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb, ptr %self__addr, i32 0, i32 0
  %.t11 = add i64 0, 0
  %rawbuf3 = load %Struct_std_2Emem_RawBuffer_864958797bafab1a, ptr %.t10
  %rawptr4 = extractvalue %Struct_std_2Emem_RawBuffer_864958797bafab1a %rawbuf3, 0
  %rawcap5 = extractvalue %Struct_std_2Emem_RawBuffer_864958797bafab1a %rawbuf3, 1
  %strptr6 = getelementptr inbounds { i64, i64, [18 x i8] }, ptr @.str17, i32 0, i32 2, i32 0
  %str07 = insertvalue %DriftString zeroinitializer, i64 17, 0
  %str8 = insertvalue %DriftString %str07, ptr %strptr6, 1
  call void @drift_bounds_check(%DriftString %str8, i64 %.t11, i64 %rawcap5)
  %.t12 = getelementptr %Struct_std_2Ecore_2Earc_ArcBox_431f4747e835d3fd, ptr %rawptr4, i64 %.t11
  store ptr %.t12, ptr %slot__addr
  %.t14 = load ptr, ptr %slot__addr
  %.t15 = getelementptr inbounds %Struct_std_2Ecore_2Earc_ArcBox_431f4747e835d3fd, ptr %.t14, i32 0, i32 0
  %.t16 = getelementptr inbounds %Struct_std_2Ecore_2Earc_ArcHeader_363bcf8619c06fdd, ptr %.t15, i32 0, i32 0
  %.t17 = add i64 0, 1
  %.t18 = add i64 0, 2
  %atomic_ptr9 = getelementptr inbounds %Struct_lang_2Eatomic_AtomicInt_4a3cfd9b16e4d07c, ptr %.t16, i32 0, i32 0
  %.t19 = call i64 @drift_atomic_fetch_sub_int(ptr %atomic_ptr9, i64 %.t17, i64 %.t18)
  %.t21 = add i64 0, 1
  %.t22 = icmp eq i64 %.t19, %.t21
  br i1 %.t22, label %.bb.if_then1, label %.bb.if_join1
.bb.if_then1:
  %.t24 = getelementptr inbounds %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb, ptr %self__addr, i32 0, i32 0
  %.t25 = add i64 0, 0
  %rawbuf10 = load %Struct_std_2Emem_RawBuffer_864958797bafab1a, ptr %.t24
  %rawptr11 = extractvalue %Struct_std_2Emem_RawBuffer_864958797bafab1a %rawbuf10, 0
  %rawcap12 = extractvalue %Struct_std_2Emem_RawBuffer_864958797bafab1a %rawbuf10, 1
  %strptr13 = getelementptr inbounds { i64, i64, [18 x i8] }, ptr @.str17, i32 0, i32 2, i32 0
  %str014 = insertvalue %DriftString zeroinitializer, i64 17, 0
  %str15 = insertvalue %DriftString %str014, ptr %strptr13, 1
  call void @drift_bounds_check(%DriftString %str15, i64 %.t25, i64 %rawcap12)
  %.t26 = getelementptr %Struct_std_2Ecore_2Earc_ArcBox_431f4747e835d3fd, ptr %rawptr11, i64 %.t25
  store ptr %.t26, ptr %slot__b32__addr
  %.t28 = load ptr, ptr %slot__b32__addr
  %.t29 = getelementptr inbounds %Struct_std_2Ecore_2Earc_ArcBox_431f4747e835d3fd, ptr %.t28, i32 0, i32 0
  %.t30 = getelementptr inbounds %Struct_std_2Ecore_2Earc_ArcHeader_363bcf8619c06fdd, ptr %.t29, i32 0, i32 0
  %.t31 = add i64 0, 1
  %atomic_ptr16 = getelementptr inbounds %Struct_lang_2Eatomic_AtomicInt_4a3cfd9b16e4d07c, ptr %.t30, i32 0, i32 0
  %.t32 = call i64 @drift_atomic_load_int(ptr %atomic_ptr16, i64 %.t31)
  %.t33 = load ptr, ptr %slot__b32__addr
  %.t34 = load %Struct_std_2Ecore_2Earc_ArcBox_431f4747e835d3fd, ptr %.t33
  %.t35 = extractvalue %Struct_std_2Ecore_2Earc_ArcBox_431f4747e835d3fd %.t34, 0
  %.t36 = extractvalue %Struct_std_2Ecore_2Earc_ArcHeader_363bcf8619c06fdd %.t35, 2
  %.t38 = getelementptr inbounds %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb, ptr %self__addr, i32 0, i32 0
  %.t39 = load %Struct_std_2Emem_RawBuffer_864958797bafab1a, ptr %.t38
  %.t40 = extractvalue %Struct_std_2Emem_RawBuffer_864958797bafab1a %.t39, 0
  call void (ptr) %.t36(ptr %.t40)
  br label %.bb.if_join1
.bb.if_join1:
  %__cleanup_t2 = load %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb, ptr %self__addr
  %__arc1 = insertvalue %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb zeroinitializer, %Struct_std_2Emem_RawBuffer_864958797bafab1a zeroinitializer, 0
  store %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb %__arc1, ptr %self__addr
  ret void
.bb.if_then:
  %__cleanup_t1 = load %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb, ptr %self__addr
  %__arc2 = insertvalue %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb zeroinitializer, %Struct_std_2Emem_RawBuffer_864958797bafab1a zeroinitializer, 0
  store %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb %__arc2, ptr %self__addr
  ret void
}
define linkonce_odr ptr @"std.core.arc::_arc_get_impl__inst__fc66586b6a63dfdc"(ptr %self) comdat {
.bb.entry:
  %self__addr = alloca ptr
  store ptr %self, ptr %self__addr
  %slot__addr = alloca ptr
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str168, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = load ptr, ptr %self__addr
  %.t4 = getelementptr inbounds %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba, ptr %.t3, i32 0, i32 0
  %.t5 = add i64 0, 0
  %rawbuf3 = load %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa, ptr %.t4
  %rawptr4 = extractvalue %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa %rawbuf3, 0
  %rawcap5 = extractvalue %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa %rawbuf3, 1
  %strptr6 = getelementptr inbounds { i64, i64, [18 x i8] }, ptr @.str17, i32 0, i32 2, i32 0
  %str07 = insertvalue %DriftString zeroinitializer, i64 17, 0
  %str8 = insertvalue %DriftString %str07, ptr %strptr6, 1
  call void @drift_bounds_check(%DriftString %str8, i64 %.t5, i64 %rawcap5)
  %.t6 = getelementptr %Struct_std_2Ecore_2Earc_ArcBox_53a4e98f36ae3d4e, ptr %rawptr4, i64 %.t5
  store ptr %.t6, ptr %slot__addr
  %.t8 = load ptr, ptr %slot__addr
  %.t9 = getelementptr inbounds %Struct_std_2Ecore_2Earc_ArcBox_53a4e98f36ae3d4e, ptr %.t8, i32 0, i32 1
  ret ptr %.t9
}
define %FnResult_Void_Error @__nothrow_wrap_std.core.arc__arc_drop_thunk_for__inst__d6c21c3166e361db(ptr %a0) {
__bb_entry:
  call void @"std.core.arc::_arc_drop_thunk_for__inst__d6c21c3166e361db"(ptr %a0)
  %ok0 = insertvalue %FnResult_Void_Error zeroinitializer, i8 0, 0
  %ok1 = insertvalue %FnResult_Void_Error %ok0, i8 0, 1
  %res = insertvalue %FnResult_Void_Error %ok1, ptr null, 2
  ret %FnResult_Void_Error %res
}
define linkonce_odr %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba @"std.core.arc::arc__inst__64ac3d24898720d1"(%Struct_std_2Esync_AtomicBool_881cc492ae8213fb %value) comdat {
.bb.entry:
  %buf__addr = alloca %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str169, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t2 = add i64 0, 1
  %len04 = add i64 0, 0
  %raw3 = call ptr @drift_alloc_array(i64 32, i64 8, i64 %len04, i64 %.t2)
  %raw05 = insertvalue %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa zeroinitializer, ptr %raw3, 0
  %raw16 = insertvalue %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa %raw05, i64 %.t2, 1
  store %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa %raw16, ptr %buf__addr
  %.t4 = add i64 0, 1
  %.t5 = call %Struct_lang_2Eatomic_AtomicInt_4a3cfd9b16e4d07c @"lang.atomic::atomic_int"(i64 %.t4)
  %.t6 = add i64 0, 0
  %.t7 = call %Struct_lang_2Eatomic_AtomicInt_4a3cfd9b16e4d07c @"lang.atomic::atomic_int"(i64 %.t6)
  %struct7 = insertvalue %Struct_std_2Ecore_2Earc_ArcHeader_363bcf8619c06fdd zeroinitializer, %Struct_lang_2Eatomic_AtomicInt_4a3cfd9b16e4d07c %.t5, 0
  %struct8 = insertvalue %Struct_std_2Ecore_2Earc_ArcHeader_363bcf8619c06fdd %struct7, %Struct_lang_2Eatomic_AtomicInt_4a3cfd9b16e4d07c %.t7, 1
  %.t9 = insertvalue %Struct_std_2Ecore_2Earc_ArcHeader_363bcf8619c06fdd %struct8, ptr @"std.core.arc::_arc_drop_thunk_for__inst__d6c21c3166e361db", 2
  %zero_struct9 = insertvalue %Struct_std_2Ecore_2Earc_ArcHeader_363bcf8619c06fdd zeroinitializer, %Struct_lang_2Eatomic_AtomicInt_4a3cfd9b16e4d07c zeroinitializer, 0
  %zero_struct10 = insertvalue %Struct_std_2Ecore_2Earc_ArcHeader_363bcf8619c06fdd %zero_struct9, %Struct_lang_2Eatomic_AtomicInt_4a3cfd9b16e4d07c zeroinitializer, 1
  %__arc1 = insertvalue %Struct_std_2Ecore_2Earc_ArcHeader_363bcf8619c06fdd %zero_struct10, ptr null, 2
  %__arc2 = insertvalue %Struct_std_2Esync_AtomicBool_881cc492ae8213fb zeroinitializer, %Struct_lang_2Eatomic_AtomicBool_4466cda2157b83d3 zeroinitializer, 0
  %struct11 = insertvalue %Struct_std_2Ecore_2Earc_ArcBox_53a4e98f36ae3d4e zeroinitializer, %Struct_std_2Ecore_2Earc_ArcHeader_363bcf8619c06fdd %.t9, 0
  %.t12 = insertvalue %Struct_std_2Ecore_2Earc_ArcBox_53a4e98f36ae3d4e %struct11, %Struct_std_2Esync_AtomicBool_881cc492ae8213fb %value, 1
  %.t14 = add i64 0, 0
  %zero_struct12 = insertvalue %Struct_std_2Ecore_2Earc_ArcBox_53a4e98f36ae3d4e zeroinitializer, %Struct_std_2Ecore_2Earc_ArcHeader_363bcf8619c06fdd zeroinitializer, 0
  %__arc3 = insertvalue %Struct_std_2Ecore_2Earc_ArcBox_53a4e98f36ae3d4e %zero_struct12, %Struct_std_2Esync_AtomicBool_881cc492ae8213fb zeroinitializer, 1
  %rawbuf13 = load %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa, ptr %buf__addr
  %rawptr14 = extractvalue %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa %rawbuf13, 0
  %rawcap15 = extractvalue %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa %rawbuf13, 1
  %strptr16 = getelementptr inbounds { i64, i64, [18 x i8] }, ptr @.str17, i32 0, i32 2, i32 0
  %str017 = insertvalue %DriftString zeroinitializer, i64 17, 0
  %str18 = insertvalue %DriftString %str017, ptr %strptr16, 1
  call void @drift_bounds_check(%DriftString %str18, i64 %.t14, i64 %rawcap15)
  %rawgep19 = getelementptr %Struct_std_2Ecore_2Earc_ArcBox_53a4e98f36ae3d4e, ptr %rawptr14, i64 %.t14
  store %Struct_std_2Ecore_2Earc_ArcBox_53a4e98f36ae3d4e %.t12, ptr %rawgep19
  %.t16 = load %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa, ptr %buf__addr
  %zero_struct20 = insertvalue %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa zeroinitializer, ptr null, 0
  %__arc4 = insertvalue %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa %zero_struct20, i64 0, 1
  store %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa %__arc4, ptr %buf__addr
  %.t17 = insertvalue %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba zeroinitializer, %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa %.t16, 0
  ret %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba %.t17
}
define linkonce_odr %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba @"std.core.arc::_arc_clone_impl__inst__d192354fe9e7c4b5"(ptr %self) comdat {
.bb.entry:
  %self__addr = alloca ptr
  store ptr %self, ptr %self__addr
  %slot__addr = alloca ptr
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str170, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = load ptr, ptr %self__addr
  %.t4 = getelementptr inbounds %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba, ptr %.t3, i32 0, i32 0
  %.t5 = add i64 0, 0
  %rawbuf3 = load %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa, ptr %.t4
  %rawptr4 = extractvalue %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa %rawbuf3, 0
  %rawcap5 = extractvalue %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa %rawbuf3, 1
  %strptr6 = getelementptr inbounds { i64, i64, [18 x i8] }, ptr @.str17, i32 0, i32 2, i32 0
  %str07 = insertvalue %DriftString zeroinitializer, i64 17, 0
  %str8 = insertvalue %DriftString %str07, ptr %strptr6, 1
  call void @drift_bounds_check(%DriftString %str8, i64 %.t5, i64 %rawcap5)
  %.t6 = getelementptr %Struct_std_2Ecore_2Earc_ArcBox_53a4e98f36ae3d4e, ptr %rawptr4, i64 %.t5
  store ptr %.t6, ptr %slot__addr
  %.t8 = load ptr, ptr %slot__addr
  %.t9 = getelementptr inbounds %Struct_std_2Ecore_2Earc_ArcBox_53a4e98f36ae3d4e, ptr %.t8, i32 0, i32 0
  %.t10 = getelementptr inbounds %Struct_std_2Ecore_2Earc_ArcHeader_363bcf8619c06fdd, ptr %.t9, i32 0, i32 0
  %.t11 = add i64 0, 1
  %.t12 = add i64 0, 0
  %atomic_ptr9 = getelementptr inbounds %Struct_lang_2Eatomic_AtomicInt_4a3cfd9b16e4d07c, ptr %.t10, i32 0, i32 0
  %.t13 = call i64 @drift_atomic_fetch_add_int(ptr %atomic_ptr9, i64 %.t11, i64 %.t12)
  %.t15 = load ptr, ptr %self__addr
  %.t16 = getelementptr inbounds %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba, ptr %.t15, i32 0, i32 0
  %.t17 = load %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa, ptr %.t16
  %.t18 = extractvalue %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa %.t17, 0
  %.t20 = load ptr, ptr %self__addr
  %.t21 = getelementptr inbounds %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba, ptr %.t20, i32 0, i32 0
  %.t22 = load %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa, ptr %.t21
  %.t23 = extractvalue %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa %.t22, 1
  %struct10 = insertvalue %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa zeroinitializer, ptr %.t18, 0
  %.t26 = insertvalue %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa %struct10, i64 %.t23, 1
  %.t27 = insertvalue %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba zeroinitializer, %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa %.t26, 0
  ret %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba %.t27
}
define internal void @__drift_cb_thunk_bf7194e0203c57a4(ptr %data) {
__bb_entry:
  call void @"std.concurrent::__lambda_cb_spawn_cb__inst__5634e65d835e6c93_0_0"(ptr %data)
  ret void
}
define void @__drift_iface_drop_helper(%DriftIface %src) {
__bb_entry:
  %iface_data = extractvalue %DriftIface %src, 0
  %iface_vtable = extractvalue %DriftIface %src, 1
  %iface_vtable_null = icmp eq ptr %iface_vtable, null
  br i1 %iface_vtable_null, label %__bb_iface_free_done, label %__bb_iface_vtable_ok
__bb_iface_vtable_ok:
  %iface_inline = extractvalue %DriftIface %src, 3
  %iface_inline_bit = and i8 %iface_inline, 1
  %iface_owns_bit = and i8 %iface_inline, 2
  %iface_is_inline = icmp ne i8 %iface_inline_bit, 0
  %iface_tmp = alloca %DriftIface
  store %DriftIface %src, ptr %iface_tmp
  %iface_inline_field = getelementptr inbounds %DriftIface, ptr %iface_tmp, i32 0, i32 2
  %iface_inline_word = getelementptr inbounds [4 x i64], ptr %iface_inline_field, i32 0, i32 0
  %iface_data_eff = select i1 %iface_is_inline, ptr %iface_inline_word, ptr %iface_data
  %iface_drop_slot = getelementptr inbounds ptr, ptr %iface_vtable, i32 0
  %iface_drop_ptr = load ptr, ptr %iface_drop_slot
  %iface_has_drop = icmp ne ptr %iface_drop_ptr, null
  br i1 %iface_has_drop, label %__bb_iface_drop_call, label %__bb_iface_drop_done
__bb_iface_drop_call:
  call void (ptr) %iface_drop_ptr(ptr %iface_data_eff)
  br label %__bb_iface_drop_done
__bb_iface_drop_done:
  %iface_needs_free = icmp ne i8 %iface_owns_bit, 0
  br i1 %iface_needs_free, label %__bb_iface_free, label %__bb_iface_free_done
__bb_iface_free:
  call void @drift_iface_free(ptr %iface_data)
  br label %__bb_iface_free_done
__bb_iface_free_done:
  ret void
}
define internal void @__drift_cb_drop_bf7194e0203c57a4(ptr %data) {
__bb_entry:
  %env_val13 = load %Struct_std_2Econcurrent___lambda_env_cb_spawn_cb__inst__5634e65d835e6c93_0_0_6efcf5ee02e3b4f9, ptr %data
  %drop_field14 = extractvalue %Struct_std_2Econcurrent___lambda_env_cb_spawn_cb__inst__5634e65d835e6c93_0_0_6efcf5ee02e3b4f9 %env_val13, 0
  call void @"std.core.arc::_arc_destroy_impl__inst__5c35dfb564641e17"(%Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb %drop_field14)
  %drop_field15 = extractvalue %Struct_std_2Econcurrent___lambda_env_cb_spawn_cb__inst__5634e65d835e6c93_0_0_6efcf5ee02e3b4f9 %env_val13, 1
  call void @__drift_iface_drop_helper(%DriftIface %drop_field15)
  call void @drift_cb_env_free(ptr %data)
  ret void
}
define linkonce_odr %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 @"std.concurrent::spawn_cb__inst__5634e65d835e6c93"(%DriftIface %cb_1) comdat {
.bb.entry:
  %state__addr = alloca %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb
  %iface_tmp_entry16 = alloca %DriftIface
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str171, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t2 = call %Struct_std_2Econcurrent_Executor_c4c2a3d6fade171d @"std.concurrent::default_executor"()
  %.t3 = call %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb @"std.concurrent::_make_result_state__inst__06225674fb98e7e5"()
  store %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb %.t3, ptr %state__addr
  %.t5 = call %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb @"std.core.arc::_arc_clone_impl__inst__4c704b39c5bb904c"(ptr %state__addr)
  %__arc1 = insertvalue %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb zeroinitializer, %Struct_std_2Emem_RawBuffer_864958797bafab1a zeroinitializer, 0
  %__arc2 = select i1 1, %DriftIface zeroinitializer, %DriftIface zeroinitializer
  %struct3 = insertvalue %Struct_std_2Econcurrent___lambda_env_cb_spawn_cb__inst__5634e65d835e6c93_0_0_6efcf5ee02e3b4f9 zeroinitializer, %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb %.t5, 0
  %.t9 = insertvalue %Struct_std_2Econcurrent___lambda_env_cb_spawn_cb__inst__5634e65d835e6c93_0_0_6efcf5ee02e3b4f9 %struct3, %DriftIface %cb_1, 1
  %.t11 = add i64 0, 1
  %len05 = add i64 0, 0
  %raw4 = call ptr @drift_alloc_array(i64 72, i64 8, i64 %len05, i64 %.t11)
  %raw06 = insertvalue %Struct_std_2Emem_RawBuffer_990b24422b696aa0 zeroinitializer, ptr %raw4, 0
  %raw17 = insertvalue %Struct_std_2Emem_RawBuffer_990b24422b696aa0 %raw06, i64 %.t11, 1
  %.t12 = add i64 0, 0
  %rawptr8 = extractvalue %Struct_std_2Emem_RawBuffer_990b24422b696aa0 %raw17, 0
  %rawcap9 = extractvalue %Struct_std_2Emem_RawBuffer_990b24422b696aa0 %raw17, 1
  %strptr10 = getelementptr inbounds { i64, i64, [18 x i8] }, ptr @.str17, i32 0, i32 2, i32 0
  %str011 = insertvalue %DriftString zeroinitializer, i64 17, 0
  %str12 = insertvalue %DriftString %str011, ptr %strptr10, 1
  call void @drift_bounds_check(%DriftString %str12, i64 %.t12, i64 %rawcap9)
  %.t13 = getelementptr %Struct_std_2Econcurrent___lambda_env_cb_spawn_cb__inst__5634e65d835e6c93_0_0_6efcf5ee02e3b4f9, ptr %rawptr8, i64 %.t12
  store %Struct_std_2Econcurrent___lambda_env_cb_spawn_cb__inst__5634e65d835e6c93_0_0_6efcf5ee02e3b4f9 %.t9, ptr %.t13
  store %DriftIface zeroinitializer, ptr %iface_tmp_entry16
  %iface_data_ptr17 = getelementptr inbounds %DriftIface, ptr %iface_tmp_entry16, i32 0, i32 0
  store ptr %.t13, ptr %iface_data_ptr17
  %iface_vtable_ptr18 = getelementptr inbounds %DriftIface, ptr %iface_tmp_entry16, i32 0, i32 1
  store ptr @__drift_cb_vtable_bf7194e0203c57a4, ptr %iface_vtable_ptr18
  %iface_flag_ptr19 = getelementptr inbounds %DriftIface, ptr %iface_tmp_entry16, i32 0, i32 3
  store i8 0, ptr %iface_flag_ptr19
  %.t6 = load %DriftIface, ptr %iface_tmp_entry16
  %__arc3 = select i1 1, %DriftIface zeroinitializer, %DriftIface zeroinitializer
  %.t16 = extractvalue %Struct_std_2Econcurrent_Executor_c4c2a3d6fade171d %.t2, 1
  %cb_addr20 = alloca %DriftIface
  store %DriftIface %.t6, ptr %cb_addr20
  %.t17 = call i64 @drift_thread_spawn(ptr %cb_addr20, i64 %.t16)
  %.t19 = extractvalue %Struct_std_2Econcurrent_Executor_c4c2a3d6fade171d %.t2, 1
  %.t21 = call i64 @drift_exec_submit(i64 %.t19, i64 %.t17)
  %.t23 = add i64 0, 0
  %.t24 = icmp ne i64 %.t21, %.t23
  br i1 %.t24, label %.bb.if_then, label %.bb.if_join
.bb.if_join:
  %.t32 = add i1 0, 0
  %.t34 = load %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb, ptr %state__addr
  %__arc4 = insertvalue %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb zeroinitializer, %Struct_std_2Emem_RawBuffer_864958797bafab1a zeroinitializer, 0
  store %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb %__arc4, ptr %state__addr
  %.t35 = add i1 0, 0
  %.t36 = add i64 0, 0
  %bool821 = zext i1 %.t32 to i8
  %struct22 = insertvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 zeroinitializer, i8 %bool821, 0
  %struct23 = insertvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %struct22, i64 %.t17, 1
  %struct24 = insertvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %struct23, %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb %.t34, 2
  %bool825 = zext i1 %.t35 to i8
  %struct26 = insertvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %struct24, i8 %bool825, 3
  %.t37 = insertvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %struct26, i64 %.t36, 4
  ret %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %.t37
.bb.if_then:
  call void @drift_thread_drop(i64 %.t17)
  %.t26 = add i1 0, 0
  %.t27 = add i64 0, 0
  %.t28 = load %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb, ptr %state__addr
  %__arc5 = insertvalue %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb zeroinitializer, %Struct_std_2Emem_RawBuffer_864958797bafab1a zeroinitializer, 0
  store %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb %__arc5, ptr %state__addr
  %.t29 = add i1 0, 0
  %bool827 = zext i1 %.t26 to i8
  %struct28 = insertvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 zeroinitializer, i8 %bool827, 0
  %struct29 = insertvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %struct28, i64 %.t27, 1
  %struct30 = insertvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %struct29, %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb %.t28, 2
  %bool831 = zext i1 %.t29 to i8
  %struct32 = insertvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %struct30, i8 %bool831, 3
  %.t31 = insertvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %struct32, i64 %.t21, 4
  ret %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %.t31
}
define linkonce_odr %Variant_std_2Ecore_Result_37335149f7faff82 @"std.concurrent::VirtualThread<T>::join__inst__21bbbc8cde113920"(ptr %self) comdat {
.bb.entry:
  %self__addr = alloca ptr
  store ptr %self, ptr %self__addr
  %guard__b192__addr = alloca %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b
  %rs__b193__addr = alloca ptr
  %guard__addr = alloca %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b
  %rs__addr = alloca ptr
  %__throw_diag_.t33__addr = alloca %Struct_std_2Econcurrent_ExecSubmitFailed_1afe4ac0bfe13e54
  %__arc1 = select i1 1, ptr null, ptr null
  %__arc2 = select i1 1, ptr null, ptr null
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str173, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t2 = load ptr, ptr %self__addr
  %.t3 = load %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0, ptr %.t2
  %field83 = extractvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %.t3, 0
  %.t4 = icmp ne i8 %field83, 0
  br i1 %.t4, label %.bb.if_then, label %.bb.if_join
.bb.if_join:
  %.t10 = load ptr, ptr %self__addr
  %.t11 = load %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0, ptr %.t10
  %.t12 = extractvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %.t11, 4
  %.t13 = add i64 0, 0
  %.t14 = icmp ne i64 %.t12, %.t13
  br i1 %.t14, label %.bb.if_then1, label %.bb.if_join1
.bb.if_join1:
  %.t46 = load ptr, ptr %self__addr
  %.t47 = load %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0, ptr %.t46
  %field84 = extractvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %.t47, 3
  %.t48 = icmp ne i8 %field84, 0
  br i1 %.t48, label %.bb.if_then2, label %.bb.if_join2
.bb.if_join2:
  %.t85 = load ptr, ptr %self__addr
  %.t86 = load %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0, ptr %.t85
  %.t87 = extractvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %.t86, 1
  call void @drift_thread_join(i64 %.t87)
  %.t88 = add i1 0, 1
  %.t90 = load ptr, ptr %self__addr
  %.t91 = getelementptr inbounds %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0, ptr %.t90, i32 0, i32 0
  %bool85 = zext i1 %.t88 to i8
  store i8 %bool85, ptr %.t91
  %.t92 = add i64 0, 0
  %.t94 = load ptr, ptr %self__addr
  %.t95 = getelementptr inbounds %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0, ptr %.t94, i32 0, i32 1
  store i64 %.t92, ptr %.t95
  %.t97 = load ptr, ptr %self__addr
  %.t98 = getelementptr inbounds %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0, ptr %.t97, i32 0, i32 2
  %.t99 = call ptr @"std.core.arc::_arc_get_impl__inst__8fb0d984495d10c9"(ptr %.t98)
  %.t100 = call %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b @"std.concurrent::Mutex<T>::lock__inst__2026c6e8047a5d49"(ptr %.t99)
  store %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b %.t100, ptr %guard__b192__addr
  %.t102 = call ptr @"std.concurrent::MutexGuard<T>::get_mut__inst__8bbc1086c0f79eaa"(ptr %guard__b192__addr)
  store ptr %.t102, ptr %rs__b193__addr
  %.t104 = load ptr, ptr %rs__b193__addr
  %.t105 = getelementptr inbounds %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79, ptr %.t104, i32 0, i32 0
  %.t106 = add i64 0, 0
  %rawbuf6 = load %Struct_std_2Emem_RawBuffer_d10426ae10844bad, ptr %.t105
  %rawptr7 = extractvalue %Struct_std_2Emem_RawBuffer_d10426ae10844bad %rawbuf6, 0
  %rawcap8 = extractvalue %Struct_std_2Emem_RawBuffer_d10426ae10844bad %rawbuf6, 1
  %strptr9 = getelementptr inbounds { i64, i64, [18 x i8] }, ptr @.str17, i32 0, i32 2, i32 0
  %str010 = insertvalue %DriftString zeroinitializer, i64 17, 0
  %str11 = insertvalue %DriftString %str010, ptr %strptr9, 1
  call void @drift_bounds_check(%DriftString %str11, i64 %.t106, i64 %rawcap8)
  %rawgep12 = getelementptr i64, ptr %rawptr7, i64 %.t106
  %.t107 = load i64, ptr %rawgep12
  %.t108 = add i1 0, 0
  %.t110 = load ptr, ptr %rs__b193__addr
  %.t111 = getelementptr inbounds %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79, ptr %.t110, i32 0, i32 1
  %bool813 = zext i1 %.t108 to i8
  store i8 %bool813, ptr %.t111
  %__arc3 = add i64 0, 0
  %variant14 = alloca %Variant_std_2Ecore_Result_37335149f7faff82
  store %Variant_std_2Ecore_Result_37335149f7faff82 zeroinitializer, ptr %variant14
  %tagptr15 = getelementptr inbounds %Variant_std_2Ecore_Result_37335149f7faff82, ptr %variant14, i32 0, i32 0
  store i8 0, ptr %tagptr15
  %payload_words16 = getelementptr inbounds %Variant_std_2Ecore_Result_37335149f7faff82, ptr %variant14, i32 0, i32 2
  %fieldptr17 = getelementptr inbounds { i64 }, ptr %payload_words16, i32 0, i32 0
  store i64 %.t107, ptr %fieldptr17
  %.t113 = load %Variant_std_2Ecore_Result_37335149f7faff82, ptr %variant14
  %__cleanup_t1 = load %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b, ptr %guard__b192__addr
  %zero_struct18 = insertvalue %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b zeroinitializer, ptr null, 0
  %zero_struct19 = insertvalue %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b %zero_struct18, ptr null, 1
  %__arc4 = insertvalue %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b %zero_struct19, i8 0, 2
  store %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b %__arc4, ptr %guard__b192__addr
  call void @"std.concurrent::MutexGuard<T>::std.core.Destructible::destroy__inst__690dc3eee478c1e7"(%Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b %__cleanup_t1)
  ret %Variant_std_2Ecore_Result_37335149f7faff82 %.t113
.bb.if_then2:
  %.t49 = load ptr, ptr %self__addr
  %.t50 = load %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0, ptr %.t49
  %.t51 = extractvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %.t50, 1
  call void @drift_thread_join(i64 %.t51)
  %.t52 = add i1 0, 1
  %.t54 = load ptr, ptr %self__addr
  %.t55 = getelementptr inbounds %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0, ptr %.t54, i32 0, i32 0
  %bool820 = zext i1 %.t52 to i8
  store i8 %bool820, ptr %.t55
  %.t56 = add i64 0, 0
  %.t58 = load ptr, ptr %self__addr
  %.t59 = getelementptr inbounds %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0, ptr %.t58, i32 0, i32 1
  store i64 %.t56, ptr %.t59
  %.t61 = load ptr, ptr %self__addr
  %.t62 = getelementptr inbounds %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0, ptr %.t61, i32 0, i32 2
  %.t63 = call ptr @"std.core.arc::_arc_get_impl__inst__8fb0d984495d10c9"(ptr %.t62)
  %.t64 = call %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b @"std.concurrent::Mutex<T>::lock__inst__2026c6e8047a5d49"(ptr %.t63)
  store %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b %.t64, ptr %guard__addr
  %.t66 = call ptr @"std.concurrent::MutexGuard<T>::get_mut__inst__8bbc1086c0f79eaa"(ptr %guard__addr)
  store ptr %.t66, ptr %rs__addr
  %.t67 = load ptr, ptr %rs__addr
  %.t68 = load %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79, ptr %.t67
  %field821 = extractvalue %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79 %.t68, 1
  %.t69 = icmp ne i8 %field821, 0
  br i1 %.t69, label %.bb.if_then3, label %.bb.if_join3
.bb.if_then3:
  %.t71 = load ptr, ptr %rs__addr
  %.t72 = getelementptr inbounds %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79, ptr %.t71, i32 0, i32 0
  %.t73 = add i64 0, 0
  %rawbuf22 = load %Struct_std_2Emem_RawBuffer_d10426ae10844bad, ptr %.t72
  %rawptr23 = extractvalue %Struct_std_2Emem_RawBuffer_d10426ae10844bad %rawbuf22, 0
  %rawcap24 = extractvalue %Struct_std_2Emem_RawBuffer_d10426ae10844bad %rawbuf22, 1
  %strptr25 = getelementptr inbounds { i64, i64, [18 x i8] }, ptr @.str17, i32 0, i32 2, i32 0
  %str026 = insertvalue %DriftString zeroinitializer, i64 17, 0
  %str27 = insertvalue %DriftString %str026, ptr %strptr25, 1
  call void @drift_bounds_check(%DriftString %str27, i64 %.t73, i64 %rawcap24)
  %rawgep28 = getelementptr i64, ptr %rawptr23, i64 %.t73
  %.t74 = load i64, ptr %rawgep28
  %__arc8 = add i64 0, 0
  %.t76 = add i1 0, 0
  %.t78 = load ptr, ptr %rs__addr
  %.t79 = getelementptr inbounds %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79, ptr %.t78, i32 0, i32 1
  %bool829 = zext i1 %.t76 to i8
  store i8 %bool829, ptr %.t79
  br label %.bb.if_join3
.bb.if_join3:
  %__cleanup_t2 = load %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b, ptr %guard__addr
  %zero_struct30 = insertvalue %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b zeroinitializer, ptr null, 0
  %zero_struct31 = insertvalue %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b %zero_struct30, ptr null, 1
  %__arc5 = insertvalue %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b %zero_struct31, i8 0, 2
  store %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b %__arc5, ptr %guard__addr
  call void @"std.concurrent::MutexGuard<T>::std.core.Destructible::destroy__inst__690dc3eee478c1e7"(%Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b %__cleanup_t2)
  %strptr32 = getelementptr inbounds { i64, i64, [10 x i8] }, ptr @.str174, i32 0, i32 2, i32 0
  %str033 = insertvalue %DriftString zeroinitializer, i64 9, 0
  %.t80 = insertvalue %DriftString %str033, ptr %strptr32, 1
  %.t81 = add i64 0, 2
  %.t82 = sub i64 0, %.t81
  %struct34 = insertvalue %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 zeroinitializer, %DriftString %.t80, 0
  %.t83 = insertvalue %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 %struct34, i64 %.t82, 1
  %variant35 = alloca %Variant_std_2Ecore_Result_37335149f7faff82
  store %Variant_std_2Ecore_Result_37335149f7faff82 zeroinitializer, ptr %variant35
  %tagptr36 = getelementptr inbounds %Variant_std_2Ecore_Result_37335149f7faff82, ptr %variant35, i32 0, i32 0
  store i8 1, ptr %tagptr36
  %payload_words37 = getelementptr inbounds %Variant_std_2Ecore_Result_37335149f7faff82, ptr %variant35, i32 0, i32 2
  %fieldptr38 = getelementptr inbounds { %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 }, ptr %payload_words37, i32 0, i32 0
  store %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 %.t83, ptr %fieldptr38
  %.t84 = load %Variant_std_2Ecore_Result_37335149f7faff82, ptr %variant35
  ret %Variant_std_2Ecore_Result_37335149f7faff82 %.t84
.bb.if_then1:
  %.t15 = load ptr, ptr %self__addr
  %.t16 = load %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0, ptr %.t15
  %.t17 = extractvalue %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0 %.t16, 4
  %.t18 = add i1 0, 1
  %.t20 = load ptr, ptr %self__addr
  %.t21 = getelementptr inbounds %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0, ptr %.t20, i32 0, i32 0
  %bool839 = zext i1 %.t18 to i8
  store i8 %bool839, ptr %.t21
  %.t22 = add i64 0, 0
  %.t24 = load ptr, ptr %self__addr
  %.t25 = getelementptr inbounds %Struct_std_2Econcurrent_VirtualThread_16d11241be0d2fa0, ptr %.t24, i32 0, i32 1
  store i64 %.t22, ptr %.t25
  %.t27 = select i1 1, ptr null, ptr null
  %__arc7 = select i1 1, ptr null, ptr null
  call void @drift_error_release(ptr %__arc1)
  br label %.bb.try_body
.bb.try_body:
  %.t29 = add i64 0, 2101326342482124991
  %strptr40 = getelementptr inbounds { i64, i64, [32 x i8] }, ptr @.str175, i32 0, i32 2, i32 0
  %str041 = insertvalue %DriftString zeroinitializer, i64 31, 0
  %.t30 = insertvalue %DriftString %str041, ptr %strptr40, 1
  %.t32 = insertvalue %Struct_std_2Econcurrent_ExecSubmitFailed_1afe4ac0bfe13e54 zeroinitializer, i64 %.t17, 0
  store %Struct_std_2Econcurrent_ExecSubmitFailed_1afe4ac0bfe13e54 %.t32, ptr %__throw_diag_.t33__addr
  %.t35 = call %DriftString @"std.concurrent::std.concurrent.ExecSubmitFailed::std.core.Diagnostic::to_json_text"(ptr %__throw_diag_.t33__addr)
  %.t28 = call ptr @drift_error_new(i64 %.t29, %DriftString %.t30)
  call void @drift_error_set_params_json(ptr %.t28, %DriftString %.t35)
  %.t36 = load %Struct_std_2Econcurrent_ExecSubmitFailed_1afe4ac0bfe13e54, ptr %__throw_diag_.t33__addr
  %__arc10 = select i1 1, ptr null, ptr null
  call void @drift_error_release(ptr %.t27)
  br label %.bb.try_dispatch
.bb.try_dispatch:
  %err_val42 = load %DriftError, ptr %.t28
  %.t38 = extractvalue %DriftError %err_val42, 0
  br label %.bb.try_catch_0
.bb.try_catch_0:
  %__arc11 = select i1 1, ptr null, ptr null
  %__arc13 = select i1 1, ptr null, ptr null
  call void @drift_error_release(ptr %__arc2)
  %err_val43 = load %DriftError, ptr %.t28
  %.t40 = extractvalue %DriftError %err_val43, 0
  %strptr44 = getelementptr inbounds { i64, i64, [7 x i8] }, ptr @.str176, i32 0, i32 2, i32 0
  %str045 = insertvalue %DriftString zeroinitializer, i64 6, 0
  %.t41 = insertvalue %DriftString %str045, ptr %strptr44, 1
  %.t42 = add i64 0, 5
  %.t43 = sub i64 0, %.t42
  %struct46 = insertvalue %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 zeroinitializer, %DriftString %.t41, 0
  %.t44 = insertvalue %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 %struct46, i64 %.t43, 1
  %variant47 = alloca %Variant_std_2Ecore_Result_37335149f7faff82
  store %Variant_std_2Ecore_Result_37335149f7faff82 zeroinitializer, ptr %variant47
  %tagptr48 = getelementptr inbounds %Variant_std_2Ecore_Result_37335149f7faff82, ptr %variant47, i32 0, i32 0
  store i8 1, ptr %tagptr48
  %payload_words49 = getelementptr inbounds %Variant_std_2Ecore_Result_37335149f7faff82, ptr %variant47, i32 0, i32 2
  %fieldptr50 = getelementptr inbounds { %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 }, ptr %payload_words49, i32 0, i32 0
  store %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 %.t44, ptr %fieldptr50
  %.t45 = load %Variant_std_2Ecore_Result_37335149f7faff82, ptr %variant47
  %__arc15 = select i1 1, ptr null, ptr null
  call void @drift_error_release(ptr %.t28)
  ret %Variant_std_2Ecore_Result_37335149f7faff82 %.t45
.bb.if_then:
  %strptr51 = getelementptr inbounds { i64, i64, [7 x i8] }, ptr @.str177, i32 0, i32 2, i32 0
  %str052 = insertvalue %DriftString zeroinitializer, i64 6, 0
  %.t5 = insertvalue %DriftString %str052, ptr %strptr51, 1
  %.t6 = add i64 0, 3
  %.t7 = sub i64 0, %.t6
  %struct53 = insertvalue %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 zeroinitializer, %DriftString %.t5, 0
  %.t8 = insertvalue %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 %struct53, i64 %.t7, 1
  %variant54 = alloca %Variant_std_2Ecore_Result_37335149f7faff82
  store %Variant_std_2Ecore_Result_37335149f7faff82 zeroinitializer, ptr %variant54
  %tagptr55 = getelementptr inbounds %Variant_std_2Ecore_Result_37335149f7faff82, ptr %variant54, i32 0, i32 0
  store i8 1, ptr %tagptr55
  %payload_words56 = getelementptr inbounds %Variant_std_2Ecore_Result_37335149f7faff82, ptr %variant54, i32 0, i32 2
  %fieldptr57 = getelementptr inbounds { %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 }, ptr %payload_words56, i32 0, i32 0
  store %Struct_std_2Econcurrent_ConcurrencyError_c3f2359fd8966204 %.t8, ptr %fieldptr57
  %.t9 = load %Variant_std_2Ecore_Result_37335149f7faff82, ptr %variant54
  ret %Variant_std_2Ecore_Result_37335149f7faff82 %.t9
}
define internal void @__drift_cb_thunk_2630cdd29808534f(ptr %data, ptr %a0) {
__bb_entry:
  call void @"std.runtime::_typebox_drop_impl__inst__c197df4173b25317"(ptr %a0)
  ret void
}
define linkonce_odr i1 @"std.runtime::GlobalRegistry::set__inst__8e3703659a16d399"(ptr %self_1, %Struct_std_2Eio_ProcessStdinCapability_59452a2d778d5df1 %value_1) comdat {
.bb.entry:
  %raw__addr = alloca %Struct_std_2Emem_RawBuffer_60df697c729ca487
  %iface_tmp_entry14 = alloca %DriftIface
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str178, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = add i64 0, 1
  %len04 = add i64 0, 0
  %raw3 = call ptr @drift_alloc_array(i64 8, i64 8, i64 %len04, i64 %.t3)
  %raw05 = insertvalue %Struct_std_2Emem_RawBuffer_60df697c729ca487 zeroinitializer, ptr %raw3, 0
  %raw16 = insertvalue %Struct_std_2Emem_RawBuffer_60df697c729ca487 %raw05, i64 %.t3, 1
  store %Struct_std_2Emem_RawBuffer_60df697c729ca487 %raw16, ptr %raw__addr
  %.t6 = add i64 0, 0
  %__arc1 = insertvalue %Struct_std_2Eio_ProcessStdinCapability_59452a2d778d5df1 zeroinitializer, i64 0, 0
  %rawbuf7 = load %Struct_std_2Emem_RawBuffer_60df697c729ca487, ptr %raw__addr
  %rawptr8 = extractvalue %Struct_std_2Emem_RawBuffer_60df697c729ca487 %rawbuf7, 0
  %rawcap9 = extractvalue %Struct_std_2Emem_RawBuffer_60df697c729ca487 %rawbuf7, 1
  %strptr10 = getelementptr inbounds { i64, i64, [18 x i8] }, ptr @.str17, i32 0, i32 2, i32 0
  %str011 = insertvalue %DriftString zeroinitializer, i64 17, 0
  %str12 = insertvalue %DriftString %str011, ptr %strptr10, 1
  call void @drift_bounds_check(%DriftString %str12, i64 %.t6, i64 %rawcap9)
  %rawgep13 = getelementptr %Struct_std_2Eio_ProcessStdinCapability_59452a2d778d5df1, ptr %rawptr8, i64 %.t6
  store %Struct_std_2Eio_ProcessStdinCapability_59452a2d778d5df1 %value_1, ptr %rawgep13
  %.t9 = load %Struct_std_2Emem_RawBuffer_60df697c729ca487, ptr %raw__addr
  %.t10 = extractvalue %Struct_std_2Emem_RawBuffer_60df697c729ca487 %.t9, 0
  store %DriftIface zeroinitializer, ptr %iface_tmp_entry14
  %iface_data_ptr15 = getelementptr inbounds %DriftIface, ptr %iface_tmp_entry14, i32 0, i32 0
  store ptr null, ptr %iface_data_ptr15
  %iface_vtable_ptr16 = getelementptr inbounds %DriftIface, ptr %iface_tmp_entry14, i32 0, i32 1
  store ptr @__drift_cb_vtable_2630cdd29808534f, ptr %iface_vtable_ptr16
  %iface_flag_ptr17 = getelementptr inbounds %DriftIface, ptr %iface_tmp_entry14, i32 0, i32 3
  store i8 0, ptr %iface_flag_ptr17
  %.t11 = load %DriftIface, ptr %iface_tmp_entry14
  %.t12 = add i64 0, 3679006201822877485
  %__arc2 = select i1 1, %DriftIface zeroinitializer, %DriftIface zeroinitializer
  store %DriftIface %.t11, ptr %iface_tmp_entry14
  %.t15 = call i64 @drift_runtime_registry_set(i64 %.t12, ptr %.t10, ptr byval(%DriftIface) align 8 %iface_tmp_entry14)
  %.t17 = add i64 0, 1
  %.t18 = icmp ne i64 %.t15, %.t17
  br i1 %.t18, label %.bb.if_then, label %.bb.if_join
.bb.if_join:
  %.t25 = add i1 0, 1
  ret i1 %.t25
.bb.if_then:
  %.t20 = add i64 0, 0
  %rawbuf18 = load %Struct_std_2Emem_RawBuffer_60df697c729ca487, ptr %raw__addr
  %rawptr19 = extractvalue %Struct_std_2Emem_RawBuffer_60df697c729ca487 %rawbuf18, 0
  %rawcap20 = extractvalue %Struct_std_2Emem_RawBuffer_60df697c729ca487 %rawbuf18, 1
  %strptr21 = getelementptr inbounds { i64, i64, [18 x i8] }, ptr @.str17, i32 0, i32 2, i32 0
  %str022 = insertvalue %DriftString zeroinitializer, i64 17, 0
  %str23 = insertvalue %DriftString %str022, ptr %strptr21, 1
  call void @drift_bounds_check(%DriftString %str23, i64 %.t20, i64 %rawcap20)
  %rawgep24 = getelementptr %Struct_std_2Eio_ProcessStdinCapability_59452a2d778d5df1, ptr %rawptr19, i64 %.t20
  %.t21 = load %Struct_std_2Eio_ProcessStdinCapability_59452a2d778d5df1, ptr %rawgep24
  %__arc3 = insertvalue %Struct_std_2Eio_ProcessStdinCapability_59452a2d778d5df1 zeroinitializer, i64 0, 0
  %.t23 = load %Struct_std_2Emem_RawBuffer_60df697c729ca487, ptr %raw__addr
  %zero_struct25 = insertvalue %Struct_std_2Emem_RawBuffer_60df697c729ca487 zeroinitializer, ptr null, 0
  %__arc4 = insertvalue %Struct_std_2Emem_RawBuffer_60df697c729ca487 %zero_struct25, i64 0, 1
  store %Struct_std_2Emem_RawBuffer_60df697c729ca487 %__arc4, ptr %raw__addr
  %rawptr26 = extractvalue %Struct_std_2Emem_RawBuffer_60df697c729ca487 %.t23, 0
  call void @drift_free_array(ptr %rawptr26)
  %.t24 = add i1 0, 0
  ret i1 %.t24
}
define linkonce_odr i1 @"std.runtime::contains__inst__a4a44818e3c6431b"(ptr %reg) comdat {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str180, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = add i64 0, 3679006201822877485
  %.t4 = call i1 @"std.runtime::GlobalRegistry::contains_type"(ptr %reg, i64 %.t3)
  ret i1 %.t4
}
define internal void @__drift_cb_thunk_6ddab27c65ae55c9(ptr %data, ptr %a0) {
__bb_entry:
  call void @"std.runtime::_typebox_drop_impl__inst__e0682510f2f4b328"(ptr %a0)
  ret void
}
define linkonce_odr i1 @"std.runtime::GlobalRegistry::set__inst__79cf2420baaed150"(ptr %self_1, %Struct_std_2Eio_ProcessStdoutCapability_55cff55291ea241c %value_1) comdat {
.bb.entry:
  %raw__addr = alloca %Struct_std_2Emem_RawBuffer_e4b983166d45ea7e
  %iface_tmp_entry14 = alloca %DriftIface
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str181, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = add i64 0, 1
  %len04 = add i64 0, 0
  %raw3 = call ptr @drift_alloc_array(i64 8, i64 8, i64 %len04, i64 %.t3)
  %raw05 = insertvalue %Struct_std_2Emem_RawBuffer_e4b983166d45ea7e zeroinitializer, ptr %raw3, 0
  %raw16 = insertvalue %Struct_std_2Emem_RawBuffer_e4b983166d45ea7e %raw05, i64 %.t3, 1
  store %Struct_std_2Emem_RawBuffer_e4b983166d45ea7e %raw16, ptr %raw__addr
  %.t6 = add i64 0, 0
  %__arc1 = insertvalue %Struct_std_2Eio_ProcessStdoutCapability_55cff55291ea241c zeroinitializer, i64 0, 0
  %rawbuf7 = load %Struct_std_2Emem_RawBuffer_e4b983166d45ea7e, ptr %raw__addr
  %rawptr8 = extractvalue %Struct_std_2Emem_RawBuffer_e4b983166d45ea7e %rawbuf7, 0
  %rawcap9 = extractvalue %Struct_std_2Emem_RawBuffer_e4b983166d45ea7e %rawbuf7, 1
  %strptr10 = getelementptr inbounds { i64, i64, [18 x i8] }, ptr @.str17, i32 0, i32 2, i32 0
  %str011 = insertvalue %DriftString zeroinitializer, i64 17, 0
  %str12 = insertvalue %DriftString %str011, ptr %strptr10, 1
  call void @drift_bounds_check(%DriftString %str12, i64 %.t6, i64 %rawcap9)
  %rawgep13 = getelementptr %Struct_std_2Eio_ProcessStdoutCapability_55cff55291ea241c, ptr %rawptr8, i64 %.t6
  store %Struct_std_2Eio_ProcessStdoutCapability_55cff55291ea241c %value_1, ptr %rawgep13
  %.t9 = load %Struct_std_2Emem_RawBuffer_e4b983166d45ea7e, ptr %raw__addr
  %.t10 = extractvalue %Struct_std_2Emem_RawBuffer_e4b983166d45ea7e %.t9, 0
  store %DriftIface zeroinitializer, ptr %iface_tmp_entry14
  %iface_data_ptr15 = getelementptr inbounds %DriftIface, ptr %iface_tmp_entry14, i32 0, i32 0
  store ptr null, ptr %iface_data_ptr15
  %iface_vtable_ptr16 = getelementptr inbounds %DriftIface, ptr %iface_tmp_entry14, i32 0, i32 1
  store ptr @__drift_cb_vtable_6ddab27c65ae55c9, ptr %iface_vtable_ptr16
  %iface_flag_ptr17 = getelementptr inbounds %DriftIface, ptr %iface_tmp_entry14, i32 0, i32 3
  store i8 0, ptr %iface_flag_ptr17
  %.t11 = load %DriftIface, ptr %iface_tmp_entry14
  %.t12 = add i64 0, 9718645279026902884
  %__arc2 = select i1 1, %DriftIface zeroinitializer, %DriftIface zeroinitializer
  store %DriftIface %.t11, ptr %iface_tmp_entry14
  %.t15 = call i64 @drift_runtime_registry_set(i64 %.t12, ptr %.t10, ptr byval(%DriftIface) align 8 %iface_tmp_entry14)
  %.t17 = add i64 0, 1
  %.t18 = icmp ne i64 %.t15, %.t17
  br i1 %.t18, label %.bb.if_then, label %.bb.if_join
.bb.if_join:
  %.t25 = add i1 0, 1
  ret i1 %.t25
.bb.if_then:
  %.t20 = add i64 0, 0
  %rawbuf18 = load %Struct_std_2Emem_RawBuffer_e4b983166d45ea7e, ptr %raw__addr
  %rawptr19 = extractvalue %Struct_std_2Emem_RawBuffer_e4b983166d45ea7e %rawbuf18, 0
  %rawcap20 = extractvalue %Struct_std_2Emem_RawBuffer_e4b983166d45ea7e %rawbuf18, 1
  %strptr21 = getelementptr inbounds { i64, i64, [18 x i8] }, ptr @.str17, i32 0, i32 2, i32 0
  %str022 = insertvalue %DriftString zeroinitializer, i64 17, 0
  %str23 = insertvalue %DriftString %str022, ptr %strptr21, 1
  call void @drift_bounds_check(%DriftString %str23, i64 %.t20, i64 %rawcap20)
  %rawgep24 = getelementptr %Struct_std_2Eio_ProcessStdoutCapability_55cff55291ea241c, ptr %rawptr19, i64 %.t20
  %.t21 = load %Struct_std_2Eio_ProcessStdoutCapability_55cff55291ea241c, ptr %rawgep24
  %__arc3 = insertvalue %Struct_std_2Eio_ProcessStdoutCapability_55cff55291ea241c zeroinitializer, i64 0, 0
  %.t23 = load %Struct_std_2Emem_RawBuffer_e4b983166d45ea7e, ptr %raw__addr
  %zero_struct25 = insertvalue %Struct_std_2Emem_RawBuffer_e4b983166d45ea7e zeroinitializer, ptr null, 0
  %__arc4 = insertvalue %Struct_std_2Emem_RawBuffer_e4b983166d45ea7e %zero_struct25, i64 0, 1
  store %Struct_std_2Emem_RawBuffer_e4b983166d45ea7e %__arc4, ptr %raw__addr
  %rawptr26 = extractvalue %Struct_std_2Emem_RawBuffer_e4b983166d45ea7e %.t23, 0
  call void @drift_free_array(ptr %rawptr26)
  %.t24 = add i1 0, 0
  ret i1 %.t24
}
define linkonce_odr i1 @"std.runtime::contains__inst__d6e7556221403df5"(ptr %reg) comdat {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str183, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = add i64 0, 9718645279026902884
  %.t4 = call i1 @"std.runtime::GlobalRegistry::contains_type"(ptr %reg, i64 %.t3)
  ret i1 %.t4
}
define internal void @__drift_cb_thunk_c13a8bf15f11890e(ptr %data, ptr %a0) {
__bb_entry:
  call void @"std.runtime::_typebox_drop_impl__inst__4bf6730b0c402e1c"(ptr %a0)
  ret void
}
define linkonce_odr i1 @"std.runtime::GlobalRegistry::set__inst__2f0a2cb7c747e9a4"(ptr %self_1, %Struct_std_2Eio_ProcessStderrCapability_d600e110b9a19e1e %value_1) comdat {
.bb.entry:
  %raw__addr = alloca %Struct_std_2Emem_RawBuffer_da7fe2d88f7ba0fa
  %iface_tmp_entry14 = alloca %DriftIface
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str184, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = add i64 0, 1
  %len04 = add i64 0, 0
  %raw3 = call ptr @drift_alloc_array(i64 8, i64 8, i64 %len04, i64 %.t3)
  %raw05 = insertvalue %Struct_std_2Emem_RawBuffer_da7fe2d88f7ba0fa zeroinitializer, ptr %raw3, 0
  %raw16 = insertvalue %Struct_std_2Emem_RawBuffer_da7fe2d88f7ba0fa %raw05, i64 %.t3, 1
  store %Struct_std_2Emem_RawBuffer_da7fe2d88f7ba0fa %raw16, ptr %raw__addr
  %.t6 = add i64 0, 0
  %__arc1 = insertvalue %Struct_std_2Eio_ProcessStderrCapability_d600e110b9a19e1e zeroinitializer, i64 0, 0
  %rawbuf7 = load %Struct_std_2Emem_RawBuffer_da7fe2d88f7ba0fa, ptr %raw__addr
  %rawptr8 = extractvalue %Struct_std_2Emem_RawBuffer_da7fe2d88f7ba0fa %rawbuf7, 0
  %rawcap9 = extractvalue %Struct_std_2Emem_RawBuffer_da7fe2d88f7ba0fa %rawbuf7, 1
  %strptr10 = getelementptr inbounds { i64, i64, [18 x i8] }, ptr @.str17, i32 0, i32 2, i32 0
  %str011 = insertvalue %DriftString zeroinitializer, i64 17, 0
  %str12 = insertvalue %DriftString %str011, ptr %strptr10, 1
  call void @drift_bounds_check(%DriftString %str12, i64 %.t6, i64 %rawcap9)
  %rawgep13 = getelementptr %Struct_std_2Eio_ProcessStderrCapability_d600e110b9a19e1e, ptr %rawptr8, i64 %.t6
  store %Struct_std_2Eio_ProcessStderrCapability_d600e110b9a19e1e %value_1, ptr %rawgep13
  %.t9 = load %Struct_std_2Emem_RawBuffer_da7fe2d88f7ba0fa, ptr %raw__addr
  %.t10 = extractvalue %Struct_std_2Emem_RawBuffer_da7fe2d88f7ba0fa %.t9, 0
  store %DriftIface zeroinitializer, ptr %iface_tmp_entry14
  %iface_data_ptr15 = getelementptr inbounds %DriftIface, ptr %iface_tmp_entry14, i32 0, i32 0
  store ptr null, ptr %iface_data_ptr15
  %iface_vtable_ptr16 = getelementptr inbounds %DriftIface, ptr %iface_tmp_entry14, i32 0, i32 1
  store ptr @__drift_cb_vtable_c13a8bf15f11890e, ptr %iface_vtable_ptr16
  %iface_flag_ptr17 = getelementptr inbounds %DriftIface, ptr %iface_tmp_entry14, i32 0, i32 3
  store i8 0, ptr %iface_flag_ptr17
  %.t11 = load %DriftIface, ptr %iface_tmp_entry14
  %.t12 = add i64 0, 3190102789603196613
  %__arc2 = select i1 1, %DriftIface zeroinitializer, %DriftIface zeroinitializer
  store %DriftIface %.t11, ptr %iface_tmp_entry14
  %.t15 = call i64 @drift_runtime_registry_set(i64 %.t12, ptr %.t10, ptr byval(%DriftIface) align 8 %iface_tmp_entry14)
  %.t17 = add i64 0, 1
  %.t18 = icmp ne i64 %.t15, %.t17
  br i1 %.t18, label %.bb.if_then, label %.bb.if_join
.bb.if_join:
  %.t25 = add i1 0, 1
  ret i1 %.t25
.bb.if_then:
  %.t20 = add i64 0, 0
  %rawbuf18 = load %Struct_std_2Emem_RawBuffer_da7fe2d88f7ba0fa, ptr %raw__addr
  %rawptr19 = extractvalue %Struct_std_2Emem_RawBuffer_da7fe2d88f7ba0fa %rawbuf18, 0
  %rawcap20 = extractvalue %Struct_std_2Emem_RawBuffer_da7fe2d88f7ba0fa %rawbuf18, 1
  %strptr21 = getelementptr inbounds { i64, i64, [18 x i8] }, ptr @.str17, i32 0, i32 2, i32 0
  %str022 = insertvalue %DriftString zeroinitializer, i64 17, 0
  %str23 = insertvalue %DriftString %str022, ptr %strptr21, 1
  call void @drift_bounds_check(%DriftString %str23, i64 %.t20, i64 %rawcap20)
  %rawgep24 = getelementptr %Struct_std_2Eio_ProcessStderrCapability_d600e110b9a19e1e, ptr %rawptr19, i64 %.t20
  %.t21 = load %Struct_std_2Eio_ProcessStderrCapability_d600e110b9a19e1e, ptr %rawgep24
  %__arc3 = insertvalue %Struct_std_2Eio_ProcessStderrCapability_d600e110b9a19e1e zeroinitializer, i64 0, 0
  %.t23 = load %Struct_std_2Emem_RawBuffer_da7fe2d88f7ba0fa, ptr %raw__addr
  %zero_struct25 = insertvalue %Struct_std_2Emem_RawBuffer_da7fe2d88f7ba0fa zeroinitializer, ptr null, 0
  %__arc4 = insertvalue %Struct_std_2Emem_RawBuffer_da7fe2d88f7ba0fa %zero_struct25, i64 0, 1
  store %Struct_std_2Emem_RawBuffer_da7fe2d88f7ba0fa %__arc4, ptr %raw__addr
  %rawptr26 = extractvalue %Struct_std_2Emem_RawBuffer_da7fe2d88f7ba0fa %.t23, 0
  call void @drift_free_array(ptr %rawptr26)
  %.t24 = add i1 0, 0
  ret i1 %.t24
}
define linkonce_odr i1 @"std.runtime::contains__inst__366e997d63749372"(ptr %reg) comdat {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str186, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = add i64 0, 3190102789603196613
  %.t4 = call i1 @"std.runtime::GlobalRegistry::contains_type"(ptr %reg, i64 %.t3)
  ret i1 %.t4
}
define linkonce_odr ptr @"std.core.arc::_arc_get_impl__inst__8fb0d984495d10c9"(ptr %self) comdat {
.bb.entry:
  %self__addr = alloca ptr
  store ptr %self, ptr %self__addr
  %slot__addr = alloca ptr
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str187, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = load ptr, ptr %self__addr
  %.t4 = getelementptr inbounds %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb, ptr %.t3, i32 0, i32 0
  %.t5 = add i64 0, 0
  %rawbuf3 = load %Struct_std_2Emem_RawBuffer_864958797bafab1a, ptr %.t4
  %rawptr4 = extractvalue %Struct_std_2Emem_RawBuffer_864958797bafab1a %rawbuf3, 0
  %rawcap5 = extractvalue %Struct_std_2Emem_RawBuffer_864958797bafab1a %rawbuf3, 1
  %strptr6 = getelementptr inbounds { i64, i64, [18 x i8] }, ptr @.str17, i32 0, i32 2, i32 0
  %str07 = insertvalue %DriftString zeroinitializer, i64 17, 0
  %str8 = insertvalue %DriftString %str07, ptr %strptr6, 1
  call void @drift_bounds_check(%DriftString %str8, i64 %.t5, i64 %rawcap5)
  %.t6 = getelementptr %Struct_std_2Ecore_2Earc_ArcBox_431f4747e835d3fd, ptr %rawptr4, i64 %.t5
  store ptr %.t6, ptr %slot__addr
  %.t8 = load ptr, ptr %slot__addr
  %.t9 = getelementptr inbounds %Struct_std_2Ecore_2Earc_ArcBox_431f4747e835d3fd, ptr %.t8, i32 0, i32 1
  ret ptr %.t9
}
define linkonce_odr %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b @"std.concurrent::Mutex<T>::lock__inst__2026c6e8047a5d49"(ptr %self) comdat {
.bb.entry:
  %self__addr = alloca ptr
  store ptr %self, ptr %self__addr
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str188, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  br label %.bb.loop_header
.bb.loop_header:
  br label %.bb.loop_body
.bb.loop_body:
  %.t3 = load ptr, ptr %self__addr
  %.t4 = getelementptr inbounds %Struct_std_2Econcurrent_Mutex_d7f34c574102f8fe, ptr %.t3, i32 0, i32 0
  %.t5 = add i1 0, 0
  %.t6 = add i1 0, 1
  %.t7 = add i64 0, 1
  %.t8 = add i64 0, 0
  %atomic_ptr3 = getelementptr inbounds %Struct_lang_2Eatomic_AtomicBool_4466cda2157b83d3, ptr %.t4, i32 0, i32 0
  %bool84 = zext i1 %.t5 to i8
  %bool85 = zext i1 %.t6 to i8
  %abool6 = call i8 @drift_atomic_compare_exchange_bool(ptr %atomic_ptr3, i8 %bool84, i8 %bool85, i64 %.t7, i64 %.t8)
  %.t9 = icmp ne i8 %abool6, 0
  %.t10 = xor i1 %.t9, true
  br i1 %.t10, label %.bb.if_then, label %.bb.if_else
.bb.if_else:
  br label %.bb.loop_exit
.bb.loop_exit:
  %.t12 = load ptr, ptr %self__addr
  %.t13 = getelementptr inbounds %Struct_std_2Econcurrent_Mutex_d7f34c574102f8fe, ptr %.t12, i32 0, i32 1
  %.t15 = load ptr, ptr %self__addr
  %.t17 = add i1 0, 1
  %struct7 = insertvalue %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b zeroinitializer, ptr %.t15, 0
  %struct8 = insertvalue %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b %struct7, ptr %.t13, 1
  %bool89 = zext i1 %.t17 to i8
  %.t18 = insertvalue %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b %struct8, i8 %bool89, 2
  ret %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b %.t18
.bb.if_then:
  br label %.bb.if_join
.bb.if_join:
  br label %.bb.loop_header
}
define linkonce_odr ptr @"std.concurrent::MutexGuard<T>::get_mut__inst__8bbc1086c0f79eaa"(ptr %self) comdat {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str189, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = load %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b, ptr %self
  %field83 = extractvalue %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b %.t3, 2
  %.t4 = icmp ne i8 %field83, 0
  %strptr4 = getelementptr inbounds { i64, i64, [32 x i8] }, ptr @.str190, i32 0, i32 2, i32 0
  %str05 = insertvalue %DriftString zeroinitializer, i64 31, 0
  %.t5 = insertvalue %DriftString %str05, ptr %strptr4, 1
  %.t6 = add i64 0, 564
  %strptr6 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str191, i32 0, i32 2, i32 0
  %str07 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t7 = insertvalue %DriftString %str07, ptr %strptr6, 1
  %strptr8 = getelementptr inbounds { i64, i64, [98 x i8] }, ptr @.str192, i32 0, i32 2, i32 0
  %str09 = insertvalue %DriftString zeroinitializer, i64 97, 0
  %.t8 = insertvalue %DriftString %str09, ptr %strptr8, 1
  call void @drift_assert_loc(i1 %.t4, %DriftString %.t5, i64 %.t6, %DriftString %.t7, %DriftString %.t8)
  %.t10 = load %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b, ptr %self
  %.t11 = extractvalue %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b %.t10, 1
  ret ptr %.t11
}
define linkonce_odr void @"std.core.arc::_arc_drop_thunk_for__inst__d6c21c3166e361db"(ptr %ctrl) comdat {
.bb.entry:
  %buf__addr = alloca %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str193, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = add i64 0, 1
  %struct3 = insertvalue %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa zeroinitializer, ptr %ctrl, 0
  %.t4 = insertvalue %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa %struct3, i64 %.t3, 1
  store %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa %.t4, ptr %buf__addr
  %.t6 = add i64 0, 0
  %rawbuf4 = load %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa, ptr %buf__addr
  %rawptr5 = extractvalue %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa %rawbuf4, 0
  %rawcap6 = extractvalue %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa %rawbuf4, 1
  %strptr7 = getelementptr inbounds { i64, i64, [18 x i8] }, ptr @.str17, i32 0, i32 2, i32 0
  %str08 = insertvalue %DriftString zeroinitializer, i64 17, 0
  %str9 = insertvalue %DriftString %str08, ptr %strptr7, 1
  call void @drift_bounds_check(%DriftString %str9, i64 %.t6, i64 %rawcap6)
  %rawgep10 = getelementptr %Struct_std_2Ecore_2Earc_ArcBox_53a4e98f36ae3d4e, ptr %rawptr5, i64 %.t6
  %.t7 = load %Struct_std_2Ecore_2Earc_ArcBox_53a4e98f36ae3d4e, ptr %rawgep10
  %zero_struct11 = insertvalue %Struct_std_2Ecore_2Earc_ArcBox_53a4e98f36ae3d4e zeroinitializer, %Struct_std_2Ecore_2Earc_ArcHeader_363bcf8619c06fdd zeroinitializer, 0
  %__arc1 = insertvalue %Struct_std_2Ecore_2Earc_ArcBox_53a4e98f36ae3d4e %zero_struct11, %Struct_std_2Esync_AtomicBool_881cc492ae8213fb zeroinitializer, 1
  %.t9 = load %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa, ptr %buf__addr
  %rawptr12 = extractvalue %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa %.t9, 0
  call void @drift_free_array(ptr %rawptr12)
  ret void
}
define linkonce_odr %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb @"std.concurrent::_make_result_state__inst__06225674fb98e7e5"() comdat {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str194, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t2 = add i64 0, 1
  %len04 = add i64 0, 0
  %raw3 = call ptr @drift_alloc_array(i64 8, i64 8, i64 %len04, i64 %.t2)
  %raw05 = insertvalue %Struct_std_2Emem_RawBuffer_d10426ae10844bad zeroinitializer, ptr %raw3, 0
  %raw16 = insertvalue %Struct_std_2Emem_RawBuffer_d10426ae10844bad %raw05, i64 %.t2, 1
  %zero_struct7 = insertvalue %Struct_std_2Emem_RawBuffer_d10426ae10844bad zeroinitializer, ptr null, 0
  %__arc1 = insertvalue %Struct_std_2Emem_RawBuffer_d10426ae10844bad %zero_struct7, i64 0, 1
  %.t5 = add i1 0, 0
  %.t6 = add i1 0, 0
  %struct8 = insertvalue %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79 zeroinitializer, %Struct_std_2Emem_RawBuffer_d10426ae10844bad %raw16, 0
  %bool89 = zext i1 %.t5 to i8
  %struct10 = insertvalue %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79 %struct8, i8 %bool89, 1
  %bool811 = zext i1 %.t6 to i8
  %.t7 = insertvalue %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79 %struct10, i8 %bool811, 2
  %zero_struct12 = insertvalue %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79 zeroinitializer, %Struct_std_2Emem_RawBuffer_d10426ae10844bad zeroinitializer, 0
  %zero_struct13 = insertvalue %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79 %zero_struct12, i8 0, 1
  %__arc2 = insertvalue %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79 %zero_struct13, i8 0, 2
  %.t9 = call %Struct_std_2Econcurrent_Mutex_d7f34c574102f8fe @"std.concurrent::mutex__inst__ad4e1b08d6b01d98"(%Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79 %.t7)
  %.t10 = call %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb @"std.core.arc::arc__inst__78ca7f72bfd04c5c"(%Struct_std_2Econcurrent_Mutex_d7f34c574102f8fe %.t9)
  ret %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb %.t10
}
define linkonce_odr %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb @"std.core.arc::_arc_clone_impl__inst__4c704b39c5bb904c"(ptr %self) comdat {
.bb.entry:
  %self__addr = alloca ptr
  store ptr %self, ptr %self__addr
  %slot__addr = alloca ptr
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str195, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = load ptr, ptr %self__addr
  %.t4 = getelementptr inbounds %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb, ptr %.t3, i32 0, i32 0
  %.t5 = add i64 0, 0
  %rawbuf3 = load %Struct_std_2Emem_RawBuffer_864958797bafab1a, ptr %.t4
  %rawptr4 = extractvalue %Struct_std_2Emem_RawBuffer_864958797bafab1a %rawbuf3, 0
  %rawcap5 = extractvalue %Struct_std_2Emem_RawBuffer_864958797bafab1a %rawbuf3, 1
  %strptr6 = getelementptr inbounds { i64, i64, [18 x i8] }, ptr @.str17, i32 0, i32 2, i32 0
  %str07 = insertvalue %DriftString zeroinitializer, i64 17, 0
  %str8 = insertvalue %DriftString %str07, ptr %strptr6, 1
  call void @drift_bounds_check(%DriftString %str8, i64 %.t5, i64 %rawcap5)
  %.t6 = getelementptr %Struct_std_2Ecore_2Earc_ArcBox_431f4747e835d3fd, ptr %rawptr4, i64 %.t5
  store ptr %.t6, ptr %slot__addr
  %.t8 = load ptr, ptr %slot__addr
  %.t9 = getelementptr inbounds %Struct_std_2Ecore_2Earc_ArcBox_431f4747e835d3fd, ptr %.t8, i32 0, i32 0
  %.t10 = getelementptr inbounds %Struct_std_2Ecore_2Earc_ArcHeader_363bcf8619c06fdd, ptr %.t9, i32 0, i32 0
  %.t11 = add i64 0, 1
  %.t12 = add i64 0, 0
  %atomic_ptr9 = getelementptr inbounds %Struct_lang_2Eatomic_AtomicInt_4a3cfd9b16e4d07c, ptr %.t10, i32 0, i32 0
  %.t13 = call i64 @drift_atomic_fetch_add_int(ptr %atomic_ptr9, i64 %.t11, i64 %.t12)
  %.t15 = load ptr, ptr %self__addr
  %.t16 = getelementptr inbounds %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb, ptr %.t15, i32 0, i32 0
  %.t17 = load %Struct_std_2Emem_RawBuffer_864958797bafab1a, ptr %.t16
  %.t18 = extractvalue %Struct_std_2Emem_RawBuffer_864958797bafab1a %.t17, 0
  %.t20 = load ptr, ptr %self__addr
  %.t21 = getelementptr inbounds %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb, ptr %.t20, i32 0, i32 0
  %.t22 = load %Struct_std_2Emem_RawBuffer_864958797bafab1a, ptr %.t21
  %.t23 = extractvalue %Struct_std_2Emem_RawBuffer_864958797bafab1a %.t22, 1
  %struct10 = insertvalue %Struct_std_2Emem_RawBuffer_864958797bafab1a zeroinitializer, ptr %.t18, 0
  %.t26 = insertvalue %Struct_std_2Emem_RawBuffer_864958797bafab1a %struct10, i64 %.t23, 1
  %.t27 = insertvalue %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb zeroinitializer, %Struct_std_2Emem_RawBuffer_864958797bafab1a %.t26, 0
  ret %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb %.t27
}
define linkonce_odr void @"std.concurrent::_publish_or_drop__inst__6e175d0504d59ca9"(ptr %state_1, i64 %v_1) comdat {
.bb.entry:
  %guard__addr = alloca %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b
  %rs__addr = alloca ptr
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str196, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = call ptr @"std.core.arc::_arc_get_impl__inst__8fb0d984495d10c9"(ptr %state_1)
  %.t4 = call %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b @"std.concurrent::Mutex<T>::lock__inst__2026c6e8047a5d49"(ptr %.t3)
  store %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b %.t4, ptr %guard__addr
  %.t6 = call ptr @"std.concurrent::MutexGuard<T>::get_mut__inst__8bbc1086c0f79eaa"(ptr %guard__addr)
  store ptr %.t6, ptr %rs__addr
  %.t7 = load ptr, ptr %rs__addr
  %.t8 = load %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79, ptr %.t7
  %field83 = extractvalue %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79 %.t8, 2
  %.t9 = icmp ne i8 %field83, 0
  br i1 %.t9, label %.bb.if_then, label %.bb.if_join
.bb.if_join:
  %.t12 = load ptr, ptr %rs__addr
  %.t13 = getelementptr inbounds %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79, ptr %.t12, i32 0, i32 0
  %.t14 = add i64 0, 0
  %__arc1 = add i64 0, 0
  %rawbuf4 = load %Struct_std_2Emem_RawBuffer_d10426ae10844bad, ptr %.t13
  %rawptr5 = extractvalue %Struct_std_2Emem_RawBuffer_d10426ae10844bad %rawbuf4, 0
  %rawcap6 = extractvalue %Struct_std_2Emem_RawBuffer_d10426ae10844bad %rawbuf4, 1
  %strptr7 = getelementptr inbounds { i64, i64, [18 x i8] }, ptr @.str17, i32 0, i32 2, i32 0
  %str08 = insertvalue %DriftString zeroinitializer, i64 17, 0
  %str9 = insertvalue %DriftString %str08, ptr %strptr7, 1
  call void @drift_bounds_check(%DriftString %str9, i64 %.t14, i64 %rawcap6)
  %rawgep10 = getelementptr i64, ptr %rawptr5, i64 %.t14
  store i64 %v_1, ptr %rawgep10
  %.t16 = add i1 0, 1
  %.t18 = load ptr, ptr %rs__addr
  %.t19 = getelementptr inbounds %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79, ptr %.t18, i32 0, i32 1
  %bool811 = zext i1 %.t16 to i8
  store i8 %bool811, ptr %.t19
  %__cleanup_t2 = load %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b, ptr %guard__addr
  %zero_struct12 = insertvalue %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b zeroinitializer, ptr null, 0
  %zero_struct13 = insertvalue %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b %zero_struct12, ptr null, 1
  %__arc2 = insertvalue %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b %zero_struct13, i8 0, 2
  store %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b %__arc2, ptr %guard__addr
  call void @"std.concurrent::MutexGuard<T>::std.core.Destructible::destroy__inst__690dc3eee478c1e7"(%Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b %__cleanup_t2)
  ret void
.bb.if_then:
  %__arc3 = add i64 0, 0
  %__cleanup_t1 = load %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b, ptr %guard__addr
  %zero_struct14 = insertvalue %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b zeroinitializer, ptr null, 0
  %zero_struct15 = insertvalue %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b %zero_struct14, ptr null, 1
  %__arc4 = insertvalue %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b %zero_struct15, i8 0, 2
  store %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b %__arc4, ptr %guard__addr
  call void @"std.concurrent::MutexGuard<T>::std.core.Destructible::destroy__inst__690dc3eee478c1e7"(%Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b %__cleanup_t1)
  ret void
}
define linkonce_odr void @"std.runtime::_typebox_drop_impl__inst__c197df4173b25317"(ptr %p) comdat {
.bb.entry:
  %raw__addr = alloca %Struct_std_2Emem_RawBuffer_60df697c729ca487
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str197, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = add i64 0, 1
  %struct3 = insertvalue %Struct_std_2Emem_RawBuffer_60df697c729ca487 zeroinitializer, ptr %p, 0
  %.t4 = insertvalue %Struct_std_2Emem_RawBuffer_60df697c729ca487 %struct3, i64 %.t3, 1
  store %Struct_std_2Emem_RawBuffer_60df697c729ca487 %.t4, ptr %raw__addr
  %.t6 = add i64 0, 0
  %rawbuf4 = load %Struct_std_2Emem_RawBuffer_60df697c729ca487, ptr %raw__addr
  %rawptr5 = extractvalue %Struct_std_2Emem_RawBuffer_60df697c729ca487 %rawbuf4, 0
  %rawcap6 = extractvalue %Struct_std_2Emem_RawBuffer_60df697c729ca487 %rawbuf4, 1
  %strptr7 = getelementptr inbounds { i64, i64, [18 x i8] }, ptr @.str17, i32 0, i32 2, i32 0
  %str08 = insertvalue %DriftString zeroinitializer, i64 17, 0
  %str9 = insertvalue %DriftString %str08, ptr %strptr7, 1
  call void @drift_bounds_check(%DriftString %str9, i64 %.t6, i64 %rawcap6)
  %rawgep10 = getelementptr %Struct_std_2Eio_ProcessStdinCapability_59452a2d778d5df1, ptr %rawptr5, i64 %.t6
  %.t7 = load %Struct_std_2Eio_ProcessStdinCapability_59452a2d778d5df1, ptr %rawgep10
  %__arc1 = insertvalue %Struct_std_2Eio_ProcessStdinCapability_59452a2d778d5df1 zeroinitializer, i64 0, 0
  %.t9 = load %Struct_std_2Emem_RawBuffer_60df697c729ca487, ptr %raw__addr
  %zero_struct11 = insertvalue %Struct_std_2Emem_RawBuffer_60df697c729ca487 zeroinitializer, ptr null, 0
  %__arc2 = insertvalue %Struct_std_2Emem_RawBuffer_60df697c729ca487 %zero_struct11, i64 0, 1
  store %Struct_std_2Emem_RawBuffer_60df697c729ca487 %__arc2, ptr %raw__addr
  %rawptr12 = extractvalue %Struct_std_2Emem_RawBuffer_60df697c729ca487 %.t9, 0
  call void @drift_free_array(ptr %rawptr12)
  ret void
}
define linkonce_odr void @"std.runtime::_typebox_drop_impl__inst__e0682510f2f4b328"(ptr %p) comdat {
.bb.entry:
  %raw__addr = alloca %Struct_std_2Emem_RawBuffer_e4b983166d45ea7e
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str198, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = add i64 0, 1
  %struct3 = insertvalue %Struct_std_2Emem_RawBuffer_e4b983166d45ea7e zeroinitializer, ptr %p, 0
  %.t4 = insertvalue %Struct_std_2Emem_RawBuffer_e4b983166d45ea7e %struct3, i64 %.t3, 1
  store %Struct_std_2Emem_RawBuffer_e4b983166d45ea7e %.t4, ptr %raw__addr
  %.t6 = add i64 0, 0
  %rawbuf4 = load %Struct_std_2Emem_RawBuffer_e4b983166d45ea7e, ptr %raw__addr
  %rawptr5 = extractvalue %Struct_std_2Emem_RawBuffer_e4b983166d45ea7e %rawbuf4, 0
  %rawcap6 = extractvalue %Struct_std_2Emem_RawBuffer_e4b983166d45ea7e %rawbuf4, 1
  %strptr7 = getelementptr inbounds { i64, i64, [18 x i8] }, ptr @.str17, i32 0, i32 2, i32 0
  %str08 = insertvalue %DriftString zeroinitializer, i64 17, 0
  %str9 = insertvalue %DriftString %str08, ptr %strptr7, 1
  call void @drift_bounds_check(%DriftString %str9, i64 %.t6, i64 %rawcap6)
  %rawgep10 = getelementptr %Struct_std_2Eio_ProcessStdoutCapability_55cff55291ea241c, ptr %rawptr5, i64 %.t6
  %.t7 = load %Struct_std_2Eio_ProcessStdoutCapability_55cff55291ea241c, ptr %rawgep10
  %__arc1 = insertvalue %Struct_std_2Eio_ProcessStdoutCapability_55cff55291ea241c zeroinitializer, i64 0, 0
  %.t9 = load %Struct_std_2Emem_RawBuffer_e4b983166d45ea7e, ptr %raw__addr
  %zero_struct11 = insertvalue %Struct_std_2Emem_RawBuffer_e4b983166d45ea7e zeroinitializer, ptr null, 0
  %__arc2 = insertvalue %Struct_std_2Emem_RawBuffer_e4b983166d45ea7e %zero_struct11, i64 0, 1
  store %Struct_std_2Emem_RawBuffer_e4b983166d45ea7e %__arc2, ptr %raw__addr
  %rawptr12 = extractvalue %Struct_std_2Emem_RawBuffer_e4b983166d45ea7e %.t9, 0
  call void @drift_free_array(ptr %rawptr12)
  ret void
}
define linkonce_odr void @"std.runtime::_typebox_drop_impl__inst__4bf6730b0c402e1c"(ptr %p) comdat {
.bb.entry:
  %raw__addr = alloca %Struct_std_2Emem_RawBuffer_da7fe2d88f7ba0fa
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str199, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = add i64 0, 1
  %struct3 = insertvalue %Struct_std_2Emem_RawBuffer_da7fe2d88f7ba0fa zeroinitializer, ptr %p, 0
  %.t4 = insertvalue %Struct_std_2Emem_RawBuffer_da7fe2d88f7ba0fa %struct3, i64 %.t3, 1
  store %Struct_std_2Emem_RawBuffer_da7fe2d88f7ba0fa %.t4, ptr %raw__addr
  %.t6 = add i64 0, 0
  %rawbuf4 = load %Struct_std_2Emem_RawBuffer_da7fe2d88f7ba0fa, ptr %raw__addr
  %rawptr5 = extractvalue %Struct_std_2Emem_RawBuffer_da7fe2d88f7ba0fa %rawbuf4, 0
  %rawcap6 = extractvalue %Struct_std_2Emem_RawBuffer_da7fe2d88f7ba0fa %rawbuf4, 1
  %strptr7 = getelementptr inbounds { i64, i64, [18 x i8] }, ptr @.str17, i32 0, i32 2, i32 0
  %str08 = insertvalue %DriftString zeroinitializer, i64 17, 0
  %str9 = insertvalue %DriftString %str08, ptr %strptr7, 1
  call void @drift_bounds_check(%DriftString %str9, i64 %.t6, i64 %rawcap6)
  %rawgep10 = getelementptr %Struct_std_2Eio_ProcessStderrCapability_d600e110b9a19e1e, ptr %rawptr5, i64 %.t6
  %.t7 = load %Struct_std_2Eio_ProcessStderrCapability_d600e110b9a19e1e, ptr %rawgep10
  %__arc1 = insertvalue %Struct_std_2Eio_ProcessStderrCapability_d600e110b9a19e1e zeroinitializer, i64 0, 0
  %.t9 = load %Struct_std_2Emem_RawBuffer_da7fe2d88f7ba0fa, ptr %raw__addr
  %zero_struct11 = insertvalue %Struct_std_2Emem_RawBuffer_da7fe2d88f7ba0fa zeroinitializer, ptr null, 0
  %__arc2 = insertvalue %Struct_std_2Emem_RawBuffer_da7fe2d88f7ba0fa %zero_struct11, i64 0, 1
  store %Struct_std_2Emem_RawBuffer_da7fe2d88f7ba0fa %__arc2, ptr %raw__addr
  %rawptr12 = extractvalue %Struct_std_2Emem_RawBuffer_da7fe2d88f7ba0fa %.t9, 0
  call void @drift_free_array(ptr %rawptr12)
  ret void
}
define linkonce_odr %Struct_std_2Econcurrent_Mutex_d7f34c574102f8fe @"std.concurrent::mutex__inst__ad4e1b08d6b01d98"(%Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79 %value) comdat {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str200, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t2 = add i1 0, 0
  %.t3 = call %Struct_lang_2Eatomic_AtomicBool_4466cda2157b83d3 @"std.concurrent::atomic_bool"(i1 %.t2)
  %zero_struct3 = insertvalue %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79 zeroinitializer, %Struct_std_2Emem_RawBuffer_d10426ae10844bad zeroinitializer, 0
  %zero_struct4 = insertvalue %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79 %zero_struct3, i8 0, 1
  %__arc1 = insertvalue %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79 %zero_struct4, i8 0, 2
  %struct5 = insertvalue %Struct_std_2Econcurrent_Mutex_d7f34c574102f8fe zeroinitializer, %Struct_lang_2Eatomic_AtomicBool_4466cda2157b83d3 %.t3, 0
  %.t5 = insertvalue %Struct_std_2Econcurrent_Mutex_d7f34c574102f8fe %struct5, %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79 %value, 1
  ret %Struct_std_2Econcurrent_Mutex_d7f34c574102f8fe %.t5
}
define %FnResult_Void_Error @__nothrow_wrap_std.core.arc__arc_drop_thunk_for__inst__361a475bfe08ec3d(ptr %a0) {
__bb_entry:
  call void @"std.core.arc::_arc_drop_thunk_for__inst__361a475bfe08ec3d"(ptr %a0)
  %ok0 = insertvalue %FnResult_Void_Error zeroinitializer, i8 0, 0
  %ok1 = insertvalue %FnResult_Void_Error %ok0, i8 0, 1
  %res = insertvalue %FnResult_Void_Error %ok1, ptr null, 2
  ret %FnResult_Void_Error %res
}
define linkonce_odr %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb @"std.core.arc::arc__inst__78ca7f72bfd04c5c"(%Struct_std_2Econcurrent_Mutex_d7f34c574102f8fe %value) comdat {
.bb.entry:
  %buf__addr = alloca %Struct_std_2Emem_RawBuffer_864958797bafab1a
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str201, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t2 = add i64 0, 1
  %len04 = add i64 0, 0
  %raw3 = call ptr @drift_alloc_array(i64 56, i64 8, i64 %len04, i64 %.t2)
  %raw05 = insertvalue %Struct_std_2Emem_RawBuffer_864958797bafab1a zeroinitializer, ptr %raw3, 0
  %raw16 = insertvalue %Struct_std_2Emem_RawBuffer_864958797bafab1a %raw05, i64 %.t2, 1
  store %Struct_std_2Emem_RawBuffer_864958797bafab1a %raw16, ptr %buf__addr
  %.t4 = add i64 0, 1
  %.t5 = call %Struct_lang_2Eatomic_AtomicInt_4a3cfd9b16e4d07c @"lang.atomic::atomic_int"(i64 %.t4)
  %.t6 = add i64 0, 0
  %.t7 = call %Struct_lang_2Eatomic_AtomicInt_4a3cfd9b16e4d07c @"lang.atomic::atomic_int"(i64 %.t6)
  %struct7 = insertvalue %Struct_std_2Ecore_2Earc_ArcHeader_363bcf8619c06fdd zeroinitializer, %Struct_lang_2Eatomic_AtomicInt_4a3cfd9b16e4d07c %.t5, 0
  %struct8 = insertvalue %Struct_std_2Ecore_2Earc_ArcHeader_363bcf8619c06fdd %struct7, %Struct_lang_2Eatomic_AtomicInt_4a3cfd9b16e4d07c %.t7, 1
  %.t9 = insertvalue %Struct_std_2Ecore_2Earc_ArcHeader_363bcf8619c06fdd %struct8, ptr @"std.core.arc::_arc_drop_thunk_for__inst__361a475bfe08ec3d", 2
  %zero_struct9 = insertvalue %Struct_std_2Ecore_2Earc_ArcHeader_363bcf8619c06fdd zeroinitializer, %Struct_lang_2Eatomic_AtomicInt_4a3cfd9b16e4d07c zeroinitializer, 0
  %zero_struct10 = insertvalue %Struct_std_2Ecore_2Earc_ArcHeader_363bcf8619c06fdd %zero_struct9, %Struct_lang_2Eatomic_AtomicInt_4a3cfd9b16e4d07c zeroinitializer, 1
  %__arc1 = insertvalue %Struct_std_2Ecore_2Earc_ArcHeader_363bcf8619c06fdd %zero_struct10, ptr null, 2
  %zero_struct11 = insertvalue %Struct_std_2Econcurrent_Mutex_d7f34c574102f8fe zeroinitializer, %Struct_lang_2Eatomic_AtomicBool_4466cda2157b83d3 zeroinitializer, 0
  %__arc2 = insertvalue %Struct_std_2Econcurrent_Mutex_d7f34c574102f8fe %zero_struct11, %Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79 zeroinitializer, 1
  %struct12 = insertvalue %Struct_std_2Ecore_2Earc_ArcBox_431f4747e835d3fd zeroinitializer, %Struct_std_2Ecore_2Earc_ArcHeader_363bcf8619c06fdd %.t9, 0
  %.t12 = insertvalue %Struct_std_2Ecore_2Earc_ArcBox_431f4747e835d3fd %struct12, %Struct_std_2Econcurrent_Mutex_d7f34c574102f8fe %value, 1
  %.t14 = add i64 0, 0
  %zero_struct13 = insertvalue %Struct_std_2Ecore_2Earc_ArcBox_431f4747e835d3fd zeroinitializer, %Struct_std_2Ecore_2Earc_ArcHeader_363bcf8619c06fdd zeroinitializer, 0
  %__arc3 = insertvalue %Struct_std_2Ecore_2Earc_ArcBox_431f4747e835d3fd %zero_struct13, %Struct_std_2Econcurrent_Mutex_d7f34c574102f8fe zeroinitializer, 1
  %rawbuf14 = load %Struct_std_2Emem_RawBuffer_864958797bafab1a, ptr %buf__addr
  %rawptr15 = extractvalue %Struct_std_2Emem_RawBuffer_864958797bafab1a %rawbuf14, 0
  %rawcap16 = extractvalue %Struct_std_2Emem_RawBuffer_864958797bafab1a %rawbuf14, 1
  %strptr17 = getelementptr inbounds { i64, i64, [18 x i8] }, ptr @.str17, i32 0, i32 2, i32 0
  %str018 = insertvalue %DriftString zeroinitializer, i64 17, 0
  %str19 = insertvalue %DriftString %str018, ptr %strptr17, 1
  call void @drift_bounds_check(%DriftString %str19, i64 %.t14, i64 %rawcap16)
  %rawgep20 = getelementptr %Struct_std_2Ecore_2Earc_ArcBox_431f4747e835d3fd, ptr %rawptr15, i64 %.t14
  store %Struct_std_2Ecore_2Earc_ArcBox_431f4747e835d3fd %.t12, ptr %rawgep20
  %.t16 = load %Struct_std_2Emem_RawBuffer_864958797bafab1a, ptr %buf__addr
  %zero_struct21 = insertvalue %Struct_std_2Emem_RawBuffer_864958797bafab1a zeroinitializer, ptr null, 0
  %__arc4 = insertvalue %Struct_std_2Emem_RawBuffer_864958797bafab1a %zero_struct21, i64 0, 1
  store %Struct_std_2Emem_RawBuffer_864958797bafab1a %__arc4, ptr %buf__addr
  %.t17 = insertvalue %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb zeroinitializer, %Struct_std_2Emem_RawBuffer_864958797bafab1a %.t16, 0
  ret %Struct_std_2Ecore_2Earc_Arc_83f839205f95c4eb %.t17
}
define linkonce_odr void @"std.core.arc::_arc_drop_thunk_for__inst__361a475bfe08ec3d"(ptr %ctrl) comdat {
.bb.entry:
  %buf__addr = alloca %Struct_std_2Emem_RawBuffer_864958797bafab1a
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str202, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = add i64 0, 1
  %struct3 = insertvalue %Struct_std_2Emem_RawBuffer_864958797bafab1a zeroinitializer, ptr %ctrl, 0
  %.t4 = insertvalue %Struct_std_2Emem_RawBuffer_864958797bafab1a %struct3, i64 %.t3, 1
  store %Struct_std_2Emem_RawBuffer_864958797bafab1a %.t4, ptr %buf__addr
  %.t6 = add i64 0, 0
  %rawbuf4 = load %Struct_std_2Emem_RawBuffer_864958797bafab1a, ptr %buf__addr
  %rawptr5 = extractvalue %Struct_std_2Emem_RawBuffer_864958797bafab1a %rawbuf4, 0
  %rawcap6 = extractvalue %Struct_std_2Emem_RawBuffer_864958797bafab1a %rawbuf4, 1
  %strptr7 = getelementptr inbounds { i64, i64, [18 x i8] }, ptr @.str17, i32 0, i32 2, i32 0
  %str08 = insertvalue %DriftString zeroinitializer, i64 17, 0
  %str9 = insertvalue %DriftString %str08, ptr %strptr7, 1
  call void @drift_bounds_check(%DriftString %str9, i64 %.t6, i64 %rawcap6)
  %rawgep10 = getelementptr %Struct_std_2Ecore_2Earc_ArcBox_431f4747e835d3fd, ptr %rawptr5, i64 %.t6
  %.t7 = load %Struct_std_2Ecore_2Earc_ArcBox_431f4747e835d3fd, ptr %rawgep10
  %zero_struct11 = insertvalue %Struct_std_2Ecore_2Earc_ArcBox_431f4747e835d3fd zeroinitializer, %Struct_std_2Ecore_2Earc_ArcHeader_363bcf8619c06fdd zeroinitializer, 0
  %__arc1 = insertvalue %Struct_std_2Ecore_2Earc_ArcBox_431f4747e835d3fd %zero_struct11, %Struct_std_2Econcurrent_Mutex_d7f34c574102f8fe zeroinitializer, 1
  %drop_field12 = extractvalue %Struct_std_2Ecore_2Earc_ArcBox_431f4747e835d3fd %.t7, 1
  %drop_field13 = extractvalue %Struct_std_2Econcurrent_Mutex_d7f34c574102f8fe %drop_field12, 1
  call void @"std.concurrent::ResultState<T>::std.core.Destructible::destroy__inst__d85c418601eb1d2e"(%Struct_std_2Econcurrent_ResultState_c3dbda09a0eaac79 %drop_field13)
  %.t9 = load %Struct_std_2Emem_RawBuffer_864958797bafab1a, ptr %buf__addr
  %rawptr14 = extractvalue %Struct_std_2Emem_RawBuffer_864958797bafab1a %.t9, 0
  call void @drift_free_array(ptr %rawptr14)
  ret void
}
define linkonce_odr void @"std.concurrent::MutexGuard<T>::std.core.Destructible::destroy__inst__690dc3eee478c1e7"(%Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b %self) comdat {
.bb.entry:
  %self__addr = alloca %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b
  store %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b %self, ptr %self__addr
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str203, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t2 = load %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b, ptr %self__addr
  %field83 = extractvalue %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b %.t2, 2
  %.t3 = icmp ne i8 %field83, 0
  br i1 %.t3, label %.bb.if_then, label %.bb.if_join
.bb.if_then:
  %.t5 = getelementptr inbounds %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b, ptr %self__addr, i32 0, i32 0
  %.t6 = load ptr, ptr %.t5
  %.t7 = getelementptr inbounds %Struct_std_2Econcurrent_Mutex_d7f34c574102f8fe, ptr %.t6, i32 0, i32 0
  %.t8 = add i1 0, 0
  %.t9 = add i64 0, 2
  %atomic_ptr4 = getelementptr inbounds %Struct_lang_2Eatomic_AtomicBool_4466cda2157b83d3, ptr %.t7, i32 0, i32 0
  %bool85 = zext i1 %.t8 to i8
  call void @drift_atomic_store_bool(ptr %atomic_ptr4, i8 %bool85, i64 %.t9)
  br label %.bb.if_join
.bb.if_join:
  %__cleanup_t1 = load %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b, ptr %self__addr
  %zero_struct6 = insertvalue %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b zeroinitializer, ptr null, 0
  %zero_struct7 = insertvalue %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b %zero_struct6, ptr null, 1
  %__arc1 = insertvalue %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b %zero_struct7, i8 0, 2
  store %Struct_std_2Econcurrent_MutexGuard_4ca67e1ecafb127b %__arc1, ptr %self__addr
  ret void
}
define i64 @"spike::__lambda_cb_main_0_0"(ptr %__env_0) {
.bb.entry:
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str204, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = getelementptr inbounds %Struct_spike___lambda_env_cb_main_0_0_7b89ae1f0169a0da, ptr %__env_0, i32 0, i32 0
  %.t4 = load %Struct_std_2Enet_TcpListener_7d3d9b3ee7d65cad, ptr %.t3
  %__arc1 = insertvalue %Struct_std_2Enet_TcpListener_7d3d9b3ee7d65cad zeroinitializer, i64 0, 0
  %.t7 = insertvalue %Struct_std_2Enet_TcpListener_7d3d9b3ee7d65cad zeroinitializer, i64 0, 0
  store %Struct_std_2Enet_TcpListener_7d3d9b3ee7d65cad %.t7, ptr %.t3
  %.t9 = getelementptr inbounds %Struct_spike___lambda_env_cb_main_0_0_7b89ae1f0169a0da, ptr %__env_0, i32 0, i32 1
  %.t10 = load %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba, ptr %.t9
  %__arc2 = insertvalue %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba zeroinitializer, %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa zeroinitializer, 0
  %.t13 = insertvalue %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba zeroinitializer, %Struct_std_2Emem_RawBuffer_1b66b676bebd11aa zeroinitializer, 0
  store %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba %.t13, ptr %.t9
  %.t14 = call i64 @"spike::_echo_serve"(%Struct_std_2Enet_TcpListener_7d3d9b3ee7d65cad %.t4, %Struct_std_2Ecore_2Earc_Arc_68b0df23800e03ba %.t10)
  ret i64 %.t14
}
define void @"std.concurrent::__lambda_cb_spawn_cb__inst__5634e65d835e6c93_0_0"(ptr %__env_0) {
.bb.entry:
  %iface_tmp_entry8 = alloca %DriftIface
  %strptr1 = getelementptr inbounds { i64, i64, [1 x i8] }, ptr @.str205, i32 0, i32 2, i32 0
  %str02 = insertvalue %DriftString zeroinitializer, i64 0, 0
  %.t1 = insertvalue %DriftString %str02, ptr %strptr1, 1
  %.t3 = getelementptr inbounds %Struct_std_2Econcurrent___lambda_env_cb_spawn_cb__inst__5634e65d835e6c93_0_0_6efcf5ee02e3b4f9, ptr %__env_0, i32 0, i32 0
  %.t5 = load %Struct_std_2Econcurrent___lambda_env_cb_spawn_cb__inst__5634e65d835e6c93_0_0_6efcf5ee02e3b4f9, ptr %__env_0
  %.t6 = extractvalue %Struct_std_2Econcurrent___lambda_env_cb_spawn_cb__inst__5634e65d835e6c93_0_0_6efcf5ee02e3b4f9 %.t5, 1
  %iface_data3 = extractvalue %DriftIface %.t6, 0
  %iface_vtable4 = extractvalue %DriftIface %.t6, 1
  %iface_inline5 = extractvalue %DriftIface %.t6, 3
  %iface_inline_bit6 = and i8 %iface_inline5, 1
  %iface_is_inline7 = icmp ne i8 %iface_inline_bit6, 0
  store %DriftIface %.t6, ptr %iface_tmp_entry8
  %iface_inline_field9 = getelementptr inbounds %DriftIface, ptr %iface_tmp_entry8, i32 0, i32 2
  %iface_inline_word10 = getelementptr inbounds [4 x i64], ptr %iface_inline_field9, i32 0, i32 0
  %iface_data_eff12 = select i1 %iface_is_inline7, ptr %iface_inline_word10, ptr %iface_data3
  %call_slot13 = getelementptr inbounds ptr, ptr %iface_vtable4, i32 1
  %call_ptr14 = load ptr, ptr %call_slot13
  %.t7 = call i64 (ptr) %call_ptr14(ptr %iface_data_eff12)
  call void @"std.concurrent::_publish_or_drop__inst__6e175d0504d59ca9"(ptr %.t3, i64 %.t7)
  ret void
}
define { i8, ptr } @"std.io::install_process_preamble"() {
__bb_entry:
  %ok = call i1 @"std.io::install_process_preamble__impl"()
  %ok_abi = zext i1 %ok to i8
  %tmp0 = insertvalue { i8, ptr } zeroinitializer, i8 %ok_abi, 0
  %tmp1 = insertvalue { i8, ptr } %tmp0, ptr null, 1
  ret { i8, ptr } %tmp1
}
define internal i64 @drift_main_argv_thunk() {
__bb_entry:
  %argc = load i32, ptr @drift_root_argc
  %argv = load ptr, ptr @drift_root_argv
  %arr.ptr = alloca %DriftArrayHeader
  call void @drift_build_argv(ptr %arr.ptr, i32 %argc, ptr %argv)
  %arr = load %DriftArrayHeader, ptr %arr.ptr
  %len = extractvalue %DriftArrayHeader %arr, 0
  %cap = extractvalue %DriftArrayHeader %arr, 1
  %gen = extractvalue %DriftArrayHeader %arr, 2
  %data_raw = extractvalue %DriftArrayHeader %arr, 3
  %tmp0 = insertvalue %DriftArrayHeader zeroinitializer, i64 %len, 0
  %tmp1 = insertvalue %DriftArrayHeader %tmp0, i64 %cap, 1
  %tmp2 = insertvalue %DriftArrayHeader %tmp1, i64 %gen, 2
  %argv_typed = insertvalue %DriftArrayHeader %tmp2, ptr %data_raw, 3
  %ret = call i64 @drift_main(%DriftArrayHeader %argv_typed)
  ret i64 %ret
}
define i32 @main(i32 %argc, ptr %argv) {
__bb_entry:
  store i32 %argc, ptr @drift_root_argc
  store ptr %argv, ptr @drift_root_argv
  %pre = call i1 @"std.io::install_process_preamble__impl"()
  %ret = call i64 @drift_run_main_on_vt(ptr @drift_main_argv_thunk)
  %trunc = trunc i64 %ret to i32
  ret i32 %trunc
}
