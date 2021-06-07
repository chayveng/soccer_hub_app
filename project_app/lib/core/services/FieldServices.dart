import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_app/core/apis/ApiConnect.dart';
import 'package:project_app/core/apis/FieldApi.dart';
import 'package:project_app/core/models/ApiResponse.dart';
import 'package:project_app/core/models/Field.dart';

import '../Config.dart';

class FieldServices {
  static Future<List<Field>> findAll() async {
    ApiResponse response = await FieldApi.findAll();
    List dataList = jsonDecode(jsonEncode(response.data));
    return fieldsFromJson(dataList);
  }

  static Future<Field> findById(int fieldId) async {
    ApiResponse response = await FieldApi.findById(fieldId);
    Field field = fieldFromJson(jsonEncode(response.data));
    return field;
  }

  static Future<bool> create(
    GlobalKey<FormState> formKey,
    Field field,
    List images,
  ) async {
    print('create');
    bool status = false;
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await FieldApi.create(field).then((value) {
        if (value.status == 1) {
          Field _field = fieldFromJson(jsonEncode(value.data));
          uploadImages(_field.id!, images);
          status = true;
        }
        print(value);
      });
    }
    return status;
  }

  static Future<bool> update(
    GlobalKey<FormState> formKey,
    Field field,
    List images,
  ) async {
    print('update');
    bool status = false;
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await FieldApi.update(field).then((value) {
        if (value.status == 1) {
          Field _field = fieldFromJson(jsonEncode(value.data));
          uploadImages(_field.id!, images);
          status = true;
        }
        print(value);
      });
    }
    return status;
  }

  static Future<void> uploadImages(int fieldId, List images) async {
    FormData data = FormData.fromMap({"fieldId": fieldId});
    for (var i = 0; i < images.length; i++) {
      data.files.addAll([
        MapEntry(
            "files", MultipartFile.fromBytes(images[i], filename: '$i.png')),
      ]);
    }
    await FieldApi.uploadImages(data).then((value) => print(value));
  }

  static Future<List<Uint8List>> downloadImages(int fieldId) async {
    List<Uint8List> images = [];
    String path = '/field/urlImages/$fieldId';
    var res = await ApiConnect.get(path: path);
    List urlImages = jsonDecode(jsonEncode(res));
    for (var url in urlImages) {
      await http.get(url).then((value) {
        images.add(value.bodyBytes);
      });
    }
    print(images.length);
    return images;
  }

  static Future<List<Field>> getByUserId(int userId) async {
    ApiResponse response = await FieldApi.findByUserId(userId);
    List dataList = jsonDecode(jsonEncode(response.data));
    return fieldsFromJson(dataList);
  }

  static Future<String> firstImageUrl(int fieldId) async {
    var url = Uri.parse('${Config.API_URL}/field/urlImages/$fieldId');
    var response = await http.get(url);
    List urlImages = jsonDecode(response.body);
    return urlImages[0];
  }
}
