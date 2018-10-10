package com.esquel.gek.prototype.config;

import org.apache.shiro.authc.credential.PasswordMatcher;
import org.apache.shiro.realm.Realm;
import org.apache.shiro.realm.jdbc.JdbcRealm;
import org.apache.shiro.realm.text.TextConfigurationRealm;
import org.apache.shiro.spring.web.config.DefaultShiroFilterChainDefinition;
import org.apache.shiro.spring.web.config.ShiroFilterChainDefinition;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ShiroConfig {

    @Bean
    public Realm realm() {
//        TextConfigurationRealm realm = new TextConfigurationRealm();
//        realm.setUserDefinitions("user=user,user\n" +
//                "admin=admin,admin");
//        return realm;

        CustomJdbcRealm customJdbcRealm = new CustomJdbcRealm();
        // 设置shiro默认的密码解析器，
        // 需配合new DefaultPasswordService().encryptPassword()使用来设置密码，可以代替bcrypt
        // 也可用cli来手工创建密码java -jar ./shiro-tools-hasher-1.3.2-cli.jar -p
        customJdbcRealm.setCredentialsMatcher(new PasswordMatcher());
//        实现RolePermissionResolver 可以直接给单独的用户赋权
//        customJdbcRealm.setRolePermissionResolver();
        return customJdbcRealm;
    }

    @Bean
    public ShiroFilterChainDefinition shiroFilterChainDefinition() {
        DefaultShiroFilterChainDefinition chainDefinition = new DefaultShiroFilterChainDefinition();

        // logged in users with the 'admin' role
        chainDefinition.addPathDefinition("/admin/**", "authc, roles[admin]");

        // logged in users with the 'document:read' permission
        chainDefinition.addPathDefinition("/docs/**", "authc, perms[document:read]");

        chainDefinition.addPathDefinition("/js/**", "anon");
        chainDefinition.addPathDefinition("/css/**", "anon");
        chainDefinition.addPathDefinition("/img/**", "anon");
        chainDefinition.addPathDefinition("/lib/**", "anon");

        // all other paths require a logged in user
        chainDefinition.addPathDefinition("/**", "authc");

        // logout
        chainDefinition.addPathDefinition("/logout", "logout");
        return chainDefinition;
    }
}
