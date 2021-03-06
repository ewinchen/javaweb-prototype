package com.esquel.gek.prototype.mapper;

import com.esquel.gek.prototype.domain.Users;
import com.esquel.gek.prototype.domain.UsersExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

public interface UsersMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table users
     *
     * @mbg.generated Tue Oct 16 00:02:16 CST 2018
     */
    long countByExample(UsersExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table users
     *
     * @mbg.generated Tue Oct 16 00:02:16 CST 2018
     */
    int deleteByExample(UsersExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table users
     *
     * @mbg.generated Tue Oct 16 00:02:16 CST 2018
     */
    int deleteByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table users
     *
     * @mbg.generated Tue Oct 16 00:02:16 CST 2018
     */
    int insert(Users record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table users
     *
     * @mbg.generated Tue Oct 16 00:02:16 CST 2018
     */
    int insertSelective(Users record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table users
     *
     * @mbg.generated Tue Oct 16 00:02:16 CST 2018
     */
    List<Users> selectByExampleWithRowbounds(UsersExample example, RowBounds rowBounds);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table users
     *
     * @mbg.generated Tue Oct 16 00:02:16 CST 2018
     */
    List<Users> selectByExample(UsersExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table users
     *
     * @mbg.generated Tue Oct 16 00:02:16 CST 2018
     */
    Users selectByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table users
     *
     * @mbg.generated Tue Oct 16 00:02:16 CST 2018
     */
    int updateByExampleSelective(@Param("record") Users record, @Param("example") UsersExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table users
     *
     * @mbg.generated Tue Oct 16 00:02:16 CST 2018
     */
    int updateByExample(@Param("record") Users record, @Param("example") UsersExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table users
     *
     * @mbg.generated Tue Oct 16 00:02:16 CST 2018
     */
    int updateByPrimaryKeySelective(Users record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table users
     *
     * @mbg.generated Tue Oct 16 00:02:16 CST 2018
     */
    int updateByPrimaryKey(Users record);
}