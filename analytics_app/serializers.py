from rest_framework import serializers
from .models import Product, Customer, Order, OrderItem, Inventory

class ProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = Product
        fields = '__all__'


class CustomerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Customer
        fields = '__all__'


class OrderItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = OrderItem
        fields = '__all__'


class OrderSerializer(serializers.ModelSerializer):
    items = OrderItemSerializer(many=True, read_only=True)

    class Meta:
        model = Order
        fields = '__all__'


class InventorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Inventory
        fields = '__all__'


class RevenueByCategorySerializer(serializers.Serializer):
    category_name = serializers.CharField(source='category__name')
    total_revenue = serializers.DecimalField(max_digits=10, decimal_places=2)


class TopSellingProductSerializer(serializers.Serializer):
    id = serializers.IntegerField()
    name = serializers.CharField()
    total_sales = serializers.IntegerField()
