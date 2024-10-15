from django.urls import reverse
from rest_framework import status
from rest_framework.test import APITestCase
from analytics_app.models import Product, Customer, Order, OrderItem, Inventory, Category
from django.contrib.auth import get_user_model
from decimal import Decimal

User = get_user_model()

class ApiTests(APITestCase):

    def setUp(self):
        self.user = User.objects.create_user(username='testuser', password='testpassword')
        self.client.force_authenticate(user=self.user)

        self.category = Category.objects.create(name='Electronics')
        self.product = Product.objects.create(
            name='Smartphone',
            SKU='SP123',
            price=Decimal("699.99"),
            category=self.category,
            is_active=True
        )
        self.customer = Customer.objects.create(name='John Doe', email='john@example.com', country='US')
        self.order = Order.objects.create(customer=self.customer, status='pending', total_amount=0)

        self.order_item = OrderItem.objects.create(
            order=self.order, 
            product=self.product, 
            quantity=2, 
            price_at_time_of_order=self.product.price
        )
        
        self.order.total_amount = self.order_item.price_at_time_of_order * self.order_item.quantity
        self.order.save()

        self.inventory = Inventory.objects.create(product=self.product, quantity=10)

    def test_product_viewset_list(self):
        url = reverse('product-list')
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data), 1)

    def test_customer_viewset_list(self):
        url = reverse('customer-list')
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data), 1)

    def test_order_viewset_list(self):
        url = reverse('order-list')
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data), 1)

    def test_order_item_viewset_list(self):
        url = reverse('orderitem-list')
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data), 1)

    def test_inventory_viewset_list(self):
        url = reverse('inventory-list')
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data), 1)

    def test_export_sales_report(self):
        url = reverse('export_sales_report', args=['1', '2023'])
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_calculate_clv(self):
        url = reverse('calculate_clv', args=[self.customer.id])
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertIn('customer', response.data)
        self.assertIn('lifetime_value', response.data)

    def test_calculate_tax(self):
        url = reverse('calculate_tax', args=[self.order.id])
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertIn('order', response.data)
        self.assertIn('tax', response.data)

    def test_sales_analytics(self):
        url = reverse('sales_analytics')
        params = {
            'type': 'revenue_by_category',
            'start_date': '2024-01-01',
            'end_date': '2024-12-31'
        }
        response = self.client.get(url, params)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_product_recommendations(self):
        url = reverse('product_recommendations', args=[self.customer.id])
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertIsInstance(response.data, list)
        self.assertGreater(len(response.data), 0)
        self.assertIn('id', response.data[0])
        self.assertIn('name', response.data[0])
        self.assertIn('price', response.data[0])

    def test_calculate_clv_customer_not_found(self):
        url = reverse('calculate_clv', args=[999])
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_404_NOT_FOUND)
        self.assertIn('error', response.data)

    def test_calculate_tax_order_not_found(self):
        url = reverse('calculate_tax', args=[999])
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_404_NOT_FOUND)
        self.assertIn('error', response.data)

    def test_sales_analytics_invalid_date_format(self):
        url = reverse('sales_analytics')
        response = self.client.get(url, {'start_date': 'invalid', 'end_date': 'invalid'})
        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertIn('error', response.data)

    def test_sales_analytics_missing_dates(self):
        url = reverse('sales_analytics')
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertIn('error', response.data)

    def test_product_viewset_list_unauthenticated(self):
        self.client.logout()
        url = reverse('product-list')
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)

    def test_calculate_clv_unauthenticated(self):
        self.client.logout()
        url = reverse('calculate_clv', args=[self.customer.id])
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)

    def test_calculate_tax_unauthenticated(self):
        self.client.logout()
        url = reverse('calculate_tax', args=[self.order.id])
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)

    def test_product_recommendations_unauthenticated(self):
        self.client.logout()
        url = reverse('product_recommendations', args=[self.customer.id])
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)

    def test_order_viewset_list_empty(self):
        self.order.delete()
        url = reverse('order-list')
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data), 0)

    def test_customer_viewset_list_empty(self):
        self.customer.delete()
        url = reverse('customer-list')
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data), 0)

    def test_inventory_viewset_list_empty(self):
        self.inventory.delete()
        url = reverse('inventory-list')
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data), 0)

    def test_order_item_viewset_list_empty(self):
        self.order_item.delete()
        url = reverse('orderitem-list')
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data), 0)

    def test_create_customer(self):
        url = reverse('customer-list')
        data = {
            'name': 'Jane Doe',
            'email': 'jane@example.com',
            'country': 'US'
        }
        response = self.client.post(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(Customer.objects.count(), 2)

    def test_create_order(self):
        url = reverse('order-list')
        data = {
            'customer': self.customer.id,
            'status': 'pending',
            'total_amount': '150.00'
        }
        response = self.client.post(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(Order.objects.count(), 2)

    def test_create_order_item(self):
        url = reverse('orderitem-list')
        data = {
            'order': self.order.id,
            'product': self.product.id,
            'quantity': 1,
            'price_at_time_of_order': self.product.price
        }
        response = self.client.post(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(OrderItem.objects.count(), 2)
