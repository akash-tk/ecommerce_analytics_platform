# E-Commerce Analytics Platform

This project is an advanced e-commerce analytics platform built using Django. It provides insightful analytics for sales data, customer behavior, and inventory management for an e-commerce company operating in multiple countries.

## Features

- **Complex Data Models:** 
  - Products, Orders, OrderItems, Customers, Inventory.
  - Custom managers, signals, and methods for managing relationships and business logic.
  
- **Advanced Business Logic:**
  - Sales analytics to calculate revenue by category, top-selling products, and customer churn rate.
  - Product recommendations based on customer purchase history, similar customer behavior, and current inventory.

- **Excel Export Functionality:**
  - Export monthly sales reports using the `openpyxl` library.

- **RESTful API:**
  - Built using Django Rest Framework.
  - JWT-based token authentication for secure access.
  - API endpoints to manage sales data, customers, and inventory.

- **Unit Testing:** 
  - Comprehensive unit tests.

- **API Documentation:** 
  - Auto-generated API documentation using drf-yasg, available via Swagger and Redoc.

## Prerequisites

Make sure you have the following installed:

- Python 3.8+
- Django 4.x+
- MySQL
- [openpyxl](https://openpyxl.readthedocs.io/) for Excel functionality
- Django Rest Framework
- drf-yasg for API documentation
- JWT Authentication with `djangorestframework-simplejwt`

## Setup Instructions

1. **Clone the repository:**

   ```bash
   git clone https://github.com/akash-tk/ecommerce_analytics_platform.git
   cd ecommerce_analytics_platform
   ```

2. **Set up a virtual environment:**

   ```bash
   python3 -m venv venv
   source venv/bin/activate  # For Linux/macOS
   # or
   venv\Scripts\activate  # For Windows
   ```

3. **Install dependencies:**

   Install the required Python packages listed in `requirements.txt`:

   ```bash
   pip install -r requirements.txt
   ```

4. **Configure the database:**

   Create a .env file in the root directory of your project with the following content:

   ```python
    # .env

    # Django settings
    SECRET_KEY=your_secret_key_here
    DEBUG=True  # Set to False in production

    # Database settings
    DATABASE_ENGINE=django.db.backends.mysql
    DATABASE_NAME=your_database_name_here
    DATABASE_USER=your_database_user_here
    DATABASE_PASSWORD=your_database_password_here
    DATABASE_HOST=localhost
    DATABASE_PORT=3306

   ```

   Open the settings.py file and ensure that the database settings use the values from the .env file. Your settings.py should look like this:

   ```
    from pathlib import Path
    from decouple import config

    BASE_DIR = Path(__file__).resolve().parent.parent

    SECRET_KEY = config('SECRET_KEY')
    DEBUG = config('DEBUG', default=False, cast=bool)

    DATABASES = {
      'default': {
          'ENGINE': config('DATABASE_ENGINE'),
          'NAME': config('DATABASE_NAME'),
          'USER': config('DATABASE_USER'),
          'PASSWORD': config('DATABASE_PASSWORD'),
          'HOST': config('DATABASE_HOST', default='localhost'),
          'PORT': config('DATABASE_PORT', default='3306'),
      }
    }

   ```

   After configuring the database, run the migrations:

   ```bash
   python manage.py migrate
   ```

6. **Create a superuser:**

   ```bash
   python manage.py createsuperuser
   ```

7. **Run the development server:**

   ```bash
   python manage.py runserver
   ```

   The application should now be running on `http://127.0.0.1:8000/`.

## API Endpoints

- **Products:**
  - List: `GET /api/products/`
  - Create: `POST /api/products/`
  
- **Customers:**
  - List: `GET /api/customers/`
  - Create: `POST /api/customers/`

- **Orders:**
  - List: `GET /api/orders/`
  - Create: `POST /api/orders/`

- **Sales Analytics:**
  - Revenue by Category: `GET /api/analytics/sales/?type=revenue_by_category&start_date=<start_date:YYYY-MM-DD>&end_date=<end_date:YYYY-MM-DD>`
  - Top Selling Products: `GET /api/analytics/sales/?type=top_selling_products&country=<country>&start_date=<start_date:YYYY-MM-DD>&end_date=<end_date:YYYY-MM-DD>`
  - Customer Churn Rate: `GET /api/analytics/sales/?type=churn_rate`

- **Recommendations:**
  - Product Recommendations based on Order History: `GET /api/recommendations/<int:customer_id>/?type=history/`
  - Product Recommendations based on Current Inventory: `GET /api/recommendations/<int:customer_id>/?type=inventory/`
  - Product Recommendations based on Similar Customers: `GET /api/recommendations/<int:customer_id>/?type=similar_customers/`
  - Customer Lifetime Value: `GET /api/customer/<int:customer_id>/clv/`
  - Tax Calculation: `GET /api/order/<int:order_id>/tax/`

- **Export Sales Report:**
  - `GET /api/export-sales/<month>/<year>/`

- **JWT Authentication:**
  - Obtain Token: `POST /api/token/`
  - Refresh Token: `POST /api/token/refresh/`

## Date Format

The date format for the API endpoints is `YYYY-MM-DD`.

## API Documentation

API documentation is available in two formats:
- **Swagger:** Visit `http://127.0.0.1:8000/swagger/`
- **Redoc:** Visit `http://127.0.0.1:8000/redoc/`

## Testing

To run the unit tests for the project, use the following command:

```bash
python manage.py test
```

## Key Design Decisions

1. **Sales Analytics & Recommendation Engine:**
   - Separated into their own classes within the `business_logic.py` file for modularity and testability.
   - Sales analytics includes revenue calculations, top-selling products, and churn rate analysis.
   - Product recommendations are based on customer purchase history, similar customer behavior, and current inventory.

2. **Customer Lifetime Value & Tax Calculation:**
   - Implemented methods to calculate customer lifetime value and tax based on the customer's country.

3. **Excel Export:**
   - Implemented using the `openpyxl` library to export monthly sales reports.

4. **JWT Authentication:**
   - Used `djangorestframework-simplejwt` for secure API access.
   - Tokens provide short-lived access to endpoints, improving security.
