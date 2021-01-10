import 'package:flutter/material.dart';

class SubInfoWidget extends StatelessWidget {
  final String name;
  final String label;
  const SubInfoWidget({this.name, this.label});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 1,
      maxLines: 2,
      style: TextStyle(fontSize: 17),
      initialValue: name,
      readOnly: true,
      decoration: InputDecoration(
        labelStyle: TextStyle(fontSize: 18),
        labelText: label,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
    );
  }
}
