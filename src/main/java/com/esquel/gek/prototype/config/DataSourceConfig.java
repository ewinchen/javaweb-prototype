package com.esquel.gek.prototype.config;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.autoconfigure.jdbc.DataSourceProperties;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.jdbc.core.JdbcTemplate;

import javax.sql.DataSource;
import java.util.Objects;

@Configuration
public class DataSourceConfig {

    @Bean
    @Primary
    @ConfigurationProperties("app.datasource.local.mssql")
    public DataSourceProperties localMssqlProperties() {
        return new DataSourceProperties();
    }

    @Bean
    @Primary
    @ConfigurationProperties("app.datasource.local.mssql")
    public DataSource localMssqlDataSource() {
        return localMssqlProperties().initializeDataSourceBuilder().build();
    }

    @Bean
    public JdbcTemplate localMssqlJdbcTemplate(
            @Qualifier("localMssqlDataSource") DataSource dataSource) {
        return new JdbcTemplate(dataSource);
    }

//    @Bean
//    public SqlSession sqlSession(@Qualifier("localMssqlDataSource") DataSource dataSource) throws Exception {
//        SqlSessionFactoryBean sqlSessionFactory = new SqlSessionFactoryBean();
//        sqlSessionFactory.setDataSource(dataSource);
//        SqlSessionTemplate sqlSessionTemplate = new SqlSessionTemplate(Objects.requireNonNull(sqlSessionFactory.getObject()));
//        return sqlSessionTemplate;
//
//    }

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
