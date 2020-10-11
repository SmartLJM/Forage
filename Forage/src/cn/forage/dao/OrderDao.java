package cn.forage.dao;

import cn.forage.model.Order;
import org.apache.ibatis.annotations.Param;

import java.util.ArrayList;

/**
 * Created by DoneSpeak on 2017/5/17.
 */
public interface OrderDao extends PageDao {

    //根据餐厅id来获取订单列表
    ArrayList<Order>getByRestaurantId(int restaurantId)throws Exception;
    //根据订单id
    ArrayList<Order>getUserOrders(int orderId)throws Exception;
    //每一份订单的总价
    float getTotal(int orderId)throws Exception;
    //添加订单
    int insertOne(Order order)throws Exception;

    int addFoodToOrder(@Param("orderId") int orderId, @Param("foodId") int foodId, @Param("num") int num)throws Exception;

    //删除订单
    int deleteOne(int orderId)throws Exception;
    //更新订单
    int updateOne(@Param("order") Order order, @Param("orderId") int orderId)throws Exception;

    ArrayList getAll(int userId);

}
