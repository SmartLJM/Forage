package cn.forage.controller;

import cn.forage.dao.CartDao;
import cn.forage.model.FoodItem;
import cn.forage.model.Result;
import cn.forage.model.User;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.rmi.server.ExportException;
import java.util.ArrayList;

/**
 * Created by DoneSpeak on 2017/5/21.
 */
@Controller
@RequestMapping("/cart")
public class CartController {
    @Autowired
    private CartDao cartDao;

    @RequestMapping(value="/list",method = RequestMethod.POST)
    @ResponseBody
    public Result getCart(int restaurantId, HttpSession session){
        User user = (User)session.getAttribute("user");
        user = new User(); //test
        user.setId(2); // test
        System.out.println(" list 收到请求");
        if(user == null){
// 用户没有登录
            return new Result(0,"用户未登录");
        }
        ArrayList<FoodItem> foods = null;
        try {
            foods = cartDao.getAllFoods(user.getId(), restaurantId);
        }catch (Exception ex){
            return new Result(0,"无法初始化购物车");
        }
        return new Result(1,"成功获取购物车",foods);
    }

    @RequestMapping(value="/operate/increase",method = RequestMethod.POST)
    @ResponseBody
    public Result addOne(int restaurantId, int foodId, HttpSession session){
        System.out.println(" increase 收到请求");

        User user = (User)session.getAttribute("user");

        int id = user.getId();
//        int id = 2; // test
        try {
            int num = cartDao.getFoodNum(foodId);
            if(num < 1 ){
                cartDao.addFood(id, foodId, 1);
            }else{
                num ++;
                cartDao.updateFoodNum(id,foodId ,num);
            }
        }catch (Exception ex){
            ex.printStackTrace();
            return new Result(0,"添加失败");
        }

        return new Result(1,"添加成功");
    }

    @RequestMapping(value = "/operate/decrease" ,method = RequestMethod.POST)
    @ResponseBody
    public Result reduceOne(int resaurantId, int foodId, int num, HttpSession session){
        System.out.println(" increace 收到请求");

        User user = (User)session.getAttribute("user");
        int id = user.getId();
        id = 2; // test
        try {
            cartDao.reduceFood(id, foodId);
        }catch (Exception ex){
            ex.printStackTrace();
            return new Result(0,"减少失败");
        }
        return new Result(1,"减少成功");
    }

    @RequestMapping(value = "/operate/clear" ,method = RequestMethod.POST)
    @ResponseBody
    public Result clearCart(int resaurantId, HttpSession session){
        User user = (User)session.getAttribute("user");
        int id = user.getId();
        try {
            cartDao.clearCart(id, resaurantId);
        }catch (Exception ex){
            ex.printStackTrace();
            return new Result(0,"清空失败");
        }
        return new Result(1,"清空成功");
    }
}