package com.ruoyi.system.service.impl;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.system.domain.SysHouse;
import com.ruoyi.system.domain.SysOrderItem;
import com.ruoyi.system.domain.vo.SysOrderItemVo;
import com.ruoyi.system.domain.vo.SysOrderVo;
import com.ruoyi.system.mapper.SysHouseMapper;
import com.ruoyi.system.mapper.SysOrderItemMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.SysOrderMapper;
import com.ruoyi.system.domain.SysOrder;
import com.ruoyi.system.service.ISysOrderService;
import org.springframework.transaction.annotation.Transactional;

/**
 * 主订单Service业务层处理
 *
 * @author ruoyi
 * @date 2024-02-02
 */
@Service
public class SysOrderServiceImpl implements ISysOrderService {
    @Autowired
    private SysOrderMapper sysOrderMapper;
    @Autowired
    private SysOrderItemMapper sysOrderItemMapper;
    @Autowired
    private SysHouseMapper sysHouseMapper;

    /**
     * 查询主订单
     *
     * @param orderId 主订单主键
     * @return 主订单
     */
    @Override
    public SysOrder selectSysOrderByOrderId(Long orderId) {
        return sysOrderMapper.selectSysOrderByOrderId(orderId);
    }

    /**
     * 查询主订单列表
     *
     * @param sysOrder 主订单
     * @return 主订单
     */
    @Override
    public List<SysOrder> selectSysOrderList(SysOrder sysOrder) {
        return sysOrderMapper.selectSysOrderList(sysOrder);
    }

    @Override
    public List<SysOrder> selectSysOrderListByOrderVo(SysOrderVo sysOrderVo) {
        return sysOrderMapper.selectSysOrderListByOrderVo(sysOrderVo);
    }

    /**
     * 新增主订单
     *
     * @param sysOrder 主订单
     * @return 结果
     */
    @Override
    public int insertSysOrder(SysOrder sysOrder) {
        sysOrder.setCreateTime(DateUtils.getNowDate());
        return sysOrderMapper.insertSysOrder(sysOrder);
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public boolean insertOrder(SysOrderVo sysOrder) {
        Date date = new Date();
        sysOrder.setStatus(0);
        sysOrder.setCreateTime(date);
        sysOrderMapper.insertSysOrder(sysOrder);
        List<SysOrderItemVo> orderItems = sysOrder.getOrderItems();
        List<SysOrderItem> orderItemList = new ArrayList<>();
        for (SysOrderItem orderItem : orderItems) {
            orderItem.setUserId(sysOrder.getUserId());
            orderItem.setOrderId(sysOrder.getOrderId());
            orderItem.setStatus(0);
            orderItem.setCreateTime(date);
            orderItemList.add(orderItem);
        }
        sysOrderItemMapper.batchInsertSysOrderItem(orderItemList);
        //修改房屋状态
        //房屋要更新为已下单未入住
        SysHouse sysHouse = new SysHouse();
        sysHouse.setHouseId(sysOrder.getHouseId());
        sysHouse.setHouseStatus(1);
        sysHouseMapper.updateSysHouse(sysHouse);
        return true;
    }

    /**
     * 修改主订单
     *
     * @param sysOrder 主订单
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Throwable.class)
    public int updateSysOrder(SysOrder sysOrder) {
        //判断订单是否存在
        SysOrder oldData = sysOrderMapper.selectSysOrderByOrderId(sysOrder.getOrderId());
        if (oldData == null) {
            return 0;
        }
        sysOrder.setUpdateTime(DateUtils.getNowDate());
        SysOrderItem sysOrderItem = new SysOrderItem();
        sysOrderItem.setOrderId(oldData.getOrderId());
        List<SysOrderItem> orderItemList = sysOrderItemMapper.selectSysOrderItemList(sysOrderItem);
        //判断是否为取消退款，是的话则根据日期判断当前订单实际状态
        if (oldData.getStatus() == 0 && oldData.getStatus() == 3) {
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
                sysOrder.setStatus(0);
            } else if (new Date().after(departureDate)) {
                //已完成
                sysOrder.setStatus(2);
            } else {
                //进行中
                sysOrder.setStatus(1);
            }
        }
        //修改主订单状态，子订单也需修改
        for (SysOrderItem orderItem : orderItemList) {
            if (sysOrder.getStatus() == 3) {
                //主订单退款中，则子订单都改为退款中
                orderItem.setStatus(4);
            } else if (sysOrder.getStatus() == 4) {
                //主订单已退款，则子订单都改为已退款
                orderItem.setStatus(5);
            } else if (sysOrder.getStatus() == 1 && orderItem.getStatus() == 0) {
                //主订单改为进行中（已入住），则待使用的子订单都改为进行中
                orderItem.setStatus(1);
            } else if (sysOrder.getStatus() == 2 && orderItem.getStatus() == 1) {
                //主订单改为已完成，则待使用的子订单都改为待评价
                orderItem.setStatus(2);
            }
        }
        //修改房屋状态
        SysOrderItem houseOrderItem = orderItemList.stream().filter(obj -> obj.getType() == 1).findFirst().get();
        SysHouse sysHouse = new SysHouse();
        sysHouse.setHouseId(oldData.getHouseId());
        if (houseOrderItem.getStatus() == 0) {
            //子订单待使用，则房屋已下单未入住
            sysHouse.setHouseStatus(1);
        } else if (houseOrderItem.getStatus() == 1) {
            //子订单进行中，则房屋已入住
            sysHouse.setHouseStatus(2);
        } else {
            sysHouse.setHouseStatus(0);
        }
        sysHouseMapper.updateSysHouse(sysHouse);
        sysOrderItemMapper.batchUpdateSysOrderItem(orderItemList);
        return sysOrderMapper.updateSysOrder(sysOrder);
    }

    /**
     * 批量删除主订单
     *
     * @param orderIds 需要删除的主订单主键
     * @return 结果
     */
    @Override
    public int deleteSysOrderByOrderIds(Long[] orderIds) {
        return sysOrderMapper.deleteSysOrderByOrderIds(orderIds);
    }

    /**
     * 删除主订单信息
     *
     * @param orderId 主订单主键
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Throwable.class)
    public int deleteSysOrderByOrderId(Long orderId) {
        sysOrderItemMapper.deleteSysOrderItemByOrderId(orderId);
        return sysOrderMapper.deleteSysOrderByOrderId(orderId);
    }
}
