package com.elling.code.generator.service.impl;

import java.io.File;
import java.io.FileWriter;
import java.util.HashMap;
import java.util.Map;

import com.elling.code.common.Config;
import com.elling.code.generator.service.CodeManager;
import com.elling.code.generator.service.ICode;
import com.elling.code.utils.CodeUtils;
import com.elling.code.utils.DateUtil;
import com.elling.code.utils.StringUtils;

import freemarker.template.Configuration;

/**
 * Service 和  ServiceImpl生成
 * @author cyy
 *
 */
public class ServiceGenerator extends CodeManager implements ICode{

	@Override
	public void genCode(String tableName, String modelName, String sign) {
		Configuration cfg = getFreemarkerConfiguration(null);
		String customMapping = "/";
		String modelNameUpperCamel = StringUtils.isNullOrEmpty(modelName) ? CodeUtils.tableNameConvertUpperCamel(tableName) : modelName;
		
		//初始化数据
		Map<String,Object> pMap = new HashMap<String,Object>();
		pMap.put("modelName", modelName);
		pMap.put("sign", sign);
		pMap.put("modelNameUpperCamel", modelNameUpperCamel);
		Map<String, Object> data = getInitData(pMap);
		
		try {
			// 创建 Service 接口
			String servicePath = PROJECT_PATH+Config.getConf("java.path")+CodeUtils.packageConvertPath(Config.getConf("service.package"));
			File serviceFile = new File(servicePath + customMapping + modelNameUpperCamel + "Service.java");
			// 查看父级目录是否存在, 不存在则创建
			if (!serviceFile.getParentFile().exists()) {
				serviceFile.getParentFile().mkdirs();
			}
			cfg.getTemplate("service.ftl").process(data, new FileWriter(serviceFile));
			logger.info(modelNameUpperCamel + "Service.java 生成成功!");
			
			// 创建 Service 接口的实现类
			String serviceImplPath = PROJECT_PATH+Config.getConf("java.path")+CodeUtils.packageConvertPath(Config.getConf("service.impl.package"));
			File serviceImplFile = new File(serviceImplPath + customMapping + modelNameUpperCamel + "ServiceImpl.java");
			// 查看父级目录是否存在, 不存在则创建
			if (!serviceImplFile.getParentFile().exists()) {
				serviceImplFile.getParentFile().mkdirs();
			}
			cfg.getTemplate("service-impl.ftl").process(data, new FileWriter(serviceImplFile));
			logger.info(modelNameUpperCamel + "ServiceImpl.java 生成成功!");
		} catch (Exception e) {
			throw new RuntimeException("Service 生成失败!", e);
		}
	}

	@Override
	public Map<String, Object> getInitData(Map<String,Object> map) {
		Map<String, Object> data = new HashMap<>();
		data.put("date", DateUtil.getNowTime());
		data.put("author", Config.getConf("author"));
		data.put("sign", map.get("sign"));
		data.put("modelNameUpperCamel", map.get("modelNameUpperCamel"));
		data.put("modelNameLowerCamel", StringUtils.toLowerCaseFirstOne(map.get("modelNameUpperCamel")+""));
		data.put("basePackage", Config.getConf("base.package"));
		
		return data;
	}

}
