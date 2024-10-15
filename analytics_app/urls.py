from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .api import (
    ProductViewSet, CustomerViewSet, OrderViewSet, OrderItemViewSet,
    InventoryViewSet, export_sales_report, 
)

from .views import SalesAnalyticsView, RecommendationView, CustomerLifetimeValueView, OrderTaxView

router = DefaultRouter()
router.register(r'products', ProductViewSet)
router.register(r'customers', CustomerViewSet)
router.register(r'orders', OrderViewSet)
router.register(r'order-items', OrderItemViewSet)
router.register(r'inventory', InventoryViewSet)

urlpatterns = [
    path('', include(router.urls)),
    path('export-sales/<int:month>/<int:year>/', export_sales_report, name='export_sales_report'),
    path('analytics/sales/', SalesAnalyticsView.as_view(), name='sales_analytics'),
    path('recommendations/<int:customer_id>/', RecommendationView.as_view(), name='product_recommendations'),
    path('recommendations/<int:customer_id>/', RecommendationView.as_view(), name='product_recommendations_with_type'),
    path('customer/<int:customer_id>/clv/', CustomerLifetimeValueView.as_view(), name='calculate_clv'),
    path('order/<int:order_id>/tax/', OrderTaxView.as_view(), name='calculate_tax'),
]
