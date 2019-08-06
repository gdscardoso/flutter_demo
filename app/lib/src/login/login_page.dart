import 'package:app/src/login/login_bloc.dart';
import 'package:app/src/shared/core/widget/input_cpf_widget.dart';
import 'package:app/src/shared/core/widget/input_field_widget.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.getBloc<LoginBloc>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                StreamBuilder(
                    stream: bloc.form.value("username"),
                    builder: (context, snapshot) {
                      return FormBuilder(
                        key: _fbKey,
                        autovalidate: true,
                        child: Column(
                          children: <Widget>[
                            InputCPF(
                              name: "username",
                              prefixIcon: Icon(Icons.person),
                              label: "CPF",
                              placeholder: "Informe o seu CPF.",
                              required: true,
                            ),
                            SizedBox(height: (MediaQuery.of(context).size.height / 100) * 2),
                            InputField(
                                name: "password",
                                prefixIcon: Icon(Icons.security),
                                mask: "@@@@@@",
                                label: "Senha",
                                placeholder: "Informe a sua senha.",
                                obscure: true,
                                maxLength: 6,
                                minLength: 6,
                                required: true),
                          ],
                        ),
                      );
                    }),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: OutlineButton(
                        child: Text("Limpar"),
                        onPressed: () {
                          _fbKey.currentState.reset();
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: OutlineButton(
                        padding: EdgeInsets.all(10),
                        child: Text("Entrar"),
                        onPressed: () {
                          _fbKey.currentState.save();
                          if (_fbKey.currentState.validate()) {
                            print(_fbKey.currentState.value);

//                            var login = LoginRequest.fromJson(_fbKey.currentState.value);
//                            print(login.username);
//                            print(login.password);

                            bloc.login(context);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginRequest {
  String username;
  String password;

  LoginRequest({this.username, this.password});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }
}
