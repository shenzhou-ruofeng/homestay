import request from '@/utils/request'

//模糊查询房源列表
export function listHouse(query) {
  return request({
    url: '/tenant/house/list',
    method: 'get',
    params: query
  })
}

export function listAllHouse(query) {
  return request({
    url: '/tenant/house/listAll',
    method: 'get',
    params: query
  })
}

// 查询房源详细
export function getHouse(houseId) {
  return request({
    url: '/tenant/house/' + houseId,
    method: 'get'
  })
}
