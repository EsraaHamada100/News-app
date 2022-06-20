import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
class DioHelper {
  // this is our link that we will get data from
  //   https://newsapi.org/v2/top-headlines?countery=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca

  static Dio? dio;

  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  // here I use this to retrieve data note that the url != baseUrl
  static Future<Response> getData({required String url, required Map<String, dynamic> query}) async{
    return await dio!.get(url, queryParameters: query);
  }



}