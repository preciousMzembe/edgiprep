import 'package:flutter/services.dart';

class PinInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove non-digit characters and spaces
    String digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');

    return TextEditingValue(
      text: digitsOnly,
      selection: TextSelection.collapsed(offset: digitsOnly.length),
    );
  }
}
