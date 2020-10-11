package cn.forage.model;

import java.util.ArrayList;

/**
 * Created by DoneSpeak on 2017/5/17.
 */
// 该类的设计不是很确定，需要自己更加需要修改，设计
public class Cart {
    private int userId;
    //    食品项{food,num}
    private ArrayList<FoodItem> foodItems;


    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public ArrayList<FoodItem> getFoodItems() {
        return foodItems;
    }

    public void setFoodItems(ArrayList<FoodItem> foodItems) {
        this.foodItems = foodItems;
    }
}
