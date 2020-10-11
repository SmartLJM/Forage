package cn.forage.dao;

import cn.forage.model.User;
import org.apache.ibatis.annotations.Param;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by DoneSpeak on 2017/5/17.
 */
public interface UserDao extends Dao<User> {

    //删查改方法成功的话，结果返回均为1;失败的话，返回的结果为0

    //通过phoneNum返回User对象
    User getUserByphoneNum(String phoneNum) throws Exception;
    User getUser(@Param("userName") String userName, @Param("password") String password) throws Exception;
    //获取页
    ArrayList<User> getFirstPage(int pageSize) throws Exception;
    ArrayList<User> getLastPage(int pageSize) throws Exception;
    ArrayList<User> getOnePage(@Param("pageSize") int pageSize, @Param("index") int index) throws Exception;
    int getPageAmount(int pageSize) throws Exception;

    //是否商家用户
    int hasRestaurant(int id) throws Exception;
    //用户是否存在
    int isExist(User u) throws Exception;

}
