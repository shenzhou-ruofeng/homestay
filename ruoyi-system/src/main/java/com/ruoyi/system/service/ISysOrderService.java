package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.SysOrder;
import com.ruoyi.system.domain.vo.SysOrderVo;

/**
 * 主订单Service接口
 * 
 * @date 2024-02-02
 */
public interface ISysOrderService 
{
    /**
     * 查询主订单
     * 
     * @param orderId 主订单主键
     * @return 主订单
     */
    public SysOrder selectSysOrderByOrderId(Long orderId);

    /**
     * 查询主订单列表
     * 
     * @param sysOrder 主订单
     * @return 主订单集合
     */
    public List<SysOrder> selectSysOrderList(SysOrder sysOrder);

    public List<SysOrder> selectSysOrderListByOrderVo(SysOrderVo sysOrderVo);

    /**
     * 新增主订单
     * 
     * @param sysOrder 主订单
     * @return 结果
     */
    public int insertSysOrder(SysOrder sysOrder);

    public boolean insertOrder(SysOrderVo sysOrder);

    /**
     * 修改主订单
     * 
     * @param sysOrder 主订单
     * @return 结果
     */
    public int updateSysOrder(SysOrder sysOrder);

    /**
     * 批量删除主订单
     * 
     * @param orderIds 需要删除的主订单主键集合
     * @return 结果
     */
    public int deleteSysOrderByOrderIds(Long[] orderIds);

    /**
     * 删除主订单信息
     * 
     * @param orderId 主订单主键
     * @return 结果
     */
    public int deleteSysOrderByOrderId(Long orderId);
}
