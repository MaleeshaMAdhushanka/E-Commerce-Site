package lk.ecommerce.ecommerce1.dao;

import lk.ecommerce.ecommerce1.entities.OrderedProduct;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderProductDao {

    private Connection con;

//    public OrderedProductDao(Connection con) {
//        super();
//        this.con = con;
//    }

    public OrderProductDao(Connection con){
        super();
        this.con = con;
    }

    public void insertOrderedProduct(OrderedProduct ordProduct) {
        try {
            String query = "insert into ordered_product(name, quantity, price, orderid) values(?, ?,  ?, ?)";
            PreparedStatement psmt = this.con.prepareStatement(query);
            psmt.setString(1, ordProduct.getName());
            psmt.setInt(2, ordProduct.getQuantity());
            psmt.setFloat(3,ordProduct.getPrice());
            psmt.setInt(4, ordProduct.getOrderId());

            psmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public List<OrderedProduct> getAllOrderedProduct(int oid){
        List<OrderedProduct> list = new ArrayList<OrderedProduct>();
        try {
            String query = "select * from ordered_product where orderid = ?";
            PreparedStatement psmt = this.con.prepareStatement(query);
            psmt.setInt(1, oid);
            ResultSet rs = psmt.executeQuery();
            while (rs.next()) {
                OrderedProduct orderProd = new OrderedProduct();
                orderProd.setName(rs.getString("name"));
                orderProd.setQuantity(rs.getInt("quantity"));
                orderProd.setPrice(rs.getFloat("price"));
                orderProd.setOrderId(oid);

                list.add(orderProd);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

























}
