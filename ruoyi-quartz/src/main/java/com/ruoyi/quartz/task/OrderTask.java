package com.ruoyi.quartz.task;

import com.ruoyi.system.domain.SysOrder;
import com.ruoyi.system.service.ISysOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

@Component("orderTask")
public class OrderTask {
    @Autowired
    private ISysOrderService sysOrderService;

    /**
     * 登记入住，扫描待使用订单，入住时间的14点<当前时间点转成进行中
     */
    public void checkIn() {
        //查询当前所有待使用订单，
        SysOrder sysOrder = new SysOrder();
        sysOrder.setStatus(0);
        List<SysOrder> sysOrders = sysOrderService.selectSysOrderList(sysOrder);
        for (SysOrder order : sysOrders) {
            Date arrivalDate = order.getArrivalDate();
            arrivalDate.setHours(14);
            arrivalDate.setMinutes(0);
            arrivalDate.setSeconds(0);
            if (arrivalDate.before(new Date())) {
                order.setStatus(1);
                sysOrderService.updateSysOrder(order);
            }
        }
    }

    /**
     * 登记离开，扫描进行中订单，离开时间的12点>当前时间点转成已完成
     */
    public void checkOut() {
        //查询当前所有进行中订单，
        SysOrder sysOrder = new SysOrder();
        sysOrder.setStatus(1);
        List<SysOrder> sysOrders = sysOrderService.selectSysOrderList(sysOrder);
        for (SysOrder order : sysOrders) {
            Date departureDate = order.getDepartureDate();
            departureDate.setHours(12);
            departureDate.setMinutes(0);
            departureDate.setSeconds(0);
            if (departureDate.after(new Date())) {
                order.setStatus(2);
                sysOrderService.updateSysOrder(order);
            }
        }
    }


}