package cn.forage.model;

/**
 * Created by DoneSpeak on 2017/5/17.
 */
public class Address {
    private int id;
    //  收单人
    private String name;
    //  收单人号码
    private String phoneNum;
    //  收单人地址
    private String location;

    // 该地址的拥有者 - 应该可以不要
    private int userId;

    @Override
    public String toString() {
        return "Address{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", phoneNum='" + phoneNum + '\'' +
                ", location='" + location + '\'' +
                ", userId=" + userId +
                '}';
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getUserId() {
        return userId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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
}
