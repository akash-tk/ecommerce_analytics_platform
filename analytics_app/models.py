from django.db import models
from django.utils import timezone
from decimal import Decimal

class ProductManager(models.Manager):
    def active_products(self):
        return self.filter(is_active=True)

    def inactive_products(self):
        return self.filter(is_active=False)

    def products_by_category(self, category_id):
        return self.filter(category_id=category_id)

    def products_below_price(self, price):
        return self.filter(price__lt=price)


class Product(models.Model):
    name = models.CharField(max_length=255)
    description = models.TextField()
    SKU = models.CharField(max_length=100, unique=True)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    category = models.ForeignKey('Category', on_delete=models.CASCADE)
    tags = models.ManyToManyField('Tag', blank=True)
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    objects = ProductManager()

    def __str__(self):
        return self.name


class Category(models.Model):
    name = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name


class Tag(models.Model):
    name = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name


class Customer(models.Model):
    name = models.CharField(max_length=255)
    email = models.EmailField(unique=True)
    country = models.CharField(max_length=100)
    registration_date = models.DateTimeField(default=timezone.now)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def calculate_lifetime_value(self):
        total_spent = sum(order.total_amount for order in self.orders.all())
        return total_spent

    def __str__(self):
        return self.name


class Order(models.Model):
    STATUS_CHOICES = [
        ('pending', 'Pending'),
        ('shipped', 'Shipped'),
        ('delivered', 'Delivered'),
        ('canceled', 'Canceled'),
    ]

    customer = models.ForeignKey(Customer, related_name='orders', on_delete=models.CASCADE)
    order_date = models.DateTimeField(default=timezone.now)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES)
    total_amount = models.DecimalField(max_digits=10, decimal_places=2)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    tax_rates = {
        'US': Decimal('0.1'),
        'UK': Decimal('0.2'),
        'CA': Decimal('0.15'),
        'DE': Decimal('0.19'),
    }

    country_mapping = {
        'usa': 'US',
        'united states': 'US',
        'uk': 'UK',
        'canada': 'CA',
        'germany': 'DE',
    }

    def save(self, *args, **kwargs):
        if self.pk:
            original_order = Order.objects.get(pk=self.pk)
            if original_order.status == 'canceled' and self.status in ['pending', 'shipped', 'delivered']:
                self.reduce_inventory()
            elif self.status == 'canceled':
                self.restore_inventory()

        super(Order, self).save(*args, **kwargs)

    def restore_inventory(self):
        order_items = self.items.all()
        for item in order_items:
            inventory = Inventory.objects.get(product=item.product)
            inventory.quantity += item.quantity
            inventory.save()

    def reduce_inventory(self):
        order_items = self.items.all()
        for item in order_items:
            inventory = Inventory.objects.get(product=item.product)
            if inventory.quantity >= item.quantity:
                inventory.quantity -= item.quantity
                inventory.save()
            else:
                print(f"Not enough inventory for {item.product.name}. Available: {inventory.quantity}, Requested: {item.quantity}")

    def calculate_tax(self):
        country_name = self.customer.country.strip().lower()
        country_code = self.country_mapping.get(country_name, country_name.upper())
        tax_rate = self.tax_rates.get(country_code, Decimal('0.2'))
        return self.total_amount * tax_rate

    def __str__(self):
        return f"Order {self.id} - {self.customer.name}"


class OrderItem(models.Model):
    order = models.ForeignKey(Order, related_name='items', on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField()
    price_at_time_of_order = models.DecimalField(max_digits=10, decimal_places=2)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def save(self, *args, **kwargs):
        super().save(*args, **kwargs)

        try:
            inventory = Inventory.objects.get(product=self.product)
            if inventory.quantity >= self.quantity:
                inventory.quantity -= self.quantity
                inventory.save()
            else:
                print(f"Not enough inventory for {self.product.name}. Available: {inventory.quantity}, Requested: {self.quantity}")
        except Inventory.DoesNotExist:
            print(f"Inventory for product {self.product.id} does not exist.")

    def __str__(self):
        return f"{self.product.name} (x{self.quantity})"


class Inventory(models.Model):
    product = models.OneToOneField(Product, on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField()
    last_restocked_date = models.DateTimeField(auto_now=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def save(self, *args, **kwargs):
        if self.quantity < 10:
            self.trigger_restock_alert()
        super().save(*args, **kwargs)

    def trigger_restock_alert(self):
        print(f"Low inventory alert for {self.product.name}")

    def __str__(self):
        return f"Inventory for {self.product.name}"
