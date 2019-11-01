package com.elling.code.generator.main;

import com.elling.code.generator.service.impl.ControllerGenerator;
import com.elling.code.generator.service.impl.MapperGenerator;
import com.elling.code.generator.service.impl.MapperXmlGenerator;
import com.elling.code.generator.service.impl.ModelAndMapperGenerator;
import com.elling.code.generator.service.impl.ServiceGenerator;
import com.elling.code.utils.CodeUtils;

public class BackEndGenMain {
	
	/**
	 * .根据表名生成对应的后端文件Service、ServiceImpl、Controller、Mapper、entity、xml等六个文件
	 * @param args
	 */
	public static void main(String[] args) {
		
		String[] tableNames = new String[] {"sys_role"};
		
		for(String tableName:tableNames) {
			String sign = CodeUtils.getTableNameSplit(tableName)[1];
			String modelName = null;
			new ModelAndMapperGenerator().genCode(tableName, modelName, sign);//生成model页面相关
			new ServiceGenerator().genCode(tableName, modelName, sign);//生成service、serviceImpl页面相关
			new ControllerGenerator().genCode(tableName, modelName, sign);//生成controller页面相关
			new MapperGenerator().genCode(tableName, modelName, sign);//生成Mapper文件
			new MapperXmlGenerator().genCode(tableName, modelName, sign);//生成Mapper.xml文件
			
		}
		System.out.println("执行成功");
		
	}
}
