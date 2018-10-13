package com.esquel.gek.prototype.mapper;

import com.esquel.gek.prototype.domain.Users;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface UsersMapper {

    @Select("SELECT * FROM USERS WHERE username = #{username}")
    Users findByUsername(@Param("username") String username);

    Users selectById(int id);
}
