package com.ruoyi.system.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.SysServiceMapper;
import com.ruoyi.system.domain.SysService;
import com.ruoyi.system.service.ISysServiceService;

/**
 * 特色服务Service业务层处理
 * 
 * @date 2024-01-29
 */
@Service
public class SysServiceServiceImpl implements ISysServiceService 
{
    @Autowired
    private SysServiceMapper sysServiceMapper;

    /**
     * 查询特色服务
     * 
     * @param serviceId 特色服务主键
     * @return 特色服务
     */
    @Override
    public SysService selectSysServiceByServiceId(Long serviceId)
    {
        return sysServiceMapper.selectSysServiceByServiceId(serviceId);
    }

    /**
     * 查询特色服务列表
     * 
     * @param sysService 特色服务
     * @return 特色服务
     */
    @Override
    public List<SysService> selectSysServiceList(SysService sysService)
    {
        return sysServiceMapper.selectSysServiceList(sysService);
    }

    /**
     * 新增特色服务
     * 
     * @param sysService 特色服务
     * @return 结果
     */
    @Override
    public int insertSysService(SysService sysService)
    {
        sysService.setCreateTime(DateUtils.getNowDate());
        return sysServiceMapper.insertSysService(sysService);
    }

    /**
     * 修改特色服务
     * 
     * @param sysService 特色服务
     * @return 结果
     */
    @Override
    public int updateSysService(SysService sysService)
    {
        sysService.setUpdateTime(DateUtils.getNowDate());
        return sysServiceMapper.updateSysService(sysService);
    }

    /**
     * 批量删除特色服务
     * 
     * @param serviceIds 需要删除的特色服务主键
     * @return 结果
     */
    @Override
    public int deleteSysServiceByServiceIds(Long[] serviceIds)
    {
        return sysServiceMapper.deleteSysServiceByServiceIds(serviceIds);
    }

    /**
     * 删除特色服务信息
     * 
     * @param serviceId 特色服务主键
     * @return 结果
     */
    @Override
    public int deleteSysServiceByServiceId(Long serviceId)
    {
        return sysServiceMapper.deleteSysServiceByServiceId(serviceId);
    }
}
