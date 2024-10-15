from django.test import SimpleTestCase
from django.urls import resolve, reverse
from analytics_app.views import (
    SalesAnalyticsView, RecommendationView, CustomerLifetimeValueView, OrderTaxView
)
from analytics_app.api import (
    ProductViewSet, CustomerViewSet, OrderViewSet, OrderItemViewSet, InventoryViewSet, export_sales_report
)

class TestUrls(SimpleTestCase):

    def test_product_url_resolves(self):
        url = reverse('product-list')
        self.assertEquals(resolve(url).func.cls, ProductViewSet)

    def test_customer_url_resolves(self):
        url = reverse('customer-list')
        self.assertEquals(resolve(url).func.cls, CustomerViewSet)

    def test_order_url_resolves(self):
        url = reverse('order-list')
        self.assertEquals(resolve(url).func.cls, OrderViewSet)

    def test_order_item_url_resolves(self):
        url = reverse('orderitem-list')
        self.assertEquals(resolve(url).func.cls, OrderItemViewSet)

    def test_inventory_url_resolves(self):
        url = reverse('inventory-list')
        self.assertEquals(resolve(url).func.cls, InventoryViewSet)

    def test_export_sales_url_resolves(self):
        url = reverse('export_sales_report', args=[10, 2024])
        self.assertEquals(resolve(url).func, export_sales_report)

    def test_sales_analytics_url_resolves(self):
        url = reverse('sales_analytics')
        self.assertEquals(resolve(url).func.view_class, SalesAnalyticsView)

    def test_product_recommendations_url_resolves(self):
        url = reverse('product_recommendations', args=[1])
        self.assertEquals(resolve(url).func.view_class, RecommendationView)

    def test_product_recommendations_with_type_url_resolves(self):
        url = reverse('product_recommendations_with_type', args=[1])
        self.assertEquals(resolve(url).func.view_class, RecommendationView)

    def test_customer_clv_url_resolves(self):
        url = reverse('calculate_clv', args=[1])
        self.assertEquals(resolve(url).func.view_class, CustomerLifetimeValueView)

    def test_order_tax_url_resolves(self):
        url = reverse('calculate_tax', args=[1])
        self.assertEquals(resolve(url).func.view_class, OrderTaxView)