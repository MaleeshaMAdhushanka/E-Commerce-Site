package lk.ecommerce.ecommerce1.entities;

import java.sql.Timestamp;

public class User {

    private int userId;
    private String userName;
    private String userEmail;
    private String userPassword;

    public User() {

    }

    public User(String userName, String userEmail, String userPassword) {
        super();
        this.userName = userName;
        this.userEmail = userEmail;
        this.userPassword = userPassword;
    }

//    public User(String userName, String userEmail, String userPassword) {
//        super();
//        this.userName = userName;
//        this.userEmail = userEmail;
//        this.userPassword = userPassword;
//    }

//    public User(String userName, String userEmail) {
//        super();
//        this.userName = userName;
//        this.userEmail = userEmail;
//    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }


}
