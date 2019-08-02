import 'dart:convert';
import 'dart:io';
import 'package:app/src/shared/interceptors/cache_inteceptor.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  Dio dio;

  LoginService(this.dio) {
//    dio.interceptors.add(CacheInterceptor());
  }

  Future<List<Post>> getPost() async {
    try {
      Response<String> response = await dio.get(
        "https://jsonplaceholder.typicode.com/todos",
      );

      if (Platform.isAndroid || Platform.isIOS) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("Posts", response.data);
      }

      List data = jsonDecode(response.data);
      List<Post> posts = data.map((v) => Post.fromJson(v)).toList();
      return posts;
    } on DioError catch (e) {
      throw "Erro de internet";
    } catch (e) {
      print(e);
      throw "Erro desconhecido";
    }
  }
}

class Post {
  int userId;
  int id;
  String title;
  bool completed;

  Post({this.userId, this.id, this.title, this.completed});

  Post.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['completed'] = this.completed;
    return data;
  }
}
