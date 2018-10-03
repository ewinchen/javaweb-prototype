package com.esquel.gek.prototype.controller.view;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class DefaultViewController {

    @RequestMapping("/")
    public String index() {
        return "index";
    }

    @RequestMapping("/index")
    public String home() {
        return "index";
    }

    @RequestMapping("/hello")
    public String hello() {
        return "hello";
    }

    @RequestMapping("/login")
    public String login() {
        return "login";
    }

    @RequestMapping("/replenishment_helper")
    public String replenishmentHelper() {
        return "replenishment_helper";
    }
}
