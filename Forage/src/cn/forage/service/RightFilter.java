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
@WebFilter(filterName = "RightFilter")
public class RightFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest httpReq = (HttpServletRequest) req;
        HttpSession session = httpReq.getSession();
        User user = (User)session.getAttribute("user");
        Restaurant rest = (Restaurant)session.getAttribute("restaurant");
//        路径判断
        String servletPath = ((HttpServletRequest) req).getServletPath();
//       用户限制
        if(servletPath.toLowerCase().startsWith("/signin")
                || servletPath.toLowerCase().startsWith("/signup")
                || servletPath.toLowerCase().startsWith("/signout")){
//            用户已经登录，则直接进入首页，否则正常进入
            if(user == null){
                chain.doFilter(req, resp);
            }else{
                ((HttpServletResponse)resp).sendRedirect("/index");
            }
        }else if(servletPath.toLowerCase().startsWith("/order")
                || servletPath.toLowerCase().startsWith("/cart/operate")
                || servletPath.toLowerCase().startsWith("/customer")){
// 没有登录去到index
            if(user == null){
                ((HttpServletResponse)resp).sendRedirect("/index");
            }else{
                chain.doFilter(req, resp);
            }
        }else if(servletPath.startsWith("/admin")){
            if(user == null){
                ((HttpServletResponse)resp).sendRedirect("/signin");
            }else{
//                判断是否有商铺
                if(rest == null){
                    ((HttpServletResponse)resp).sendRedirect("/restsignup");
                }else{
//                    有商铺正常进入
                    chain.doFilter(req, resp);
                }
            }
        }
    }

    public void init(FilterConfig config) throws ServletException {

    }

}
