from django.apps import apps
from django.test import TestCase
from analytics_app.apps import AnalyticsAppConfig

class AnalyticsAppConfigTest(TestCase):
    def test_app_config(self):
        self.assertEqual(AnalyticsAppConfig.name, 'analytics_app')
        self.assertEqual(apps.get_app_config('analytics_app').name, 'analytics_app')

    def test_default_auto_field(self):
        app_config = apps.get_app_config('analytics_app')
        self.assertEqual(app_config.default_auto_field, 'django.db.models.BigAutoField')
