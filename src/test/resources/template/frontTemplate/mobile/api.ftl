import { baseUrl } from '@/config/env'
import axios from './http'

/**
 * ${sign}管理模块
 */
const ${sign}Api = {
  // list
  list (params) {
    return axios.post(`${r"${baseUrl}"}/${modelNameLowerCamel}/getByExample`, params)
  },
  // 删除
  deleteByIds (params) {
    return axios.post(`${r"${baseUrl}"}/${modelNameLowerCamel}/deleteByIds`, params)
  },
  // 保存
  save (params) {
    return axios.post(`${r"${baseUrl}"}/${modelNameLowerCamel}/add`, params)
  },
  // 更新
  update (params) {
    return axios.post(`${r"${baseUrl}"}/${modelNameLowerCamel}/update`, params)
  },
  // 详情
  detail (params) {
    return axios.post(`${r"${baseUrl}"}/${modelNameLowerCamel}/detail`, params)
  },
  // 根据组别选择
  getListByGroup (params) {
    return axios.post(`${r"${baseUrl}"}/${modelNameLowerCamel}/getListByGroup`, params)
  },
  // 查询
  getByCondition (params) {
    return axios.post(`${r"${baseUrl}"}/${modelNameLowerCamel}/getByCondition`, params)
  },
  // 保存或者更新
  saveOrUpdate (params) {
    return axios.post(`${r"${baseUrl}"}/${modelNameLowerCamel}/saveOrUpdate`, params)
  },
}

export {
  ${sign}Api,
}
