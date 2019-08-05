import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class LoginWidget extends StatelessWidget {
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

  LoginWidget(
      {Key key,
      this.label,
      this.placeholder,
      this.obscure = false,
      this.mask,
      this.prefixIcon,
      this.required = false,
      this.maxLength,
      this.minLength})
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

    if(true)
      validators.add(CustomValidators.cpf(errorText: "O CPF digitado não é valido."));
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      controller: _controller,
      attribute: label.replaceAll(label, " ").toLowerCase(),
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


class CustomValidators extends FormBuilderValidators{

  static FormFieldValidator cpf({
    String errorText = "This cpf cannot be valid.",
  }) {
    return (valueCandidate) {
      if (!_validarCPF(valueCandidate)) {
        return errorText;
      }

      return null;
    };

  }

  static bool _validarCPF(String cpf){
    List<int> sanitizedCPF = cpf
        .replaceAll(new RegExp(r'\.|-'), '')
        .split('')
        .map((String digit) => int.parse(digit))
        .toList();
    return !_blacklistedCPF(sanitizedCPF.join()) &&
        sanitizedCPF[9] == _gerarDigitoVerificador(sanitizedCPF.getRange(0, 9).toList()) &&
        sanitizedCPF[10] == _gerarDigitoVerificador(sanitizedCPF.getRange(0, 10).toList());
  }

  static bool _blacklistedCPF(String cpf) {
    return
      cpf == '11111111111' ||
          cpf == '22222222222' ||
          cpf == '33333333333' ||
          cpf == '44444444444' ||
          cpf == '55555555555' ||
          cpf == '66666666666' ||
          cpf == '77777777777' ||
          cpf == '88888888888' ||
          cpf == '99999999999';
  }

  static int _gerarDigitoVerificador(List<int> digits) {
    int baseNumber = 0;
    for (var i = 0; i < digits.length; i++) {
      baseNumber += digits[i] * ((digits.length + 1) - i);
    }
    int verificationDigit = baseNumber * 10 % 11;
    return verificationDigit >= 10 ? 0 : verificationDigit;
  }

}
