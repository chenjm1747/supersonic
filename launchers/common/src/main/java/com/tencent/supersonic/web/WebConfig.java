package com.tencent.supersonic.web;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.nio.file.Path;
import java.nio.file.Paths;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Value("${s2.frontend.dist:}")
    private String frontendDist;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        String webappPath;

        if (frontendDist != null && !frontendDist.isEmpty()) {
            Path distPath = Paths.get(frontendDist).toAbsolutePath();
            webappPath = "file:" + distPath.toString() + "/";
        } else {
            webappPath = "file:./webapp/";
        }

        registry.addResourceHandler("/webapp/**").addResourceLocations(webappPath);

        registry.addResourceHandler("/favicon.ico").addResourceLocations(webappPath);
    }

    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/").setViewName("forward:/index.html");
    }
}
