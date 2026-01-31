import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final IconData? icon;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final double fontSize;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;
  final bool isEmail;
  final VoidCallback? onTap;



  const CustomTextField({
    super.key,
    required this.label,
    this.icon,
    this.isPassword = false,
    required this.controller,
    this.validator,
    this.fontSize = 18,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.isEmail = false,
    this.onTap

  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      readOnly: widget.onTap != null, // makes the field non-editable if onTap is provided
      controller: widget.controller,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      style: TextStyle(
        color: Colors.white,
        fontSize: widget.fontSize,
      ),
      validator: widget.validator,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: const TextStyle(color: Colors.grey),
        prefixIcon: widget.icon != null
            ? Icon(widget.icon, color: Colors.green)
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.green),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.green,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        )
            : widget.onTap != null
            ? IconButton(
          icon: const Icon(Icons.calendar_month, color: Colors.grey),
          onPressed: widget.onTap,
        )
            : null,

      ),
    );
  }
}
