package cn.forage.controller;

import cn.forage.dao.RestaurantDao;
import cn.forage.dao.UserDao;
import cn.forage.model.Restaurant;
import cn.forage.model.Result;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.naming.Name;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.UUID;

/**
 * Created by JIANG on 2017/5/18.
 */

@Controller
@RequestMapping("/admin/UserCenter")
public class UserCenterController {

    @Resource
    private RestaurantDao restaurantDao;


    @RequestMapping("/getRestaurant")
    @ResponseBody
    public Restaurant getRestaurant(HttpSession session){

        Restaurant restaurant1 = (Restaurant)session.getAttribute("restaurant");
        System.out.print(restaurant1);
//        Restaurant restaurant1 = new Restaurant();
//        restaurant1.setId(2);
//        restaurant1.setName("restaurant");
//        restaurant1.setOwner(null);
//        restaurant1.setPhoneNum("15464564");
//        restaurant1.setRestaurantImg("https://www.baidu.com/img/bd_logo1.png");
        return restaurant1;
    }

    @RequestMapping("restaurantImg")
    @ResponseBody
    public Result updateImage(HttpServletRequest req, HttpSession session)  {

        // 保存图片
        String picture = storeImage(req);
        System.out.println("image:"+picture);
        // 更新数据库
        return updateAttribute(session,"restaurantImg",picture);
    }

    @RequestMapping("name")
    @ResponseBody
    public Result updateName(HttpSession session,String name){

        return updateAttribute(session, "name", name);
    }


    @RequestMapping("phoneNum")
    @ResponseBody
    public Result updatePhone(HttpSession session,String phoneNum){
        return updateAttribute(session,"phoneNum",phoneNum);
    }

    // 更新Restaurant 表的属性值
    private Result updateAttribute(HttpSession session,String column,String value){

        Restaurant restaurant = (Restaurant)session.getAttribute("restaurant");
        int res_id = restaurant.getId();

        switch (column){
            case "restaurantImg":
                restaurant.setRestaurantImg(value);
                break;
            case "name":
                restaurant.setName(value);
                break;
            case "phoneNum":
                restaurant.setPhoneNum(value);
                break;
            default:
                break;
        }

        Result result = new Result();
        try {
            if (value==null)
                throw new Exception();
            restaurantDao.updateOne(restaurant);
            result.status = Result.OK;
            result.message = "修改成功";
        }catch (Exception e){
            e.printStackTrace();
            result.status = Result.ERROR;
            result.message = "修改失败";
        }
        return result;
    }

    // 保存图片
    private String storeImage(HttpServletRequest req){
        try {
            DiskFileItemFactory factory = new DiskFileItemFactory();

            //设置内存临界值
            factory.setSizeThreshold(10 * 1024 * 1024);

            ServletFileUpload servletFileUpload = new ServletFileUpload(factory);
            List<FileItem> fileItems = servletFileUpload.parseRequest(req);
            FileItem fileItem = fileItems.get(0);
            // 获取一个独一无二的数字
            UUID uuid = UUID.randomUUID();
            //获取文件名称
            String fileName = fileItem.getName();
            fileName = uuid + "_" + fileName;
            String picture = req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort() + "/img/" + fileName;

            System.out.println(picture);
            new File(req.getServletContext().getRealPath("/img")).mkdir();

            fileItem.write(new File(req.getServletContext().getRealPath("/img"), fileName));
            return picture;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }

}













