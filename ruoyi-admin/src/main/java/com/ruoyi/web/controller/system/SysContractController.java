package com.ruoyi.web.controller.system;

import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.domain.SysHouse;
import com.ruoyi.system.domain.SysOrder;
import com.ruoyi.system.domain.vo.SysContractVo;
import com.ruoyi.system.domain.vo.SysOrderVo;
import com.ruoyi.system.service.ISysHouseService;
import com.ruoyi.system.service.ISysOrderService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.SysContract;
import com.ruoyi.system.service.ISysContractService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 合同Controller
 *
 * @date 2024-01-31
 */
@RestController
@RequestMapping("/system/contract")
public class SysContractController extends BaseController {
    @Autowired
    private ISysContractService sysContractService;
    @Autowired
    private ISysHouseService sysHouseService;
    @Autowired
    private ISysOrderService sysOrderService;

    /**
     * 查询合同列表
     */
    @PreAuthorize("@ss.hasPermi('system:contract:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysContract sysContract) {
        startPage();
        if (SecurityUtils.hasRole("landlord") && !SecurityUtils.isAdmin(getUserId())) {
            //房东身份，仅查自己的
            sysContract.setUserId(getUserId());
        }
        List<SysContractVo> list = sysContractService.selectSysContractList(sysContract);
        return getDataTable(list);
    }

    /**
     * 导出合同列表
     */
    @PreAuthorize("@ss.hasPermi('system:contract:export')")
    @Log(title = "合同", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, SysContract sysContract) {
        List<SysContractVo> list = sysContractService.selectSysContractList(sysContract);
        ExcelUtil<SysContractVo> util = new ExcelUtil<SysContractVo>(SysContractVo.class);
        util.exportExcel(response, list, "合同数据");
    }

    /**
     * 获取合同详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:contract:query')")
    @GetMapping(value = "/{contractId}")
    public AjaxResult getInfo(@PathVariable("contractId") Long contractId) {
        return success(sysContractService.selectSysContractByContractId(contractId));
    }

    /**
     * 新增合同
     */
    @PreAuthorize("@ss.hasPermi('system:contract:add')")
    @Log(title = "合同", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody SysContract sysContract) {
        //判断该房屋是否已申请过合同
        if (sysContract.getHouseId() == null) {
            return AjaxResult.error("房源ID不能为空");
        }
        SysContract contract = new SysContract();
        contract.setHouseId(sysContract.getHouseId());
        List<SysContract> existList = sysContractService.selectSysContractList(contract).stream()
                .filter(obj -> obj.getStatus() != 3).collect(Collectors.toList());
        if (existList.size() != 0) {
            return AjaxResult.error("该房源已申请过合同，请勿重复提交");
        }
        return toAjax(sysContractService.insertSysContract(sysContract));
    }

    /**
     * 修改合同
     */
    @PreAuthorize("@ss.hasPermi('system:contract:edit')")
    @Log(title = "合同", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody SysContract sysContract) {
        //判断该房源是否空置，非空置禁止修改
        SysHouse sysHouse = sysHouseService.selectSysHouseByHouseId(sysContract.getHouseId());
        if (sysHouse.getHouseStatus() == null) {
            return AjaxResult.error("房源不存在");
        }
        if (sysContract.getStatus() != null) {
            if (sysContract.getStatus() == 3) {
                //合同终止，需判断是否有未完成订单
                SysOrderVo sysOrderVo = new SysOrderVo();
                sysOrderVo.setStatusList(new Integer[]{0, 1, 3});
                List<SysOrder> sysOrders = sysOrderService.selectSysOrderListByOrderVo(sysOrderVo);
                if (sysOrders.size() > 0) {
                    return AjaxResult.error("该房源有未完成订单，终止合同失败");
                }
            }
            if (sysContract.getStatus() == 2) {
                //合同生效，房屋可供租
                sysHouse.setRentStatus(1);
            } else {
                sysHouse.setRentStatus(0);
            }
            sysHouseService.updateSysHouse(sysHouse);
        }
        return toAjax(sysContractService.updateSysContract(sysContract));
    }

    /**
     * 删除合同
     */
//    @PreAuthorize("@ss.hasPermi('system:contract:remove')")
//    @Log(title = "合同", businessType = BusinessType.DELETE)
//    @DeleteMapping("/{contractIds}")
//    public AjaxResult remove(@PathVariable Long[] contractIds) {
//        return toAjax(sysContractService.deleteSysContractByContractIds(contractIds));
//    }
}
