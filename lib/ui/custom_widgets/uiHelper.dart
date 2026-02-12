

import 'package:flutter/material.dart';

InputDecoration myFieldDecoration({
  required String hint,
  required var sHint,
  required String label,
  required var sLabel,
  bool isPassword = false,
  bool isPasswordVisible = false,
  VoidCallback? onPasswordVisibilityTap,

}){
  return InputDecoration(
    hintText:hint,
    hintStyle: sHint,
    labelText:label,
    labelStyle: sLabel,
    suffixIcon: isPassword ? IconButton(onPressed: onPasswordVisibilityTap, icon: Icon(isPasswordVisible ? Icons.visibility: Icons.visibility_off,color: Colors.white,)) : null,
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(21),
),

  );
}