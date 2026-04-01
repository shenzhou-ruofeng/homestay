import request from '@/utils/request'

// 新增评价
export function addComment(data) {
  return request({
    url: '/tenant/comment',
    method: 'post',
    data: data
  })
}

// 查询评价详细
export function getComment(orderItemId) {
  return request({
    url: '/tenant/comment/' + orderItemId,
    method: 'get'
  })
}


// 修改评价
export function updateComment(data) {
  return request({
    url: '/tenant/comment',
    method: 'put',
    data: data
  })
}
