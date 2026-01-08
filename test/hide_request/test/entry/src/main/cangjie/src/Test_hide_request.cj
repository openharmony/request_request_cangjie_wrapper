/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package ohos_app_cangjie_entry

internal import ohos.ark_interop.*
internal import kit.PerformanceAnalysisKit.Hilog
internal import kit.BasicServicesKit.*
internal import kit.BasicServicesKit.CommonEventValueType as CEMValueType
internal import ohos.base.*
internal import std.runtime.*
internal import std.sync.*
internal import std.time.*
import std.unittest.testmacro.*
import std.unittest.*
import std.unittest.common.*
import std.unittest.testmacro.*
import ohos.base.*
import std.collection.HashMap
import ohos.business_exception.*
import kit.PerformanceAnalysisKit.Hilog

@Test
class Test_hide_request {
    override func afterAll(): Unit {
        sleepFor(1.second)
    }

    @TestCase
    @Skip
    @Tag[APILevel22, TestLevel0]
    func testHideEnum(): Unit {
        let instance1 = Faults.Param
        let instance2 = Faults.Tcp
    }
}
