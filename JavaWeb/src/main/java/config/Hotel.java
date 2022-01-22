package config;

import java.util.ArrayList;

public class Hotel{
    public static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    public static final String URL = "jdbc:mysql://localhost:3306/new?autoReconnect=true&useSSL=false&useUnicode=true&charaterEncoding=UTF";

    public static  String USERNAME = "chadi";

    public static  String PASSWORD = "chadiemsi";

    public static final String SYSTEMUSERNAME = "chadi";

    public static final String SYSTEMPASSWORD = "chadiemsi";

    public static final String HOTELUSERNAME = "hotel";

    public static final String HOTELPASSWORD = "chadiemsi";

    public static int status = 1 ; 
    
    public static final String SQL_ALL_ORDERS = "SELECT * FROM orders";
    public static final String SQL_ALL_ADMINS = "SELECT * FROM systemAdministrator";

    
    public static final String SQL_ALL_ROOMS ="SELECT * FROM roomtypeandprice" ;

    public static final String SQL_ALL_WAITERS ="SELECT * FROM waiter" ;

    public static final String SQL_ALL_TIME_EXTENSION_ORDERS = "SELECT * FROM timeextension";

    public static final String SEARCH_ROOM = "1";

    public static final String ADD_ROOM = "2";

    public static final String EDIT_ROOM = "3";

    public static final String DELETE_ROOM = "4";

}
