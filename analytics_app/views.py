from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework_simplejwt.authentication import JWTAuthentication
from .models import Customer, Order, Product
from .business_logic import SalesAnalytics, RecommendationEngine
from .serializers import RevenueByCategorySerializer, TopSellingProductSerializer, ProductSerializer

class SalesAnalyticsView(APIView):
    permission_classes = [IsAuthenticated]
    authentication_classes = [JWTAuthentication]

    def get(self, request):
        analytics_type = request.query_params.get('type')
        start_date = request.query_params.get('start_date')
        end_date = request.query_params.get('end_date')
        country = request.query_params.get('country')

        sales_analytics = SalesAnalytics()

        if analytics_type == 'revenue_by_category':
            try:
                data = sales_analytics.calculate_revenue_by_category(start_date, end_date)
                serializer = RevenueByCategorySerializer(data, many=True)
                return Response(serializer.data)
            except Exception as e:
                return Response({"error": str(e)}, status=400)

        elif analytics_type == 'top_selling_products':
            if country:
                data = sales_analytics.identify_top_selling_products_by_country(country, start_date, end_date)
                serializer = TopSellingProductSerializer(data, many=True)
                return Response(serializer.data)
            else:
                return Response({"error": "Country is required for top-selling products."}, status=400)

        elif analytics_type == 'churn_rate':
            data = sales_analytics.compute_customer_churn_rate()
            return Response({"churn_rate": data})

        else:
            return Response({"error": "Invalid analytics type."}, status=400)

class RecommendationView(APIView):
    permission_classes = [IsAuthenticated]
    authentication_classes = [JWTAuthentication]

    def get(self, request, customer_id):
        recommendation_type = request.query_params.get('type')

        try:
            customer = Customer.objects.get(id=customer_id)
        except Customer.DoesNotExist:
            return Response({"error": "Customer not found."}, status=404)

        recommendation_engine = RecommendationEngine()

        if recommendation_type == 'history':
            data = recommendation_engine.suggest_products_based_on_history(customer)
        elif recommendation_type == 'similar_customer':
            data = recommendation_engine.suggest_products_based_on_similar_customers(customer)
        elif recommendation_type == 'inventory':
            data = recommendation_engine.suggest_products_based_on_inventory()
        else:
            data = recommendation_engine.suggest_general_products(customer)

        serializer = ProductSerializer(data, many=True)
        return Response(serializer.data)

class CustomerLifetimeValueView(APIView):
    permission_classes = [IsAuthenticated]
    authentication_classes = [JWTAuthentication]

    def get(self, request, customer_id):
        try:
            customer = Customer.objects.get(id=customer_id)
        except Customer.DoesNotExist:
            return Response({"error": "Customer not found."}, status=404)

        lifetime_value = customer.calculate_lifetime_value()
        return Response({"customer": customer.name, "lifetime_value": lifetime_value})

class OrderTaxView(APIView):
    permission_classes = [IsAuthenticated]
    authentication_classes = [JWTAuthentication]

    def get(self, request, order_id):
        try:
            order = Order.objects.get(id=order_id)
        except Order.DoesNotExist:
            return Response({"error": "Order not found."}, status=404)

        tax = order.calculate_tax()
        return Response({"order": order.id, "tax": tax})
