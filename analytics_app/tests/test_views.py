from rest_framework.test import APITestCase
from rest_framework import status
from django.urls import reverse
from analytics_app.models import Customer, Order, Product, Category, Inventory
from django.contrib.auth.models import User
from rest_framework_simplejwt.tokens import RefreshToken
from django.utils import timezone
from datetime import timedelta

class ViewsTestCase(APITestCase):

    def setUp(self):
        self.category = Category.objects.create(name="Electronics")
        self.product = Product.objects.create(
            name="Laptop",
            description="A powerful laptop",
            SKU="LAP12345",
            price=1000.00,
            category=self.category,
            is_active=True
        )
        self.customer = Customer.objects.create(
            name="John Doe",
            email="john.doe@example.com",
            country="US"
        )
        self.order = Order.objects.create(
            customer=self.customer,
            status="pending",
            total_amount=1000.00,
            order_date=timezone.now()
        )
        self.inventory = Inventory.objects.create(
            product=self.product,
            quantity=50
        )
        self.superuser = User.objects.create_superuser(
            username="adminuser",
            email="admin@example.com",
            password="adminpassword"
        )
        self.token = self.get_jwt_token(self.superuser)

    def get_jwt_token(self, user):
        refresh = RefreshToken.for_user(user)
        return str(refresh.access_token)

    def test_sales_analytics_view_revenue_by_category(self):
        url = reverse('sales_analytics')
        self.client.credentials(HTTP_AUTHORIZATION='Bearer ' + self.token)
        start_date = (timezone.now() - timedelta(days=365)).strftime('%Y-%m-%d')
        end_date = timezone.now().strftime('%Y-%m-%d')
        response = self.client.get(url, {
            'type': 'revenue_by_category',
            'start_date': start_date,
            'end_date': end_date
        })
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_sales_analytics_view_invalid_type(self):
        url = reverse('sales_analytics')
        self.client.credentials(HTTP_AUTHORIZATION='Bearer ' + self.token)
        response = self.client.get(url, {'type': 'invalid_type'})
        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertEqual(response.data['error'], "Invalid analytics type.")

    def test_recommendation_view(self):
        url = reverse('product_recommendations', kwargs={'customer_id': self.customer.id})
        self.client.credentials(HTTP_AUTHORIZATION='Bearer ' + self.token)
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_customer_lifetime_value_view(self):
        url = reverse('calculate_clv', kwargs={'customer_id': self.customer.id})
        self.client.credentials(HTTP_AUTHORIZATION='Bearer ' + self.token)
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertIn('lifetime_value', response.data)

    def test_order_tax_view(self):
        url = reverse('calculate_tax', kwargs={'order_id': self.order.id})
        self.client.credentials(HTTP_AUTHORIZATION='Bearer ' + self.token)
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertIn('tax', response.data)

    def test_recommendation_view_customer_not_found(self):
        url = reverse('product_recommendations', kwargs={'customer_id': 999})
        self.client.credentials(HTTP_AUTHORIZATION='Bearer ' + self.token)
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_404_NOT_FOUND)
        self.assertEqual(response.data['error'], "Customer not found.")
