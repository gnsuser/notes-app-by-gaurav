from django.db import models

class Note(models.Model):
    note_id = models.CharField(max_length=5, unique=True)
    content = models.TextField()

    def __str__(self):
        return f"{self.note_id}: {self.content}"
