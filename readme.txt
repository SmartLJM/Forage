Controller的配置是自动加载，添加一个Controller到controller目录中,然后添加@Controller注解即可。

对于MyBatis的说明：
添加一个Dao类到dao目录先，然后在mapper目录下添加对应的mapper.xml即可。其中id为对应的方法。

jsp文件路径：必须放在WEB-INF/views下，WEB-INF目录下文件不能直接访问。视图的路径看spring-servlet.xml文件。