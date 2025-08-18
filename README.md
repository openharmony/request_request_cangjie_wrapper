# request_cangjie_wrapper

## Introduction

The request_cangjie_wrapper is a Cangjie API encapsulated on OpenHarmony based on the capabilities of the upload and download subsystem. The upload and download subsystem provides upload and download capabilities for applications, including creating, removing, suspending, and starting upload and download tasks, and subscribing to the task progress and result.


## System Architecture

**Figure 1** Architecture of the request_cangjie_wrapper


![](figures/request_cangjie_wrapper_architecture_en.png "Architecture of the request_cangjie_wrapper")

## Directory Structure

The source code of the upload and download subsystem is stored in the **/base/request** directory.

The directory structure is as follows:

```
base/request/request_cangjie_wrapper
├── ohos             # Cangjie Upload and Download code
├── figures          # architecture pictures
```

## Repositories Involved

[request_request](https://gitee.com/openharmony/request_request/blob/master/README.md)
