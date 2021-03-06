<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${basePackage}.dao.mapper.${modelNameUpperCamel}Mapper">
  <resultMap id="BaseResultMap" type="${basePackage}.model.${modelNameUpperCamel}">
    <#list colsEntity as result>
    <#if result.colunmKey = 'PRI'>
    <id column="${result.colunm}" jdbcType="${result.dataType}" property="${result.colunmUp}" />
    <#else>
    <result column="${result.colunm}" jdbcType="${result.dataType}" property="${result.colunmUp}" />
    </#if>
    </#list>
  </resultMap>
  <resultMap id="customerMap" type="java.util.HashMap">
    <#list colsEntity as result>
    <#if result.colunmKey = 'PRI'>
    <id column="${result.colunm}" jdbcType="${result.dataType}" property="${result.colunmUp}" />
    <#else>
    <result column="${result.colunm}" jdbcType="${result.dataType}" property="${result.colunmUp}" />
    </#if>
    </#list>
  </resultMap>
  <!--根据自定义条件查询-->
  <select id="getByCondition" resultMap="BaseResultMap">
	    SELECT
			<include refid="BaseColumn"/>
		FROM
			${tableName} T
		<where>
		    <#list colsEntity as result>
			<if test="${result.colunmUp}!=null and ${result.colunmUp} != ''">AND T.${result.colunm} = ${r'#{'}${result.colunmUp}${r'}'}</if>
			</#list>
		</where>
  </select>
  <sql id="BaseColumn">
  		<#list colsEntityNoKey as result><#if (result_index+1)==(colsEntityNoKey?size)>T.${result.colunm}<#else>T.${result.colunm},</#if></#list>
  </sql>
</mapper>