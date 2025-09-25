# 上传下载仓颉封装

## 简介

上传下载仓颉封装是在 OpenHarmony 上提供开发者使用仓颉语言进行应用开发时的上传下载能力，当前上传下载仓颉封装支持 standard 设备。仓颉上传下载封装为应用提供完整的上传/下载能力，涵盖任务创建、移除、暂停、启动等核心操作，同时支持订阅任务进度、成功、失败等状态变更，助力开发者便捷、高效地实现上传/下载业务功能。

## 系统架构

**图 1**  上传下载仓颉架构图

!["上传下载仓颉架构图"](figures/request_cangjie_wrapper_architecture.png)

如架构图所示：

接口层

- 任务创建/移除：面向开发者提供创建和移除上传下载任务的能力。
- 查询任务信息：面向开发者提供查询上传下载任务信息的能力。
- 任务启动/停止：面向开发者提供启动和停止已经创建的上传下载任务的能力。
- 订阅任务状态：面向开发者提供订阅任务状态的接口的能力，当任务状态发生变化时触发回调。
- 任务中断/继续：面向开发者提供中断一个正在执行的上传下载任务和继续一个被中断的上传下载任务的能力。

框架层

- 任务创建/移除功能封装：基于底层 request 服务的任务创建和移除的能力，实现仓颉创建和移除上传下载任务的功能。
- 查询任务信息功能封装：基于底层 request 服务的任务信息查询的能力，实现仓颉查询上传下载任务信息的功能。
- 任务启动/停止功能封装：基于底层 request 服务的任务启动和停止的能力，实现仓颉启动和停止已经创建的上传下载任务的功能。
- 订阅任务状态功能封装：基于底层 request 服务的任务订阅的能力，实现仓颉订阅任务状态的接口的功能。
- 任务中断/继续功能封装：基于底层 request 服务的任务中断和继续的能力，实现仓颉任务中断和继续的功能。
- 仓颉上传下载FFI接口定义：负责定义被仓颉语言调用的C语言互操作接口，用于实现仓颉上传下载能力。

架构图中依赖部件引入说明

- request：负责提供上传下载基础功能，封装C语言接口提供给仓颉进行互操作。
- cangjie_ark_interop：负责提供仓颉注解类定义，用于对API进行标注，以及提供抛向用户的BusinessException异常类定义。
- ability_cangjie_wrapper：负责提供Ability或Application的上下文的基础能力，包括访问特定应用程序的资源等。
- arkui_cangjie_wrapper：负责提供基础类型定义，提供CString类型转换为String类型的能力。
- hiviewdfx_cangjie_wrapper：负责提供日志接口，用于在关键路径处打印日志。

## 目录

```
base/request/request_cangjie_wrapper
├── figures            # 存放README中的架构图         
├── ohos
│   └── request        # 仓颉上传下载接口实现
└── test
    └── request        # 仓颉上传下载接口测试代码
```

## 使用说明

提供以下上传下载功能：

- 创建要上传或下载的任务
- 根据任务id查询任务
- 移除属于调用方的指定任务
- 根据默认Filter过滤条件查找任务id
- 根据Filter过滤条件查找任务id
- 根据任务id查询任务的详细信息
- 根据任务id和token查询任务的详细信息
- 订阅/取消订阅任务的事件
- 启动/停止/暂停/重启任务

request相关API请参见[上传下载 API参考](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/BasicServicesKit/cj-apis-request-agent.md)，相关指导请参见[上传下载开发指南](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_zh_cn/basic-services/request/cj-app-file-upload-download.md)。

## 约束

- 如需使用request服务，需要申请ohos.permission.INTERNET权限。
- request数据单元为文件形式，其余数据形式需要调用者自行封装为文件路径。
- request服务不提供完整的HTTP/HTTPS 接口，如需使用完整的HTTP/HTTPS 接口推荐使用[netmanager](https://gitcode.com/openharmony-sig/netmanager_netmanager_cangjie_wrapper)。
- 下载服务器需支持 HTTP 协议的 head 方法，并且需要能通过 Content-length 获取下载数据大小，否则下载任务会失败。
- 下载时用户指定文件已存在，会在创建任务时校验并抛出异常，创建任务失败。
- 允许用户指定多文件上传成功策略：多文件在同一个任务中上传，以任务维度为判断标准，必须所有文件上传成功判定为成功。
- 与ArkTS提供的API能力相比，暂不支持以下功能：
  - 创建并启动一个上传任务
  - 创建并启动一个下载任务
  - 设置任务每秒能传输的字节数上限
  - 订阅/取消订阅任务失败原因
  - 订阅/取消订阅任务等待原因

## 参与贡献

欢迎广大开发者贡献代码、文档等，具体的贡献流程和方式请参见[参与贡献](https://gitcode.com/openharmony/docs/blob/master/zh-cn/contribute/%E5%8F%82%E4%B8%8E%E8%B4%A1%E7%8C%AE.md)。

## 相关仓

[request_request](https://gitcode.com/openharmony/request_request/blob/master/README_ZH.md)

[cangjie_ark_interop](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/README_zh.md)

[ability_cangjie_wrapper](https://gitcode.com/openharmony-sig/ability_ability_cangjie_wrapper/blob/master/README_zh.md)

[arkui_cangjie_wrapper](https://gitcode.com/openharmony-sig/arkui_arkui_cangjie_wrapper/blob/master/README_zh.md)

[hiviewdfx_cangjie_wrapper](https://gitcode.com/openharmony-sig/hiviewdfx_hiviewdfx_cangjie_wrapper/blob/master/README_zh.md)
