
# Tarea
1. Identificar los code smells
2. Explicar por que son peligrosos
3. Hacer refactor para eliminar los code smells
```java
public class User {
    private String name;
    private String address;
    private String phone;
    private String email;
    private int loyaltyPoints;
    private double accountBalance;
    private List<String> orders;
    private List<String> coupons;

    // Method to update user information
    public void updateInfo(String name, String address, String phone, String email) {
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.email = email;
    }

    // Method to calculate discount based on loyalty points
    public double calculateDiscount(int loyaltyPoints, double accountBalance) {
        double discount = 0.0;
        if (loyaltyPoints > 100) {
            discount = accountBalance * 0.1;
        } else if (loyaltyPoints > 200) {
            discount = accountBalance * 0.2;
        } else {
            discount = accountBalance * 0.05;
        }
        return discount;
    }

    // Method to print all orders
    public void printOrders() {
        for (String order : orders) {
            System.out.println("Order: " + order);
        }
    }

    // Method to apply coupons
    public void applyCoupons(List<String> coupons) {
        for (String coupon : coupons) {
            System.out.println("Applying coupon: " + coupon);
        }
    }

    // Deprecated method
    public void deprecatedMethod() {
        // This method is no longer used
    }
}
```

# Respuestas
## 1. Code Smells
Obsesión por los primitivos:
```java
public class User {
    private String name;
    private String address;
    private String phone;
    private String email;
    private int loyaltyPoints;
    private double accountBalance;
    private List<String> orders;
    private List<String> coupons;
```

Lista larga de parámetros:
```java
public void updateInfo(String name, String address, String phone, String email) {
```

Clase larga (métodos como este pueden ir en otra clase):
```java
public double calculateDiscount(int loyaltyPoints, double accountBalance) {
        double discount = 0.0;
        if (loyaltyPoints > 100) {
            discount = accountBalance * 0.1;
        } else if (loyaltyPoints > 200) {
            discount = accountBalance * 0.2;
        } else {
            discount = accountBalance * 0.05;
        }
        return discount;
    }
```
Código muerto:
```java
public void deprecatedMethod() {
        // This method is no longer used
    }
```

Comentarios innecesarios:
```java
// Method to print all orders
    public void printOrders() {
```

## 2. ¿Por qué son peligrosos?
Los code smells son peligrosos porque, aunque el código funcione, indican problemas de diseño que lo vuelven difícil de entender, modificar y mantener; con el tiempo aumentan el riesgo de errores, rompen principios como la responsabilidad única y se termina convirtiendo en codigo espageti, haciendo que cada cambio sea más costoso y peligroso para la estabilidad del sistema.

## 3. Refactor
```java
import java.util.List;

class ContactInfo {
    private String name;
    private String address;
    private String phone;
    private String email;

    public ContactInfo(String name, String address, String phone, String email) {
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.email = email;
    }

    public String name() {
        return name;
    }
}

class LoyaltyAccount {
    private int points;
    private double balance;

    public LoyaltyAccount(int points, double balance) {
        this.points = points;
        this.balance = balance;
    }

    public double calculateDiscount() {
        if (points > 200) {
            return balance * 0.20;
        }
        if (points > 100) {
            return balance * 0.10;
        }
        return balance * 0.05;
    }
}

class Order {
    private String id;

    public Order(String id) {
        this.id = id;
    }

    public void print() {
        System.out.println("Order: " + id);
    }
}

class Coupon {
    private String code;

    public Coupon(String code) {
        this.code = code;
    }

    public void apply() {
        System.out.println("Applying coupon: " + code);
    }
}

public class User {

    private ContactInfo contactInfo;
    private LoyaltyAccount loyaltyAccount;
    private List<Order> orders;
    private List<Coupon> coupons;

    public User(ContactInfo contactInfo,
                LoyaltyAccount loyaltyAccount,
                List<Order> orders,
                List<Coupon> coupons) {
        this.contactInfo = contactInfo;
        this.loyaltyAccount = loyaltyAccount;
        this.orders = orders;
        this.coupons = coupons;
    }

    public void updateContactInfo(ContactInfo newContactInfo) {
        this.contactInfo = newContactInfo;
    }

    public double calculateDiscount() {
        return loyaltyAccount.calculateDiscount();
    }

    public void printOrders() {
        orders.forEach(Order::print);
    }

    public void applyCoupons() {
        coupons.forEach(Coupon::apply);
    }
}

```