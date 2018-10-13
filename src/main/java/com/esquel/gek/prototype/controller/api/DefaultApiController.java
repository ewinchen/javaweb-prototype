package com.esquel.gek.prototype.controller.api;

import com.esquel.gek.prototype.dao.DefaultDao;
import com.esquel.gek.prototype.mapper.UsersMapper;
import com.esquel.gek.prototype.service.DefaultService;
import org.apache.shiro.authc.credential.DefaultPasswordService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class DefaultApiController {

    private Logger logger = LoggerFactory.getLogger("com.esquel.gek.prototype.controller.api.DefaultApiController");

    @Autowired
    private DefaultService defaultService;



    @GetMapping("/search_gknum_info")
    public Map<String, Object> searchGkNumInfo(@RequestParam("gknum") String gkNum, @RequestParam(name="jobnum", required = false) String jobNum) {
        logger.info(gkNum + jobNum);
        return defaultService.getGkNumInfo();
    }

    @GetMapping("/search_jobnum")
    public List<Map<String, Object>> getJobNum() {
        return defaultService.getJobNum();
    }

    @GetMapping("/search_pponum")
    public List<Map<String, Object>> getPpoNum() {
        return defaultService.getPpoNum();
    }

    @GetMapping("/search_pack_detail/{ppoLotId}")
    public List<Map<String, Object>> getPackDetail(@PathVariable String ppoLotId) {
        return defaultService.getPackDetail();
    }

    @GetMapping("/hello")
    public String hello() {
        // 使用shiro默认的加密方式
        String password = new DefaultPasswordService().encryptPassword("123");

        defaultService.hello();

        return "hello, " + password;
    }

    @GetMapping("/array-list")
    public List<String> list() {
        List<String> res = new ArrayList<>();
        res.add("1");
        res.add("2");
        res.add("3");
        res.add("4");
        res.add("5");
        return res;
    }

    @GetMapping("/hash-map")
    public Map<Object, Object> map() {
        Map<Object, Object> res = new HashMap<>();
        res.put(1, 1);
        res.put("2", 3);
        res.put("name", "Edwin");
        return res;
    }
}
