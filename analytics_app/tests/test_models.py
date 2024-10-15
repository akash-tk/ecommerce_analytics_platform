from django.test import TestCase
from django.utils import timezone
from decimal import Decimal
from analytics_app.models import Product, Category, Tag, Customer, Order, OrderItem, Inventory

class ProductModelTest(TestCase):
    def setUp(self):
        self.category = Category.objects.create(name="Electronics")
        self.product = Product.objects.create(
            name="Smartphone",
            description="A smartphone with many features",
            SKU="SM12345",
            price=Decimal("500.00"),
            category=self.category,
            is_active=True
        )
    
    def test_product_creation(self):
        self.assertEqual(self.product.name, "Smartphone")
        self.assertEqual(self.product.SKU, "SM12345")
        self.assertEqual(self.product.price, Decimal("500.00"))
        self.assertTrue(self.product.is_active)

    def test_product_manager_active(self):
        active_products = Product.objects.active_products()
        self.assertIn(self.product, active_products)

    def test_product_manager_inactive(self):
        self.product.is_active = False
        self.product.save()
        inactive_products = Product.objects.inactive_products()
        self.assertIn(self.product, inactive_products)

    def test_products_by_category(self):
        products = Product.objects.products_by_category(self.category.id)
        self.assertIn(self.product, products)

    def test_products_below_price(self):
        cheap_product = Product.objects.create(
            name="Basic Phone",
            description="A basic phone",
            SKU="BP12345",
            price=Decimal("100.00"),
            category=self.category,
            is_active=True
        )
        products = Product.objects.products_below_price(Decimal("200.00"))
        self.assertIn(cheap_product, products)


class CategoryModelTest(TestCase):
    def setUp(self):
        self.category = Category.objects.create(name="Books")

    def test_category_creation(self):
        self.assertEqual(self.category.name, "Books")


class TagModelTest(TestCase):
    def setUp(self):
        self.tag = Tag.objects.create(name="Sale")

    def test_tag_creation(self):
        self.assertEqual(self.tag.name, "Sale")


class CustomerModelTest(TestCase):
    def setUp(self):
        self.customer = Customer.objects.create(
            name="John Doe",
            email="john@example.com",
            country="USA",
        )

    def test_customer_creation(self):
        self.assertEqual(self.customer.name, "John Doe")
        self.assertEqual(self.customer.email, "john@example.com")
        self.assertEqual(self.customer.country, "USA")

    def test_lifetime_value(self):
        order1 = Order.objects.create(customer=self.customer, status="delivered", total_amount=Decimal('200.00'))
        order2 = Order.objects.create(customer=self.customer, status="shipped", total_amount=Decimal('300.00'))
        self.assertEqual(self.customer.calculate_lifetime_value(), Decimal('500.00'))

    def test_customer_lifetime_value_zero(self):
        self.assertEqual(self.customer.calculate_lifetime_value(), Decimal('0.00'))


class OrderModelTest(TestCase):
    def setUp(self):
        self.customer = Customer.objects.create(
            name="John Doe",
            email="john@example.com",
            country="USA",
        )
        self.order = Order.objects.create(
            customer=self.customer,
            status="pending",
            total_amount=Decimal("100.00")
        )
    
    def test_order_creation(self):
        self.assertEqual(self.order.customer.name, "John Doe")
        self.assertEqual(self.order.status, "pending")
        self.assertEqual(self.order.total_amount, Decimal("100.00"))

    def test_calculate_tax(self):
        tax = self.order.calculate_tax()
        self.assertEqual(tax, Decimal('10.00'))

    def test_calculate_tax_for_unknown_country(self):
        self.customer.country = "Unknownland"
        self.customer.save()
        tax = self.order.calculate_tax()
        self.assertEqual(tax, self.order.total_amount * Decimal('0.2'))


class OrderItemModelTest(TestCase):
    def setUp(self):
        self.category = Category.objects.create(name="Electronics")
        self.product = Product.objects.create(
            name="Smartphone",
            SKU="SM12345",
            price=Decimal("500.00"),
            category=self.category,
            is_active=True
        )
        self.customer = Customer.objects.create(
            name="Jane Doe",
            email="jane@example.com",
            country="USA",
        )
        self.order = Order.objects.create(
            customer=self.customer,
            status="pending",
            total_amount=Decimal("1000.00")
        )
        self.inventory = Inventory.objects.create(
            product=self.product,
            quantity=5,
            last_restocked_date=timezone.now()
        )
    
    def test_order_item_creation(self):
        order_item = OrderItem.objects.create(order=self.order, product=self.product, quantity=1, price_at_time_of_order=self.product.price)
        self.assertEqual(order_item.product.name, "Smartphone")
        self.assertEqual(order_item.quantity, 1)

    def test_inventory_reduction_on_order_item_creation(self):
        order_item = OrderItem.objects.create(order=self.order, product=self.product, quantity=3, price_at_time_of_order=self.product.price)
        self.inventory.refresh_from_db()
        self.assertEqual(self.inventory.quantity, 2)

    def test_inventory_alert_when_not_enough(self):
        self.inventory.quantity = 1
        self.inventory.save()
        order_item = OrderItem.objects.create(order=self.order, product=self.product, quantity=2, price_at_time_of_order=self.product.price)
        self.inventory.refresh_from_db()
        self.assertEqual(self.inventory.quantity, 1)

    def test_no_inventory_exists(self):
        new_product = Product.objects.create(
            name="Tablet", SKU="TB123", price=Decimal("300.00"), category=self.category, is_active=True
        )
        order_item = OrderItem.objects.create(order=self.order, product=new_product, quantity=2, price_at_time_of_order=new_product.price)
        self.assertRaises(Inventory.DoesNotExist, Inventory.objects.get, product=new_product)


class InventoryModelTest(TestCase):
    def setUp(self):
        self.category = Category.objects.create(name="Furniture")
        self.product = Product.objects.create(
            name="Chair",
            description="Comfortable office chair",
            SKU="CH123",
            price=Decimal("150.00"),
            category=self.category,
            is_active=True
        )
        self.inventory = Inventory.objects.create(
            product=self.product,
            quantity=5,
            last_restocked_date=timezone.now()
        )
    
    def test_inventory_creation(self):
        self.assertEqual(self.inventory.product.name, "Chair")
        self.assertEqual(self.inventory.quantity, 5)

    def test_restock_alert(self):
        self.inventory.quantity = 4
        self.inventory.save()

    def test_low_inventory_alert(self):
        self.inventory.quantity = 9
        self.inventory.save()
        self.inventory.refresh_from_db()
        self.assertLess(self.inventory.quantity, 10)
