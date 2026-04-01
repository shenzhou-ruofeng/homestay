package com.ruoyi.system.service.impl;

import java.util.List;

import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.system.domain.vo.SysHouseVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.SysHouseMapper;
import com.ruoyi.system.domain.SysHouse;
import com.ruoyi.system.service.ISysHouseService;

/**
 * 房源Service业务层处理
 *
 * @date 2024-01-25
 */
@Service
public class SysHouseServiceImpl implements ISysHouseService {
    @Autowired
    private SysHouseMapper sysHouseMapper;

    /**
     * 查询房源
     *
     * @param houseId 房源主键
     * @return 房源
     */
    @Override
    public SysHouse selectSysHouseByHouseId(Long houseId) {
        return sysHouseMapper.selectSysHouseByHouseId(houseId);
    }

    @Override
    public List<SysHouse> selectSysHouseByHouseIds(Long[] houseIds) {
        return sysHouseMapper.selectSysHouseByHouseIds(houseIds);
    }

    /**
     * 查询房源列表
     *
     * @param sysHouse 房源
     * @return 房源
     */
    @Override
    public List<SysHouse> selectSysHouseList(SysHouse sysHouse) {
        return sysHouseMapper.selectSysHouseList(sysHouse);
    }

    @Override
    public List<SysHouse> selectRentableSysHouseList(SysHouseVo sysHouseVo) {
        return sysHouseMapper.selectRentableSysHouseList(sysHouseVo);
    }

    /**
     * 新增房源
     *
     * @param sysHouse 房源
     * @return 结果
     */
    @Override
    public int insertSysHouse(SysHouse sysHouse) {
        sysHouse.setCreateTime(DateUtils.getNowDate());
        return sysHouseMapper.insertSysHouse(sysHouse);
    }

    /**
     * 修改房源
     *
     * @param sysHouse 房源
     * @return 结果
     */
    @Override
    public int updateSysHouse(SysHouse sysHouse) {
        sysHouse.setUpdateTime(DateUtils.getNowDate());
        return sysHouseMapper.updateSysHouse(sysHouse);
    }

    /**
     * 批量删除房源
     *
     * @param houseIds 需要删除的房源主键
     * @return 结果
     */
    @Override
    public int deleteSysHouseByHouseIds(Long[] houseIds) {
        return sysHouseMapper.deleteSysHouseByHouseIds(houseIds);
    }

    /**
     * 删除房源信息
     *
     * @param houseId 房源主键
     * @return 结果
     */
    @Override
    public int deleteSysHouseByHouseId(Long houseId) {
        return sysHouseMapper.deleteSysHouseByHouseId(houseId);
    }
}
