package cn.forage.model;

import java.sql.Timestamp;
import java.util.Date;

public class Order {
  private int id;
  private Timestamp code;
  private int userId;
  private int address;
  private String state;
  private String phoneNum;
  private float total;
  private Date createtime;
  private int restaurantId;

  public Order(int id, Timestamp code, int userId, int address, String state, String phoneNum, float toatal, Date createtime, int restaurantId) {
    this.id = id;
    this.code = code;
    this.userId = userId;
    this.address = address;
    this.state = state;
    this.phoneNum = phoneNum;
    this.total = toatal;
    this.createtime = createtime;
    this.restaurantId = restaurantId;
  }

  public Order() {
  }

  public void setRestaurantId(int restaurantId) {
    this.restaurantId = restaurantId;
  }

  public int getRestaurantId() {
    return restaurantId;
  }

  @Override
  public String toString() {
    return "Order{" +
            "id=" + id +
            ", code=" + code +
            ", userId=" + userId +
            ", address='" + address + '\'' +
            ", state='" + state + '\'' +
            ", phoneNum='" + phoneNum + '\'' +
            //", toatal=" + total +
            ", createtime=" + createtime +
            ", restaurantId=" + restaurantId +
            '}';
  }

  public String getPhoneNum() {
    return phoneNum;
  }

  public float getToatal() {
    return total;
  }

  public void setId(int id) {
    this.id = id;
  }

  public void setPhoneNum(String phoneNum) {
    this.phoneNum = phoneNum;
  }

  public void setToatal(float toatal) {
    this.total = toatal;
  }

  public int getUserId() {
    return userId;
  }


  public void setUserId(int userId) {
    this.userId = userId;
  }


  public int getId() {
    return id;
  }

  /*public void setId(int id) {
    this.id = id;
  }*/

  public Timestamp getCode() {
    return code;
  }

  public void setCode(Timestamp code) {
    this.code = code;
  }


  public int getAddress() {
    return address;
  }

  public void setAddress(int address) {
    this.address = address;
  }

  public String getState() {
    return state;
  }

  public void setState(String state) {
    this.state = state;
  }

  public Date getCreatetime() {
    return createtime;
  }

  public void setCreatetime(Date createtime) {
    this.createtime = createtime;
  }


}
