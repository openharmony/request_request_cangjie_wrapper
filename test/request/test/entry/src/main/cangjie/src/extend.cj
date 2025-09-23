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

/**
 * Created on 2024/8/6
 */
package ohos_app_cangjie_entry

import BasicServicesKit.*

extend Config {
    public operator func ==(other: Config): Bool {
        return this.action == other.action && this.url == other.url && this.description == other.description &&
            this.overwrite == other.overwrite && this.network == other.network && this.metered == other.metered &&
            this.roaming == other.roaming && this.retry == other.retry && this.redirect == other.redirect &&
            this.index == other.index && this.begins == other.begins && this.ends == other.ends && this.gauge == other
            .gauge && this.precise == other.precise && this.priority == other.priority
    }
    // this.mode == other.mode method saveas network token extras
    public func toString(): String {
        let sb = StringBuilder()
        sb.append("(action, ${action}), ")
        sb.append("(url, ${url}), ")
        sb.append("(title, ${title}), ")
        sb.append("(description, ${description}), ")
        sb.append("(overwrite, ${overwrite}), ")
        sb.append("(network, ${network}), ")
        sb.append("(metered, ${metered}), ")
        sb.append("(roaming, ${roaming}), ")
        sb.append("(retry, ${retry}), ")
        sb.append("(redirect, ${redirect}), ")
        sb.append("(index, ${index}), ")
        sb.append("(begins, ${begins}), ")
        sb.append("(ends, ${ends}), ")
        sb.append("(gauge, ${gauge}), ")
        sb.append("(precise, ${precise}), ")
        sb.append("(priority, ${priority})")
        return sb.toString()
    }
}

extend Task {
    public operator func ==(other: Task): Bool {
        return this.tid == other.tid && this.config == other.config
    }
}
