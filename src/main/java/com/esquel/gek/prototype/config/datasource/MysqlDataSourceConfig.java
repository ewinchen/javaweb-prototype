package com.esquel.gek.prototype.config.datasource;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.autoconfigure.jdbc.DataSourceProperties;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;

import javax.sql.DataSource;
import java.util.Objects;

/**
 * 多数据源的时候，可以用MapperScan指定Mapper要注入的sqlSession，前提要不适用@Mapper注解，@Mapper注解会为所有注册的sqlSession都注入所有Mapper
 */
@Configuration
@MapperScan(basePackages = "com.esquel.gek.prototype.mapper", sqlSessionFactoryRef = "mysqlSqlSession")
public class MysqlDataSourceConfig {

    @Bean
    @ConfigurationProperties("app.datasource.local.mysql")
    public DataSourceProperties localMysqlProperties() {
        return new DataSourceProperties();
    }

    @Bean
    @ConfigurationProperties("app.datasource.local.mysql")
    public DataSource localMysqlDataSource() {
        return localMysqlProperties().initializeDataSourceBuilder().build();
    }

    @Bean
    public JdbcTemplate localMysqlJdbcTemplate(
            @Qualifier("localMysqlDataSource") DataSource dataSource) {
        return new JdbcTemplate(dataSource);
    }

    /**
     * 只是用mybatis时，mybatis多数据，还可以在xml文件配置各自的environment，然后使用SqlSessionFactoryBuilder().build(environment)设置
     * 使用spring-mybatis的话，new SqlSessionFactoryBean() 是通过设置所有属性后sqlSessionFactoryBean.getObject() 调用SqlSessionFactoryBuilder().build()
     */
    @Bean
    public SqlSession mysqlSqlSession(@Qualifier("localMysqlDataSource") DataSource dataSource) throws Exception {
        SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
        sqlSessionFactoryBean.setDataSource(dataSource);
        Resource resource = new ClassPathResource("mybatis-config-mysql.xml");
        sqlSessionFactoryBean.setConfigLocation(resource);

        return new SqlSessionTemplate(Objects.requireNonNull(sqlSessionFactoryBean.getObject()));
    }

    @Bean
    public PlatformTransactionManager localMysqlTransactionManager(@Qualifier("localMysqlDataSource") DataSource dataSource) {
        return new DataSourceTransactionManager(dataSource);
    }
}
