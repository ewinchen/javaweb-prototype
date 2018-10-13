package com.esquel.gek.prototype.config;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.autoconfigure.jdbc.DataSourceProperties;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;

import javax.sql.DataSource;
import java.util.Objects;

@Configuration
public class DataSourceConfig {

    @Bean
    @Primary
    @ConfigurationProperties("app.datasource.local.sqlserver")
    public DataSourceProperties localSqlserverProperties() {
        return new DataSourceProperties();
    }

    @Bean
    @Primary
    @ConfigurationProperties("app.datasource.local.sqlserver")
    public DataSource localSqlserverDataSource() {
        return localSqlserverProperties().initializeDataSourceBuilder().build();
    }

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
    public JdbcTemplate localSqlserverJdbcTemplate(
            @Qualifier("localSqlserverDataSource") DataSource dataSource) {
        return new JdbcTemplate(dataSource);
    }

    /**
     * mybatis多数据源权宜之计，后续应该在xml文件配置各自的environment，然后使用SSqlSessionFactoryBuilder().build()设置
     * new SqlSessionFactoryBean()是通过设置所有属性后
     * @param dataSource
     * @return
     * @throws Exception
     */
    @Bean
    public SqlSession customSqlSession(@Qualifier("localMysqlDataSource") DataSource dataSource) throws Exception {
        SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
        sqlSessionFactoryBean.setDataSource(dataSource);
        Resource resource = new ClassPathResource("mybatis-config.xml");
        sqlSessionFactoryBean.setConfigLocation(resource);
        return new SqlSessionTemplate(Objects.requireNonNull(sqlSessionFactoryBean.getObject()));

    }

    @Bean
    public PlatformTransactionManager localSqlserverTransactionManager(@Qualifier("localSqlserverDataSource") DataSource dataSource) {
        return new DataSourceTransactionManager(dataSource);
    }

    @Bean
    public PlatformTransactionManager localMysqlTransactionManager(@Qualifier("localMysqlDataSource") DataSource dataSource) {
        return new DataSourceTransactionManager(dataSource);
    }

//    @Bean
//    @ConfigurationProperties("app.datasource.kmis")
//    public DataSourceProperties kmisProperties() {
//        return new DataSourceProperties();
//    }
//
//    @Bean
//    @ConfigurationProperties("app.datasource.kmis")
//    public DataSource kmisDataSource() {
//        return kmisProperties().initializeDataSourceBuilder().build();
//    }
//
//    @Bean
//    @ConfigurationProperties("app.datasource.uat")
//    public DataSourceProperties uatProperties() {
//        return new DataSourceProperties();
//    }
//
//    @Bean
//    @ConfigurationProperties("app.datasource.uat")
//    public DataSource uatDataSource() {
//        return uatProperties().initializeDataSourceBuilder().build();
//    }
//
//    @Bean
//    public JdbcTemplate kmisJdbcTemplate(
//            @Qualifier("kmisDataSource") DataSource dataSource) {
//        return new JdbcTemplate(dataSource);
//    }
//
//    @Bean
//    public JdbcTemplate uatJdbcTemplate(
//            @Qualifier("uatDataSource") DataSource dataSource) {
//        return new JdbcTemplate(dataSource);
//    }

}
