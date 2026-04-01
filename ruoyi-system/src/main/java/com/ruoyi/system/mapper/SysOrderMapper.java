package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.SysOrder;
import com.ruoyi.system.domain.vo.SysOrderVo;

/**
 * 主订单Mapper接口
 * 
 * @date 2024-02-02
 */
public interface SysOrderMapper 
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

    /**
     * 修改主订单
     * 
     * @param sysOrder 主订单
     * @return 结果
     */
    public int updateSysOrder(SysOrder sysOrder);

    /**
     * 删除主订单
     * 
     * @param orderId 主订单主键
     * @return 结果
     */
    public int deleteSysOrderByOrderId(Long orderId);

    /**
     * 批量删除主订单
     * 
     * @param orderIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteSysOrderByOrderIds(Long[] orderIds);
}
