package com.ruoyi.system.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.system.domain.SysOrder;
import com.ruoyi.system.domain.vo.SysOrderItemVo;
import com.ruoyi.system.mapper.SysOrderMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.SysOrderItemMapper;
import com.ruoyi.system.domain.SysOrderItem;
import com.ruoyi.system.service.ISysOrderItemService;
import org.springframework.transaction.annotation.Transactional;

/**
 * 子订单Service业务层处理
 *
 * @author ruoyi
 * @date 2024-02-02
 */
@Service
public class SysOrderItemServiceImpl implements ISysOrderItemService {
    @Autowired
    private SysOrderItemMapper sysOrderItemMapper;
    @Autowired
    private SysOrderMapper sysOrderMapper;

    /**
     * 查询子订单
     *
     * @param orderItemId 子订单主键
     * @return 子订单
     */
    @Override
    public SysOrderItem selectSysOrderItemByOrderItemId(Long orderItemId) {
        return sysOrderItemMapper.selectSysOrderItemByOrderItemId(orderItemId);
    }

    /**
     * 查询子订单列表
     *
     * @param sysOrderItem 子订单
     * @return 子订单
     */
    @Override
    public List<SysOrderItem> selectSysOrderItemList(SysOrderItem sysOrderItem) {
        return sysOrderItemMapper.selectSysOrderItemList(sysOrderItem);
    }

    @Override
    public List<SysOrderItemVo> selectSysOrderItemVoList(SysOrderItem sysOrderItem) {
        return sysOrderItemMapper.selectSysOrderItemVoList(sysOrderItem);
    }

    @Override
    public List<SysOrderItemVo> selectSysOrderItemVoListByVo(SysOrderItemVo sysOrderItem) {
        return sysOrderItemMapper.selectSysOrderItemVoListByVo(sysOrderItem);
    }

    /**
     * 新增子订单
     *
     * @param sysOrderItem 子订单
     * @return 结果
     */
    @Override
    public int insertSysOrderItem(SysOrderItem sysOrderItem) {
        sysOrderItem.setCreateTime(DateUtils.getNowDate());
        return sysOrderItemMapper.insertSysOrderItem(sysOrderItem);
    }

    @Override
    public int batchInsertSysOrderItem(List<SysOrderItem> sysOrderItems) {
        for (SysOrderItem sysOrderItem : sysOrderItems) {
            sysOrderItem.setCreateTime(DateUtils.getNowDate());
        }
        return sysOrderItemMapper.batchInsertSysOrderItem(sysOrderItems);
    }

    /**
     * 修改子订单
     *
     * @param sysOrderItem 子订单
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Throwable.class)
    public int updateSysOrderItem(SysOrderItem sysOrderItem) {
        SysOrderItem oldData = selectSysOrderItemByOrderItemId(sysOrderItem.getOrderItemId());
        if (oldData == null) {
            return 0;
        }
        sysOrderItem.setUpdateTime(DateUtils.getNowDate());
        SysOrder sysOrder = sysOrderMapper.selectSysOrderByOrderId(oldData.getOrderId());
        //判断是否为取消退款，是的话则根据日期判断当前订单实际状态
        if (sysOrderItem.getStatus() == 0 && oldData.getStatus() == 4) {
            Date arrivalDate = sysOrder.getArrivalDate();
            arrivalDate.setHours(14);
            arrivalDate.setMinutes(0);
            arrivalDate.setSeconds(0);
            Date departureDate = sysOrder.getDepartureDate();
            departureDate.setHours(12);
            departureDate.setMinutes(0);
            departureDate.setSeconds(0);
            if (new Date().before(arrivalDate)) {
                //待使用
                sysOrderItem.setStatus(0);
            } else if (new Date().after(departureDate)) {
                //待评价
                sysOrderItem.setStatus(2);
            } else {
                //进行中
                sysOrderItem.setStatus(1);
            }
        }
        //若子订单已退款，则修改主订单金额
        if (sysOrderItem.getStatus() == 5) {
            BigDecimal total = sysOrder.getPrice().subtract(oldData.getTotal());
            if (total.intValue() == 0) {
                //总额为0，主订单设置为已退款状态
                sysOrder.setStatus(4);
            }else {
                //总额非0，修改主订单价格
                sysOrder.setPrice(total);
            }
            sysOrderMapper.updateSysOrder(sysOrder);
        }
        return sysOrderItemMapper.updateSysOrderItem(sysOrderItem);
    }

    @Override
    public int batchUpdateSysOrderItem(List<SysOrderItem> sysOrderItems) {
        //只允许更新同一订单的子订单
        List<Long> orderIds = sysOrderItems.stream().map(SysOrderItem::getOrderId).distinct().collect(Collectors.toList());
        if (orderIds.size() != 1) {
            return 0;
        }
        SysOrder oldData = sysOrderMapper.selectSysOrderByOrderId(orderIds.get(0));
        for (SysOrderItem sysOrderItem : sysOrderItems) {
            sysOrderItem.setUpdateTime(DateUtils.getNowDate());
            //判断是否为取消退款，是的话则根据日期判断当前订单实际状态
            if (sysOrderItem.getStatus() == 0 && oldData.getStatus() == 4) {
                Date arrivalDate = oldData.getArrivalDate();
                arrivalDate.setHours(14);
                arrivalDate.setMinutes(0);
                arrivalDate.setSeconds(0);
                Date departureDate = oldData.getDepartureDate();
                departureDate.setHours(12);
                departureDate.setMinutes(0);
                departureDate.setSeconds(0);
                if (new Date().before(arrivalDate)) {
                    //待使用
                    sysOrderItem.setStatus(0);
                } else if (new Date().after(departureDate)) {
                    //待评价
                    sysOrderItem.setStatus(2);
                } else {
                    //进行中
                    sysOrderItem.setStatus(1);
                }
            }
        }
        return sysOrderItemMapper.batchUpdateSysOrderItem(sysOrderItems);
    }

    /**
     * 批量删除子订单
     *
     * @param orderItemIds 需要删除的子订单主键
     * @return 结果
     */
    @Override
    public int deleteSysOrderItemByOrderItemIds(Long[] orderItemIds) {
        return sysOrderItemMapper.deleteSysOrderItemByOrderItemIds(orderItemIds);
    }

    /**
     * 删除子订单信息
     *
     * @param orderItemId 子订单主键
     * @return 结果
     */
    @Override
    public int deleteSysOrderItemByOrderItemId(Long orderItemId) {
        return sysOrderItemMapper.deleteSysOrderItemByOrderItemId(orderItemId);
    }

    @Override
    public int deleteSysOrderItemByOrderId(Long orderId) {
        return sysOrderItemMapper.deleteSysOrderItemByOrderId(orderId);
    }
}
