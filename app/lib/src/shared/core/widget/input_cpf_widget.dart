import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class InputCPF extends StatelessWidget {
  final String name;
  final Icon prefixIcon;
  final String label;
  final String placeholder;
  final String mask = "000.000.000-00";
  final bool required;
  MaskedTextController _controller;
  List<FormFieldValidator> validators = [];

  InputCPF({this.name, this.label, this.placeholder, this.prefixIcon, this.required = false}) {
    this._initMaskAndValidators();
  }

  _initMaskAndValidators() {
    if (this.mask != null) _controller = MaskedTextController(mask: this.mask);
    if (this.required) validators.add(FormBuilderValidators.required(errorText: "$label é obrigatório."));
    validators.add(CustomValidators.cpf(errorText: "O CPF digitado não é valido."));
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      controller: _controller,
      attribute: name != null ? name : label.replaceAll(" ", "").toLowerCase(),
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

class CustomValidators extends FormBuilderValidators {
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

  static bool _validarCPF(String cpf) {
    if(cpf == null || cpf.length < 14) return false;

    List<int> sanitizedCPF =
        cpf.replaceAll(new RegExp(r'\.|-'), '').split('').map((String digit) => int.parse(digit)).toList();
    return !_blacklistedCPF(sanitizedCPF.join()) &&
        sanitizedCPF[9] == _gerarDigitoVerificador(sanitizedCPF.getRange(0, 9).toList()) &&
        sanitizedCPF[10] == _gerarDigitoVerificador(sanitizedCPF.getRange(0, 10).toList());
  }

  static bool _blacklistedCPF(String cpf) {
    return cpf == '11111111111' ||
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
