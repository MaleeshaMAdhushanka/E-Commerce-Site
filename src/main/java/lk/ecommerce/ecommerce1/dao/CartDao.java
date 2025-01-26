package lk.ecommerce.ecommerce1.dao;

import lk.ecommerce.ecommerce1.entities.Cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CartDao {

    private Connection con;

    public CartDao(Connection con) {
        this.con = con;
    }

    public boolean addToCart(Cart cart){
        boolean flag = false;
        //Check if user exists
        try {
            if (!isUserExists(cart.getUserId())) {
                System.out.println("User ID does not exist: " + cart.getUserId());
                return false;
            }

        String query = "insert into cart(uid, pid, quantity) values (?,?,?)";
        PreparedStatement pstm  = this.con.prepareStatement(query);
        pstm.setInt(1, cart.getUserId());
        pstm.setInt(2, cart.getProductId());
        pstm.setInt(3, cart.getQuantity());

            System.out.println("Adding to cart: UID=" + cart.getUserId() + ", PID=" + cart.getProductId() + ", Quantity=" + cart.getQuantity());

            pstm.executeUpdate();
        flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;


    }

    private boolean isUserExists(int userId) {
        return false;
    }

    public List<Cart> getCartListByUserId(int uid){
        List<Cart> list = new ArrayList<Cart>();

        try {
         String query = "select  * from cart where uid = ?";
           PreparedStatement pstm = this.con.prepareStatement(query);
           pstm.setInt(1, uid);

          ResultSet rs =  pstm.executeQuery();
          while (rs.next()){
              Cart cart = new Cart();
              cart.setCartId(rs.getInt("id"));
              cart.setUserId(rs.getInt("uid"));
              cart.setProductId(rs.getInt("pid"));
              cart.setQuantity(rs.getInt("quantity"));

              list.add(cart);
          }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getQuantity(int uid, int pid){
        int qty = 0;

        try {
          String query = "select * from cart where uid = ? and pid = ?";
            PreparedStatement pstm = this.con.prepareStatement(query);
            pstm.setInt(1, uid);
            pstm.setInt(2, pid);
           ResultSet rs =  pstm.executeQuery();
           while (rs.next()){
             qty  =  rs.getInt("quantity");
           }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return qty;

    }

    public int getQuantityById(int id){
        int qty = 0;
        try {
        String query = "select * from cart where id = ?";

        PreparedStatement pstm = this.con.prepareStatement(query);
        pstm.setInt(1, id);
       ResultSet rs =  pstm.executeQuery();
       while (rs.next()){
          qty = rs.getInt("quantity");
       }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return qty;
    }

    public void updateQuantity(int id, int qty) {

        try {
            String query = "update cart set quantity = ? where id = ?";
            PreparedStatement psmt = this.con.prepareStatement(query);
            psmt.setInt(1, qty);
            psmt.setInt(2, id);

            psmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public void removeProduct(int cid){
        try{
            String query = "delete from cart where id = ?";
            PreparedStatement pstm = this.con.prepareStatement(query);
            pstm.setInt(1, cid);
            pstm.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }


    }

    public void removeAllProduct(){
        try {
            String query = "delete from cart";
            PreparedStatement pstm = this.con.prepareStatement(query);
            pstm.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int getIdByUserIdAndProductId(int uid, int pid){
        int cid = 0;
        try {
            String query = "select * from cart where uid = ? and pid = ?";
            PreparedStatement pstm = this.con.prepareStatement(query);
            pstm.setInt(1, uid);
            pstm.setInt(2, pid);

           ResultSet rs =  pstm.executeQuery();
           while (rs.next()){
             cid = rs.getInt("id");
           }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return cid;
    }


    public int getCartCountByUserId(int uid){
        int count = 0;

        try {
            String query = "select count(*) from cart where uid=?";
            PreparedStatement pstm =  this.con.prepareStatement(query);
            pstm.setInt(1, uid);

             ResultSet rs = pstm.executeQuery();
              rs.next();
              count =  rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;

    }

    public int getProductId(int cid){
        int pid = 0;

        try {
            String query = "select pid from cart where id=?";
            PreparedStatement pstm = this.con.prepareStatement(query);
            pstm.setInt(1, cid);
            ResultSet rs =  pstm.executeQuery();
            rs.next();
            pid = rs.getInt(1);


        } catch (Exception e) {
            e.printStackTrace();

        }
        return pid;

    }






}

