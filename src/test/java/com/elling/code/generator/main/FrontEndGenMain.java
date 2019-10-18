package com.elling.code.generator.main;

import com.elling.code.generator.service.impl.ListAndManGenerator;
import com.elling.code.utils.CodeUtils;

public class FrontEndGenMain {
	/**
	 * .根据表名生成对应的后端文件Service、ServiceImpl、Controller、Mapper、entity、xml等六个文件
	 * @param args
	 */
	public static void main(String[] args) {
		
		String[] tableNames = new String[] {"sys_user"};
		
		for(String tableName:tableNames) {
			String sign = CodeUtils.getTableNameSplit(tableName)[1];
			String modelName = null;
			new ListAndManGenerator().genCode(tableName, modelName, sign);//生成xxxList.vue和xxxManager.vue的文件
		}
		System.out.println("执行成功");
		
	}
}
