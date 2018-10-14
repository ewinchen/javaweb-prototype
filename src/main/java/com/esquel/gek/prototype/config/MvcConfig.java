package com.esquel.gek.prototype.config;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.Map;

@Configuration
@ControllerAdvice(basePackages = "com.esquel.gek.prototype.controller.view")
public class MvcConfig implements WebMvcConfigurer {
    private static Logger log = LoggerFactory.getLogger(MvcConfig.class);

    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/spec").setViewName("spec");
    }

    @ModelAttribute(name = "subject")
    public Subject subject() {
        return SecurityUtils.getSubject();
    }

    /**
     * 就算不配置这里，当错误发生依然会跳转到error.jsp
     * 如果error.jsp也发生错误，会调用自带的错误页面
     *
     * 这里只能捕获Controller 的错误，不能捕获JSP的错误
     * 估计是因为JSP 的错误不会抛出到Controller，所以此处不能捕获，而直接跳转到error.jsp
     * 因此就算设置了model 属性也未必能带到error.jsp，因为这里没有调用
     */
    // @ExceptionHandler
    public String handleException(Exception e, Model model) {

        StringWriter sw = new StringWriter();
        PrintWriter pw = new PrintWriter(sw);
        e.printStackTrace(pw);

        Map<String, Object> error = new HashMap<>();
        error.put("status", HttpStatus.INTERNAL_SERVER_ERROR);
        error.put("message", "Internal Server Error");
        error.put("stackTrace", sw.toString());

        model.addAttribute("error", error);

        return "error";
    }
}
