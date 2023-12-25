import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final double width;
  final IconData icon;
  final String hintText;
  final Function() onSave;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  const MyTextField({
    super.key,
    required this.width,
    required this.icon,
    required this.hintText,
    this.validator,
    required this.onSave,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 50,
          width: 50,
          color: const Color(0xff00264d),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        Column(
          children: [
            const SizedBox(
              height: 2,
            ),
            SizedBox(
              height: 50,
              width: width * 0.6,
              child: TextFormField(
                controller: controller,
                onSaved: onSave(),
                validator: validator,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: const TextStyle(color: Colors.white),
                  fillColor: const Color(0xff385273),
                  filled: true,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
