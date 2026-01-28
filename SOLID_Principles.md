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
  def send_confirmation_email
    # Lógica para enviar un correo electrónico de confirmación
    puts "Email enviado a customer@example.com"
  end
end

class OrderPrinter
  def print_order
    @items.each do |item|
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
    total - (total*@discount)
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
```