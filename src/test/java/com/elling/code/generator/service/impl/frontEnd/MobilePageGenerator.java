package com.elling.code.generator.service.impl.frontEnd;

import java.io.File;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.elling.code.common.Config;
import com.elling.code.common.database.QueryMysqlTable;
import com.elling.code.common.entity.TableColEntity;
import com.elling.code.generator.service.CodeManager;
import com.elling.code.generator.service.ICode;
import com.elling.code.utils.CodeUtils;
import com.elling.code.utils.StringUtils;
import com.elling.common.utils.StringUtil;
import com.google.common.base.CaseFormat;

import freemarker.template.Configuration;

/**
 * 生成mobile phone中xxxList.vue、 xxxItem.vue、xxxxItemModify.vue、xxxitemDetail.vue、xxxApi.js、xxxstyle.css相关文档
 * 生成手机上的相关页面，列表页面、查看页面、详细页面、编辑页面、api界面、公共style页面
 * 
 * @author Administrator
 *
 */
public class MobilePageGenerator extends CodeManager implements ICode{

	@Override
	public void genCode(String tableName, String modelName, String sign) {
		String templatePath = "/src/test/resources/template/frontTemplate/mobile";
		Configuration cfg = getFreemarkerConfiguration(templatePath);
		String customMapping = "/" + sign + "/";
		String modelNameLowerCamel = StringUtils.isNullOrEmpty(modelName) ? CodeUtils.tableNameConvertLowerCamel(tableName) : modelName;
		String PAGE_PATH = Config.getConf("page.path");
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("tableName", tableName);
		map.put("sign", sign);
		map.put("modelNameLowerCamel", modelNameLowerCamel);
		Map<String, Object> data = getInitData(map);
		try {
			// 创建 api 页面***********************************************************************************************************************
			String path = PROJECT_PATH + PAGE_PATH + customMapping + sign + "-api.js";
			File file = new File(path);
			// 查看父级目录是否存在, 不存在则创建
			if (!file.getParentFile().exists()) {
				file.getParentFile().mkdirs();
			}
			cfg.getTemplate("api.ftl").process(data, new FileWriter(file));
			System.out.println("api路径为："+path);
			
			
			// 创建 item 页面***********************************************************************************************************************
			path = PROJECT_PATH + PAGE_PATH + customMapping + modelNameLowerCamel + ".vue";
			file = new File(path);
			// 查看父级目录是否存在, 不存在则创建
			if (!file.getParentFile().exists()) {
				file.getParentFile().mkdirs();
			}
			cfg.getTemplate("item.ftl").process(data, new FileWriter(file));
			System.out.println("item路径为："+path);
			
			
			
			// 创建 itemDetail 页面***********************************************************************************************************************
			path = PROJECT_PATH + PAGE_PATH + customMapping + modelNameLowerCamel + "Detail.vue";
			file = new File(path);
			// 查看父级目录是否存在, 不存在则创建
			if (!file.getParentFile().exists()) {
				file.getParentFile().mkdirs();
			}
			cfg.getTemplate("itemDetail.ftl").process(data, new FileWriter(file));
			System.out.println("itemDetail路径为："+path);
			
			
			// 创建 itemList 页面***********************************************************************************************************************
			path = PROJECT_PATH + PAGE_PATH + customMapping + modelNameLowerCamel + "List.vue";
			file = new File(path);
			// 查看父级目录是否存在, 不存在则创建
			if (!file.getParentFile().exists()) {
				file.getParentFile().mkdirs();
			}
			cfg.getTemplate("itemList.ftl").process(data, new FileWriter(file));
			System.out.println("itemList路径为："+path);
			
			
			// 创建 itemModify 页面***********************************************************************************************************************
			path = PROJECT_PATH + PAGE_PATH + customMapping + modelNameLowerCamel + "Modify.vue";
			file = new File(path);
			// 查看父级目录是否存在, 不存在则创建
			if (!file.getParentFile().exists()) {
				file.getParentFile().mkdirs();
			}
			cfg.getTemplate("itemModify.ftl").process(data, new FileWriter(file));
			System.out.println("itemModify路径为："+path);
					
			
			
			// 创建 style 页面***********************************************************************************************************************
			path = PROJECT_PATH + PAGE_PATH + customMapping + modelNameLowerCamel + "style.css";
			file = new File(path);
			// 查看父级目录是否存在, 不存在则创建
			if (!file.getParentFile().exists()) {
				file.getParentFile().mkdirs();
			}
			cfg.getTemplate("style.ftl").process(data, new FileWriter(file));
			System.out.println("style路径为："+path);
									
			
			
		} catch (Exception e) {
			throw new RuntimeException("vue 生成失败!", e);
		}
	}

