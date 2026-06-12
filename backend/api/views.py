from django.conf import settings
from django.utils import timezone
from rest_framework.response import Response
from rest_framework.views import APIView


class HealthCheckView(APIView):
    def get(self, request):
        return Response(
            {
                "status": "ok",
                "service": settings.API_NAME,
                "time": timezone.now().isoformat(),
            }
        )


class HomeSummaryView(APIView):
    def get(self, request):
        return Response(
            {
                "title": "Density",
                "tagline": "A Flutter app backed by a Python API.",
                "actions": [
                    {
                        "label": "API health",
                        "endpoint": "/api/health/",
                    },
                    {
                        "label": "Home payload",
                        "endpoint": "/api/home/",
                    },
                ],
            }
        )
