package cn.forage.controller;

import cn.forage.dao.OrderDao;
import cn.forage.dao.UserDao;
import cn.forage.model.Order;
import cn.forage.model.Restaurant;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by JIANG on 2017/5/18.
 */


/**
 * Created by DoneSpeak on 2017/5/20.
 */
@Controller
@RequestMapping("/admin/OrderManage")
public class OrderManageController {
    //
    @Resource
    private OrderDao orderDao;
    @Resource
    private UserDao userDao;


    @RequestMapping(value = "/getOrderList" ,method = RequestMethod.POST)
    @ResponseBody
    public OrderList getOrderList(int page, int rows, HttpSession session){

//
        Restaurant restaurant = (Restaurant)session.getAttribute("restaurant");
        int res_id = restaurant.getId();


        /**这里由foodDao对象查询数据库，并返回所有查询结果*/
        ArrayList<MyOrder> orders  = new ArrayList<>();
        // 总记录数
        int total = 0;
        try {
            // 获取Order列表
            ArrayList<Order> list = orderDao.getOnePage(res_id,(page-1) * rows,rows);
//            ArrayList<Order> list = orderDao.getOnePage(2,(page-1) * rows,rows);
            // 获取总记录数
            total = orderDao.getAmount(res_id);
//            total = orderDao.getAmount(2);
System.out.println("*****************");
            System.out.print(orders);
System.out.println("*****************");

            // 将从数据库中查找的订单某些列进行转化
            for(Order order:list){
                String buyerName = userDao.getOne(order.getUserId()).getName();
                float totalMoney = orderDao.getTotal(order.getId());
                orders.add(toMyOrder(order, buyerName, totalMoney));
            }

        } catch (Exception e) {
            e.printStackTrace();

        }

        // 测试用例
//        for(int i=0;i<10;i++){
//            MyOrder order = new MyOrder();
//            order.code = i+"";
//            order.buyerName = "buyername_"+i;
//            order.buyerPhone = "phonenumber_"+i;
//            order.totalMoney = "totalnumey_"+i;
//            order.orderTime = System.currentTimeMillis()+"";
//            order.status = "finished";
//            orders.add(order);
//        }

        OrderList result = new OrderList();
        result.total = total;
        result.rows = orders;
        System.out.println(orders.size());
        return result;


    }

    // 将返回的Order类进行处理
    private MyOrder toMyOrder(Order order, String buyerName, float totalMoney){

        MyOrder myOrder = new MyOrder();
        myOrder.code = order.getCode()+"";
        myOrder.buyerName = buyerName;
        myOrder.totalMoney = totalMoney+"";
        myOrder.orderTime = order.getCreatetime().toString();
        myOrder.status = order.getState();

        return myOrder;

    }

    // 内部类，用来返回数据到客户端，字段必须为total 和 rows
    static class OrderList{
        // 记录总数
        public int total = 0;
        // 查询结果记录
        public List<MyOrder> rows = null;

    }


    // 内部类， 用于存放要显示的订单数据
    static class MyOrder{
        // 订单编号
        public String code;
        // 订购者
        public String buyerName;
        // 总价
        public String totalMoney;
        // 下单时间
        public String orderTime;
        // 订单状态
        public String status;
    }
}
