import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final numericValue = int.tryParse(newValue.text);
    if (numericValue != null) {
      final formattedValue = NumberFormat.decimalPattern('vi_VN').format(numericValue);
      return TextEditingValue(
        text: formattedValue,
        selection: TextSelection.collapsed(offset: formattedValue.length),
      );
    }

    return oldValue;
  }
}
