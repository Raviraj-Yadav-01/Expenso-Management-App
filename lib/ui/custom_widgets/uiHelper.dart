

import 'package:flutter/material.dart';

InputDecoration myFieldDecoration({
  required String hint,
  required String label,
  bool isPassword = false,
  bool isPasswordVisible = false,
  VoidCallback? onPasswordVisibilityTap

}){

  return InputDecoration(
    hintText: hint,
    labelText:label,
    suffixIcon: isPassword ? IconButton(onPressed: onPasswordVisibilityTap
        , icon: Icon(isPasswordVisible ? Icons.visibility: Icons.visibility_off)) : null,
    border:OutlineInputBorder(
        borderRadius:BorderRadius.circular(21),
    )
  );
}