package lk.ecommerce.ecommerce1.dao;

import jakarta.annotation.Resource;
import lk.ecommerce.ecommerce1.entities.Admin;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminDao {

//    @Resource(name = "java:comp/env/jdbc/pool")
//    private DataSource con;

    private Connection con;

    public AdminDao(Connection con) {
        super();
        this.con = con;
    }


    public boolean saveAdmin(Admin admin){
        boolean flag = false;
        try {
            String query = "insert into admin(name, email, password, phone) values(?, ?, ?, ?)";
            PreparedStatement psmt = this.con.prepareStatement(query);
            psmt.setString(1, admin.getName());
            psmt.setString(2, admin.getEmail());
            psmt.setString(3, admin.getPassword());
            psmt.setString(4, admin.getPhone());

            psmt.executeUpdate();
            flag = true;

        } catch (SQLException e) {
            e.printStackTrace();
       }
        return flag;

    }

    public Admin getAdminByEmailPassword(String email, String password) {
        Admin admin = null;
        try {
            String query = "select * from admin where email = ? and password = ?";
            PreparedStatement psmt = this.con.prepareStatement(query);
            psmt.setString(1, email);
            psmt.setString(2, password);

            ResultSet set = psmt.executeQuery();
            //emial elai password ekai match
            while (set.next()) {
                admin = new Admin();
                admin.setId(set.getInt("id"));
                admin.setName(set.getString("name"));
                admin.setEmail(set.getString("email"));
                admin.setPassword(set.getString("password"));
                admin.setPhone(set.getString("phone"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return admin;

    }

    public List<Admin> getAllAdmin(){
        List<Admin> list = new ArrayList<Admin>();

        String query = "select * from admin";
        try {
            Statement statement = this.con.createStatement();
           ResultSet rs = statement.executeQuery(query);
           while (rs.next()){
               Admin admin = new Admin();
               admin.setId(rs.getInt("id"));
                admin.setName(rs.getString("name"));
                admin.setEmail(rs.getString("email"));
               admin.setPassword(rs.getString("password"));
                admin.setPhone(rs.getString("phone"));


                list.add(admin);


           }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean deleteAdmin(int id){
        boolean flag = false;

        try{
            String query = "delete from admin where id = ?";
         PreparedStatement pstm = this.con.prepareStatement(query);
         pstm.setInt(1, id);
         pstm.executeUpdate();
         flag = true;

        } catch (Exception e) {
            e.printStackTrace();
        }
      return flag;
    }




}
