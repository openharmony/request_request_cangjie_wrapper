# request_cangjie_wrapper

## Introduction

The request_cangjie_wrapper provides upload and download capabilities for applications, including creating, removing, suspending, and starting upload and download tasks, and subscribing to the task progress and result,Cangjie open interface for uploading and downloading supports standard devices.

## System Architecture

**Figure 1** Architecture of the request_cangjie_wrapper

!["Architecture of the request_cangjie_wrapper"](figures/request_cangjie_wrapper_architecture_en.png )

As depicted in the architecture diagram:

Interface Layer

- Task Creation/Removal: Provides interfaces for creating and removing upload/download tasks.
- Query Task Information: Provides interfaces for querying upload/download task information.
- Task Start/Stop: Provides interfaces for starting and stopping already created upload/download tasks.
- Subscribe to Task Status: Provides interfaces for subscribing to task status, triggering callbacks when task status changes.
- Task Pause/Resume: Provides interfaces for pausing an executing upload/download task and resuming a paused upload/download task.

Framework Layer

- Encapsulates the underlying task capabilities to provide standardized functional support for the interface layer, including:
  - Task Creation/Removal Function Encapsulation
  - Query Task Information Function Encapsulation
  - Task Start/Stop Function Encapsulation
  - Subscribe to Task Status Function Encapsulation
  - Task Pause/Resume Function Encapsulation
- Cangjie Upload/Download FFI Interface Definition: Responsible for defining C language interoperability interfaces called by the Cangjie language to implement Cangjie upload/download capabilities.
- request: Responsible for providing upload/download basic functionality, encapsulating C language interfaces for Cangjie interoperability.
- cangjie_ark_interop: Responsible for providing Cangjie annotation class definitions for API annotation, and providing BusinessException exception class definition thrown to users.
- ability_cangjie_wrapper: Responsible for providing basic capabilities of Ability or Application context, including accessing specific application resources.
- arkui_cangjie_wrapper: Responsible for providing basic type definitions and the ability to convert CString type to String type.
* hiviewdfx_cangjie_wrapper: Responsible for providing logging interfaces for printing logs at critical paths.

## Directory Structure

```
base/request/request_cangjie_wrapper
├── figures            # architecture pictures           
├── ohos
│   └── request        # Cangjie Upload and Download code          
└── test
    └── request        # Cangjie Upload and Download test code
```

## Constraint

- If you need to use the request service, you need to apply for the ohos.permission.INTERNET permissions.
- The data unit is in file form, and the rest of the data forms need to be encapsulated by the caller into file paths by themselves.
- The request service does not provide a complete HTTP/HTTPS SDK interface. It is only for users of the HTTP/HTTPS SDK. If you need this interface, it is recommended to use [netmanager](https://gitcode.com/openharmony-sig/netmanager_netmanager_cangjie_wrapper).
- The download server must support the head method of the HTTP protocol and be able to obtain the size of the download data through Content-length; otherwise, the download task will fail.
- When downloading, if the user specifies that the file already exists, it will be verified when creating the task and an exception will be thrown, resulting in the failure of task creation.
- Allow users to specify a successful multi-file upload strategy: When multiple files are uploaded in the same task, the task dimension is used as the judgment criterion. All files must be uploaded successfully to be considered successful.
- Compared with the API capabilities provided by ArkTS, the following functions are temporarily not supported
  - Create and start an upload task.
  - Create and start a download task.
  - Set the upper limit of bytes that the task can transfer per second.
  - Reasons for the failure of the subscription/unsubscription task.
  - Reasons for waiting for the subscription/unsubscription task.

## Instructions For Use

The following upload and download functions are provided：

- Create a task to upload or download.
- Query the task based on the task id.
- Remove the specified task belonging to the caller.
- Search for task id.
- Based on the default Filter conditions. Search for task id.
- Based on the Filter conditions. Query the detailed information of the task based on the task id.
- Query the detailed information of the task based on the task id and token.
- Events for subscribing to/unsubscribing tasks.
- Start/Stop/Pause/restart tasks.

For the request APIs, please refer to [Upload and Download API reference](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/BasicServicesKit/cj-apis-request-agent.md). For relevant guidance, please refer to [Upload and Download Guide](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_en/basic-services/request/cj-app-file-upload-download.md).

## Code Contribution

Developers are welcome to contribute code, documentation, etc. For specific contribution processes and methods, please refer to [Code Contribution](https://gitcode.com/openharmony/docs/blob/master/en/contribute/code-contribution.md).

## Repositories Involved

[request_request](https://gitcode.com/openharmony/request_request/blob/master/README.md)

[cangjie_ark_interop](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/README.md)

[ability_cangjie_wrapper](https://gitcode.com/openharmony-sig/ability_ability_cangjie_wrapper/blob/master/README.md)

[arkui_cangjie_wrapper](https://gitcode.com/openharmony-sig/arkui_arkui_cangjie_wrapper/blob/master/README.md)

[hiviewdfx_cangjie_wrapper](https://gitcode.com/openharmony-sig/hiviewdfx_hiviewdfx_cangjie_wrapper/blob/master/README.md)
