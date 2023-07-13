import 'package:flutter/cupertino.dart';
import 'package:sampleproject/models/note.dart';
import 'package:sampleproject/services/api_service.dart';

class NotesProvider with ChangeNotifier{

  List<Note> notes=[];

  NotesProvider(){
    fetchNotes();
  }

  void sortNotes(){
    notes.sort((a,b)=> b.dateadded!.compareTo(a.dateadded!));
  }

  List<Note> getFilteredNotes(String searchQuery){
    return notes.where((element) => element.title!.toLowerCase().contains(searchQuery.toLowerCase())
    || element.content!.toLowerCase().contains(searchQuery.toLowerCase())).toList();
  }

  void addNote(Note note){
    notes.add(note);
    sortNotes();
    //First show  the changes to the UI
    notifyListeners();
    //Then update in API
    ApiService.addNote(note);
  }

  void updateNote(Note note){
    int indexOfNote=notes.indexOf(notes.firstWhere((element) => element.id==note.id));
    notes[indexOfNote]=note;
    sortNotes();
    notifyListeners();
    ApiService.addNote(note);
  }

  void deleteNote(Note note){
    int indexOfNote=notes.indexOf(notes.firstWhere((element) => element.id==note.id));
    notes.removeAt(indexOfNote);
    sortNotes();
    notifyListeners();
    ApiService.deleteNote(note);
  }

  void fetchNotes() async{
    notes = await ApiService.fetchNotes("farhaanareeb03@gmail.com");
    sortNotes();
    notifyListeners();
  }

}