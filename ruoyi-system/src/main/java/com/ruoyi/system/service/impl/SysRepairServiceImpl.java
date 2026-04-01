package com.ruoyi.system.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.SysRepairMapper;
import com.ruoyi.system.domain.SysRepair;
import com.ruoyi.system.service.ISysRepairService;

/**
 * 报修Service业务层处理
 * 
 * @date 2024-02-05
 */
@Service
public class SysRepairServiceImpl implements ISysRepairService 
{
    @Autowired
    private SysRepairMapper sysRepairMapper;

    /**
     * 查询报修
     * 
     * @param repairId 报修主键
     * @return 报修
     */
    @Override
    public SysRepair selectSysRepairByRepairId(Long repairId)
    {
        return sysRepairMapper.selectSysRepairByRepairId(repairId);
    }

    /**
     * 查询报修列表
     * 
     * @param sysRepair 报修
     * @return 报修
     */
    @Override
    public List<SysRepair> selectSysRepairList(SysRepair sysRepair)
    {
        return sysRepairMapper.selectSysRepairList(sysRepair);
    }

    /**
     * 新增报修
     * 
     * @param sysRepair 报修
     * @return 结果
     */
    @Override
    public int insertSysRepair(SysRepair sysRepair)
    {
        sysRepair.setCreateTime(DateUtils.getNowDate());
        return sysRepairMapper.insertSysRepair(sysRepair);
    }

    /**
     * 修改报修
     * 
     * @param sysRepair 报修
     * @return 结果
     */
    @Override
    public int updateSysRepair(SysRepair sysRepair)
    {
        sysRepair.setUpdateTime(DateUtils.getNowDate());
        return sysRepairMapper.updateSysRepair(sysRepair);
    }

    /**
     * 批量删除报修
     * 
     * @param repairIds 需要删除的报修主键
     * @return 结果
     */
    @Override
    public int deleteSysRepairByRepairIds(Long[] repairIds)
    {
        return sysRepairMapper.deleteSysRepairByRepairIds(repairIds);
    }

    /**
     * 删除报修信息
     * 
     * @param repairId 报修主键
     * @return 结果
     */
    @Override
    public int deleteSysRepairByRepairId(Long repairId)
    {
        return sysRepairMapper.deleteSysRepairByRepairId(repairId);
    }
}
