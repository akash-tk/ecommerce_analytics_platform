from django.contrib import admin
from .models import Product, Customer, Order, OrderItem, Inventory, Category, Tag

admin.site.register(Product)
admin.site.register(Customer)
admin.site.register(Order)
admin.site.register(OrderItem)
admin.site.register(Inventory)
admin.site.register(Category)
admin.site.register(Tag)