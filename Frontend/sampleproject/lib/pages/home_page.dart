import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleproject/models/note.dart';
import 'package:sampleproject/pages/add_new_note.dart';
import 'package:sampleproject/providers/notes_provider.dart';

class HomePage extends StatefulWidget{
  const HomePage({ Key ? key}) : super(key: key);

  @override
  _HomePageState createState()=> _HomePageState();
}

class _HomePageState extends State<HomePage>{

  String searchQuery="";

  @override
  Widget build(BuildContext context){
    NotesProvider notesProvider=Provider.of<NotesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title:const Text("TaskiT"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: (notesProvider.notes.length>0) ? ListView(
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                autofocus: false,
                onChanged: (val) {
                  setState(() {
                    searchQuery=val;
                  });
                },
                decoration: const InputDecoration(
                  hintText: "Search Task..."
                ),
              ),
            ),

            (notesProvider.getFilteredNotes(searchQuery).length > 0) ? GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2
              ),
              itemCount:notesProvider.getFilteredNotes(searchQuery).length,
              itemBuilder: (context, index){
                Note currentNote=notesProvider.getFilteredNotes(searchQuery)[index];
                return GestureDetector(
                  
                  onTap: (){
                    //Update
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context)=> AddNewNotePage(isUpdate: true, note: currentNote,)
                      ),
                    );
                  },
                  onLongPress: (){
                    //Delete
                    notesProvider.deleteNote(currentNote);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.blue,
                        width: 2
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(currentNote.title!, 
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20,)
                        ,maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 7,),
                        Text(currentNote.content!, 
                        style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 63, 63, 63)),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ): const Padding(
              padding: EdgeInsets.all(8),
              child: Text("No Tasks Found", textAlign: TextAlign.center,),
            ), 
          ],
        ) : const Center(
            child: Text(
            "\"The best time to start was yesterday. The next best time is NOW.\"",
            style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.blue,
          ),
          textAlign: TextAlign.center,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ),

        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(
              context,
              CupertinoPageRoute(
                fullscreenDialog: true,
                builder: (context)=>const AddNewNotePage(isUpdate: false,)
                ),
            );
          },
          child: const Icon(Icons.add),
        ),
      );
  }
}
