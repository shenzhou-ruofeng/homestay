import request from '@/utils/request'

// 查询特色服务列表
export function listService(query) {
  return request({
    url: '/system/service/list',
    method: 'get',
    params: query
  })
}

// 查询特色服务详细
export function getService(serviceId) {
  return request({
    url: '/system/service/' + serviceId,
    method: 'get'
  })
}

// 新增特色服务
export function addService(data) {
  return request({
    url: '/system/service',
    method: 'post',
    data: data
  })
}

// 修改特色服务
export function updateService(data) {
  return request({
    url: '/system/service',
    method: 'put',
    data: data
  })
}

// 删除特色服务
export function delService(serviceId) {
  return request({
    url: '/system/service/' + serviceId,
    method: 'delete'
  })
}
