package com.ruoyi.system.service;

import java.util.List;

import com.ruoyi.system.domain.SysOrderItem;
import com.ruoyi.system.domain.vo.SysOrderItemVo;

/**
 * 子订单Service接口
 *
 * @date 2024-02-02
 */
public interface ISysOrderItemService {
    /**
     * 查询子订单
     *
     * @param orderItemId 子订单主键
     * @return 子订单
     */
    public SysOrderItem selectSysOrderItemByOrderItemId(Long orderItemId);

    /**
     * 查询子订单列表
     *
     * @param sysOrderItem 子订单
     * @return 子订单集合
     */
    public List<SysOrderItem> selectSysOrderItemList(SysOrderItem sysOrderItem);

    public List<SysOrderItemVo> selectSysOrderItemVoList(SysOrderItem sysOrderItem);

    public List<SysOrderItemVo> selectSysOrderItemVoListByVo(SysOrderItemVo sysOrderItem);

    /**
     * 新增子订单
     *
     * @param sysOrderItem 子订单
     * @return 结果
     */
    public int insertSysOrderItem(SysOrderItem sysOrderItem);

    public int batchInsertSysOrderItem(List<SysOrderItem> sysOrderItems);

    /**
     * 修改子订单
     *
     * @param sysOrderItem 子订单
     * @return 结果
     */
    public int updateSysOrderItem(SysOrderItem sysOrderItem);

    public int batchUpdateSysOrderItem(List<SysOrderItem> sysOrderItems);

    /**
     * 批量删除子订单
     *
     * @param orderItemIds 需要删除的子订单主键集合
     * @return 结果
     */
    public int deleteSysOrderItemByOrderItemIds(Long[] orderItemIds);

    /**
     * 删除子订单信息
     *
     * @param orderItemId 子订单主键
     * @return 结果
     */
    public int deleteSysOrderItemByOrderItemId(Long orderItemId);

    public int deleteSysOrderItemByOrderId(Long orderId);
}
