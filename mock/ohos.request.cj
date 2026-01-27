/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
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


package ohos.request

import ohos.app.ability.ui_ability.UIAbilityContext
import ohos.callback_invoke.*
import ohos.labels.APILevel
import std.collection.HashMap

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Request.FileTransferAgent"
]
public enum EventCallbackType {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    Progress
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    Completed
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    Failed
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    Pause
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    Resume
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    Remove
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    Response
    | ...
}

extend EventCallbackType <: ToString {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public func toString(): String {
        return String()
    }
}

extend EventCallbackType <: Hashable {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public func hashCode(): Int64 {
        return 0
    }
}

extend EventCallbackType <: Equatable<EventCallbackType> {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public operator func ==(other: EventCallbackType): Bool {
        return true
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public operator func !=(other: EventCallbackType): Bool {
        return true
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Request.FileTransferAgent"
]
public enum Action {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    Download
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    Upload
    | ...
}

extend Action <: ToString {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public func toString(): String {
        return String()
    }
}

extend Action <: Equatable<Action> {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public operator func ==(other: Action): Bool {
        return true
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public operator func !=(other: Action): Bool {
        return true
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Request.FileTransferAgent"
]
public enum Mode {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    Background
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    Foreground
    | ...
}

extend Mode <: ToString {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public func toString(): String {
        return String()
    }
}

extend Mode <: Equatable<Mode> {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public operator func ==(other: Mode): Bool {
        return true
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public operator func !=(other: Mode): Bool {
        return true
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Request.FileTransferAgent"
]
public enum Network {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    AnyType
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    Wifi
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    Cellular
    | ...
}

extend Network <: ToString {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public func toString(): String {
        return String()
    }
}

extend Network <: Equatable<Network> {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public operator func ==(other: Network): Bool {
        return true
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public operator func !=(other: Network): Bool {
        return true
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Request.FileTransferAgent"
]
public enum BroadcastEvent <: ToString {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    Complete | ...

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public func toString(): String {
        return String()
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Request.FileTransferAgent"
]
public class FileSpec {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public var path: String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public var mimeType: ?String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public var filename: ?String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public var extras: HashMap<String, String>

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public init(
        path: String,
        mimeType!: ?String = None,
        filename!: ?String = None,
        extras!: HashMap<String, String> = HashMap<String, String>()
    ) {
        super()
        this.path = String()
        this.mimeType = None
        this.filename = None
        this.extras = HashMap()
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Request.FileTransferAgent"
]
public enum FormItemValue {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ] StringItem(String)
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    | ...
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Request.FileTransferAgent"
]
public class FormItem {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public var name: String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public var value: FormItemValue

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public init(name: String, value: FormItemValue) {
        super()
        this.name = String()
        this.value = FormItemValue.StringItem(String())
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Request.FileTransferAgent"
]
public enum ConfigData {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ] StringValue(String)
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    | ...
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Request.FileTransferAgent"
]
public class Config {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public var action: Action

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public var url: String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public var title: ?String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public var description: String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public var mode: Mode

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public var overwrite: Bool

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public var method: ?String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public var headers: HashMap<String, String>

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public var data: ?ConfigData

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public var saveas: String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public var network: Network

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public var metered: Bool

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public var roaming: Bool

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public var retry: Bool

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public var redirect: Bool

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public var index: UInt32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public var begins: Int64

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public var ends: Int64

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public var gauge: Bool

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public var precise: Bool

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public var token: ?String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public var priority: UInt32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public var extras: HashMap<String, String>

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public init(
        action: Action,
        url: String,
        title!: ?String = None,
        description!: String = "",
        mode!: Mode = Mode.Background,
        overwrite!: Bool = false,
        method!: ?String = None,
        headers!: HashMap<String, String> = HashMap<String, String>(),
        data!: ?ConfigData = None,
        saveas!: String = "./",
        network!: Network = Network.AnyType,
        metered!: Bool = false,
        roaming!: Bool = true,
        retry!: Bool = true,
        redirect!: Bool = true,
        index!: UInt32 = 0,
        begins!: Int64 = 0,
        ends!: Int64 = -1,
        gauge!: Bool = false,
        precise!: Bool = false,
        token!: ?String = None,
        priority!: UInt32 = 0,
        extras!: HashMap<String, String> = HashMap<String, String>()
    ) {
        super()
        this.action = Action.Download
        this.url = String()
        this.title = None
        this.description = String()
        this.mode = Mode.Background
        this.overwrite = true
        this.method = None
        this.headers = HashMap()
        this.data = None
        this.saveas = String()
        this.network = Network.AnyType
        this.metered = true
        this.roaming = true
        this.retry = true
        this.redirect = true
        this.index = 0
        this.begins = 0
        this.ends = 0
        this.gauge = true
        this.precise = true
        this.token = None
        this.priority = 0
        this.extras = HashMap()
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Request.FileTransferAgent"
]
public enum State {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    Initialized
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    Waiting
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    Running
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    Retrying
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    Paused
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    Stopped
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    Completed
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    Failed
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    Removed
    | ...
}

extend State <: ToString {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public func toString(): String {
        return String()
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Request.FileTransferAgent"
]
public class Progress {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public let state: State

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public let index: UInt32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public let processed: Int64

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public let sizes: Array<Int64>

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public let extras: HashMap<String, String>
    
    public init() {
        super()
        this.state = State.Initialized
        this.index = 0
        this.processed = 0
        this.sizes = Array()
        this.extras = HashMap()
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Request.FileTransferAgent"
]
public class HttpResponse {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public let version: String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public let statusCode: Int32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public let reason: String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public let headers: HashMap<String, Array<String>>
    
    public init() {
        super()
        this.version = String()
        this.statusCode = 0
        this.reason = String()
        this.headers = HashMap()
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Request.FileTransferAgent"
]
public enum Faults {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    Others
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    Disconnected
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    Timeout
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    Protocol
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    Fsio
    | ...
}

extend Faults <: ToString {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public func toString(): String {
        return String()
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Request.FileTransferAgent"
]
public class Filter {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public var before: ?Int64

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public var after: ?Int64

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public var state: ?State

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public var action: ?Action

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public var mode: ?Mode

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public init(
        before!: ?Int64 = None,
        after!: ?Int64 = None,
        state!: ?State = None,
        action!: ?Action = None,
        mode!: ?Mode = None
    ) {
        super()
        this.before = None
        this.after = None
        this.state = None
        this.action = None
        this.mode = None
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Request.FileTransferAgent"
]
public class TaskInfo {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public let saveas: String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public let url: String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public let data: ConfigData

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public let tid: String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public let title: String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public let description: String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public let action: Action

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public let mode: Mode

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public let priority: UInt32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public let mimeType: String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public let progress: Progress

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public let gauge: Bool

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public let ctime: UInt64

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public let mtime: UInt64

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public let retry: Bool

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public let tries: UInt32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public let faults: Faults

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public let reason: String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public let extras: HashMap<String, String>
    
    public init() {
        super()
        this.saveas = String()
        this.url = String()
        this.data = ConfigData.StringValue(String())
        this.tid = String()
        this.title = String()
        this.description = String()
        this.action = Action.Download
        this.mode = Mode.Background
        this.priority = 0
        this.mimeType = String()
        this.progress = Progress()
        this.gauge = true
        this.ctime = 0
        this.mtime = 0
        this.retry = true
        this.tries = 0
        this.faults = Faults.Others
        this.reason = String()
        this.extras = HashMap()
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Request.FileTransferAgent"
]
public class Task {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public let tid: String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public var config: Config

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public init(tid: String, config: Config) {
        super()
        this.tid = String()
        this.config = Config(
            Action.Download,
            String(),
            title: None,
            description: String(),
            mode: Mode.Background,
            overwrite: true,
            method: None,
            headers: HashMap(),
            data: None,
            saveas: String(),
            network: Network.AnyType,
            metered: true,
            roaming: true,
            retry: true,
            redirect: true,
            index: 0,
            begins: 0,
            ends: 0,
            gauge: true,
            precise: true,
            token: None,
            priority: 0,
            extras: HashMap()
        )
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public func on(event: EventCallbackType, callback: Callback1Argument<HttpResponse>): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public func on(event: EventCallbackType, callback: Callback1Argument<Progress>): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent"
    ]
    public func off(event: EventCallbackType, callback!: ?CallbackObject = None): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        permission: "ohos.permission.INTERNET",
        syscap: "SystemCapability.Request.FileTransferAgent",
        throwexception: true,
        workerthread: true
    ]
    public func start(): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        permission: "ohos.permission.INTERNET",
        syscap: "SystemCapability.Request.FileTransferAgent",
        throwexception: true,
        workerthread: true
    ]
    public func pause(): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        permission: "ohos.permission.INTERNET",
        syscap: "SystemCapability.Request.FileTransferAgent",
        throwexception: true,
        workerthread: true
    ]
    public func resume(): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Request.FileTransferAgent",
        throwexception: true,
        workerthread: true
    ]
    public func stop(): Unit {
        return ()
    }
}

@!APILevel[
    since: "22",
    permission: "ohos.permission.INTERNET",
    syscap: "SystemCapability.Request.FileTransferAgent",
    throwexception: true,
    workerthread: true
]
public func create(context: UIAbilityContext, config: Config): Task {
    return Task(
        String(),
        Config(
            Action.Download,
            String(),
            title: None,
            description: String(),
            mode: Mode.Background,
            overwrite: true,
            method: None,
            headers: HashMap(),
            data: None,
            saveas: String(),
            network: Network.AnyType,
            metered: true,
            roaming: true,
            retry: true,
            redirect: true,
            index: 0,
            begins: 0,
            ends: 0,
            gauge: true,
            precise: true,
            token: None,
            priority: 0,
            extras: HashMap()
        )
    )
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Request.FileTransferAgent",
    throwexception: true,
    workerthread: true
]
public func remove(id: String): Unit {
    return ()
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Request.FileTransferAgent",
    throwexception: true,
    workerthread: true
]
public func getTask(context: UIAbilityContext, id: String, token!: ?String = None): Task {
    return Task(
        String(),
        Config(
            Action.Download,
            String(),
            title: None,
            description: String(),
            mode: Mode.Background,
            overwrite: true,
            method: None,
            headers: HashMap(),
            data: None,
            saveas: String(),
            network: Network.AnyType,
            metered: true,
            roaming: true,
            retry: true,
            redirect: true,
            index: 0,
            begins: 0,
            ends: 0,
            gauge: true,
            precise: true,
            token: None,
            priority: 0,
            extras: HashMap()
        )
    )
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Request.FileTransferAgent",
    throwexception: true,
    workerthread: true
]
public func show(id: String): TaskInfo {
    return TaskInfo()
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Request.FileTransferAgent",
    throwexception: true,
    workerthread: true
]
public func touch(id: String, token: String): TaskInfo {
    return TaskInfo()
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Request.FileTransferAgent",
    throwexception: true,
    workerthread: true
]
public func search(filter!: Filter = Filter()): Array<String> {
    return Array()
}
