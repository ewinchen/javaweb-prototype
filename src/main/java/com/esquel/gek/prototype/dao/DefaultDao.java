package com.esquel.gek.prototype.dao;

import com.esquel.gek.prototype.domain.Users;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import java.util.Map;

@Component
public class DefaultDao {

    @Autowired
    @Qualifier("mysqlSqlSession")
    private SqlSession mysqlSqlSession;

    @Autowired
    private SqlSession sqlSessionTemplate;

    public Users getUser(long id) {
        return sqlSessionTemplate.selectOne("selectUserById", id);
    }

    public Users getUserProxy(long id) {
        return sqlSessionTemplate.selectOne("selectById", id);
    }

    public Map<String, Object> getCity() {
        return mysqlSqlSession.selectOne("selectCity");
    }
}
