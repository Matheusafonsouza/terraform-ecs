from clients.views import ClientViewSet
from rest_framework import routers
from django.contrib import admin
from django.urls import path, include

router = routers.DefaultRouter()
router.register('clients', ClientViewSet, basename='clients')

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include(router.urls)),
]
