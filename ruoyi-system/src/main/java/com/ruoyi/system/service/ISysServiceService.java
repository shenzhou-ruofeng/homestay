package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.SysService;

/**
 * 特色服务Service接口
 * 
 * @date 2024-01-29
 */
public interface ISysServiceService 
{
    /**
     * 查询特色服务
     * 
     * @param serviceId 特色服务主键
     * @return 特色服务
     */
    public SysService selectSysServiceByServiceId(Long serviceId);

    /**
     * 查询特色服务列表
     * 
     * @param sysService 特色服务
     * @return 特色服务集合
     */
    public List<SysService> selectSysServiceList(SysService sysService);

    /**
     * 新增特色服务
     * 
     * @param sysService 特色服务
     * @return 结果
     */
    public int insertSysService(SysService sysService);

    /**
     * 修改特色服务
     * 
     * @param sysService 特色服务
     * @return 结果
     */
    public int updateSysService(SysService sysService);

    /**
     * 批量删除特色服务
     * 
     * @param serviceIds 需要删除的特色服务主键集合
     * @return 结果
     */
    public int deleteSysServiceByServiceIds(Long[] serviceIds);

    /**
     * 删除特色服务信息
     * 
     * @param serviceId 特色服务主键
     * @return 结果
     */
    public int deleteSysServiceByServiceId(Long serviceId);
}
