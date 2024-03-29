import 'dart:convert';
import 'dart:io';

import 'package:app/src/shared/interceptors/cache_inteceptor.dart';
import 'package:app/src/shared/models/produto.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/src/produtos/produtos_bloc.dart';

class GeneralApi {
  Dio dio;

  GeneralApi(this.dio) {
    dio.interceptors.add(CacheInterceptor());
  }

  Future<List<Produto>> getProducts() async {
    try {
      Response response = await dio.get(
        "https://raw.githubusercontent.com/gdscardoso/flutter_demo/master/backend/products.json",
      );
      if (Platform.isAndroid || Platform.isIOS) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("Produto", response.data);
      }

      List data = jsonDecode(response.data);
      List<Produto> produtos = data.map((v) => Produto.fromJson(v)).toList();
      return produtos;

    } on DioError catch (e) {
      throw "Erro de internet";
    } catch (e) {
      throw "Erro desconhecido";
    }
  }
}
