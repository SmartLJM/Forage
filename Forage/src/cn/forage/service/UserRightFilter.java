package cn.forage.service;

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
@WebFilter(filterName = "UserRightFilter")
public class UserRightFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
//        chain.doFilter(req, resp);
        HttpServletRequest httpReq = (HttpServletRequest) req;
        HttpSession session = httpReq.getSession();
        User user = (User)session.getAttribute("user");
        if(user == null){
//  未登录
//            站内转发
//            httpReq.getRequestDispatcher("/login").forward(req, resp);
//            重定向
            ((HttpServletResponse)resp).sendRedirect("/login");
        }else{
//  已经登录 -  正常进入
            chain.doFilter(req, resp);
        }
    }

    public void init(FilterConfig config) throws ServletException {

    }

}
