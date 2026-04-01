package com.ruoyi.web.controller.system;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.common.config.RuoYiConfig;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.file.FileUploadUtils;
import com.ruoyi.common.utils.file.ImageUtils;
import com.ruoyi.common.utils.file.MimeTypeUtils;
import com.ruoyi.common.utils.uuid.IdUtils;
import com.ruoyi.system.domain.SysContract;
import com.ruoyi.system.service.ISysContractService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.SysHouse;
import com.ruoyi.system.service.ISysHouseService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 房源Controller
 *
 * @date 2024-01-25
 */
@RestController
@RequestMapping("/system/house")
public class SysHouseController extends BaseController {
    @Autowired
    private ISysHouseService sysHouseService;

    /**
     * 查询房源列表
     */
    @PreAuthorize("@ss.hasPermi('system:house:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysHouse sysHouse) {
        startPage();
        if (SecurityUtils.hasRole("landlord") && !SecurityUtils.isAdmin(getUserId())) {
            //房东身份，仅查自己的
            sysHouse.setUserId(getUserId());
        }
        List<SysHouse> list = sysHouseService.selectSysHouseList(sysHouse);
        //图片拼接上地址
        for (SysHouse house : list) {
            List<String> url = new ArrayList<>();
            for (String fileName : house.getImageUrl().split(",")) {
                url.add(RuoYiConfig.getImageUrl() + fileName);
            }
            house.setImageUrl(String.join(",", url));
        }
        return getDataTable(list);
    }

    /**
     * 查询所有房源列表
     */
    @PreAuthorize("@ss.hasPermi('system:house:list')")
    @GetMapping("/listAll")
    public AjaxResult listAll(SysHouse sysHouse) {
        if (SecurityUtils.hasRole("landlord") && !SecurityUtils.isAdmin(getUserId())) {
            //房东身份，仅查自己的
            sysHouse.setUserId(getUserId());
        }
        List<SysHouse> list = sysHouseService.selectSysHouseList(sysHouse);
        return AjaxResult.success(list);
    }

    /**
     * 导出房源列表
     */
    @PreAuthorize("@ss.hasPermi('system:house:export')")
    @Log(title = "房源", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, SysHouse sysHouse) {
        List<SysHouse> list = sysHouseService.selectSysHouseList(sysHouse);
        ExcelUtil<SysHouse> util = new ExcelUtil<SysHouse>(SysHouse.class);
        util.exportExcel(response, list, "房源数据");
    }

    /**
     * 获取房源详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:house:query')")
    @GetMapping(value = "/{houseId}")
    public AjaxResult getInfo(@PathVariable("houseId") Long houseId) {
        SysHouse house = sysHouseService.selectSysHouseByHouseId(houseId);
        List<String> url = new ArrayList<>();
        for (String fileName : house.getImageUrl().split(",")) {
            url.add(RuoYiConfig.getImageUrl() + fileName);
        }
        house.setImageUrl(String.join(",", url));
        return success(house);
    }

    /**
     * 新增房源
     */
    @PreAuthorize("@ss.hasPermi('system:house:add')")
    @Log(title = "房源", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody SysHouse sysHouse) {
        //房东则获取当前登录的用户id
        if (!SecurityUtils.isAdmin(getUserId()) && SecurityUtils.hasRole("landlord")) {
            sysHouse.setUserId(getUserId());
        } else {
            if (sysHouse.getUserId() == null) {
                return AjaxResult.error("房东ID不能为空");
            }
        }
        //保存房源图片
        String[] base64List = sysHouse.getImageUrl().split(",");
        List<String> imageUrls = new ArrayList<>();
        for (String base64 : base64List) {
            String fileName = ImageUtils.saveImage(base64, RuoYiConfig.getUploadPath());
            if (fileName == null) {
                return AjaxResult.error("保存房源图片失败");
            }
            imageUrls.add(fileName);
        }
        sysHouse.setImageUrl(StringUtils.join(imageUrls, ","));
        return toAjax(sysHouseService.insertSysHouse(sysHouse));
    }

    /**
     * 修改房源
     */
    @PreAuthorize("@ss.hasPermi('system:house:edit')")
    @Log(title = "房源", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody SysHouse sysHouse) {
        //校验房源是否存在
        SysHouse oldData = sysHouseService.selectSysHouseByHouseId(sysHouse.getHouseId());
        if (oldData == null) {
            return AjaxResult.error("该房源不存在");
        }
        String[] images = sysHouse.getImageUrl().split(",");
        List<String> maintain = new ArrayList<>();
        List<String> imageUrls = new ArrayList<>();
        for (String image : images) {
            if (image.contains(".jpg")) {
                //原图片
                maintain.add(image);
                imageUrls.add(image);
            } else {
                //新图片
                String fileName = ImageUtils.saveImage(image, RuoYiConfig.getUploadPath());
                if (fileName == null) {
                    return AjaxResult.error("保存房源图片失败");
                }
                imageUrls.add(fileName);
            }
        }
        //删除原图片
        List<String> deleteList = Arrays.stream(oldData.getImageUrl().split(","))
                .filter(obj -> !maintain.contains(obj))
                .collect(Collectors.toList());
        for (String fileName : deleteList) {
            boolean res = ImageUtils.deleteImage(RuoYiConfig.getUploadPath() + fileName);
            if (!res) {
                return AjaxResult.error("删除房源图片失败");
            }
        }
        sysHouse.setImageUrl(StringUtils.join(imageUrls, ","));
        return toAjax(sysHouseService.updateSysHouse(sysHouse));
    }

    /**
     * 删除房源
     */
    @PreAuthorize("@ss.hasPermi('system:house:remove')")
    @Log(title = "房源", businessType = BusinessType.DELETE)
    @DeleteMapping("/{houseIds}")
    public AjaxResult remove(@PathVariable Long[] houseIds) {
        //校验房源是否存在
        List<SysHouse> oldDataList = sysHouseService.selectSysHouseByHouseIds(houseIds);
        if (oldDataList.size() != houseIds.length) {
            return AjaxResult.error("房源不存在");
        }
        for (SysHouse sysHouse : oldDataList) {
            for (String fileName : sysHouse.getImageUrl().split(",")) {
                boolean res = ImageUtils.deleteImage(RuoYiConfig.getUploadPath() + fileName);
                if (!res) {
                    return AjaxResult.error("删除房源图片失败");
                }
            }
        }
        return toAjax(sysHouseService.deleteSysHouseByHouseIds(houseIds));
    }
}
