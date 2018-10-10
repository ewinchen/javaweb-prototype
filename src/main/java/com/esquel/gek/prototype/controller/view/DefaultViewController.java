package com.esquel.gek.prototype.controller.view;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class DefaultViewController {

    private void setPageModel(Model model, String pageUrl, String pageHeader, String pageDesc, String pageParent, String pageName) {
        model.addAttribute("pageUrl", pageUrl);
        model.addAttribute("pageHeader", pageHeader);
        model.addAttribute("pageDesc", pageDesc);
        model.addAttribute("pageParent", pageParent);
        model.addAttribute("pageName", pageName);
    }

    @RequestMapping("/")
    public String index(Model model) {
        setPageModel(model, "/index", "Dashboard", "Welcome", "Dashboard", "");
        return "/index";
    }

    @RequestMapping("/index")
    public String home(Model model) {
        setPageModel(model, "/index", "Dashboard", "Welcome", "Dashboard", "");
        return "/index";
    }

    @RequestMapping("/business")
    public String business(Model model) {
        setPageModel(model, "/business", "Business", "Make Money", "Business", "");
        return "/business";
    }

    @RequestMapping("/department/center")
    public String center(Model model) {
        setPageModel(model, "/department/center", "Center", "I Am King", "Department", "Center");
        return "/department/center";
    }

    @RequestMapping("/department/assistant")
    public String assistant(Model model) {
        setPageModel(model, "/department/assistant", "Assistant", "I Am Commander", "Department", "Assistant");
        return "/department/assistant";
    }

    @RequestMapping("/setting")
    public String setting(Model model) {
        setPageModel(model, "/setting", "Setting", "Under My Control", "Setting", "");
        return "/setting";
    }

    @RequestMapping("/hello")
    public String hello(Model model) {
        setPageModel(model, "/hello", "Test", "You Want to Kill Me?", "Test", "");
        return "/hello";
    }

    @RequestMapping("/login")
    public String login() {
        return "login";
    }

    @RequestMapping("/replenishment_helper")
    public String replenishmentHelper() {
        return "index";
    }
}
