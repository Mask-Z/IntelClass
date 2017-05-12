package com.aixuexiao.web.interceptor;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2017/5/10 0010.
 */
public class PermissionInterceptor extends HandlerInterceptorAdapter {

    public List<String> getUncheckUrls() {
        return uncheckUrls;
    }

    public void setUncheckUrls(List<String> uncheckUrls) {
        this.uncheckUrls = uncheckUrls;
    }

    /**
     * 免登入 免检查地址
     */

    private List<String> uncheckUrls = new ArrayList<String>();

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {

        String requestUrl = request.getRequestURI();
        if (uncheckUrls.contains(requestUrl))
        {
            return true;
        } else
        {
        //TODO 做拦截的事情
            return true;
        }
    }
}