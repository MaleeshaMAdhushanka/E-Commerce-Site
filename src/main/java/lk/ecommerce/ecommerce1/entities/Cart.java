package lk.ecommerce.ecommerce1.entities;

public class Cart {


    private int cartId;
    private int userId;
    private int productId;
    private int quantity;

    public Cart(int uid, int pid, int i) {
        super();
    }

    public Cart() {

    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
