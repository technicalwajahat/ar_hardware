import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditProductFields extends StatefulWidget {
  final String name;
  final bool enabled;
  final String regExp;
  final String validator;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController controller;

  const EditProductFields({
    super.key,
    required this.name,
    required this.regExp,
    required this.validator,
    required this.textInputType,
    required this.controller,
    required this.textInputAction,
    required this.enabled,
  });

  @override
  State<EditProductFields> createState() => _EditProductFieldsState();
}

class _EditProductFieldsState extends State<EditProductFields> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      keyboardType: widget.textInputType,
      enabled: widget.enabled,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
        FilteringTextInputFormatter.allow(RegExp(widget.regExp)),
      ],
      validator: (value) {
        if (value!.isEmpty) {
          return (widget.validator);
        }
        return null;
      },
      onSaved: (value) {
        widget.controller.text = value!;
      },
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: widget.name,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
