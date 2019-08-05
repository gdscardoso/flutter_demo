import 'package:app/src/login/login_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var bloc = BlocProvider.getBloc<LoginBloc>();

  @override
  Widget build(BuildContext context) {
    print('build LoginPage');
    return Container();

//    return Scaffold(
//        appBar: AppBar(
//          title: Text("Carrinho"),
//        ),
//        floatingActionButton: FloatingActionButton(
//          onPressed: () => bloc.login(context),
//          child: Icon(Icons.refresh),
//        ),
//        body: SingleChildScrollView(
//          child: Container(
//            height: MediaQuery.of(context).size.height,
//            padding: EdgeInsets.all(10),
//            child: Column(
//              mainAxisSize: MainAxisSize.max,
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                LoginWidget(
//                  mask: "000.000.000-00",
//                  stream: bloc.form.value("username"),
//                  label: "Usuario",
//                  onChange: bloc.form.change("username"),
//                  placeholder: "Infome a usuario",
//                ),
//                SizedBox(
//                  height: 10,
//                ),
//                LoginWidget(
//                  stream: bloc.form.value("password"),
//                  label: "Senha",
//                  onChange: bloc.form.change("password"),
//                  placeholder: "Infome a senha",
//                  obscure: true,
//                ),
//                SizedBox(
//                  height: 20.0,
//                ),
//                StreamBuilder<bool>(
//                  stream: bloc.form.isValid,
//                  builder: (context, snapshot) => RaisedButton(
//                    color: Colors.tealAccent,
//                    onPressed: snapshot.hasData ? () => bloc.login(context) : null,
//                    child: Text("Submit"),
//                  ),
//                ),
//              ],
//            ),
//          ),
//        ));
  }
}
