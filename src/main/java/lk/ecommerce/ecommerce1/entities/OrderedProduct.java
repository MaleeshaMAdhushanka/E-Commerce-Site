package lk.ecommerce.ecommerce1.entities;

public class OrderedProduct {

    private int id;
    private String name;

    private int quantity;

    private float price;

    private int orderId;


    public OrderedProduct() {
        super();
    }

    public OrderedProduct(String name, int quantity, float price, int orderId) {
        super();
        this.name = name;
        this.quantity = quantity;
        this.price = price;
        this.orderId = orderId;
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

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }



    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }
}
