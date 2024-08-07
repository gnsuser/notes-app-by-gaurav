from django.urls import path
from . import views

urlpatterns = [
    path('', views.add_note_view, name='add_note'),
    path('notes/', views.list_notes_view, name='list_notes'),
]
