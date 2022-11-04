from rest_framework import viewsets

from clients.serializers import ClientSerializer
from clients.models import Client


class ClientViewSet(viewsets.ModelViewSet):
    queryset = Client.objects.all()
    serializer_class = ClientSerializer
