package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.SysRepair;

/**
 * 报修Mapper接口
 * 
 * @date 2024-02-05
 */
public interface SysRepairMapper 
{
    /**
     * 查询报修
     * 
     * @param repairId 报修主键
     * @return 报修
     */
    public SysRepair selectSysRepairByRepairId(Long repairId);

    /**
     * 查询报修列表
     * 
     * @param sysRepair 报修
     * @return 报修集合
     */
    public List<SysRepair> selectSysRepairList(SysRepair sysRepair);

    /**
     * 新增报修
     * 
     * @param sysRepair 报修
     * @return 结果
     */
    public int insertSysRepair(SysRepair sysRepair);

    /**
     * 修改报修
     * 
     * @param sysRepair 报修
     * @return 结果
     */
    public int updateSysRepair(SysRepair sysRepair);

    /**
     * 删除报修
     * 
     * @param repairId 报修主键
     * @return 结果
     */
    public int deleteSysRepairByRepairId(Long repairId);

    /**
     * 批量删除报修
     * 
     * @param repairIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteSysRepairByRepairIds(Long[] repairIds);
}
