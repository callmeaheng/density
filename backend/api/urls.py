from django.urls import path

from .views import HomeSummaryView, HealthCheckView

urlpatterns = [
    path("health/", HealthCheckView.as_view(), name="health-check"),
    path("home/", HomeSummaryView.as_view(), name="home-summary"),
]
