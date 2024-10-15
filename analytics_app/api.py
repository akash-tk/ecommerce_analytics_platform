from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticated
from rest_framework_simplejwt.authentication import JWTAuthentication
from .models import Product, Customer, Order, OrderItem, Inventory
from .serializers import ProductSerializer, CustomerSerializer, OrderSerializer, OrderItemSerializer, InventorySerializer
from .utils import export_monthly_sales_report
from rest_framework.decorators import api_view
from rest_framework.response import Response
from datetime import datetime
from django.http import HttpResponse
from .business_logic import SalesAnalytics, RecommendationEngine

class ProductViewSet(viewsets.ModelViewSet):
    serializer_class = ProductSerializer
    permission_classes = [IsAuthenticated]
    authentication_classes = [JWTAuthentication]
    queryset = Product.objects.active_products()

    def get_queryset(self):
        queryset = super().get_queryset()
        category_id = self.request.query_params.get('category_id')
        if category_id:
            queryset = queryset.filter(category_id=category_id)
        is_active = self.request.query_params.get('is_active')
        if is_active is not None:
            queryset = queryset.filter(is_active=(is_active.lower() == 'true'))
        return queryset

class CustomerViewSet(viewsets.ModelViewSet):
    queryset = Customer.objects.all()
    serializer_class = CustomerSerializer
    permission_classes = [IsAuthenticated]
    authentication_classes = [JWTAuthentication]

class OrderViewSet(viewsets.ModelViewSet):
    queryset = Order.objects.all()
    serializer_class = OrderSerializer
    permission_classes = [IsAuthenticated]
    authentication_classes = [JWTAuthentication]

class OrderItemViewSet(viewsets.ModelViewSet):
    queryset = OrderItem.objects.all()
    serializer_class = OrderItemSerializer
    permission_classes = [IsAuthenticated]
    authentication_classes = [JWTAuthentication]

class InventoryViewSet(viewsets.ModelViewSet):
    queryset = Inventory.objects.all()
    serializer_class = InventorySerializer
    permission_classes = [IsAuthenticated]
    authentication_classes = [JWTAuthentication]

@api_view(['GET'])
def export_sales_report(request, month, year):
    return export_monthly_sales_report(month, year)

@api_view(['GET'])
def calculate_clv(request, customer_id):
    try:
        customer = Customer.objects.get(id=customer_id)
        clv = customer.calculate_lifetime_value()
        return Response({'customer': customer.name, 'CLV': clv})
    except Customer.DoesNotExist:
        return Response({'error': 'Customer not found'}, status=404)

@api_view(['GET'])
def calculate_tax(request, order_id):
    try:
        order = Order.objects.get(id=order_id)
        tax = order.calculate_tax()
        return Response({'order_id': order.id, 'tax': tax})
    except Order.DoesNotExist:
        return Response({'error': 'Order not found'}, status=404)

@api_view(['GET'])
def sales_analytics(request):
    start_date = request.GET.get('start_date')
    end_date = request.GET.get('end_date')
    if not start_date or not end_date:
        return Response({'error': 'Please provide start_date and end_date parameters'}, status=400)
    try:
        start_date = datetime.strptime(start_date, '%Y-%m-%d')
        end_date = datetime.strptime(end_date, '%Y-%m-%d')
    except ValueError:
        return Response({'error': 'Invalid date format. Use YYYY-MM-DD.'}, status=400)
    analytics = SalesAnalytics()
    revenue_by_category = analytics.calculate_revenue_by_category(start_date, end_date)
    return Response(revenue_by_category)

@api_view(['GET'])
def product_recommendations(request, customer_id):
    try:
        customer = Customer.objects.get(id=customer_id)
        recommendation_engine = RecommendationEngine()
        recommended_products = recommendation_engine.recommend_products(customer)
        return Response({'customer': customer.name, 'recommended_products': recommended_products})
    except Customer.DoesNotExist:
        return Response({'error': 'Customer not found'}, status=404)
