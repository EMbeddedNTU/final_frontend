import 'package:flutter/material.dart';

class CustomTextBox extends StatefulWidget {
  CustomTextBox(
      {Key? key,
      required this.onSubmitted,
      this.hint = "",
      this.prefix,
      this.suffix})
      : super(key: key);

  final String hint;
  final Widget? prefix;
  final Widget? suffix;
  final ValueChanged<String> onSubmitted;

  @override
  CustomTextBoxState createState() => CustomTextBoxState();
}

class CustomTextBoxState extends State<CustomTextBox> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(bottom: 3),
      height: 44,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10)),
      child: TextField(
        controller: controller,
        onSubmitted: widget.onSubmitted,
        decoration: InputDecoration(
            prefixIcon: widget.prefix,
            suffixIcon: widget.suffix,
            border: InputBorder.none,
            hintText: widget.hint,
            hintStyle: const TextStyle(color: Colors.black, fontSize: 15)),
      ),
    );
  }
}
