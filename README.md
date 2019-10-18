# EllingTool
一、代码生成工具
1、这里用了freemarker的模板，东查查西查查组合起来
2、根据自己业务相关，代码比较简陋，哈哈哈，能够方便项目就ok，这边记录一下，方便以后自己看看，目录如下
|---src
  |---test
   |---java
    |---com
     |---elling
      |---code
       |---common
        |--Config.java
        |---database
         |--QueryMysqlTable.java		--查询mysql的数据库操作帮助类
         |--QueryOracleTable.java		--查询oracle的数据库操作帮助类
        |---entity
         |--TableColEntity.java			--实体类
       |---generator
        |---main
         |--BackEndGenMain.java			--生成后端代码的Main
         |--FrontEndGenMain.java		--生成前端代码的Main
        |---service
         |--CodeManager.java			--代码生成的Manager函数
         |--ICode.java					--接口
         |---impl
          |--ControllerGenerator.java		--生成Controller函数
          |--ListAndManGenerator.java		--前端页面文件的的生成函数
          |--ModelAndMapperGenerator.java	--Model和Entity生成函数
          |--ServiceGenerator.java			--Service和ServiceImpl的生成函数
       |---utils
        |--CodeUtils.java		--代码的帮助类
        |--DateUtil.java		--日期帮助类
        |--FileUtil.java		--文件帮助类
        |--StringUtils.java		--字符串帮助类
   |---resources
    |--config.properties		--配置文件
    |---template
     |---backTemplate
      |--controller.ftl			--controller的模板
      |--service-impl.ftl		--serviceImpl的模板
      |--service.ftl			--service的模板
     |---frontTemplate
      |--list.ftl				--list的模板
      |--manager.ftl			--Manager的模板
      |--treelist.ftl			--treeList的模板
      
3、如果生成的模板中会出现很多空行的情况下，使用^(\s*)\r\n正则表达式替换掉所有空行，这样就可以保持原有模板，如果使用eclipse的格式化，会产生很多行，虽然也方便，但是一个tr，td给一行，有时候挺难受的，个人感觉O(∩_∩)O    