# CC++ Study Notes



error: Floating point exception: 8

Solution: the reason is divided by zero.



Error: > ENCODER.exe!_heap_alloc_base(unsigned int size) 行 57 C

Solution: 数组下标越界



项目文件包含 ToolsVersion='12.0'。此工具集可能未知或缺失(您可以通过安装相应版本的 MSBuild 来解决该问题)，或者该生成因策略原因已被强制更改为特殊 ToolsVersion。将此项目视作具有 ToolsVersion='4.0'。

解决方法：右键点击你的项目，选择属性，再点击配置属性中的常规，常规中有个平台工作集，点下拉菜单栏，以2012为例（如图），点击应用即可。 
或修改为V100。