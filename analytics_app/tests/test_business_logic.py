from django.test import TestCase
from unittest.mock import patch, MagicMock
from analytics_app.business_logic import SalesAnalytics, RecommendationEngine
from analytics_app.models import Product, Customer, OrderItem

class SalesAnalyticsTest(TestCase):

    @patch('analytics_app.models.Product.objects.filter')
    def test_calculate_revenue_by_category(self, mock_filter):
        mock_queryset = MagicMock()
        mock_queryset.values.return_value.annotate.return_value = [{'category__name': 'Electronics', 'total_revenue': 500}]
        mock_filter.return_value = mock_queryset

        analytics = SalesAnalytics()
        start_date = '2023-01-01'
        end_date = '2023-12-31'
        result = analytics.calculate_revenue_by_category(start_date, end_date)

        self.assertEqual(result, [{'category__name': 'Electronics', 'total_revenue': 500}])
        mock_filter.assert_called_with(orderitem__order__order_date__range=[start_date, end_date])

    @patch('analytics_app.models.Product.objects.filter')
    def test_identify_top_selling_products_by_country(self, mock_filter):
        mock_queryset = MagicMock()
        mock_queryset.annotate.return_value.values.return_value.order_by.return_value = [
            {'id': 1, 'name': 'Laptop', 'total_sales': 100}
        ]
        mock_filter.return_value = mock_queryset

        analytics = SalesAnalytics()
        country = 'USA'
        start_date = '2023-01-01'
        end_date = '2023-12-31'
        result = analytics.identify_top_selling_products_by_country(country, start_date, end_date)

        self.assertEqual(result, [{'id': 1, 'name': 'Laptop', 'total_sales': 100}])
        mock_filter.assert_called_with(
            orderitem__order__customer__country=country,
            orderitem__order__order_date__range=[start_date, end_date]
        )

    @patch('analytics_app.models.Customer.objects.filter')
    @patch('analytics_app.models.Customer.objects.count')
    def test_compute_customer_churn_rate(self, mock_count, mock_filter):
        mock_filter.return_value.distinct.return_value.count.return_value = 10
        mock_count.return_value = 50

        analytics = SalesAnalytics()
        result = analytics.compute_customer_churn_rate(period_in_days=30)

        self.assertAlmostEqual(result, 0.8)
        mock_filter.assert_called()
        mock_count.assert_called()

class RecommendationEngineTest(TestCase):

    @patch('analytics_app.models.OrderItem.objects.filter')
    @patch('analytics_app.models.Product.objects.filter')
    def test_suggest_products_based_on_history(self, mock_product_filter, mock_orderitem_filter):
        mock_orderitem_filter.return_value.values_list.return_value.distinct.return_value = [1, 2, 3]
        mock_product_filter.return_value.distinct.return_value = ['Product1', 'Product2']

        customer = MagicMock()
        recommendations = RecommendationEngine.suggest_products_based_on_history(customer)

        self.assertEqual(recommendations, ['Product1', 'Product2'])
        mock_orderitem_filter.assert_called_with(order__customer=customer)
        mock_product_filter.assert_called_with(id__in=[1, 2, 3])

    @patch('analytics_app.models.Customer.objects.filter')
    @patch('analytics_app.models.Product.objects.filter')
    def test_suggest_products_based_on_similar_customers(self, mock_product_filter, mock_customer_filter):
        mock_customer_filter.return_value.exclude.return_value.distinct.return_value = [1, 2]
        mock_product_filter.return_value.distinct.return_value.exists.return_value = True

        customer = MagicMock()
        recommendations = RecommendationEngine.suggest_products_based_on_similar_customers(customer)

        self.assertTrue(recommendations.exists())
        mock_customer_filter.assert_called()
        mock_product_filter.assert_called_with(orderitem__order__customer__in=[1, 2])

    @patch('analytics_app.models.Product.objects.filter')
    def test_suggest_products_based_on_inventory(self, mock_filter):
        mock_queryset = MagicMock()
        mock_queryset.exists.return_value = True
        mock_filter.return_value = mock_queryset

        recommendations = RecommendationEngine.suggest_products_based_on_inventory()

        self.assertTrue(recommendations.exists())
        mock_filter.assert_called_with(inventory__quantity__gt=10)

    @patch('analytics_app.models.Product.objects.all')
    def test_suggest_general_products(self, mock_all):
        mock_queryset = MagicMock()
        mock_queryset.exists.return_value = True
        mock_all.return_value = mock_queryset

        customer = MagicMock()
        recommendations = RecommendationEngine.suggest_general_products(customer)

        self.assertTrue(recommendations.exists())
        mock_all.assert_called_with()
