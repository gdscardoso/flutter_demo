import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class InputField extends StatelessWidget {
  final String name;
  final Icon prefixIcon;
  final String label;
  final String placeholder;
  final bool obscure;
  final String mask;
  final bool required;
  final double maxLength;
  final double minLength;
  MaskedTextController _controller;
  List<FormFieldValidator> validators = [];

  InputField(
      {Key key,
      this.label,
      this.placeholder,
      this.obscure = false,
      this.mask,
      this.prefixIcon,
      this.required = false,
      this.maxLength,
      this.minLength,
      this.name})
      : super(key: key) {
    this._initMaskAndValidators();
  }

  _initMaskAndValidators() {
    if (this.mask != null) _controller = MaskedTextController(mask: this.mask);
    if (this.required) validators.add(FormBuilderValidators.required(errorText: "$label é obrigatório."));
    if (this.maxLength != null)
      validators.add(FormBuilderValidators.maxLength(maxLength,
          errorText: "O tamanho "
              "máximo de $label é ${maxLength.toInt()}."));

    if (this.minLength != null)
      validators.add(FormBuilderValidators.minLength(minLength,
          errorText: "O tamanho "
              "mínimo de $label é ${minLength.toInt()}."));
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      controller: _controller,
      attribute: name != null ? name : label.replaceAll(" ", "").toLowerCase(),
      obscureText: obscure,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(),
        hintText: placeholder,
        labelText: required ? "$label *" : label,
      ),
      validators: validators,
    );
  }
}
