package com.esquel.gek.prototype.dao;

import com.esquel.gek.prototype.domain.Users;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class DefaultDao {

    @Autowired
    private SqlSession sqlSession;

    public Users getUser(long id) {
        return sqlSession.selectOne("selectUserById", id);
    }

    public Users getUserProxy(long id) {
        return sqlSession.selectOne("selectById", id);
    }
}
