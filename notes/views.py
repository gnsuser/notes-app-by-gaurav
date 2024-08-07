from django.shortcuts import render, redirect
from .models import Note

def add_note_view(request):
    if request.method == 'POST':
        content = request.POST.get('content')
        last_note = Note.objects.all().order_by('note_id').last()
        if last_note:
            new_id = f"N{int(last_note.note_id[1:]) + 1:04}"
        else:
            new_id = "N0001"
        new_note = Note.objects.create(note_id=new_id, content=content)
        return render(request, 'note_added.html', {'note_id': new_note.note_id})
    return render(request, 'add_note.html')

def list_notes_view(request):
    notes = Note.objects.all()
    return render(request, 'list_notes.html', {'notes': notes})
