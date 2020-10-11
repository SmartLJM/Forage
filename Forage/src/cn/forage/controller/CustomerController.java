package cn.forage.controller;

import cn.forage.dao.OrderDao;
import cn.forage.model.Order;
import cn.forage.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.lang.reflect.Array;
import java.util.ArrayList;

/**
 * Created by DoneSpeak on 2017/5/21.
 */
@Controller
@RequestMapping("/customer")
public class CustomerController {

    @Autowired
    private OrderDao orderDao;

    @RequestMapping("/orders")
    public String customer(HttpSession session, Model model){
        User user = (User)session.getAttribute("user");
        ArrayList<Order> orders = new ArrayList<Order>();
        try {
            orders = orderDao.getAll(user.getId());
        }catch(Exception ex){
            ex.printStackTrace();
            return "error";
        }
        model.addAttribute("orders",orders);
        return "customerIndex";
    }
}
