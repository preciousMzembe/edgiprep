import 'package:edgiprep/components/close_quiz.dart';
import 'package:edgiprep/components/loading.dart';
import 'package:flutter/material.dart';

// loading
Future<void> showLoadingDialog(
    BuildContext context, String title, String subTitle) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              LoadingPane(
                title: title,
                subTitle: subTitle,
              )
            ],
          ),
        ),
      );
    },
  );
}

// close
Future<void> showCloseQuizDialog(
    BuildContext context, String title, String subTitle, Function close) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              CloseQuizPane(
                title: title,
                subTitle: subTitle,
                close: close,
              )
            ],
          ),
        ),
      );
    },
  );
}
