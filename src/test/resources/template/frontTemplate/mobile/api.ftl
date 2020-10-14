import { baseUrl } from '@/config/env'
import axios from './http'

/**
 * ${sign}管理模块
 */
const ${sign}Api = {
  // list
  list (params) {
    return axios.post(`${r"${baseUrl}"}/${modelNameLowerCamel}/list`, params)
  },
  // 删除(多条)
  deleteByIds (params) {
    return axios.post(`${r"${baseUrl}"}/${modelNameLowerCamel}/deleteByIds`, params)
  },
  // 删除
  delete (params) {
    return axios.post(`${r"${baseUrl}"}/${modelNameLowerCamel}/delete`, params)
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
