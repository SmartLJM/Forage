package cn.forage.dao;

import cn.forage.model.FoodItem;
import org.apache.ibatis.annotations.Param;

import java.util.ArrayList;
import java.util.Date;

/**
 * Created by DoneSpeak on 2017/5/17.
 */
public interface FoodDao extends PageDao {
    ArrayList  getFoodsByRestName(String name)throws Exception;
    ArrayList getAllFoods(int restaurantId)throws Exception;
    int addOneFood(FoodItem item)throws Exception;
    int deleteOneFood(@Param("id") int id)throws Exception;
    int updateOneFood(FoodItem item)throws Exception;
    //得到每一份商品的月售份额
    int getSellNum(@Param("foodId") int foodId, @Param("startTime") Date startTime, @Param("finishTime") Date finishTime)throws Exception;


}
