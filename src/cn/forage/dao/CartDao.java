package cn.forage.dao;

import cn.forage.model.FoodItem;
import org.apache.ibatis.annotations.Param;

import java.util.ArrayList;

/**
 * Created by Adminstrator on 2017/5/20.
 */
public interface CartDao extends Dao<FoodItem>,PageDao<FoodItem> {
    ArrayList<FoodItem> getAllFoods(@Param("userId") int userId, @Param("restaurantId") int restaurantId)throws  Exception;
    int addFood(@Param("userId") int userId, @Param("foodId") int foodId, @Param("num") int num) throws  Exception;
    int reduceFood(@Param("userId") int userId, @Param("foodId") int foodId)throws Exception;
    int clearCart(@Param("userId") int userId, @Param("restaurantId") int restaurantId)throws Exception;
    int moveCart2Order(int userId, int restaurantId)throws Exception;

    int getFoodNum(int foodId) throws Exception;

    int updateFoodNum(@Param("userId")int userId, @Param("foodId") int foodId,@Param("num") int num) throws Exception;

}
