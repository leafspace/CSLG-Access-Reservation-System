#include "stdafx.h"

using namespace System::Reflection;
using namespace System::Runtime::CompilerServices;

//
// 有关程序集的常规信息是通过下列
// 属性集控制的。更改这些属性值可修改与程序集
// 关联的信息。
//
[assembly:AssemblyTitleAttribute("")];
[assembly:AssemblyDescriptionAttribute("")];
[assembly:AssemblyConfigurationAttribute("")];
[assembly:AssemblyCompanyAttribute("")];
[assembly:AssemblyProductAttribute("")];
[assembly:AssemblyCopyrightAttribute("")];
[assembly:AssemblyTrademarkAttribute("")];
[assembly:AssemblyCultureAttribute("")];		

//
// 程序集的版本信息由下列 4 个值组成: 
//
//      主版本
//      次版本
//      内部版本号
//      修订号
//
// 您可以指定所有这些值，也可以使用“修订号”和“内部版本号”的默认值，方法是按
//如下所示使用 '*':

[assembly:AssemblyVersionAttribute("1.0.*")];

//
// 要对程序集进行签名，必须指定要使用的密钥。有关程序集签名的更多信息，请参考 
// Microsoft .NET Framework 文档。
//
// 使用下面的属性控制用于签名的密钥。
//
// 注意: 
//   (*) 如果未指定密钥，则不会对程序集签名。
//   (*) KeyName 是指已经安装在
//       计算机上的加密服务提供程序(CSP)中的密钥。KeyFile 是指包含
//       密钥的文件。
//   (*) 如果 KeyFile 和 KeyName 值都已指定，则 
//       进行下面的处理:
//       (1) 如果在 CSP 中可以找到 KeyName，则使用该密钥。
//       (2) 如果 KeyName 不存在而 KeyFile 存在，则将 
//           KeyFile 中的密钥安装到 CSP 中并且使用该密钥。
//   (*) 要创建 KeyFile，可以使用 sn.exe(强名称)实用工具。
//        在指定 KeyFile 时，KeyFile 的位置应该是
//        相对于项目目录的位置。
//   (*)“延迟签名”是一个高级选项 - 有关它的更多信息，请参阅 Microsoft .NET Framework
//       文档。
//
[assembly:AssemblyDelaySignAttribute(false)];
[assembly:AssemblyKeyFileAttribute("")];
[assembly:AssemblyKeyNameAttribute("")];

