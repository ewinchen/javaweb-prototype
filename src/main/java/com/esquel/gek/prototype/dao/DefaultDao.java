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

    /**
     * 可以直接调用生成的Mapper 的方法，因为已为sqlSession 注入所有statement
     * 没必要这样用，直接用对应的Mapper 就行了
     * 这里只是测试，验证
     */
    public Users getUserProxy(long id) {
        return sqlSessionTemplate.selectOne("selectById", id);
    }

    /**
     * 调用自定义Mapper 的方法
     */
    public Users getUser(long id) {
        return sqlSessionTemplate.selectOne("selectUserById", id);
    }

    /**
     * 调用另一个数据源的自定义Mapper 的方法
     */
    public Map<String, Object> getCity() {
        return mysqlSqlSession.selectOne("selectCity");
    }
}
