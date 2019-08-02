import 'dart:async';
import 'package:app/src/produtos/produtos_page.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:app/src/login/login_service.dart';
import 'package:app/src/login/login_validators.dart';

class LoginBloc extends BlocBase {
  final LoginService api;

  LoginBloc(this.api);

  final FormState form = FormState({
    "username": ValueState<String>(validator: LoginValidators.userValidator),
    "password": ValueState<String>(validator: LoginValidators.passwordValidator),
  });

  login(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProdutosPage()));
  }

  void dispose() {
    form.dispose();
    print("dispose LoginBloc");
  }
}

class ValueState<T> {
  Function validator;

  ValueState({this.validator});

  final valueController = BehaviorSubject<T>();

  Stream<T> get value => validator != null
      ? valueController?.transform(StreamTransformer.fromHandlers(handleData: validator))
      : valueController.stream;

  Function(T) get valueChange => valueController.sink.add;

  dispose() {
    valueController.close();
  }
}

class FormState {
  final Map<String, ValueState> mapValueState;

  Stream<bool> get isValid => Observable.combineLatestList(mapValueState.values.map((f) => f.value)).map((f) => true);

  FormState(this.mapValueState);

  value(String key) {
    return mapValueState[key].value;
  }

  change(String key) {
    return mapValueState[key].valueChange;
  }

  dispose() {
    mapValueState.forEach((k, v) {
      mapValueState[k].dispose();
    });
  }
}
