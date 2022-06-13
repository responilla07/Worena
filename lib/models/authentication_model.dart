import 'package:flutter/cupertino.dart';

class AuthUserModel {
  String fullName;
  String firstName;
  String lastName;
  String email;
  String picURL;
  String message;
  int status;

  AuthUserModel({@required Map<dynamic,dynamic> data}){
    this.fullName = data['fullName'] ?? "";
    this.firstName = data['firstName'] ?? "";
    this.lastName = data['lastName'] ?? "";
    this.email = data['email'] ?? "";
    this.picURL = data['picURL'] ?? "";
    this.message = data['message'] ?? "user not found";
    this.status = data['status'] ?? 404;
  }
}