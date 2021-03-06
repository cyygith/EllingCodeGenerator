package com.elling.code.generator.service.impl;

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
import com.elling.code.utils.DateUtil;
import com.elling.code.utils.StringUtils;
import com.elling.common.utils.StringUtil;
import com.google.common.base.CaseFormat;

import freemarker.template.Configuration;

public class MapperGenerator extends CodeManager implements ICode{

	@Override
	public void genCode(String tableName, String modelName, String sign) {
		String templatePath = "/src/test/resources/template/backTemplate";
		Configuration cfg = getFreemarkerConfiguration(templatePath);//模板地址
		String customMapping = "/";
		String modelNameLowerCamel = StringUtils.isNullOrEmpty(modelName) ? CodeUtils.tableNameConvertLowerCamel(tableName) : modelName;
		String modelNameUpperCamel = StringUtils.isNullOrEmpty(modelName) ? CodeUtils.tableNameConvertUpperCamel(tableName) : modelName;
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("tableName", tableName);
		map.put("sign", sign);
		map.put("modelNameLowerCamel", modelNameLowerCamel);
		map.put("modelNameUpperCamel", modelNameUpperCamel);
		Map<String, Object> data = getInitData(map);
		try {
			
			// 创建 Mapper 接口
			String servicePath = PROJECT_PATH+Config.getConf("java.path")+CodeUtils.packageConvertPath(Config.getConf("mapper.package"));
			File serviceFile = new File(servicePath + customMapping + modelNameUpperCamel + "Mapper.java");
			// 查看父级目录是否存在, 不存在则创建
			if (!serviceFile.getParentFile().exists()) {
				serviceFile.getParentFile().mkdirs();
			}
			cfg.getTemplate("mapper.ftl").process(data, new FileWriter(serviceFile));
			logger.info(modelNameUpperCamel + "Mapper.java 生成成功!");
			System.out.println("Mapper-service路径为："+servicePath);
			
		} catch (Exception e) {
			throw new RuntimeException("Mapper.java 生成失败!", e);
		}
	}

	@Override
	public Map<String, Object> getInitData(Map<String, Object> pmap) {
		Map<String, Object> data = new HashMap<>();
		String tableName = pmap.get("tableName")+"";
		String schema = Config.getConf("jdbc.schema");
		data.put("date", DateUtil.getNowTime());
		data.put("author", Config.getConf("author"));
		data.put("sign", pmap.get("sign"));
		data.put("modelNameLowerCamel", pmap.get("modelNameLowerCamel"));
		data.put("modelNameUpperCamel", pmap.get("modelNameUpperCamel"));
		data.put("modelNameMidCamel",CaseFormat.LOWER_UNDERSCORE.to(CaseFormat.LOWER_HYPHEN, tableName.toLowerCase()));
		data.put("basePackage", Config.getConf("base.package"));
		return data;
	}

}
