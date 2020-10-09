package com.elling.code.generator.main;

import com.elling.code.generator.service.impl.frontEnd.MobilePageGenerator;
import com.elling.code.utils.CodeUtils;

public class FrontEndGenMain {
	/**
	 * .根据表名生成对应的前端文件xxxList.vue、xxxManager.vue两个文件
	 * @param args
	 */
	public static void main(String[] args) {
		//"tool_gen_code"
		//"RENT_GROUP","RENT_HOUSE","RENT_PERSON","RENT_CONTRACT","RENT_BILL"
		//"rent_group","rent_house","rent_person","rent_contract","rent_bill"
		String[] tableNames = new String[] {"rent_house"};
		
		for(String tableName:tableNames) {
			String sign = CodeUtils.getTableNameSplit(tableName)[1];
			String modelName = null;
//			生成xxxList.vue和xxxManager.vue的文件（后端管理界面生成）
//			new ListAndManGenerator().genCode(tableName, modelName, sign);
			
			//生成mobile相关的   xxxitem.vue、xxx-api.js、xxxitemDetail.vue、xxItemList.vue、xxxxitemModify.vue、style.css、（前端操作界面生成）
			new MobilePageGenerator().genCode(tableName, modelName, sign);
			
			
		}
		System.out.println("执行成功");
		
	}
}