	@Override
	public Map<String, Object> getInitData(Map<String, Object> pmap) {
		Map<String, Object> data = new HashMap<>();
		String tableName = pmap.get("tableName")+"";
		String schema = Config.getConf("jdbc.schema");
		data.put("sign", pmap.get("sign"));
		data.put("modelNameLowerCamel", pmap.get("modelNameLowerCamel"));
		data.put("modelNameMidCamel",CaseFormat.LOWER_UNDERSCORE.to(CaseFormat.LOWER_HYPHEN, tableName.toLowerCase()));
		data.put("base_model",Config.getConf("base.model"));
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("tableName", tableName);
		map.put("url", Config.getConf("jdbc.url"));
		map.put("username", Config.getConf("jdbc.username"));
		map.put("passwd", Config.getConf("jdbc.password"));
		map.put("schema", schema);
		
		QueryMysqlTable query = new QueryMysqlTable();
		String sql = "select t.COLUMN_NAME,t.COLUMN_COMMENT,t.COLUMN_KEY,T.DATA_TYPE from information_schema.`COLUMNS` t where t.TABLE_NAME = '"+tableName+"' AND t.TABLE_SCHEMA='"+schema+"'";    //要执行的SQL
		String[] arr = new String[] {null};
		List<Map<String,Object>> list = query.getBySql(sql, null);
		List<TableColEntity> colList = new ArrayList<TableColEntity>();
		TableColEntity col = null;
		for(int i=0,len=list.size();i<len;i++) {
			col = new TableColEntity();
			Map tMap = list.get(i);
			col.setColunm(CaseFormat.LOWER_UNDERSCORE.to(CaseFormat.LOWER_CAMEL, tMap.get("COLUMN_NAME")+""));
			col.setComment(tMap.get("COLUMN_COMMENT")+"");
			col.setColunmKey(tMap.get("COLUMN_KEY")+"");
			col.setDataType(tMap.get("DATA_TYPE")+"");
			if(StringUtil.getString(tMap.get("COLUMN_KEY")).equals("PRI")) {
				data.put("primaryKey", tMap.get("COLUMN_NAME"));
			}
			/**
        	 * .设置处理类型,如果包含time的话则显示time，
        	 * .如果是status,则显示select类型，以后可以规范一下，下拉框如何设置，这里手动写
        	 * .如果是...可以设置为radio类型
        	 * .其他的默认为text类型
        	 */
			String colunm = tMap.get("COLUMN_NAME")+"";
        	if(colunm.toLowerCase().contains("time")) {
        		col.setDealType("time");
        	}else if(colunm.toLowerCase().contains("status")) {
        		col.setDealType("select");
        	}else {
        		col.setDealType("text");
        	}
			
			colList.add(col);
		}
		
		List<TableColEntity> list1 = new ArrayList<TableColEntity>();
		colList.forEach((item->{
			if(!item.getColunmKey().equals("PRI")) {
				list1.add(item);
			}
		}));
		
		data.put("colsEntityNoKey",list1);
		data.put("colsEntity",colList);
		
		return data;
	}

}
