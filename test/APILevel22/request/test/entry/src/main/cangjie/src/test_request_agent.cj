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

import std.convert.*
import std.unittest.*
import std.unittest.testmacro.*
import CoreFileKit.{FileIo, OpenMode}
import AbilityKit.{AbilityStageContext, UIAbilityContext, Want}
import BasicServicesKit.{State as RState, Filter as RFilter, Action as RAction, Progress as RProgress, remove as rRemove
    }
import BasicServicesKit.*
import std.collection.*
import std.runtime.*
import std.sync.*
import std.time.*
import std.unittest.*
import std.unittest.common.*
import std.unittest.testmacro.*
import ohos.base.*
import ohos.callback_invoke.*
import ohos.business_exception.*
import PerformanceAnalysisKit.Hilog

public func requestWaitFor(timeout: Duration, condition: () -> Bool) {
    let monitor = Monitor()
    let conditionIsMet = AtomicBool(false)
    let checkerTimer = Timer.repeatDuring(timeout, Duration.Zero, Duration.millisecond * 500,
        {
            => if (condition()) {
                conditionIsMet.store(true)
                synchronized(monitor) {
                    monitor.notify()
                }
            }
        })
    let cancellerTimer = Timer.once(timeout) {
        => synchronized(monitor) {
            monitor.notify()
        }
    }
    synchronized(monitor) {
        monitor.wait()
    }
    if (conditionIsMet.load()) {
        Hilog.info(0, "CangjieTest", "condition passed")
    } else {
        @Assert(false)
    }
    checkerTimer.cancel()
    cancellerTimer.cancel()
}

const EXCEPTION_PERMISSION: Int32 = 201
const EXCEPTION_PARAMCHECK: Int32 = 401
const EXCEPTION_UNSUPPORTED: Int32 = 801
const EXCEPTION_FILEIO: Int32 = 13400001
const EXCEPTION_FILEPATH: Int32 = 13400002
const EXCEPTION_SERVICE: Int32 = 13400003
const EXCEPTION_OTHERS: Int32 = 13499999
const EXCEPTION_TASK_NOT_FOUND: Int32 = 21900006

