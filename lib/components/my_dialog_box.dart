import 'package:flutter/material.dart';

class MyDialogBox {
  void displayDialog({
    required BuildContext context,
    required Widget content,
    required TextEditingController textContoller,
    required String textBtn1,
    required String textBtn2,
    required VoidCallback onPressBtn1,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: content,
            actions: [
              MaterialButton(
                onPressed: () {
                  //save to db
                  onPressBtn1();

                  //close the popup
                  Navigator.pop(context);

                  //clear the contents of controller
                  textContoller.clear();
                },
                child: Text(textBtn1),
              ),
              MaterialButton(
                onPressed: () {
                  //close the popup
                  Navigator.pop(context);
                  //clear the contents of controller
                  textContoller.clear();
                },
                child: Text(textBtn2),
              )
            ],
          );
        });
  }
}
