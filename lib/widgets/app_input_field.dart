import 'package:flutter/material.dart';
import 'package:world_cup/utility/size_config.dart';

enum AppInputType { password, email }

class AppInputField extends StatefulWidget {
  final String title;
  final FocusNode focusNode;
  final TextEditingController controller;
  final String hint;
  final String? Function(String? value)? validate;
  final void Function()? onEditingComplete;
  final void Function(String? value)? onChange;
  final AppInputType? inputType;
  final double height;
  const AppInputField(
      {super.key,
      required this.title,
      required this.controller,
      required this.focusNode,
      required this.hint,
      this.height = 10,
      this.inputType,
      this.validate,
      this.onEditingComplete,
      this.onChange});

  @override
  State<AppInputField> createState() => _AppInputFieldState();
}

class _AppInputFieldState extends State<AppInputField> {
  bool hasFocus = false;
  bool showText = true;
  @override
  void initState() {
    widget.focusNode.addListener(listToFocusChange);
    super.initState();
  }

  void listToFocusChange() {
    setState(() {
      hasFocus = widget.focusNode.hasFocus;
    });
  }

  togglePassowrd() {
    setState(() {
      showText = !showText;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(widget.title),
      const Padding(padding: EdgeInsets.only(bottom: 10)),
      Container(
        height: getPercentScreenHeight(widget.height),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            border: Border.all(
                color: hasFocus
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
                width: hasFocus ? 2 : 0)),
        child: TextFormField(
          onTap: () {
            widget.focusNode.requestFocus();
          },
          controller: widget.controller,
          focusNode: widget.focusNode,
          validator: widget.validate,
          onChanged: widget.onChange,
          onEditingComplete: widget.onEditingComplete,
          obscureText: !showText,
          decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: suffixIcon,
          ),
        ),
      ),
    ]);
  }

  Widget? get suffixIcon {
    if (widget.inputType == AppInputType.email) {
      return const Icon(Icons.email);
    } else if (widget.inputType == AppInputType.password) {
      return IconButton(
          onPressed: togglePassowrd,
          icon: Icon(showText ? Icons.visibility : Icons.visibility_off));
    } else {
      return null;
    }
  }
}
