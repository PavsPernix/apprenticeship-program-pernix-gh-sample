# Tarea

- Hacer refactor del siguiente código para seguir el principio SOLID y hacerle push a Github

### Código Inicial (Problema a Resolver)
```ruby
class Order
  def initialize(items)
    @items = items
  end

  def calculate_total
    total = 0
    @items.each do |item|
      total += item.price
    end
    total
  end

  def send_confirmation_email
    # Lógica para enviar un correo electrónico de confirmación
    puts "Email enviado a customer@example.com"
  end

  def print_order
    @items.each do |item|
      puts "Item: #{item.name} - Price: #{item.price}"
    end
  end
end

class Item
  attr_accessor :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end
```

### Instrucciones para la Tarea

1. **Single Responsibility Principle (SRP)**: Identifica las diferentes responsabilidades en la clase `Order` y sepáralas en clases adecuadas.
2. **Open/Closed Principle (OCP)**: Considera cómo podrías extender la funcionalidad del cálculo del total para diferentes tipos de descuentos o promociones sin modificar la clase existente.
3. **Dependency Inversion Principle (DIP)**: Refactoriza la lógica de envío de correos electrónicos para que la clase `Order` no dependa directamente de una implementación específica.


### Solución
```ruby
class EmailService
  def initialize(email)
    @email = email
  end

  def send_confirmation_email
    puts "Email enviado a #{@email}"
  end
end

class OrderPrinter
  def print_order(order)
    order.items.each do |item|
      puts "Item: #{item.name} - Price: #{item.price}"
    end
  end
end

class StandardPricing
  def calculate_total(items)
    items.sum(&:price)
  end
end

class DiscountPricing
  def initialize(discount)
    @discount = discount
  end

  def calculate_total(items)
    total = items.sum(&:price)
    total - (total * @discount)
  end
end

class Order
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def calculate_total(pricing_strategy)
    pricing_strategy.calculate_total(@items)
  end
end

class Item
  attr_accessor :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end

############ PRUEBA DE IMPLEMENTACION ###########
# 1. Set values for items
items = [
  Item.new("Laptop", 1000),
  Item.new("Mouse", 50),
  Item.new("Keyboard", 100)
]

# 2. Create the order
order = Order.new(items)

# 3. Calculate the total
pricing = DiscountPricing.new(0.1) # 10% discount
total = order.calculate_total(pricing)

puts "Total order price: #{total}"

# 4. Send an email to the customer
email_service = EmailService.new("customer@email.com")
email_service.send_confirmation_email

# 5. Print the order
printer = OrderPrinter.new
printer.print_order(order)

```