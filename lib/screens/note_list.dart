import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app1/model/note.dart';
import 'package:flutter_app1/utils/database_helper.dart';
import 'package:flutter_app1/screens/note_details.dart';
import 'package:sqflite/sqflite.dart';


class NoteList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return NoteListState();
  }
}

class NoteListState extends State<NoteList> {

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {

    if (noteList == null) {
      noteList = List<Note>();
      updateListView(1);
    }

    return Scaffold(

      appBar: AppBar(
        title: Text('Item List'),
      ),

      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Here...',
              ),
              onChanged: (text) {
                updateListView(2, text);
              },
            ),
          ),
      Expanded(
      child: getNoteListView(),
      )],

      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FAB clicked');
          navigateToDetail(Note('', 0, '',0,'',''), 'Add Item');
        },

        tooltip: 'Add Item',

        child: Icon(Icons.add),

      ),
    );
  }

  ListView getNoteListView() {

    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: Text(this.noteList[position].name, style: titleStyle,),
            subtitle:
                Text(' Size: '+(this.noteList[position].size).toString()+
            '\n Size Type: '+this.noteList[position].sizeType+
            '\n Price: '+ (this.noteList[position].price).toString()+
            '\n Color: '+ this.noteList[position].color+
                '\n Made In: '+ this.noteList[position].madeIn),

            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.grey,),
              onTap: () {
                _delete(context, noteList[position]);
              },
            ),


            onTap: () {
              debugPrint("ListTile Tapped");
              navigateToDetail(this.noteList[position],'Edit Item');
            },

          ),
        );
      },
    );
  }


  void _delete(BuildContext context, Note note) async {

    int result = await databaseHelper.deleteNote(note.id);
    if (result != 0) {
      _showSnackBar(context, 'Item Deleted Successfully');
      updateListView(1);
    }
  }

  void _showSnackBar(BuildContext context, String message) {

    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Note note, String title) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetail(note, title);
    }));

    if (result == true) {
      updateListView(1);
    }
  }

  void updateListView(int i, [String search]) {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    if (i == 1) {
      dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }
    else{
      dbFuture.then((database) {
        Future<List<Note>> noteListFuture = databaseHelper.getNoteFilteredList(search);
        noteListFuture.then((noteList) {
          setState(() {
            this.noteList = noteList;
            this.count = noteList.length;
          });
        });
      });
    }
  }
}
