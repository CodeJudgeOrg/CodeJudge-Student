/// Copyright 2026 Fabian Roland (naibaf-1)

/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at

/// http://www.apache.org/licenses/LICENSE-2.0

/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

import 'dart:ffi';
import 'package:ffi/ffi.dart';

typedef CJudgerFunc = Pointer<Utf8> Function(Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>);
typedef DartJudgerFunc = Pointer<Utf8> Function(Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>);

// Define the bindings for my library
class JudgerLib {
  late final DynamicLibrary _lib;
  late final DartJudgerFunc runJudge;

  JudgerLib(this._lib) {
    runJudge = _lib.lookup<NativeFunction<CJudgerFunc>>('runJudge').asFunction();
  }

  // Function "translating" between the library and the flutter code
  String callJudger(String code, String programmingLanguage, String solution) {
    final codePointer = code.toNativeUtf8();
    final languagePointer = programmingLanguage.toNativeUtf8();
    final solutionPointer = solution.toNativeUtf8();

    final resultPointer = runJudge(codePointer, languagePointer, solutionPointer);

    final result = resultPointer.toDartString();

    // Free memory, because the library doesn't free it
    malloc.free(codePointer);
    malloc.free(languagePointer);
    malloc.free(solutionPointer);

    return result;
  }
}
