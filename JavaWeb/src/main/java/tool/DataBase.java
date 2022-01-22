package tool;

import config.Hotel;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.HashMap;

public class DataBase {

    private static Connection connection = null;
    public static Connection hotelConnection =null ;
    public static Connection systemConnection =null ;
    public static  HashMap<String,Connection> MAP =null ;
    
    static {

        try {
            Class.forName(GCON.DRIVER);
            MAP = new HashMap<String, Connection>();
            hotelConnection = DriverManager.getConnection(
                    Hotel.URL,
                    Hotel.HOTELUSERNAME,
                    Hotel.HOTELPASSWORD);
            MAP.put(Hotel.HOTELUSERNAME, hotelConnection);
            systemConnection = DriverManager.getConnection(
                    Hotel.URL,
                    Hotel.SYSTEMUSERNAME,
                    Hotel.SYSTEMPASSWORD);
            MAP.put(Hotel.SYSTEMUSERNAME,systemConnection);
        } catch (Exception exception) {
            exception.printStackTrace();
        }
    }

    public static void disConnection() {
        connection = null;
    }


    public static Connection getConnection() throws Exception {
        
        if (connection == null) {
            connection = DriverManager.getConnection(Hotel.URL, Hotel.USERNAME, Hotel.PASSWORD);
            return connection;
        }
        else if (Hotel.status == 0) {
            return MAP.get(Hotel.HOTELUSERNAME) ;
        } else {
            return MAP.get(Hotel.SYSTEMUSERNAME) ;
        }
    }
    public static void setConnection(Connection connection) throws Exception {

        DataBase.connection = connection ;
    }

}
