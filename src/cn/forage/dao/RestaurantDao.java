package cn.forage.dao;

import cn.forage.model.Restaurant;

/**
 * Created by DoneSpeak on 2017/5/17.
 */
public interface RestaurantDao  extends Dao<Restaurant>,PageDao<Restaurant> {

    //通过phoneNum返回Restaurant对象
    Restaurant getOneRestaurantByphoneNum(String phoneNum)throws Exception;

}
