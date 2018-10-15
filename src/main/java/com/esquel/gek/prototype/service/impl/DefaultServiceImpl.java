package com.esquel.gek.prototype.service.impl;

import com.esquel.gek.prototype.dao.DefaultDao;
import com.esquel.gek.prototype.domain.Users;
import com.esquel.gek.prototype.domain.UsersExample;
import com.esquel.gek.prototype.mapper.UsersMapper;
import com.esquel.gek.prototype.service.DefaultService;
import org.apache.shiro.authc.credential.DefaultPasswordService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class DefaultServiceImpl implements DefaultService {

    private static final Logger logger = LoggerFactory.getLogger(DefaultServiceImpl.class);

    /**
     * 使用@Mapper，并且是单数据源的时候是不需要@Autowired的  参考日志：Enabling autowire by type for MapperFactoryBean with name 'usersMapper'.
     * 多数据源的时候，不加@AutoWired的话，系统启动时不知道注入到哪个SqlSession，会报错，加上@Autowired 会自动注入到默认的SqlSession！
     * <p>
     * 如果不使用@Mapper的话，不会自动注入，须要@Autowired的注解！
     * 但是代码里没有实现，所以须要用@SuppressWarnings
     */
    @SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
    @Autowired
    private UsersMapper usersMapper;

    @Autowired
    private DefaultDao defaultDao;

    @Override
    public Map<String, Object> getGkNumInfo() {
        return null;
    }

    @Override
    public List<Map<String, Object>> getJobNum() {
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
        /**
         * 测试使用Mapper
         */
        UsersExample usersExample = new UsersExample();

        usersExample.or().andUsernameEqualTo("admin");

        logger.info("Mapper of UsersExample: " + usersMapper.selectByExample(usersExample).get(0).toString());

        logger.info("Mapper of Primary Key: " + usersMapper.selectByPrimaryKey(1L).toString());

        Users user = new Users();
//        user.setUsername("Edwin");
//        String password = new DefaultPasswordService().encryptPassword("behappy");
//        user.setUsername("Ewin");
//        String password = new DefaultPasswordService().encryptPassword("beStrong");
//        user.setUsername("Robert");
//        String password = new DefaultPasswordService().encryptPassword("beGood");
//        user.setUsername("SuperRobert");
//        String password = new DefaultPasswordService().encryptPassword("beSuper");
//        user.setUsername("SuperEdwin");
//        String password = new DefaultPasswordService().encryptPassword("bePower");
//        user.setUsername("RampageEdwin");
//        String password = new DefaultPasswordService().encryptPassword("beHealthy");
        user.setUsername("TiredEdwin1");
        String password = new DefaultPasswordService().encryptPassword("beLazy1");
        user.setPassword(password);
        user.setEnable(true);
        usersMapper.insert(user);

        logger.info("Identity: " + user.getId());

        logger.info("new User: " + user);

        /**
         * 测试调用不同的数据源
         */
        logger.info("Dao: " + defaultDao.getUser(2).toString());
        logger.info("Dao of Mysql: " + defaultDao.getCity().toString());
    }


}
