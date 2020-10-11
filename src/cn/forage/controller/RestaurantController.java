package cn.forage.controller;

import cn.forage.dao.FoodDao;
import cn.forage.dao.RestaurantDao;
import cn.forage.model.FoodItem;
import cn.forage.model.Restaurant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;

/**
 * Created by DoneSpeak on 2017/5/21.
 */
@Controller
@RequestMapping("/restaurant")
public class RestaurantController {
    @Autowired
    private RestaurantDao restDao;

    @Autowired
    private FoodDao foodDao;

    @RequestMapping("/{restaurantId}")
    public String index(@PathVariable int restaurantId, Model model){
        ArrayList<FoodItem> foods = null;
        try {
//            [TODO] 应该使用getpage进行分页
            foods = foodDao.getAllFoods(restaurantId);

            model.addAttribute("restaurantId",restaurantId);
            model.addAttribute("foodItems",foods);
        }catch(Exception ex){
            ex.printStackTrace();
            return "error";
        }
        return "restaurant";
    }
}
