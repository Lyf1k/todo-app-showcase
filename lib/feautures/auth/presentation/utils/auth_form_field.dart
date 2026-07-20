import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthTextField extends StatefulWidget {
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool? isPassword;
  final String? Function(String?)? validator;
  final String hintText;
  final String titleText;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.titleText,
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
  late bool fieldIsNotEmpty;

  @override
  void initState() {
    isObscureText = true;
    fieldIsNotEmpty = true;
    isNotEntity = widget.controller.text.isNotEmpty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.titleText, style: Theme.of(context).textTheme.bodyLarge),
        TextFormField(
          validator:
              widget.validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return "Error correct ${widget.titleText.toLowerCase()}";
                }
                return null;
              },
          onChanged: (value) {
            if (value.isNotEmpty) {}
          },
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
                        ? Icon(
                            Icons.visibility_outlined,
                            color: isNotEntity
                                ? Theme.of(context).primaryColor
                                : null,
                          )
                        : Icon(
                            Icons.visibility_off,
                            color: isNotEntity
                                ? Theme.of(context).primaryColor
                                : null,
                          ),
                  )
                : null,
          ),
          keyboardType: widget.keyboardType,
        ),
      ],
    );
  }
}
