import 'package:app/src/login/login_bloc.dart';
import 'package:app/src/login/login_widget.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LoginPage2 extends StatelessWidget {
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
                        initialValue: {"username": "", "password": ""},
                        autovalidate: true,
                        child: Column(
                          children: <Widget>[
                            LoginWidget(
                              prefixIcon: Icon(Icons.security),
                              mask: "000.000.000-00",
                              label: "CPF",
                              placeholder: "Informe o seu CPF.",
                              minLength: 14,
                              required: true,
                            ),
//                            FormBuilderTextField(
//                              controller: MaskedTextController(mask: "000.000.000-00"),
//                              attribute: "username",
//                              decoration: InputDecoration(
//                                border: OutlineInputBorder(),
//                                prefixIcon: Icon(Icons.person),
//                                hintText: "Informe o CPF",
//                                labelText: "CPF",
//                              ),
//                              validators: [
//                                FormBuilderValidators.required(errorText: "CPF obrigatório."),
//                              ],
//                            ),
                            SizedBox(height: (MediaQuery.of(context).size.height / 100) * 2),
                            LoginWidget(
                              prefixIcon: Icon(Icons.security),
                              mask: "@@@@@@",
                              label: "Senha",
                              placeholder: "Informe a sua senha.",
                              obscure: true,
                              maxLength: 6,
                              required: true,
                            ),
//                            FormBuilderTextField(
//                              controller: MaskedTextController(mask: "@@@@@@"),
//                              attribute: "password",
//                              obscureText: true,
//                              decoration: InputDecoration(
//                                prefixIcon: Icon(Icons.security),
//                                border: OutlineInputBorder(),
//                                hintText: "Informe sua senha",
//                                labelText: "Senha",
//                              ),
//                              validators: [
//                                FormBuilderValidators.required(errorText: "Senha obrigatória."),
//                              ],
//                            ),
                          ],
                        ),
                      );
                    }),
                SizedBox(
                  height: 20,
                ),
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
