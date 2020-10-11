package cn.forage.dao;

import org.apache.ibatis.annotations.Param;

import java.util.ArrayList;

/**
 * Created by DoneSpeak on 2017/5/17.
 */
public interface PageDao<T> {

    int getAmount(int id)throws Exception;
    ArrayList<T> getFirstPage(@Param("id") int id, @Param("offset") int offset, @Param("pageSize") int pageSize) throws Exception;
    ArrayList<T> getLastPage(@Param("id") int id, @Param("offset") int offset, @Param("pageSize") int pageSize) throws Exception;
    ArrayList<T> getOnePage(@Param("id") int id, @Param("offset") int offset, @Param("pageSize") int pageSize) throws Exception;
}
