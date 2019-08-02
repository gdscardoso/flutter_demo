import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class LoginWidget extends StatelessWidget {
  final Function onChange;
  final String label;
  final String placeholder;
  final bool obscure;
  final Stream stream;
  final String mask;
  MaskedTextController controller;

  LoginWidget({Key key, this.onChange, this.label, this.placeholder, this.obscure = false, this.stream, this.mask}) {
    if (this.mask != null) controller = MaskedTextController(mask: this.mask);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: stream,
        builder: (context, snapshot) {
          print(snapshot.data);
          return TextField(
            maxLength: this.controller != null ? this.controller.mask.length : null,
            controller: controller,
            onChanged: onChange,
            keyboardType: TextInputType.text,
            obscureText: obscure,
            autofocus: true,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: placeholder,
              labelText: label,
              errorText: snapshot.error,
            ),
          );
        });
  }
}
