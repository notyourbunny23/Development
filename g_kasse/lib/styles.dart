import 'package:flutter/material.dart';

final ButtonStyle gButton = ElevatedButton.styleFrom(
  backgroundColor: const Color(0xFFFEF7FF), // Button Background Color
  foregroundColor: Colors.black, // Button Text Color
  elevation: 2,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8.0),
  ),
);

BoxDecoration TextFieldDecoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      color: const Color(0xFF79747E),
      width: 0.1,
    ),
  );
}

TextStyle TextFieldStyle() {
  return TextStyle(
    height: 1,
    fontSize: 14,
  );
}

InputDecoration DropdownDecoration() {
  return InputDecoration(
    isDense: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
}
