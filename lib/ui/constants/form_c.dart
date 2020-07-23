import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

final Color cursorColor = const Color(0xFFEA5455);

InputDecoration formDecoration = const InputDecoration(
  prefixIcon: const Icon(
    LineAwesomeIcons.money,
    //color: const Color(0xFF2d2d2d),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: const BorderSide(
      color: const Color(0xFFEA5455),
    ),
  ),
  errorBorder: const OutlineInputBorder(
    borderSide: const BorderSide(
      color: const Color(0xFF2d2d2d),
    ),
  ),
  focusedErrorBorder: const OutlineInputBorder(
    borderSide: const BorderSide(
      color: const Color(0xFFE23744),
    ),
  ),
  enabledBorder: const OutlineInputBorder(
    borderSide: const BorderSide(),
  ),
  labelText: 'Price',
  labelStyle: const TextStyle(
    color: const Color(0xFF696969),
  ),
  hintText: '0.00',
);

InputDecoration formPeriodDataDecoration = const InputDecoration(
  focusedBorder: const OutlineInputBorder(
    borderSide: const BorderSide(
      color: const Color(0xFFEA5455),
    ),
  ),
  errorBorder: const OutlineInputBorder(
    borderSide: const BorderSide(
      color: const Color(0xFF2d2d2d),
    ),
  ),
  focusedErrorBorder: const OutlineInputBorder(
    borderSide: const BorderSide(
      color: const Color(0xFFE23744),
    ),
  ),
  enabledBorder: const OutlineInputBorder(
    borderSide: const BorderSide(),
  ),
  labelText: 'Every',
  labelStyle: const TextStyle(
    color: const Color(0xFF696969),
  ),
  hintText: '1',
);

InputDecoration formPayDateDecoration(dateCtl, context) {
  return InputDecoration(
    prefixIcon: const Icon(LineAwesomeIcons.calendar),
    focusedBorder: const OutlineInputBorder(
      borderSide: const BorderSide(),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: const BorderSide(
        color: const Color(0xFFE23744),
      ),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: const BorderSide(),
    ),
    labelStyle: const TextStyle(color: Color(0xFF696969)),
    suffixIcon: IconButton(
      icon: const Icon(
        LineAwesomeIcons.trash_o,
      ),
      onPressed: () {
        dateCtl.clear();
        FocusScope.of(context).unfocus();
      },
    ),
    labelText: "Payment Date",
  );
}
