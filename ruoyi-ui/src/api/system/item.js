import request from '@/utils/request'

// 查询子订单列表
export function listItem(query) {
  return request({
    url: '/system/item/list',
    method: 'get',
    params: query
  })
}

// 查询子订单详细
export function getItem(orderItemId) {
  return request({
    url: '/system/item/' + orderItemId,
    method: 'get'
  })
}

// 新增子订单
export function addItem(data) {
  return request({
    url: '/system/item',
    method: 'post',
    data: data
  })
}

// 修改子订单
export function updateItem(data) {
  return request({
    url: '/system/item',
    method: 'put',
    data: data
  })
}

// 删除子订单
export function delItem(orderItemId) {
  return request({
    url: '/system/item/' + orderItemId,
    method: 'delete'
  })
}
