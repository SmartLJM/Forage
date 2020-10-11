package cn.forage.service;

import cn.forage.model.Restaurant;
import cn.forage.model.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by DoneSpeak on 2017/5/20.
 */
@WebFilter(filterName = "AdminRightFilter")
public class AdminRightFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest httpReq = (HttpServletRequest) req;
        HttpSession session = httpReq.getSession();
        Restaurant rest = (Restaurant)session.getAttribute("restaurant");
        if(rest == null){
//  未登录
//            站内转发
//            httpReq.getRequestDispatcher("/login").forward(req, resp);
//            重定向
            ((HttpServletResponse)resp).sendRedirect("/admin/signin");
        }else{
//  已经登录 -  正常进入
            chain.doFilter(req, resp);
        }
    }

    public void init(FilterConfig config) throws ServletException {

    }

}
