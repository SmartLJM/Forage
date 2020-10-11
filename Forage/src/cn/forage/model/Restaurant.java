package cn.forage.model;

import java.util.Date;

/**
 * Created by DoneSpeak on 2017/5/17.
 */
public class Restaurant {
    private int id;
    private String name;
    private User owner;
    private String phoneNum;
    private String location;
    private Date createdDate;
    private String state;

    public Date getCreatedDate() {
        return createdDate;
    }

    private String restaurantImg;

    public void setId(int id) {
        this.id = id;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    @Override
    public String toString() {
        return "Restaurant{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", owner=" + owner.toString() +
                ", phoneNum='" + phoneNum + '\'' +
                ", location='" + location + '\'' +
                ", createdDate=" + createdDate +
                ", state='" + state + '\'' +
                ", restaurantImg='" + restaurantImg + '\'' +
                '}';
    }

    public int getId() {
        return id;
    }


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public User getOwner() {
        return owner;
    }

    public void setOwner(User owner) {
        this.owner = owner;
    }

    public String getPhoneNum() {
        return phoneNum;
    }

    public void setPhoneNum(String phoneNum) {
        this.phoneNum = phoneNum;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public Date getCreateDate() {
        return createdDate;
    }

    public void setCreateDate(Date createDate) {
        this.createdDate = createDate;
    }

   public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getRestaurantImg() {
        return restaurantImg;
    }

    public void setRestaurantImg(String restaurantImg) {
        this.restaurantImg = restaurantImg;
    }
}
