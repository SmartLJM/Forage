package cn.forage.controller;

import cn.forage.dao.FoodDao;
import cn.forage.model.FoodItem;
import cn.forage.model.Restaurant;
import cn.forage.model.Result;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import sun.reflect.generics.tree.ReturnType;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * Created by JIANG on 2017/5/18.
 */
/**这个类处理“菜品管理”的后台事物*/
@Controller
@RequestMapping("/admin/FoodManage")
public class FoodManageController {

    /**操作数据库的对象*/
    @Resource
    FoodDao foodDao;

    /**项数据库添加菜品*/
    @RequestMapping(value = "/addFood", method = RequestMethod.POST)
    @ResponseBody
    public Result addFood(HttpServletRequest req ,HttpSession session){

        Restaurant restaurant = (Restaurant)session.getAttribute("restaurant");
        int res_id = restaurant.getId();

        // 返回结果对象
        Result result = new Result();
        try {
            // 解析菜品
            FoodItem food = this.parseFood(req);


            if(food==null){
                throw new Exception();
            }
            food.setRestaurantId(res_id);

            // 添加到数据库
            foodDao.addOneFood(food);

            result.status = Result.OK;
            result.message = "添加成功";
        }catch (Exception e){
            result.status = Result.ERROR;
            result.message = "添加失败";
        }finally {
            return result;
        }

    }


    /**更新菜品*/
    @RequestMapping(value = "/updateFood" ,method = RequestMethod.POST)
    @ResponseBody
    public Result updateFood(HttpServletRequest req,HttpSession session){

        Restaurant restaurant = (Restaurant)session.getAttribute("restaurant");
        int res_id = restaurant.getId();

        // 返回结果对象
        Result result = new Result();
        try {
            // 解析菜品
            FoodItem food = this.parseFood(req);

            if(food==null){
                throw new Exception();
            }
            food.setRestaurantId(res_id);

            // 添加到数据库
            foodDao.updateOneFood(food);


            //修改成功
            result.status = Result.OK;
            result.message = "修改成功";
        }catch (Exception e){
            e.printStackTrace();

            result.status = Result.ERROR;
            result.message = "修改失败";

        }finally {
            return result;
        }

    }

    /**删除菜品 */
    @RequestMapping(value = "/deleteFood" ,method = RequestMethod.POST)
    @ResponseBody
    public Result deleteFood(String ids){


        // 把要删除的所有菜品项的id 解析到array数组中
        String[] array = ids.split(",");

        // 返回的操作结果对象
        Result result = null;

        // 删除的记录数
        int count = 0;

        System.out.println("before");
        try{
            for (String id:array){
                count += foodDao.deleteOneFood(Integer.parseInt(id));
            }
        }catch(Exception ex){
            ex.printStackTrace();
            // 删除失败
            result.status = Result.OK;
            result.message = "删除失败";
            return result;
        }
        System.out.println(count);

        // 删除成功
        result.status = Result.OK;
        result.message = "成功删除 "+array.length+" 条记录";

        return result;

    }


    /**获取菜品列表*/
    @RequestMapping(value = "/getFoodList" ,method = RequestMethod.POST)
    @ResponseBody
    public FoodList getFoodList(int page, int rows,HttpSession session){

        Restaurant restaurant = (Restaurant)session.getAttribute("restaurant");
        int res_id = restaurant.getId();


        /**这里由foodDao对象查询数据库，并返回所有查询结果*/
        ArrayList<FoodItem> foods  = null;
        int total = 0;
        try {
            // 获取一页food
            foods = foodDao.getOnePage(res_id,(page-1)*rows,rows);
//            foods = foodDao.getOnePage(2,(page-1)*rows,rows);
            // 获取总记录数
            total = foodDao.getAmount(res_id);
//            total = foodDao.getAmount(2);
        } catch (Exception e) {
            e.printStackTrace();

        }
        // 测试用例
//        foods = new ArrayList<>();
//        for(int i=0;i<10;i++){
//            FoodItem food = new FoodItem();
//            food.setId(i);
//            food.setName("name:"+i);
//            food.setPrice(i);
//            food.setUnit("unit:"+i);
//            food.setPicture("url:"+i);
//            food.setType("type:蔬菜");
//            foods.add(food);
//        }

        FoodList result = new FoodList();
        result.total = total;
        result.rows = foods;
        return result;

    }


    /**把提交的表单解析成food对象*/
    private FoodItem parseFood(HttpServletRequest req) throws UnsupportedEncodingException {

        FoodItem  food = new FoodItem();

        // 设置编码方式
        req.setCharacterEncoding("UTF-8");

        DiskFileItemFactory factory = new DiskFileItemFactory();

        //设置内存临界值
        factory.setSizeThreshold(10 * 1024 * 1024);

        ServletFileUpload servletFileUpload = new ServletFileUpload(factory);

        //设置上传文件的大小限制
        servletFileUpload.setFileSizeMax(30 * 1024 * 1024);
        servletFileUpload.setSizeMax(50 * 1024 * 1024);
        try {
            List<FileItem> fileItems = servletFileUpload.parseRequest(req);
            for (FileItem fileItem : fileItems) {
                if (fileItem.isFormField()) {
                    // 上传项是普通字段
                    String fieldName = fileItem.getFieldName();
                    String value = fileItem.getString("UTF-8");
                    switch (fieldName) {
                        case "id":
                            food.setId(Integer.parseInt(value.length()==0?"-1":value));
                        case "name":
                            food.setName(value);
                            break;
                        case "price":
                            food.setPrice(Float.parseFloat(value));
                            break;
                        case "unit":
                            food.setUnit(value);
                            break;
                        case "type":
                            food.setType(value);
                            break;
                        default:
                            break;
                    }
                } else {
                    //上传的是文件

                    // 获取一个独一无二的数字
                    UUID uuid = UUID.randomUUID();
                    //获取文件名称
                    String fileName = fileItem.getName();
                    fileName = uuid + "_" + fileName;
                    String picture = req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort() + "/img/" + fileName;
                    food.setPicture(picture);

                    new File(req.getServletContext().getRealPath("/img")).mkdir();

                    fileItem.write(new File(req.getServletContext().getRealPath("/img"), fileName));


                }
            }// end for

        } catch (FileUploadException e) {
            food = null;
            e.printStackTrace();
        } catch (Exception e) {
            food = null;
            e.printStackTrace();
        }
        return food;
    }

    // 一个内部类，用来返回查询菜品列表的结果，字段必须为total 和 rows
    static class FoodList{
        // 记录总数
        public int total = 0;
        // 查询结果记录
        public List<FoodItem> rows = null;
    }

}
