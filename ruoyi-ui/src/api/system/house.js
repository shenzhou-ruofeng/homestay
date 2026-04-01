import request from '@/utils/request'

// 查询房源列表
export function listHouse(query) {
  return request({
    url: '/system/house/list',
    method: 'get',
    params: query
  })
}

// 查询所有房源列表
export function listAllHouse(query) {
  return request({
    url: '/system/house/listAll',
    method: 'get',
    params: query
  })
}

// 查询房源详细
export function getHouse(houseId) {
  return request({
    url: '/system/house/' + houseId,
    method: 'get'
  })
}

// 新增房源
export function addHouse(data) {
  return request({
    url: '/system/house',
    method: 'post',
    data: data
  })
}

// 修改房源
export function updateHouse(data) {
  return request({
    url: '/system/house',
    method: 'put',
    data: data
  })
}

// 删除房源
export function delHouse(houseId) {
  return request({
    url: '/system/house/' + houseId,
    method: 'delete'
  })
}
