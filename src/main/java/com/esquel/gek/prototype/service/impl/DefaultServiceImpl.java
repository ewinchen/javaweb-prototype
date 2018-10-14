package com.esquel.gek.prototype.service.impl;

import com.esquel.gek.prototype.dao.DefaultDao;
import com.esquel.gek.prototype.mapper.UsersMapper;
import com.esquel.gek.prototype.service.DefaultService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import javax.validation.constraints.Null;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class DefaultServiceImpl implements DefaultService {

    private static final Logger logger = LoggerFactory.getLogger(DefaultServiceImpl.class);

//    @SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
    @SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
    /**
     * 使用@Mapper，并且是单数据源的时候是不需要@Autowired的  参考日志：Enabling autowire by type for MapperFactoryBean with name 'usersMapper'.
     * 多数据源的时候，不加@AutoWired的话，系统启动时不知道注入到哪个SqlSession，会报错，加上@Autowired 会自动注入到默认的SqlSession！
     *
     * 如果不使用@Mapper的话，不会自动注入，须要@Autowired的注解！
     */
    @Autowired
    private UsersMapper usersMapper;

    @Autowired
    private DefaultDao defaultDao;

//    @Autowired
//    @Qualifier("kmisJdbcTemplate")
//    private JdbcTemplate kmisJdbcTemplate;
//
//    @Autowired
//    @Qualifier("uatJdbcTemplate")
//    private JdbcTemplate uatJdbcTemplate;

    @Override
    public Map<String, Object> getGkNumInfo() {
        return null;
    }

    @Override
    public List<Map<String, Object>> getJobNum() {
//        List<Map<String, Object>> a = uatJdbcTemplate.queryForList("SELECT TOP 10 * FROM ArtDB.dbo.rtPdInfo;");
//        List<Map<String, Object>> b = kmisJdbcTemplate.queryForList("SELECT TOP 10 * FROM ArtDB.dbo.rtPdInfo;");
//
//        List<Map<String, Object>> res = new ArrayList<>();
//        res.addAll(a);
//        res.addAll(b);
        return null;
    }

    @Override
    public List<Map<String, Object>> getPackDetail() {
        return null;
    }

    @Override
    public List<Map<String, Object>> getPpoNum() {
        return null;
    }

    /**
     * 事务管理，先到这个地步吧，如果想使用分布式事务，须要使用JTA，Spring Boot也有相关文档
     * 若设置了Primary 事务管理器，会默认使用
     * 若想指定数据源，使用 @Transactional(transactionManager = "localMysqlTransactionManager")
     */
    @Override
    @Transactional
    public void hello() {
        logger.info(usersMapper.findByUsername("admin").toString());

        logger.info(usersMapper.selectById(1).toString());

        logger.info(defaultDao.getUser(2).toString());

        logger.info(defaultDao.getCity().toString());

        logger.info(defaultDao.getUserProxy(3).toString());

    }


}
