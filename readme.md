# 微服务 测试数据 批量写入数据库

数据生成工具采用PowerDesigner
## 建议
数据量最少为10，关键数据尽量采用list自定义数据，分关键数据随机生成，若不同应用间存在id的引用，建议引用其他应用或者表的前5条，数据删除为第10条之后
## 说明

* 文件夹名称即为应用名称
* 文件夹下支持多个sql文件
* config.yml为数据库信息和sql执行的顺序信息
* 自动建表的sql语句支持navcat导出的sql语句和Powerdesigner语句(后续支持)
* 全局配置参数请看当前目录下的config.yml
* 不同微服务的配置参数请参考micro-account下的config.yml
* 建表支持navcat导出的表和powerdesigner生成的表，默认为navcat



