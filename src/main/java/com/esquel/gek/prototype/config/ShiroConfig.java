package com.esquel.gek.prototype.config;

import org.apache.shiro.authc.credential.PasswordMatcher;
import org.apache.shiro.codec.Base64;
import org.apache.shiro.mgt.RememberMeManager;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.realm.Realm;
import org.apache.shiro.spring.web.config.DefaultShiroFilterChainDefinition;
import org.apache.shiro.spring.web.config.ShiroFilterChainDefinition;
import org.apache.shiro.web.mgt.CookieRememberMeManager;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.apache.shiro.web.servlet.Cookie;
import org.apache.shiro.web.servlet.SimpleCookie;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;

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
    public RememberMeManager rememberMeManager(@Qualifier("rememberMeCookieTemplate") Cookie cookie) {
        CookieRememberMeManager rememberMeManager = new CookieRememberMeManager();
        cookie.setMaxAge(604800);
        rememberMeManager.setCookie(cookie);
        rememberMeManager.setCipherKey(Base64.decode("kPH+bIxk5D2deZiIxcaaaA=="));
        return rememberMeManager;
    }

//    @Bean
//    public SecurityManager securityManager(List<Realm> realms) {
//        DefaultWebSecurityManager securityManager =  new DefaultWebSecurityManager();
//        //设置realm.
//        securityManager.setRealms(realms);
//
//        return securityManager;
//    }


    @Bean
    public ShiroFilterChainDefinition shiroFilterChainDefinition() {
        DefaultShiroFilterChainDefinition chainDefinition = new DefaultShiroFilterChainDefinition();

        // logged in users with the 'admin' role
        // chainDefinition.addPathDefinition("/admin/**", "authc, roles[admin]");

        // logged in users with the 'document:read' permission
        // chainDefinition.addPathDefinition("/docs/**", "authc, perms[document:read]");

        chainDefinition.addPathDefinition("/js/**", "anon");
        chainDefinition.addPathDefinition("/css/**", "anon");
        chainDefinition.addPathDefinition("/img/**", "anon");
        chainDefinition.addPathDefinition("/lib/**", "anon");

        chainDefinition.addPathDefinition("/spec", "anon");
        chainDefinition.addPathDefinition("/api/**", "anon");

        chainDefinition.addPathDefinition("/", "user");
        chainDefinition.addPathDefinition("/index", "user");
//        chainDefinition.addPathDefinition("/**", "user");

        // all other paths require a logged in user
        chainDefinition.addPathDefinition("/**", "authc");

        // logout
        chainDefinition.addPathDefinition("/logout", "logout");
        return chainDefinition;
    }
}
