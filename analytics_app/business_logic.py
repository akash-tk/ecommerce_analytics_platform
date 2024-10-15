from datetime import datetime, timedelta
from django.db.models import Sum
from .models import Order, Product, Customer, OrderItem

class SalesAnalytics:
    def calculate_revenue_by_category(self, start_date, end_date):
        revenue_by_category = Product.objects.filter(
            orderitem__order__order_date__range=[start_date, end_date]
        ).values('category__name').annotate(
            total_revenue=Sum('orderitem__price_at_time_of_order')
        )
        return list(revenue_by_category) if revenue_by_category else []

    def identify_top_selling_products_by_country(self, country, start_date, end_date):
        top_products = Product.objects.filter(
            orderitem__order__customer__country=country,
            orderitem__order__order_date__range=[start_date, end_date]
        ).annotate(
            total_sales=Sum('orderitem__quantity')
        ).values('id', 'name', 'total_sales').order_by('-total_sales')
        return list(top_products) if top_products else []

    def compute_customer_churn_rate(self, period_in_days=30):
        now = datetime.now()
        active_customers = Customer.objects.filter(
            orders__order_date__gte=now - timedelta(days=period_in_days)
        ).distinct().count()
        total_customers = Customer.objects.count()
        if total_customers == 0:
            return 0
        churn_rate = 1 - (active_customers / total_customers)
        return churn_rate


class RecommendationEngine:
    @staticmethod
    def suggest_products_based_on_history(customer):
        purchased_product_ids = OrderItem.objects.filter(
            order__customer=customer
        ).values_list('product_id', flat=True).distinct()
        if not purchased_product_ids:
            return []
        recommendations = Product.objects.filter(
            id__in=purchased_product_ids
        ).distinct()
        return recommendations

    @staticmethod
    def suggest_products_based_on_similar_customers(customer):
        purchased_product_ids = customer.orders.values_list('items__product_id', flat=True).distinct()
        similar_customers = Customer.objects.filter(
            orders__items__product_id__in=purchased_product_ids
        ).exclude(id=customer.id).distinct()
        recommended_products = Product.objects.filter(
            orderitem__order__customer__in=similar_customers
        ).distinct()
        return recommended_products if recommended_products.exists() else []

    @staticmethod
    def suggest_products_based_on_inventory():
        inventory_products = Product.objects.filter(inventory__quantity__gt=10)
        return inventory_products if inventory_products.exists() else []

    @staticmethod
    def suggest_general_products(customer):
        general_recommendations = Product.objects.all()[:10]
        return general_recommendations if general_recommendations.exists() else []
