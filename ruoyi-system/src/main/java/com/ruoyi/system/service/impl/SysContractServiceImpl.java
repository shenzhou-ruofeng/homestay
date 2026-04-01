package com.ruoyi.system.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.system.domain.vo.SysContractVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.SysContractMapper;
import com.ruoyi.system.domain.SysContract;
import com.ruoyi.system.service.ISysContractService;

/**
 * 合同Service业务层处理
 * 
 * @date 2024-01-31
 */
@Service
public class SysContractServiceImpl implements ISysContractService 
{
    @Autowired
    private SysContractMapper sysContractMapper;

    /**
     * 查询合同
     * 
     * @param contractId 合同主键
     * @return 合同
     */
    @Override
    public SysContract selectSysContractByContractId(Long contractId)
    {
        return sysContractMapper.selectSysContractByContractId(contractId);
    }

    /**
     * 查询合同列表
     * 
     * @param sysContract 合同
     * @return 合同
     */
    @Override
    public List<SysContractVo> selectSysContractList(SysContract sysContract)
    {
        return sysContractMapper.selectSysContractList(sysContract);
    }

    /**
     * 新增合同
     * 
     * @param sysContract 合同
     * @return 结果
     */
    @Override
    public int insertSysContract(SysContract sysContract)
    {
        sysContract.setCreateTime(DateUtils.getNowDate());
        return sysContractMapper.insertSysContract(sysContract);
    }

    /**
     * 修改合同
     * 
     * @param sysContract 合同
     * @return 结果
     */
    @Override
    public int updateSysContract(SysContract sysContract)
    {
        sysContract.setUpdateTime(DateUtils.getNowDate());
        return sysContractMapper.updateSysContract(sysContract);
    }

    /**
     * 批量删除合同
     * 
     * @param contractIds 需要删除的合同主键
     * @return 结果
     */
    @Override
    public int deleteSysContractByContractIds(Long[] contractIds)
    {
        return sysContractMapper.deleteSysContractByContractIds(contractIds);
    }

    /**
     * 删除合同信息
     * 
     * @param contractId 合同主键
     * @return 结果
     */
    @Override
    public int deleteSysContractByContractId(Long contractId)
    {
        return sysContractMapper.deleteSysContractByContractId(contractId);
    }
}
