package cn.forage.controller;

import cn.forage.dao.AddressDao;
import cn.forage.dao.CartDao;
import cn.forage.dao.OrderDao;
import cn.forage.model.*;
import com.sun.deploy.nativesandbox.comm.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;

/**
 * Created by DoneSpeak on 2017/5/20.
 */
@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private CartDao cartDao;

    @Autowired
    private OrderDao orderDao;

    @Autowired
    private AddressDao addrDao;

    @RequestMapping("/preview")
    public String preview(int restaurantId, HttpSession session, Model model){
        User user = (User)session.getAttribute("user");

        ArrayList<FoodItem> foodList = new ArrayList<FoodItem>();
        ArrayList<Address> addrlist = new ArrayList<Address>();
        try{
//            获取购物车中的食品列表
            //            [TODO] test
            foodList = cartDao.getAllFoods(2, restaurantId);
//            addrlist = addrDao.getAllAddr(user.getId());
//            [TODO] test
            addrlist = addrDao.getAllAddr(2);
        }catch(Exception ex){
            ex.printStackTrace();
//            return "customerOrderPreview";
            return "error";
        }

        model.addAttribute("foodItems",foodList);
        model.addAttribute("addresses",addrlist);
        model.addAttribute("restaurantId",restaurantId);


        return "customerOrderPreview";
    }

    @RequestMapping("/confirm")
//    @ResponseBody
    public String confirm(int restaurantId, int addressId, HttpSession session, HttpServletResponse resp){
        User user = (User)session.getAttribute("user");
//        int userId = user.getId();
//        [TODO] test
        int userId = 2;
        try {
//            cartDao.moveCart2Order(user.getId(), restaurantId);
            Order order = new Order();

            order.setUserId(userId);
            order.setAddress(addressId);
            order.setCode(new Timestamp(System.currentTimeMillis()));
            order.setCreatetime(new Date());
            order.setRestaurantId(restaurantId);

            int orderId = orderDao.insertOne(order);

            ArrayList<FoodItem> foods = cartDao.getAllFoods(userId,restaurantId);
            for(FoodItem item : foods){
                orderDao.addFoodToOrder(userId, item.getId(),item.getNum());
            }
            cartDao.clearCart(userId, restaurantId);
        }catch(Exception ex){
//            return new Result(0,"订单创建失败");
//            return "finishorder";
            try {
                resp.sendRedirect("/order/submitOrder");
            }catch(Exception e){
                e.printStackTrace();
                return "error";
            }
            return "error";
        }
//        return new Result(1,"订单创建成功");
        try {
            resp.sendRedirect("/order/submitOrder");
        }catch(Exception ex){
            ex.printStackTrace();
            return "error";
        }
        return "submitOrder";
    }

    @RequestMapping("/cancel")
    @ResponseBody
    public Result cancel(int restaurantId, HttpSession session){
        User user = (User)session.getAttribute("user");
        try {
//            orderDao.cancel(user.getId(), restaurantId);
        }catch(Exception ex){
            return new Result(0,"订单取消失败");
        }
        return new Result(1,"订单取消成功");
    }

    @RequestMapping("submitOrder")
    public String submitOrder(){
        return "submitOrder";
    }
}
