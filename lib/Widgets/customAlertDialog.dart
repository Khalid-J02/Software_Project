import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../classes/language_constants.dart';
import 'dart:ui' as ui;

class CustomAlertDialog {
  static void showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: translation(context)!.localeName == 'ar'
              ? ui.TextDirection.rtl
              : ui.TextDirection.ltr,
          child: AlertDialog(
            title: Text(translation(context)!.customError),
            content: Text(errorMessage),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(translation(context)!.customOk),
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<String?> showDeclineReasonDialog(BuildContext context) async {
    TextEditingController reasonController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: translation(context)!.localeName == 'ar'
              ? ui.TextDirection.rtl
              : ui.TextDirection.ltr,
          child: AlertDialog(
            title: Text(translation(context)!.customDeclineTitle),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(translation(context)!.customDeclineReason),
                  TextFormField(
                    controller: reasonController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return translation(context)!.customDeclineReasonLabel;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: translation(context)!.customDeclineReasonHint,
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text(translation(context)!.customDeclineReasonCancel),
              ),
              TextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.of(context).pop(reasonController
                        .text); // Close the dialog and return the reason
                  }
                },
                child: Text(translation(context)!.customDeclineReasonSubmit),
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<bool> showConfirmationDialog(BuildContext context) async {
    final bool? shouldAccept = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: translation(context)!.localeName == 'ar'
              ? ui.TextDirection.rtl
              : ui.TextDirection.ltr,
          child: AlertDialog(
            title: Text(translation(context)!.customAcceptTitle),
            content: Text(translation(context)!.customAcceptText),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(translation(context)!.customAcceptYes),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(translation(context)!.customAcceptNo),
              ),
            ],
          ),
        );
      },
    );

    return shouldAccept ?? false;
  }

  static Future<bool?> showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: translation(context)!.localeName == 'ar'
              ? ui.TextDirection.rtl
              : ui.TextDirection.ltr,
          child: AlertDialog(
            title: Text(translation(context)!.customLogoutConfirmation),
            content: Text(translation(context)!.customLogoutContent),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text(translation(context)!.customLogout),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // Cancel logout
                },
                child: Text(translation(context)!.customCancel),
              ),
            ],
          ),
        );
      },
    );
  }

  static void showErrorDialogForTask16(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: translation(context)!.localeName == 'ar'
              ? ui.TextDirection.rtl
              : ui.TextDirection.ltr,
          child: AlertDialog(
            title: Text(translation(context)!.customStaticTaskTitle),
            content: Text(errorMessage),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(translation(context)!.customOk),
              ),
            ],
          ),
        );
      },
    );
  }

  static void showSuccessDialog(BuildContext context, String successMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: translation(context)!.localeName == 'ar'
              ? ui.TextDirection.rtl
              : ui.TextDirection.ltr,
          child: AlertDialog(
            title: Text(translation(context)!.customSuccess),
            content: Text(successMessage),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(translation(context)!.customOk),
              ),
            ],
          ),
        );
      },
    );
  }

  static void showSuccessDialogforReset(BuildContext context, String successMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: translation(context)!.localeName == 'ar'
              ? ui.TextDirection.rtl
              : ui.TextDirection.ltr,
          child: AlertDialog(
            title: Text(translation(context)!.customSuccess),
            content: Text(successMessage),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .pushReplacementNamed('/Login');
                },
                child: Text(
                    translation(context)!.customOk),
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<void> showParallelTasksDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: translation(context)!.localeName == 'ar'
              ? ui.TextDirection.rtl
              : ui.TextDirection.ltr,
          child: AlertDialog(
            title: Text(translation(context)!.customParallelTasksTitle),
            content: Text(translation(context)!.customParallelTasksContent),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(translation(context)!.customOk)),
            ],
          ),
        );
      },
    );
  }

  static Future<String?> showExpectedStartDatefortheTask(BuildContext context) async {
    TextEditingController dateController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2024),
        lastDate: DateTime(2026),
      );
      if (picked != null) {
        dateController.text = DateFormat('dd MMM, yyyy').format(picked);
        formKey.currentState?.validate();
      }
    }

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: translation(context)!.localeName == 'ar'
              ? ui.TextDirection.rtl
              : ui.TextDirection.ltr,
          child: AlertDialog(
            title: Text(translation(context)!.customExpectedDateTitle),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(translation(context)!.customExpectedDateContent),
                  TextFormField(
                    controller: dateController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return translation(context)!.customExpectedDateError;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: translation(context)!.customExpectedDateHint,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () => _selectDate(context),
                      ),
                    ),
                    readOnly: true, // Prevents keyboard from opening
                    onTap: () => _selectDate(context),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(translation(context)!.customCancel),
              ),
              TextButton(
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    Navigator.of(context).pop(dateController.text);
                  }
                },
                child: Text(translation(context)!.customSubmit),
              ),
            ],
          ),
        );
      },
    );
  }
}
