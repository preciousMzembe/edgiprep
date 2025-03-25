import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove non-digit characters
    String digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Limit input to 12 digits
    if (digitsOnly.length > 12) {
      digitsOnly = digitsOnly.substring(0, 12);
    }

    String formatted = _formatPhoneNumber(digitsOnly);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  String _formatPhoneNumber(String digits) {
    // Ensure safe substring operations
    String part1 = digits.length > 3 ? digits.substring(0, 3) : digits;
    String part2 = digits.length > 6
        ? digits.substring(3, 6)
        : (digits.length > 3 ? digits.substring(3) : '');
    String part3 = digits.length > 9
        ? digits.substring(6, 9)
        : (digits.length > 6 ? digits.substring(6) : '');
    String part4 = digits.length > 12
        ? digits.substring(9, 12)
        : (digits.length > 9 ? digits.substring(9) : '');

    return [part1, part2, part3, part4]
        .where((part) => part.isNotEmpty)
        .join(' ');
  }
}