@Test
class TestRequestAgent {
    // /data/app/el2/100/base/com.example.requestllt/haps/entry/cache
    let DefaultSandBoxCache = "/data/storage/el2/base/haps/entry/cache"
    let now = DateTime.now()
    let fileName = "test_${now.month}_${now.dayOfMonth}_${now.hour}_${now.minute}_${now.second}_${now.nanosecond}.txt"
    let filePath = "${DefaultSandBoxCache}/${fileName}"
    let zipURL = "https://gitee.com/openharmony/docs/repository/archive/OpenHarmony-6.0-Release.zip"
    let fileURL = "https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png"
    let responseCallback = HttpResponseCallback()
    let pauseCallback = MyCallback(Beused: false)
    override func afterAll(): Unit {
        GC()
        sleep(Duration.second)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func CreateTask_BaseFunction_Success(): Unit {
        let now = DateTime.now()
        let fileName = "test_${now.month}_${now.dayOfMonth}_${now.hour}_${now.minute}_${now.second}_${now.nanosecond}.txt"
        let filePath = "${DefaultSandBoxCache}/${fileName}"
        let config = Config(
            RAction.Download,
            fileURL,
            saveas: fileName,
            headers: HashMap<String, String>([("headers", "http")]),
            metered: false,
            roaming: true,
            description: "download test",
            network: Network.AnyType,
            title: "download test title"
        )
        let task = create(getAbilityContext(), config)
        task.on(EventCallbackType.Response, responseCallback)
        task.start()
        // will fail if the certificate is compromised
        requestWaitFor(Duration.second * 10) {
            =>
            let stat = FileIo.stat(filePath)
            let size = stat.size
            //Hilog.info(0, "CangjieTest", "size = ${size}")
            size > 0
        }
        Hilog.info(0, "CangjieTest", "task.tid = ${task.tid}")
        let task2 = getTask(getAbilityContext(), task.tid)
        @Expect(task == task2)
        if (FileIo.access(filePath)) {
            FileIo.unlink(filePath)
        }
        rRemove(task.tid)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func CreateTask_NoFilePermission_ThrowExcept(): Unit {
        let task: Task
        try {
            let invaliedFilePath = "/data/storage/No_file_Permission.txt"
            let config = Config(
                RAction.Download,
                fileURL,
                saveas: invaliedFilePath
            )
            task = create(getAbilityContext(), config)
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(e.code, EXCEPTION_PARAMCHECK)
            //@Expect(e.message.contains("the parameters check fails"))
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func CreateTask_DuplicatefilePath_ThrowExcept(): Unit {
        try {
            let config = Config(
                RAction.Download,
                fileURL,
                saveas: fileName
            )
            let task1 = create(getAbilityContext(), config)
            let task2 = create(getAbilityContext(), config)
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(e.code, EXCEPTION_FILEIO)
            //@Expect(e.message.contains("file operation error"))
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func InvalidConfig_URLExceedMaxLength_ThrowExcept(): Unit {
        try {
            const MAX_URL_SIZE = 2048
            let invalidURL = String(Array<Rune>(MAX_URL_SIZE + 1, repeat: r'a'))
            let invalidURLConfig = Config(
                RAction.Upload,
                invalidURL
            )
            create(getAbilityContext(), invalidURLConfig)
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(e.code, EXCEPTION_PARAMCHECK)
            //@Expect(e.message.contains("the parameters check fails"))
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func InvalidConfig_URLFormatError_ThrowExcept(): Unit {
        try {
            // url must be "^http(s)?:\\/\\/.+"
            let invalidURL = "invalid_url_format"
            let invalidURLConfig = Config(
                RAction.Upload,
                invalidURL
            )
            create(getAbilityContext(), invalidURLConfig)
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(e.code, EXCEPTION_PARAMCHECK)
            //@Expect(e.message.contains("the parameters check fails"))
        }
    }
    @TestCase
    @Tag[APILevel22, TestLevel0]
    func ShowTask_BaseFunction_Success(): Unit {
        let config = Config(
            RAction.Download,
            fileURL,
            saveas: "success.txt",
            overwrite: true,
            description: "success test task",
            priority: 2,
            gauge: false
        )
        let notStartTask = create(getAbilityContext(), config)
        let taskInfo = show(notStartTask.tid)
        @Expect(taskInfo.action.toString(), config.action.toString())
        @Expect(taskInfo.url, config.url)
        @Expect(taskInfo.saveas, DefaultSandBoxCache + "/" + (config.saveas))
        @Expect(taskInfo.description, config.description)
        @Expect(taskInfo.priority, config.priority)
        @Expect(taskInfo.gauge, config.gauge)
        rRemove(notStartTask.tid)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func ShowTask_NotFoundTask_ThrowExecption(): Unit {
        try {
            let task = show("22222")
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(e.code, EXCEPTION_TASK_NOT_FOUND)
            //@Expect(e.message.contains("task not found"))
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func TouchTask_BaseFunction_Success(): Unit {
        let config = Config(
            RAction.Download,
            fileURL,
            token: "success1",
            overwrite: true,
            description: "success test task",
            priority: 2,
            gauge: false
        )
        let task = create(getAbilityContext(), config)
        task.start()
        let taskInfo = touch(task.tid, "success1")
        @Expect(taskInfo.action.toString(), config.action.toString())
        @Expect(taskInfo.url, config.url)
        @Expect(taskInfo.description, config.description)
        @Expect(taskInfo.priority, config.priority)
        @Expect(taskInfo.gauge, config.gauge)
        rRemove(task.tid)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func TouchTask_TokenError_ThrowExecption(): Unit {
        let config = Config(
            RAction.Download,
            fileURL,
            token: "success1",
            overwrite: true
        )
        let task = create(getAbilityContext(), config)
        task.start()
        try {
            let task = touch(task.tid, "Wrong Token")
            @Expect(false)
        } catch (e: BusinessException) {
            if (FileIo.access(filePath)) {
                FileIo.unlink(filePath)
            }
            @Expect(e.code, EXCEPTION_TASK_NOT_FOUND)
            //@Expect(e.message.contains("task not found"))
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func TouchTask_NotFoundTask_ThrowExecption(): Unit {
        try {
            touch("22222", "null2222222")
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(e.code, EXCEPTION_TASK_NOT_FOUND)
            //@Expect(e.message.contains("task not found"))
        }
    }

    func createTasks(): (Task, Task) {
        let config = Config(
            RAction.Download,
            fileURL,
            overwrite: true
        )
        let notStartTask = create(getAbilityContext(), config)
        let file = FileIo.open(
            "${DefaultSandBoxCache}/test.txt",
            mode: OpenMode.READ_WRITE | OpenMode.CREATE
        )
        FileIo.write(file.fd, "TEST")
        FileIo.close(file)
        let fileSpec = FileSpec("./test.txt")
        let data = ConfigData.FormItems([FormItem("test", FormItemValue.FileItem(fileSpec))])
        let uploadConfig = Config(
            RAction.Upload,
            "http://127.0.0.1",
            data: data
        )
        let uploadFailedTask = create(getAbilityContext(), uploadConfig)
        uploadFailedTask.start()
        (notStartTask, uploadFailedTask)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func SearchTask_GetAllTask_Success(): Unit {
        let (notStartTask, uploadTask) = createTasks()
        let (notStartTid, uploadTid) = (notStartTask.tid, uploadTask.tid)
        let expectAllTids: Array<String> = search()
        @Expect(expectAllTids.contains(notStartTid))
        @Expect(expectAllTids.contains(uploadTid))

        let initTids: Array<String> = search(filter: RFilter(state: RState.Initialized))
        @Expect(initTids.contains(notStartTid))

        let emptyTids: Array<String> = search(filter: RFilter(mode: Mode.Foreground))
        @Expect(emptyTids.contains(notStartTid), false)

        rRemove(notStartTid)
        rRemove(uploadTid)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func TaskStartthenPause_TestSizeTwice_SizeEqual(): Unit {
        let config = Config(
            RAction.Download,
            zipURL,
            saveas: fileName,
            overwrite: true
        )
        let task = create(getAbilityContext(), config)
        task.start()
        task.pause()
        sleepFor(1.second)
        let stat2 = FileIo.stat(filePath)
        let size2 = stat2.size
        sleepFor(1.second)
        let stat3 = FileIo.stat(filePath)
        let size3 = stat3.size
        @Expect(size3,size2)
        if (FileIo.access(filePath)) {
            FileIo.unlink(filePath)
        }
        rRemove(task.tid)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func TaskStartthenResume_TaskFinished_ThrowExcption(): Unit {
        let config = Config(
            RAction.Download,
            zipURL,
            saveas: fileName,
            overwrite: true
        )
        let task = create(getAbilityContext(), config)
        task.start()
        try {
            task.resume()
            @Expect(false)
        } catch (e: Exception) {
            Hilog.error(0, "CangjieTest", e.toString())
        //@Expect(e.message,"task state error")
        } finally {
            if (FileIo.access(filePath)) {
                FileIo.unlink(filePath)
            }
            rRemove(task.tid)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func TaskResume_WithoutStart_ThrowExcption() {
        let config = Config(
            RAction.Download,
            fileURL,
            saveas: fileName,
            overwrite: true
        )
        let task = create(getAbilityContext(), config)
        try {
            task.resume()
            @Expect(false)
        } catch (e: Exception) {
            Hilog.error(0, "CangjieTest", e.toString())
        //@Expect(e.message,"task state error")
        } finally {
            rRemove(task.tid)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func TaskStop_WithoutStart_ThrowExcption(): Unit {
        let config = Config(
            RAction.Download,
            fileURL,
            overwrite: true
        )
        let task = create(getAbilityContext(), config)
        try {
            task.stop()
            @Expect(false)
        } catch (e: Exception) {
            Hilog.error(0, "CangjieTest", e.toString())
        //@Expect(e.message,"task state error")
        } finally {
            rRemove(task.tid)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func TaskStratthenStop_TestSizeTwice_SizeEqual(): Unit {
        let config = Config(
            RAction.Download,
            zipURL,
            saveas: fileName,
            overwrite: true
        )
        let task = create(getAbilityContext(), config)
        task.start()
        @Expect(FileIo.access(filePath))
        task.stop()
        sleepFor(1.second)
        let stat2 = FileIo.stat(filePath)
        let size2 = stat2.size
        sleepFor(1.second)
        @Expect( FileIo.stat(filePath).size,size2)
        if (FileIo.access(filePath)) {
            FileIo.unlink(filePath)
        }
        rRemove(task.tid)
    }

    @TestCase
    @Tag[APILevel12, TestLevel0]
    func TaskStartthenPausethenStop_TestSizeTwice_SizeEqual_TaskFinished_ThrowExcption(): Unit {
        let config = Config(
            RAction.Download,
            zipURL,
            saveas: fileName,
            overwrite: true
        )
        let task = create(getAbilityContext(), config)
        task.start()
        @Expect(FileIo.access(filePath),true)
        task.pause()
        let stat2 = FileIo.stat(filePath)
        let stat3 = FileIo.stat(filePath)
        let size2 = stat2.size
        let size3 = stat2.size
        @Expect(size3,size2)
        if (FileIo.access(filePath)) {
            FileIo.unlink(filePath)
        }
        rRemove(task.tid)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func TaskStartthenPausethenResume_TestSizeTwice_SizeEqual(): Unit {
        let config = Config(
            RAction.Download,
            fileURL,
            saveas: fileName,
            overwrite: true
        )
        let task = create(getAbilityContext(), config)
        task.start()
        task.pause()
        sleepFor(1.second)
        let stat2 = FileIo.stat(filePath)
        let size2 = stat2.size
        sleepFor(1.second)
        let stat3 = FileIo.stat(filePath)
        let size3 = stat3.size
        @Expect(size3,size2)
        let stat = FileIo.stat(filePath)
        let size = stat.size
        task.resume()
        requestWaitFor(Duration.second * 10) {
            =>
            let stat4 = FileIo.stat(filePath)
            let size4 = stat4.size
            size4 > size
        }
        if (FileIo.access(filePath)) {
            FileIo.unlink(filePath)
        }
        rRemove(task.tid)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func TaskStart_DuplicateStart_ThrowExcption(): Unit {
        let config = Config(
            RAction.Download,
            zipURL,
            saveas: fileName,
            overwrite: true
        )
        let task = create(getAbilityContext(), config)
        task.start()
        try {
            task.start()
            @Expect(false)
        } catch (e: Exception) {
            Hilog.error(0, "CangjieTest", e.toString())
        //@Expect(e.message,"task state error")
        } finally {
            if (FileIo.access(filePath)) {
                FileIo.unlink(filePath)
            }
        }
        rRemove(task.tid)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func TaskStartthenPausethenResumethenStop_BaseFunc_Success(): Unit {
        let config = Config(
            RAction.Download,
            zipURL,
            saveas: fileName,
            overwrite: true
        )
        let task = create(getAbilityContext(), config)
        task.start()
        task.pause()
        task.resume()
        task.stop()
        if (FileIo.access(filePath)) {
            FileIo.unlink(filePath)
        }
        rRemove(task.tid)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func CreateTask_SizeLessThan8_ThrowExcption(): Unit {
        let config = Config(
            RAction.Download,
            fileURL,
            saveas: fileName,
            overwrite: true,
            token: "1234567"
        )
        try {
            let task = create(getAbilityContext(), config)
            @Expect(false)
        } catch (e: Exception) {
            @Expect(e.toString(),"BusinessException: errorcode: 401, message: Parameter verification failed, the length of token should between 8 and 2048 bytes")
        }
    }
    @TestCase
    @Tag[APILevel22, TestLevel0]
    func CreateTask_SizeMoreThan2048_ThrowExcption(): Unit {
        let str = StringBuilder(r'a', 2049)
        let token = str.toString()
        let config = Config(
            RAction.Download,
            fileURL,
            saveas: fileName,
            token: token
        )
        try {
            create(getAbilityContext(), config)
            @Expect(false)
        } catch (e: Exception) {
            @Expect(e.toString(),"BusinessException: errorcode: 401, message: Parameter verification failed, the length of token should between 8 and 2048 bytes")
        }
    }
    @TestCase
    @Tag[APILevel22, TestLevel0]
    func TaskOn_Pause_Success() {
        let config = Config(
            RAction.Download,
            zipURL,
            saveas: fileName,
            overwrite: true
        )
        let task = create(getAbilityContext(), config)
        let pauseCallback = MyCallback(Beused: false)
        task.on(EventCallbackType.Pause, pauseCallback)
        sleepFor(1.second)
        task.start()
        task.pause()
        sleepFor(1.second)
        @Expect(pauseCallback.getState(),true)
        rRemove(task.tid)
        if (FileIo.access(filePath)) {
            FileIo.unlink(filePath)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func TaskOn_Remove_Success() {
        let config = Config(
            RAction.Download,
            zipURL,
            saveas: fileName,
            overwrite: true
        )
        let task = create(getAbilityContext(), config)
        let removeCallback = MyCallback(Beused: false)
        task.on(EventCallbackType.Remove, removeCallback)
        rRemove(task.tid)
        sleepFor(1.second)
        @Expect(removeCallback.getState(),true)
        if (FileIo.access(filePath)) {
            FileIo.unlink(filePath)
        }
    }
    @TestCase
    @Tag[APILevel22, TestLevel0]
    func TaskOff_Pause_Success() {
        let config = Config(
            RAction.Download,
            zipURL,
            saveas: fileName,
            overwrite: true
        )
        let task = create(getAbilityContext(), config)
        let pauseCallback = MyCallback(Beused: false)
        task.on(EventCallbackType.Pause, pauseCallback)
        sleepFor(1.second)
        task.off(EventCallbackType.Pause, callback: pauseCallback)
        task.start()
        task.pause()
        sleepFor(1.second)
        @Expect(pauseCallback.getState(), false)
        rRemove(task.tid)
        if (FileIo.access(filePath)) {
            FileIo.unlink(filePath)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func TaskOff_Remove_Success() {
        let config = Config(
            RAction.Download,
            zipURL,
            saveas: fileName,
            overwrite: true
        )
        let task = create(getAbilityContext(), config)
        let removeCallback = MyCallback(Beused: false)
        task.on(EventCallbackType.Remove, removeCallback)
        task.off(EventCallbackType.Remove)
        sleepFor(1.second)
        rRemove(task.tid)
        sleepFor(1.second)
        @Expect(removeCallback.getState(),false)
        if (FileIo.access(filePath)) {
            FileIo.unlink(filePath)
        }
    }
    @TestCase
    @Tag[APILevel22, TestLevel0]
    func CreateFaults_toString_Success(): Unit {
        let faults1: Faults = Others
        @Expect(faults1.toString(),"Faults.Others")
        let faults2: Faults = Timeout
        @Expect(faults2.toString(),"Faults.Timeout")
        let faults3: Faults = Disconnected
        @Expect(faults3.toString(),"Faults.Disconnected")
        let faults4: Faults = Protocol
        @Expect(faults4.toString(),"Faults.Protocol")
        let faults5: Faults = Fsio
        @Expect(faults5.toString(),"Faults.Fsio")
    }
    @TestCase
    @Tag[APILevel22, TestLevel0]
    func CreateState_toString_Success(): Unit {
        let state1: State = Initialized
        @Expect(state1.toString(),"State.Initialized")
        let state2: State = Waiting
        @Expect(state2.toString(),"State.Waiting")
        let state3: State = Running
        @Expect(state3.toString(),"State.Running")
        let state4: State = Paused
        @Expect(state4.toString(),"State.Paused")
        let state5: State = Stopped
        @Expect(state5.toString(),"State.Stopped")
        let state6: State = Completed
        @Expect(state6.toString(),"State.Completed")
        let state7: State = Retrying
        @Expect(state7.toString(),"State.Retrying")
        let state8: State = Failed
        @Expect(state8.toString(),"State.Failed")
        let state9: State = Removed
        @Expect(state9.toString(),"State.Removed")
    }
    @TestCase
    @Tag[APILevel22, TestLevel0]
    func CreateNetwork_toString_Success(): Unit {
        let network1: Network = Wifi
        @Expect(network1.toString(),"Network.Wifi")
        let network2: Network = AnyType
        @Expect(network2.toString(),"Network.AnyType")
        let network3: Network = Cellular
        @Expect(network3.toString(),"Network.Cellular")
    }
    @TestCase
    @Tag[APILevel22, TestLevel0]
    func CreateMode_toString_Success(): Unit {
        let mode1: Mode = Mode.Background
        @Expect(mode1.toString(),"Mode.Background")
        let mode2: Mode = Mode.Foreground
        @Expect(mode2.toString(),"Mode.Foreground")
    }
    @TestCase
    @Tag[APILevel22, TestLevel0]
    func CreateAction_toString_Success(): Unit {
        let action1: RAction = Download
        @Expect(action1.toString(),"Action.Download")
        let action2: RAction = Upload
        @Expect(action2.toString(),"Action.Upload")
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func CreateFilter_toString_Success(): Unit {
        let filter = RFilter(
            state: RState.Completed,
            mode: Mode.Background
        )
        Hilog.info(0, "CangjieTest", filter
            .state
            .toString())
        Hilog.info(0, "CangjieTest", filter
            .action
            .toString())
        @Expect(filter.state.toString(),"Some(State.Completed)")
        @Expect(filter.action.toString(),"None")
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func CreateFileSpec_toString_Success(): Unit {
        let filespec = FileSpec("mypath")
        @Expect(filespec.path,"mypath")
        let broadcast1: BroadcastEvent = Complete
        @Expect(broadcast1.toString(), "ohos.request.event.COMPLETE")
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func CreateFormItem_toString_Success(): Unit {
        let formitem = FormItem(
            "name",
            StringItem("str")
        )
        @Expect(formitem.name,"name")
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func enumBroadcastEvent() {
        @Expect(BroadcastEvent.Complete.toString(), "ohos.request.event.COMPLETE")
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func TaskCreate_CreateUpload_ExpectSuccess(): Unit {
        let fileSpec = FileSpec("./test.txt")
        let item1 = FormItem("test1", FormItemValue.FileItem(fileSpec))
        let item2 = FormItem("test2", FormItemValue.StringItem("test2"))
        let item3 = FormItem("test3", FormItemValue.FileItemArray([fileSpec, fileSpec]))
        let FormItems = [item1, item2, item3]
        let data = ConfigData.FormItems(FormItems)

        let uploadConfig = Config(
            RAction.Upload,
            "http://127.0.0.1",
            data: data
        )
        create(getAbilityContext(), uploadConfig)
        @Expect(true)
        let task = create(getAbilityContext(), uploadConfig)
        let taskGot = getTask(getAbilityContext(), task.tid)
        Hilog.info(0, "CangjieTest", "task is ${task.config.toString()}")
        Hilog.info(0, "CangjieTest", "task2 is ${taskGot.config.toString()}")
        @Expect(task == taskGot)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func GetTask_CompareWithCreated_ExpectSame() {
        try {
            getTask(getAbilityContext(), "123")
            @Expect(false)
        } catch (e: BusinessException) {
            Hilog.error(0, "CangjieTest", e.message)
            @Expect(e.code, 21900006)
        }
        let config1 = Config(
            RAction.Download,
            fileURL,
            overwrite: true,
            mode: Mode.Foreground,
            network: Wifi,
        )
        let config2 = Config(
            RAction.Download,
            fileURL,
            overwrite: true,
            network: Cellular
        )
        let task1 = create(getAbilityContext(), config1)
        let task1_copy = getTask(getAbilityContext(), task1.tid)
        @Expect(task1 == task1_copy)
        Hilog.info(0, "CangjieTest", "task1 is ${task1.config.toString()}")
        Hilog.info(0, "CangjieTest", "task1_copy is ${task1_copy.config.toString()}")
        let task2 = create(getAbilityContext(), config2)
        @Expect(task2 == getTask(getAbilityContext(), task2.tid))
        if (FileIo.access(filePath)) {
            FileIo.unlink(filePath)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_EventCallbackType() {
        let enumArray: Array<EventCallbackType> = [EventCallbackType.Progress, Completed, Failed, Pause, Resume, Remove, Response]
        let enumArray2: Array<EventCallbackType> = [EventCallbackType.Progress, Completed, Failed, Pause, Resume, Remove, Response]
        let strArray: Array<String> = [
            "EventCallbackType.Progress",
            "EventCallbackType.Completed",
            "EventCallbackType.Failed",
            "EventCallbackType.Pause",
            "EventCallbackType.Resume",
            "EventCallbackType.Remove",
            "EventCallbackType.Response"
        ]
        for (i in 0..enumArray.size) {
            @Expect(enumArray[i] == enumArray2[i])
            @Expect(enumArray[i].toString() == strArray[i])
            @Expect(enumArray[i] != enumArray[(i + 1) % enumArray.size])
            let h = enumArray[i].hashCode()
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_EnumAction() {
        let enumArray: Array<Action> = [Download, Upload]
        let enumArray2: Array<Action> = [Download, Upload]
        let strArray: Array<String> = [
            "Action.Download",
            "Action.Upload"
        ]
        for (i in 0..enumArray.size) {
            @Expect(enumArray[i] == enumArray2[i])
            @Expect(enumArray[i].toString() == strArray[i])
            @Expect(enumArray[i] != enumArray[(i + 1) % enumArray.size])
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_EnumMode() {
        let enumArray: Array<Mode> = [Background, Foreground]
        let enumArray2: Array<Mode> = [Background, Foreground]
        let strArray: Array<String> = [
            "Mode.Background",
            "Mode.Foreground"
        ]
        for (i in 0..enumArray.size) {
            @Expect(enumArray[i] == enumArray2[i])
            @Expect(enumArray[i].toString() == strArray[i])
            @Expect(enumArray[i] != enumArray[(i + 1) % enumArray.size])
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_Network() {
        let enumArray: Array<Network> = [AnyType, Wifi, Cellular]
        let enumArray2: Array<Network> = [AnyType, Wifi, Cellular]
        let strArray: Array<String> = [
            "Network.AnyType",
            "Network.Wifi",
            "Network.Cellular"
        ]
        for (i in 0..enumArray.size) {
            @Expect(enumArray[i] == enumArray2[i])
            @Expect(enumArray[i].toString() == strArray[i])
            @Expect(enumArray[i] != enumArray[(i + 1) % enumArray.size])
        }
    }
}

public class ProgressCallback <: Callback1Argument<RProgress> {
    public ProgressCallback(let f: (RProgress) -> Unit) {}

    public open func invoke(err: ?BusinessException, arg: RProgress): Unit {
        f(arg)
    }
}

class MyCallback <: Callback1Argument<RProgress> {
    public MyCallback(public var Beused!: Bool = false) {}
    public open func invoke(err: ?BusinessException, arg: RProgress): Unit {
        Beused = true
    }
    public func getState(): Bool {
        Beused
    }
}

extend HttpResponse {
    func toString(): String {
        let sb = StringBuilder()
        sb.append("version = ${this.version}, ")
        sb.append("statusCode = ${this.statusCode}, ")
        sb.append("reason = ${this.reason}, ")
        sb.append("headers = ${this.headers}")
        return sb.toString()
    }
}

class HttpResponseCallback <: Callback1Argument<HttpResponse> {
    public HttpResponseCallback() {}
    public open func invoke(err: ?BusinessException, arg: HttpResponse): Unit {
        Hilog.info(0, "CangjieTest", "HttpResponse is ${arg.toString()}")
    }
}
