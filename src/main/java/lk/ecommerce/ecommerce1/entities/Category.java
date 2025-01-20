package lk.ecommerce.ecommerce1.entities;

public class Category {

    private int categoryId;
    private String categoryName;
    private  String categoryImage;

    private Category(){
        super();
    }

    public Category(String categoryName, String categoryImage) {
        super();
        this.categoryName = categoryName;
        this.categoryImage = categoryImage;
    }

    public Category(int categoryId, String categoryName, String categoryImage) {
        super();
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.categoryImage = categoryImage;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getCategoryImage() {
        return categoryImage;
    }

    public void setCategoryImage(String categoryImage) {
        this.categoryImage = categoryImage;
    }

}
