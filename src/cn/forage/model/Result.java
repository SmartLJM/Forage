package cn.forage.model;

/**
 * Created by DoneSpeak on 2017/5/17.
 */
public class Result {
    public static int ERROR = 0;
    public static int OK = 1;

    public int status;
    public String message;
    public Object data;

    public Result(){}

    public Result(int status, String message){
        this.status = status;
        this.message = message;
        this.data = null;
    }

    public Result(int status, String message, Object data){
        this.status = status;
        this.message = message;
        this.data = data;
    }
}
