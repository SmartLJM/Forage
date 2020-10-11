package cn.forage.model;

/**
 * Created by DoneSpeak on 2017/5/17.
 */
public class FoodItem {


    private int id;
    private String name;
    private float price;
    private String unit;
    //    图片的url
    private String picture;
    //    店家对该食品的归类
    private String type;

    //单类食品的数量
    private int num;

    //月售量
    private int saleNum;

    private int restaurantId;

    public void setSaleNum(int saleNum) {
        this.saleNum = saleNum;
    }

    public int getSaleNum() {

        return saleNum;
    }

    @Override
    public String toString() {
        return "FoodItem{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", unit='" + unit + '\'' +
                ", picture='" + picture + '\'' +
                ", type='" + type + '\'' +
                ", num=" + num +
                '}';
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public float getPrice() {
        return price;
    }

    public String getUnit() {
        return unit;
    }

    public String getPicture() {
        return picture;
    }

    public String getType() {
        return type;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public int getRestaurantId() {
        return restaurantId;
    }

    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }
}
