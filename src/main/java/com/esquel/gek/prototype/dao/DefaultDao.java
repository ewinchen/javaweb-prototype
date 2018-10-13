package com.esquel.gek.prototype.dao;

import com.esquel.gek.prototype.domain.Users;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.Map;

@Repository
public class DefaultDao {

    @Autowired
    @Qualifier("customSqlSession")
    private SqlSession customSqlSession;

    @Autowired
    private SqlSessionTemplate sqlSession;

    public Users getUser(long id) {
        return sqlSession.selectOne("selectUserById", id);
    }

    public Users getUserProxy(long id) {
        return sqlSession.selectOne("selectById", id);
    }

    public Map<String, Object> getCity() {
        return customSqlSession.selectOne("selectCity");
    }
}
