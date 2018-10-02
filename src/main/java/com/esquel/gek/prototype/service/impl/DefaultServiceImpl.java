package com.esquel.gek.prototype.service.impl;

import com.esquel.gek.prototype.service.DefaultService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import javax.validation.constraints.Null;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class DefaultServiceImpl implements DefaultService {

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
}
