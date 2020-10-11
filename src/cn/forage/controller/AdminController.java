package cn.forage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by DoneSpeak on 2017/5/20.
 */
@Controller
@RequestMapping("/admin")
public class AdminController {
    @RequestMapping("/center")
    public String center(){
        return "center";
    }

    @RequestMapping("/foodManage")
    public String foodManage(){
        return "foodManage";
    }

    @RequestMapping("/userCenter")
    public String userCenter(){
        return "userCenter";
    }

    @RequestMapping("/orderManage")
    public String orderManage(){
        return "orderManage";
    }
}
