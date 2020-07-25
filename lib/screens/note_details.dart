import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app1/model/note.dart';
import 'package:flutter_app1/utils/database_helper.dart';
import 'package:intl/intl.dart';

class NoteDetail extends StatefulWidget {

  final String appBarTitle;
  final Note note;

  NoteDetail(this. note, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {

    return NoteDetailState(this.note, this.appBarTitle);
  }
}

class NoteDetailState extends State<NoteDetail> {

  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Note item;

  TextEditingController nameController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController sizeTypeController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController madeInController = TextEditingController();


  NoteDetailState(this.item, this.appBarTitle);

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;

    nameController.text = item.name;
    sizeController.text = (item.size).toString();
    sizeTypeController.text = item.sizeType;
    priceController.text = (item.price).toString();
    colorController.text = item.color;
    madeInController.text = item.madeIn;

    return WillPopScope(

        onWillPop: () {
          // Write some code to control things, when user press Back navigation button in device navigationBar
          moveToLastScreen();
        },

        child: Scaffold(
          appBar: AppBar(
            title: Text(appBarTitle),
            leading: IconButton(icon: Icon(
                Icons.arrow_back),
                onPressed: () {
                  // Write some code to control things, when user press back button in AppBar
                  moveToLastScreen();
                }
            ),
          ),

          body: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[

                // First Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: nameController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in Name Text Field');
                      updateName();
                    },
                    decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),

                // Second Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: sizeController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in Size Text Field');
                      updateSize();
                    },
                    decoration: InputDecoration(
                        labelText: 'Size',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),

                // third Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: sizeTypeController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in size Type Text Field');
                      updateSizeType();
                    },
                    decoration: InputDecoration(
                        labelText: 'Size Type',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),
                // Fourth Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: priceController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in Price Text Field');
                      updatePrice();
                    },
                    decoration: InputDecoration(
                        labelText: 'Price',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),
                // 5th Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: colorController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in Color Text Field');
                      updateColor();
                    },
                    decoration: InputDecoration(
                        labelText: 'Color',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),
                // 6th Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: madeInController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in Made In Text Field');
                      updateMadeIn();
                    },
                    decoration: InputDecoration(
                        labelText: 'Made In',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),
                //7th   Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Save',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint("Save button clicked");
                              _save();
                            });
                          },
                        ),
                      ),

                      Container(width: 5.0,),

                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Delete',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint("Delete button clicked");
                              _delete();
                            });
                          },
                        ),
                      ),

                    ],
                  ),
                ),

              ],
            ),
          ),

        ));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  // Convert the String priority in the form of integer before saving it to Database

  // Update the title of Note object
  void updateName(){
    item.name = nameController.text;
  }

  // Update the description of Note object
  void updateSize() {
    item.size = double.parse(sizeController.text);
  }
  void updateSizeType(){
    item.sizeType = sizeTypeController.text;
  }
  void updatePrice() {
    item.price = double.parse(priceController.text);
  }
  void updateColor(){
    item.color = colorController.text;
  }
  void updateMadeIn(){
    item.madeIn = madeInController.text;
  }
  // Save data to database
  void _save() async {

    moveToLastScreen();

    int result;
    if (item.id != null) {  // Case 1: Update operation
      result = await helper.updateNote(item);
    } else { // Case 2: Insert Operation
      result = await helper.insertNote(item);
    }

    if (result != 0) {  // Success
      _showAlertDialog('Status', 'Item Saved Successfully');
    } else {  // Failure
      _showAlertDialog('Status', 'Problem Saving Item');
    }

  }

  void _delete() async {

    moveToLastScreen();

    // Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
    // the detail page by pressing the FAB of NoteList page.
    if (item.id == null) {
      _showAlertDialog('Status', 'No Item was deleted');
      return;
    }

    // Case 2: User is trying to delete the old note that already has a valid ID.
    int result = await helper.deleteNote(item.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Item Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Item');
    }
  }

  void _showAlertDialog(String title, String message) {

    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog
    );
  }

}