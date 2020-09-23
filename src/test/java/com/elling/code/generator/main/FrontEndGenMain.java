package com.elling.code.generator.main;

import com.elling.code.generator.service.impl.ListAndManGenerator;
import com.elling.code.utils.CodeUtils;

public class FrontEndGenMain {
	/**
	 * .根据表名生成对应的前端文件xxxList.vue、xxxManager.vue两个文件
	 * @param args
	 */
	public static void main(String[] args) {
		//"tool_gen_code"
		//"RENT_GROUP","RENT_HOUSE","RENT_PERSON","RENT_CONTRACT","RENT_BILL"
		String[] tableNames = new String[] {"rent_group","rent_house","rent_person","rent_contract","rent_bill"};
		
		for(String tableName:tableNames) {
			String sign = CodeUtils.getTableNameSplit(tableName)[1];
			String modelName = null;
			new ListAndManGenerator().genCode(tableName, modelName, sign);//生成xxxList.vue和xxxManager.vue的文件
		}
		System.out.println("执行成功");
		
	}
}
