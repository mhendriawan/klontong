import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

extension NumberParsing on int {
  String toCurrency() => NumberFormat.currency(
        locale: 'ID',
        symbol: 'Rp ',
        decimalDigits: 0,
      ).format(this);

  String toCurrencyLite() => NumberFormat.currency(
        locale: 'ID',
        decimalDigits: 0,
        symbol: '',
      ).format(this);
}

extension DoubleParsing on double {
  String toCurrency() => NumberFormat.currency(
        locale: 'ID',
        symbol: 'Rp ',
        decimalDigits: 0,
      ).format(this);

  String toCurrencyLite() => NumberFormat.currency(
        locale: 'ID',
        decimalDigits: 0,
        symbol: '',
      ).format(this);

  String toDecimalCurrency() => NumberFormat.currency(
        locale: 'ID',
        symbol: 'Rp ',
      ).format(this);

  String toDecimalCurrencyLite() => NumberFormat.currency(
        locale: 'ID',
        symbol: '',
      ).format(this);
}

class CurrencyInputFormatter extends TextInputFormatter {
  final NumberFormat _currencyFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;

    // Remove non-numeric characters
    String value = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (value.isEmpty) return newValue.copyWith(text: 'Rp0');

    // Format to currency
    String newText = _currencyFormat.format(int.parse(value));

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
