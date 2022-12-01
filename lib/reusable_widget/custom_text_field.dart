import 'package:flutter/material.dart';
import '../colors.dart';

class CustomTextFieldSettingWidget extends StatelessWidget {
  final double widthSized;
  final Color colorsBorder;
  final String hintText;
  final String prefixText;
  const CustomTextFieldSettingWidget({
    required this.colorsBorder,
    required this.widthSized,
    required this.hintText,
    required this.prefixText,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthSized,
      child: TextField( // Textfield ubah Nama
        textAlign: TextAlign.end,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: colorsBorder),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: colorsBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: colorsBorder),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1,)
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1,color: Colors.black)
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1,color: Colors.yellowAccent)
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 14,
            color: Color(0xFFB3B1B1)
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 10, top: 15),
            child: Text(
              prefixText,
              style: TextStyle(
                color: textFieldGreen,
                fontSize: 14
              ),
            ),
          ),
        ),
      ),
    );
  }
}