import openpyxl
from django.http import HttpResponse
from .models import OrderItem
from django.db import DatabaseError

def export_monthly_sales_report(month, year):
    month = str(month)
    year = str(year)

    if not month.isdigit() or not year.isdigit():
        return HttpResponse("Invalid month or year", status=400)

    month = int(month)
    year = int(year)

    if month < 1 or month > 12:
        return HttpResponse("Invalid month", status=400)

    if year < 2000:
        return HttpResponse("Invalid year", status=400)

    try:
        orders = OrderItem.objects.filter(
            order__order_date__year=year,
            order__order_date__month=month
        ).select_related('product')

        workbook = openpyxl.Workbook()
        sheet = workbook.active
        sheet.title = "Monthly Sales Report"

        headers = ["Product", "Quantity Sold", "Total Revenue"]
        sheet.append(headers)

        for item in orders:
            row = [
                item.product.name,
                item.quantity,
                item.quantity * item.price_at_time_of_order,
            ]
            sheet.append(row)

        response = HttpResponse(content_type='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
        response['Content-Disposition'] = f'attachment; filename=Sales_Report_{month}_{year}.xlsx'
        workbook.save(response)

        return response

    except DatabaseError:
        return HttpResponse("Database error occurred while fetching data.", status=500)
