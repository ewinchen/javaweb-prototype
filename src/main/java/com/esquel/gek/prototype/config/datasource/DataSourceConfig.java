package com.esquel.gek.prototype.config.datasource;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.autoconfigure.jdbc.DataSourceProperties;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;

import javax.sql.DataSource;

/**
 * 多数据源的时候，可以用MapperScan指定Mapper要注入的sqlSession，前提要不使用@Mapper注解，@Mapper注解会为所有注册的sqlSession都注入所有Mapper
 *
 * 为什么没有sqlSession？
 * spring-mybatis 会为默认的数据源自动创建 sqlSessionTemplate，并且会读取application.properties 中Mybatis的配置
 * 参考 org.mybatis.spring.boot.autoconfigure.MybatisAutoConfiguration
 */
@Configuration
@MapperScan(basePackages = "com.esquel.gek.prototype.mapper", sqlSessionTemplateRef = "sqlSessionTemplate")
public class DataSourceConfig {

    /**
     * spring boot有默认的datasource 配置，多数据源时不适用
     */
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
    @Primary
    public JdbcTemplate localSqlserverJdbcTemplate(
            @Qualifier("localSqlserverDataSource") DataSource dataSource) {
        return new JdbcTemplate(dataSource);
    }

    @Bean
    @Primary
    public PlatformTransactionManager localSqlserverTransactionManager(@Qualifier("localSqlserverDataSource") DataSource dataSource) {
        return new DataSourceTransactionManager(dataSource);
    }
}
