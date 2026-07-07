import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthTextField extends StatefulWidget {
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool? isPassword;
  final String? Function(String?)? validator;
  final String hintText;
  final String text;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.text,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.isPassword,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool isObscureText;
  late bool isNotEntity;

  @override
  void initState() {
    isObscureText = true;
    isNotEntity = widget.controller.text.isNotEmpty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.text, style: Theme.of(context).textTheme.bodyLarge),
        TextFormField(
          validator: widget.validator,
          controller: widget.controller,
          obscureText: widget.isPassword == true ? isObscureText : false,
          decoration: InputDecoration(
            hintText: widget.hintText,
            suffixIcon: widget.isPassword == true
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isObscureText = !isObscureText;
                      });
                    },
                    icon: isObscureText == true
                        ? Icon(Icons.visibility_outlined)
                        : Icon(Icons.visibility_off),
                  )
                : null,
          ),
          keyboardType: widget.keyboardType,
        ),
      ],
    );
  }
}
