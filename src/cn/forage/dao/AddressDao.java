package cn.forage.dao;

import cn.forage.model.User;

import java.util.ArrayList;

/**
 * Created by DoneSpeak on 2017/5/17.
 */
public interface AddressDao extends Dao<User>,PageDao<User> {

    ArrayList getAllAddr(int userId)throws Exception;

}
