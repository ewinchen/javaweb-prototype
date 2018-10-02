package com.esquel.gek.prototype.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.autoconfigure.security.servlet.PathRequest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.JdbcUserDetailsManager;

import javax.sql.DataSource;

@EnableWebSecurity
public class SecurityConfig {

/*    @Autowired
    @Qualifier("localMssqlDataSource")
    private DataSource dataSource;

    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
        // ensure the passwords are encoded properly
        User.UserBuilder users = User.withDefaultPasswordEncoder();
        auth
            .jdbcAuthentication()
            .dataSource(dataSource);
            //创建表
            //.withDefaultSchema()
            //插入数据
            //.withUser(users.username("guest").password("password").roles("USER"));
    }*/
/*
    // 应用启动时的全局配置
    @Autowired
    public void configureGlobal(JdbcUserDetailsManager jdbcUserDetailsManager, PasswordEncoder passwordEncoder) throws Exception {
        User.UserBuilder userBuilder = User.builder();

        UserDetails sysadmin = userBuilder.username("sysadmin").password("sysadmin").roles("ADMIN", "USER").passwordEncoder(passwordEncoder::encode).build();
        UserDetails sales01 = userBuilder.username("sales01").password("sales01").roles("SALES", "USER").passwordEncoder(passwordEncoder::encode).build();
        UserDetails ppc01 = userBuilder.username("ppc01").password("ppc01").roles("PPC", "USER").passwordEncoder(passwordEncoder::encode).build();
        UserDetails tech01 = userBuilder.username("tech01").password("tech01").roles("TECH", "USER").passwordEncoder(passwordEncoder::encode).build();

        jdbcUserDetailsManager.createUser(sysadmin);
        jdbcUserDetailsManager.createUser(sales01);
        jdbcUserDetailsManager.createUser(tech01);

//        jdbcUserDetailsManager.createGroup("group_admin", AuthorityUtils.createAuthorityList("view", "update"));
//        jdbcUserDetailsManager.createGroup("group_quest", AuthorityUtils.createAuthorityList("view"));
//
//        jdbcUserDetailsManager.addUserToGroup("admin", "group_admin");
//        jdbcUserDetailsManager.addUserToGroup("quest", "group_quest");
    }

*/
    /**
     * Basic Auth每次请求都会将用户名和密码(user:password的键值对，虽然不一定用密码)以Base64编码的方式发送
     * 似乎达不到JWT的作用，先放在这里以供参考
     * 如果是普通的MVC应用，同域的AJAX请求也会带上cookies的信息即JSSESSIONID,似乎不需要Basic Auth验证
     *
     * JWT的使用还是有待商榷啊，看看github大神的评论
     * https://github.com/shieldfy/API-Security-Checklist/issues/6#issuecomment-371038523
     */
    /*@Configuration
    @Order(1)
    public static class ApiWebSecurityConfigurationAdapter extends WebSecurityConfigurerAdapter {

        protected void configure(HttpSecurity http) throws Exception {
            http
                .antMatcher("/api/**")
                    .authorizeRequests()
                    .anyRequest().hasRole("ADMIN")
                    .and()
                .httpBasic();
        }
    }*/

    @Configuration
    public static class FormLoginWebSecurityConfigurerAdapter extends WebSecurityConfigurerAdapter {

        @Override
        protected void configure(HttpSecurity http) throws Exception {
            http
                .authorizeRequests()
                    .requestMatchers(PathRequest.toStaticResources().atCommonLocations()).permitAll()
                    .antMatchers("/", "/index", "/replenishment_helper").permitAll()
                    .antMatchers("/hello").hasRole("USER")
                    .anyRequest().authenticated()
                    .and()
                .formLogin();
//                    .loginPage("/login")
//                    .permitAll()
//                    .and()
//                .logout()
//                    .permitAll();
        }

        // 使用JDBC管理用户验证
        @Bean
        public JdbcUserDetailsManager jdbcUserDetailsManager(@Qualifier("localMssqlDataSource") DataSource dataSource) {
            JdbcUserDetailsManager jdbcUserDetailsManager = new JdbcUserDetailsManager();
//            jdbcUserDetailsManager.setEnableAuthorities(false);
//            jdbcUserDetailsManager.setEnableGroups(true);
            jdbcUserDetailsManager.setDataSource(dataSource);
            return jdbcUserDetailsManager;
        }

        // 设置密码加密方式，默认为bcrypt
        @Bean
        public PasswordEncoder passwordEncoder() {
            PasswordEncoder passwordEncoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();
            return passwordEncoder;
        }
    }


}