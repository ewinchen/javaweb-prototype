package com.esquel.gek.prototype.config;

import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationException;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.apache.shiro.util.JdbcUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

import java.sql.SQLException;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;


public class CustomJdbcRealm extends AuthorizingRealm {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        if (principalCollection == null) {
            throw new AuthorizationException("PrincipalCollection method argument cannot be null.");
        } else {
            String username = (String) ((Map) this.getAvailablePrincipal(principalCollection)).get("username");
            Set<String> roleNames = new LinkedHashSet();
            Set<String> permissions = new LinkedHashSet();

            List<Map<String, Object>> roleList = jdbcTemplate.queryForList("select a.role_name from role a inner join users_role b on a.id = b.role_id inner join users c on b.users_id = c.id where c.username = ?", username);
            for (Map<String, Object> role : roleList) {
                String roleName = (String) role.get("role_name");
                if (roleName != null) {
                    roleNames.add(roleName);
                }

                List<Map<String, Object>> permissionList = jdbcTemplate.queryForList("select a.permission_string from permission a inner join role_permission b on a.id = b.permission_id inner join role c on b.role_id = c.id where c.role_name = ?", roleName);
                for (Map<String, Object> permission : permissionList) {
                    String permissionString = (String) permission.get("permission_string");
                    if (permissionString != null) {
                        permissions.add(permissionString);
                    }
                }
            }

            SimpleAuthorizationInfo info = new SimpleAuthorizationInfo(roleNames);
            info.setStringPermissions(permissions);
            return info;
        }
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {

        String username = (String) authenticationToken.getPrincipal();

        List<Map<String, Object>> userList = jdbcTemplate.queryForList("select * from users where username = ?", username);

        if (userList.size() != 1) {
            throw new UnknownAccountException();
        }

        if (userList.get(0).get("enable").equals(0)) {
            throw new LockedAccountException();
        }

        SimpleAuthenticationInfo simpleAuthenticationInfo = new SimpleAuthenticationInfo(userList.get(0), userList.get(0).get("password"), getName());

        return simpleAuthenticationInfo;
    }
}
