import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/src/login/login_widget.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class LoginPage2 extends StatefulWidget {
  @override
  _LoginPage2State createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {
//  var bloc = BlocProvider.getBloc<LoginBloc>();

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    print('build LoginPage');

    return Scaffold(
      appBar: AppBar(
        title: Text("Carrinho"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              FormBuilder(
                key: _fbKey,
                initialValue: {
                  "username": "",
                  "password": ""
                },
                autovalidate: true,
                child: Column(
                  children: <Widget>[
                    FormBuilderTextField(
                      attribute: "username",
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Informe o CPF",
                        labelText: "CPF",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FormBuilderTextField(
                      attribute: "password",
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Informe o Senha",
                        labelText: "Senha",
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  MaterialButton(
                    child: Text("Submit"),
                    onPressed: () {
                      _fbKey.currentState.save();
                      if (_fbKey.currentState.validate()) {
                        var login = LoginRequest.fromJson(_fbKey.currentState.value);
                      }
                    },
                  ),
                  MaterialButton(
                    child: Text("Reset"),
                    onPressed: () {
                      _fbKey.currentState.reset();
                    },
                  ),
                ],
              )
            ],
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
