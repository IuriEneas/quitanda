import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.labelText,
    required this.icon,
    this.isSecret = false,
    this.inputFormatters,
    this.inputType = TextInputType.text,
    this.initialValue,
    this.readOnly = false,
    this.validator,
    this.controller,
    this.onSaved,
    this.formFieldKey,
  });

  final String labelText;
  final IconData icon;
  final bool isSecret;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType inputType;
  final String? initialValue;
  final bool readOnly;
  final String? Function(String? value)? validator;
  final void Function(String? value)? onSaved;
  final TextEditingController? controller;
  final GlobalKey<FormFieldState>? formFieldKey;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = false;

  @override
  void initState() {
    super.initState();
    isObscure = widget.isSecret;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        key: widget.formFieldKey,
        controller: widget.controller,
        readOnly: widget.readOnly,
        initialValue: widget.initialValue,
        inputFormatters: widget.inputFormatters,
        keyboardType: widget.inputType,
        obscureText: isObscure,
        validator: widget.validator,
        onSaved: widget.onSaved,
        decoration: InputDecoration(
          suffixIcon: widget.isSecret
              ? GestureDetector(
                  child:
                      Icon(isObscure ? Icons.visibility : Icons.visibility_off),
                  onTap: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                )
              : null,
          prefixIcon: Icon(widget.icon),
          labelText: widget.labelText,
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
