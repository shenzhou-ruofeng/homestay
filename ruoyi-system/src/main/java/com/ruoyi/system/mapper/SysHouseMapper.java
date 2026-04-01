package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.SysHouse;
import com.ruoyi.system.domain.vo.SysHouseVo;

/**
 * 房源Mapper接口
 * 
 * @date 2024-01-25
 */
public interface SysHouseMapper 
{
    /**
     * 查询房源
     * 
     * @param houseId 房源主键
     * @return 房源
     */
    public SysHouse selectSysHouseByHouseId(Long houseId);

    public List<SysHouse> selectSysHouseByHouseIds(Long[] houseIds);


    /**
     * 查询房源列表
     * 
     * @param sysHouse 房源
     * @return 房源集合
     */
    public List<SysHouse> selectSysHouseList(SysHouse sysHouse);


    public List<SysHouse> selectRentableSysHouseList(SysHouseVo sysHouseVo);


    /**
     * 新增房源
     * 
     * @param sysHouse 房源
     * @return 结果
     */
    public int insertSysHouse(SysHouse sysHouse);

    /**
     * 修改房源
     * 
     * @param sysHouse 房源
     * @return 结果
     */
    public int updateSysHouse(SysHouse sysHouse);

    /**
     * 删除房源
     * 
     * @param houseId 房源主键
     * @return 结果
     */
    public int deleteSysHouseByHouseId(Long houseId);

    /**
     * 批量删除房源
     * 
     * @param houseIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteSysHouseByHouseIds(Long[] houseIds);
}
