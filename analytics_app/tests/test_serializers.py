from django.test import TestCase
from analytics_app.models import Product, Customer, Order, OrderItem, Inventory, Category
from analytics_app.serializers import (
    ProductSerializer, CustomerSerializer, OrderSerializer, OrderItemSerializer,
    InventorySerializer
)
from decimal import Decimal

class ProductSerializerTest(TestCase):
    def setUp(self):
        self.category = Category.objects.create(name="Test Category")
        self.product = Product.objects.create(
            name="Test Product",
            description="Test Description",
            SKU="SKU123",
            price=Decimal('100.00'),
            category=self.category,
            is_active=True
        )

    def test_product_serializer_invalid(self):
        invalid_product_data = {
            'name': '',
            'description': '',
            'SKU': '',
            'price': 'invalid',
            'category': None,
            'is_active': True,
        }
        serializer = ProductSerializer(data=invalid_product_data)
        self.assertFalse(serializer.is_valid())
        self.assertIn('name', serializer.errors)
        self.assertIn('price', serializer.errors)

class CustomerSerializerTest(TestCase):
    def setUp(self):
        self.customer = Customer.objects.create(
            name="John Doe",
            email="john@example.com",
            country="USA"
        )

    def test_customer_serializer_invalid(self):
        invalid_customer_data = {
            'name': '',
            'email': 'not-an-email',
            'country': ''
        }
        serializer = CustomerSerializer(data=invalid_customer_data)
        self.assertFalse(serializer.is_valid())
        self.assertIn('name', serializer.errors)
        self.assertIn('email', serializer.errors)
        self.assertIn('country', serializer.errors)

    def test_customer_serializer_missing_email(self):
        invalid_customer_data = {
            'name': 'John Doe',
            'email': '',
            'country': 'USA'
        }
        serializer = CustomerSerializer(data=invalid_customer_data)
        self.assertFalse(serializer.is_valid())
        self.assertIn('email', serializer.errors)

class OrderSerializerTest(TestCase):
    def setUp(self):
        self.category = Category.objects.create(name="Test Category")
        self.product = Product.objects.create(
            name="Test Product",
            description="Test Description",
            SKU="SKU123",
            price=Decimal('50.00'),
            category=self.category,
            is_active=True
        )
        self.customer = Customer.objects.create(name="John Doe", email="john@example.com", country="USA")
        self.order = Order.objects.create(customer=self.customer, status='pending', total_amount=Decimal('150.00'))

    def test_order_serializer_invalid(self):
        invalid_order_data = {
            'customer': None,
            'status': 'invalid_status',
            'total_amount': 'invalid'
        }
        serializer = OrderSerializer(data=invalid_order_data)
        self.assertFalse(serializer.is_valid())
        self.assertIn('customer', serializer.errors)
        self.assertIn('status', serializer.errors)
        self.assertIn('total_amount', serializer.errors)

class OrderItemSerializerTest(TestCase):
    def setUp(self):
        self.category = Category.objects.create(name="Test Category")
        self.product = Product.objects.create(
            name="Test Product",
            description="Test Description",
            SKU="SKU123",
            price=Decimal('50.00'),
            category=self.category,
            is_active=True
        )
        self.customer = Customer.objects.create(name="John Doe", email="john@example.com", country="USA")
        self.order = Order.objects.create(customer=self.customer, status='pending', total_amount=Decimal('150.00'))
        self.order_item = OrderItem.objects.create(order=self.order, product=self.product, quantity=2, price_at_time_of_order=Decimal('50.00'))

    def test_orderitem_serializer_missing_product(self):
        invalid_order_item_data = {
            'order': self.order.id,
            'product': None,
            'quantity': 1,
            'price_at_time_of_order': '50.00'
        }
        serializer = OrderItemSerializer(data=invalid_order_item_data)
        self.assertFalse(serializer.is_valid())
        self.assertIn('product', serializer.errors)

class InventorySerializerTest(TestCase):
    def setUp(self):
        self.category = Category.objects.create(name="Test Category")
        self.product = Product.objects.create(
            name="Test Product",
            description="This is a test product.",
            SKU="TESTSKU123",
            price=Decimal('29.99'),
            category=self.category
        )

    def test_inventory_serializer_valid(self):
        valid_inventory_data = {
            'product': self.product.id,
            'quantity': 50
        }
        serializer = InventorySerializer(data=valid_inventory_data)
        self.assertTrue(serializer.is_valid())
        self.assertEqual(serializer.validated_data['quantity'], 50)
