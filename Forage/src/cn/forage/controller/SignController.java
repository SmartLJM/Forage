package cn.forage.controller;

import cn.forage.dao.RestaurantDao;
import cn.forage.dao.UserDao;
import cn.forage.model.Restaurant;
import cn.forage.model.User;
import cn.forage.utils.EncoderUtil;
import jdk.nashorn.internal.runtime.regexp.joni.constants.RegexState;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.List;
import java.util.UUID;

/**
 * Created by DoneSpeak on 2017/5/17.
 */
@Controller
@RequestMapping("/")
public class SignController {
    @Autowired
    private UserDao userDao;

    @Autowired
    private RestaurantDao restDao;

    @RequestMapping(value="/signin",method = RequestMethod.GET)
    public String signin() {
        return "signin";
    }

    @RequestMapping(value = "/signin",method = RequestMethod.POST)
//    @ResponseBody
    public String signin(String userName, String password, HttpSession session, Model model){
        User user = null;

        try{
            user = userDao.getUser(userName,password);
        }catch(Exception ex){
            ex.printStackTrace();
            model.addAttribute("error","登录失败");
            return "signin";
        }
//        System.out.print(phoneNum + ":" + password + "\n");
//        System.out.print(user);
        String result = "";
        if(user == null){
//            空 - 表示用户不存在
//            result = "{\"status\":\"0\",\"message\":\"密码输出错误或者用户名错误\"}";
            model.addAttribute("error","密码输出错误或者用户名错误");
            return "signin";
        }else{
//            用户存在
//            密码清空
            user.setPassword("");
//            存入 session 中
            session.setAttribute("user",user);
//            result = "{\"status\":\"1\",\"message\":\"登录成功\"}";
            return "redirect:/index";
        }
//        return result;

    }

    @RequestMapping("/signout")
    public String signout(HttpSession session){
        session.removeAttribute("user");
        session.removeAttribute("restaurant");
        return "index";
    }

    @RequestMapping(value="/signup",method = RequestMethod.GET)
    public String signup(){
        return "signup";
    }

    @RequestMapping(value = "/signup",method = RequestMethod.POST)
//    @ResponseBody
    public String signup(User user, String repassword, HttpSession session, Model model){
        String result = "";
        EncoderUtil encoder = new EncoderUtil();
        System.out.print(user + "\n");
//        加密
        repassword = encoder.sha(repassword);
        if(!repassword.equals(user.getPassword())){
//            return "{\"status\":\"0\",\"message\":\"两次输入密码不匹配\"}";
            model.addAttribute("error","两次输入密码不匹配");
            return "signup";
        }
//        先判断用户是否已经注册
//        已注册
        User tempUser = null;
        try {
            System.out.print(user.getPhoneNum());
            tempUser = userDao.getUserByphoneNum(user.getPhoneNum());
            System.out.println(tempUser);
        }catch (Exception ex){
            ex.printStackTrace();
//            return "{\"status\":\"0\",\"message\":\"注册失败\"}";
            model.addAttribute("error","注册失败");
            return "signup";
        }
        if(tempUser != null){
//            return "{\"status\":\"0\",\"message\":\"用户已存在\"}";
            model.addAttribute("error","用户已存在");
            return "signup";
        }

//        未注册 -- 注册
        int id = -1;
        try {
           id = userDao.addOne(user);
        } catch (Exception e) {
//            处理错误
            e.printStackTrace();
//            return "{\"status\":\"0\",\"message\":\"无法注册\"}";
            model.addAttribute("error","无法注册");
            return "signup";
        }
//        设置用户id
        user.setId(id);
//        清空密码
        user.setPassword("");
//        写入session中
        session.setAttribute("user",user);
//        return "{\"status\":\"1\",\"message\":\"注册成功\"}";
        return "redirect:/index";
    }

    @RequestMapping(value="/restsignup",method = RequestMethod.GET)
    public String restsignup(){
        return "restsignup";
    }

    @RequestMapping(value="/restsignup",method = RequestMethod.POST)
//    @ResponseBody
    public String restsignup(Restaurant rest, HttpSession session, Model model, HttpServletRequest req, HttpServletResponse response){
        String result = "";
        User user = (User)session.getAttribute("user");
//        先判断用户是否已经注册
//        已注册
        try {
//            if (userDao.hasRestaurant(user.getId()) == 1) {
////            return "{\"status\":\"0\",\"message\":\"用户已有商铺\"}";
//                model.addAttribute("error", "用户已有商铺");
//                return "restsignup";
//            }
        }catch(Exception ex){
            ex.printStackTrace();
            model.addAttribute("error","注册失败");
            return "restsignup";
        }
        int id = -1;

//        保存图片
        String pitureUrl = storeImage(req);
        rest.setRestaurantImg(pitureUrl);
        try {
            id = restDao.addOne(rest);
        } catch (Exception e) {
//            处理错误
            e.printStackTrace();
//            return "{\"status\":\"0\",\"message\":\"无法注册\"}";
            model.addAttribute("error","无法注册");
            return "restsignup";
        }
        rest.setId(id);
//        写入session中
        session.setAttribute("restaurant",rest);
//        return "{\"status\":\"1\",\"message\":\"注册成功\"}";
        try {
            response.sendRedirect("/admin/index");
        }catch(Exception ex){
            ex.printStackTrace();
            return "error";
        }
        return "index";
    }

    private String storeImage(HttpServletRequest req){
        try {
            DiskFileItemFactory factory;
            factory = new DiskFileItemFactory();

            //设置内存临界值
            factory.setSizeThreshold(10 * 1024 * 1024);

            ServletFileUpload servletFileUpload = new ServletFileUpload(factory);
            List<FileItem> fileItems = servletFileUpload.parseRequest(req);
            FileItem fileItem = fileItems.get(0);
            // 获取一个独一无二的数字
            UUID uuid = UUID.randomUUID();
            //获取文件名称
            String fileName = fileItem.getName();
            fileName = uuid + "_" + fileName;
            String picture = req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort() + "/static/img/" + fileName;

            System.out.println(picture);
            new File(req.getServletContext().getRealPath("/img")).mkdir();

            fileItem.write(new File(req.getServletContext().getRealPath("/img"), fileName));
            return picture;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }
}
