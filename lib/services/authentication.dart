import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:word_game/models/authentication_model.dart';
import 'package:word_game/models/models.dart';

import 'account_details.dart';

class Authentication {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //Google Sign-In
  Future<AuthUserModel> googleSignIn() async {
    GoogleSignInAccount user;
    GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>['email', 'https://www.googleapis.com/auth/userinfo.profile',]);
    var data = {};

    try {
      user = await _googleSignIn.signIn();
      List name = user.displayName != null ? user.displayName.split(" ") : ["",""];

      data = {
        "fullName" : user.displayName,
        "firstName" : name[0],
        "lastName" : name[name.length - 1],
        "email": user.email,
        "picURL": user.photoUrl,
        "message" : "login success",
        "status" : 200,
      };
    } on PlatformException catch (error) {
      data = {
        "message" : error.message,
        "status" : error.code,
      };
    } catch (e) {
      data = {
        "message" : "login cancelled",
        "status" : 401,
      };
    }

    return AuthUserModel(data: data);
  }

  //Facebook Sign-In
  Future<AuthUserModel> facebookSignIn() async {
    FacebookLogin facebookLogin = FacebookLogin();
    FacebookLoginResult facebookLoginResult = await facebookLogin.logIn(['email']);
    var data = {};

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.loggedIn:
        String token = facebookLoginResult.accessToken.token;
        AuthCredential credential = FacebookAuthProvider.credential(token);
        User user = (await firebaseAuth.signInWithCredential(credential)).user;

        var url = Uri.https('graph.facebook.com', '/v5.0/me', {
          "fields" : "picture.width(1200).height(1200),name,first_name,last_name,birthday,email",
          "access_token" : token,
        });
        
        var graphResponse = await http.get(url);
        Map<String, dynamic> decoded = jsonDecode(graphResponse.body);
        log(decoded.toString());

        data = {
          "fullName" : user.displayName,
          "firstName" : decoded["first_name"],
          "lastName" : decoded["last_name"],
          "email" : user.email,
          "picURL" : user.photoURL + "?type=large", //My profile http://graph.facebook.com/1917315168434460/picture?type=large
          "message" : "login success",
          "status" : 200,
        };
        break;
      case FacebookLoginStatus.cancelledByUser:
        data = {
          "message": "login cancelled",
          "status": 200,
        };
        break;
      case FacebookLoginStatus.error:
        data = {
          "message": FacebookLoginStatus.error,
          "status": 401,
        };
        break;
    }
    return AuthUserModel(data: data);
  }
  
  //Normal Sign-In
  Future<AuthUserModel> normalSignIn({@required String email, @required String password}) async {
    var data = {};

    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(email: email.trim().toLowerCase(),password: password,)).user;
      List name = user.displayName != null ? user.displayName.split(" ") : ["",""];

      data = {
        "fullName" : user.displayName,
        "firstName" : name[0],
        "lastName" : name[name.length - 1],
        "email" : user.email,
        "picURL" : user.photoURL,
        "message" : "login success",
        "status" : 200,
      };
    } catch (error) {
      switch (error.code.toString().toLowerCase()) {
        case 'error-undefined':
          data = {
            "message" : error.message,
            "status" : 404,};
          break;
        case 'user-not-found':
          data = {
            "message" : "The email or password is invalid",
            "status" : 401,};
          break;
        case 'wrong-password':
          data = {
            "message" : "The email or password is invalid",
            "status" : 401,};
          break;
        case 'invalid-email':
          data = {
            "message" : "The email or password is invalid",
            "status" : 401,};
          break;
        default:
          data = {
            "message" : error.message,
            "status" : 404,};
      }
    }

    return AuthUserModel(data: data);
  }
  
  //Logout
  logoutAuthUser() async {
    await FirebaseAuth?.instance?.signOut();
    await FacebookLogin()?.logOut();
    await GoogleSignIn()?.signOut();
    accountDetails.value = UserDetailsModel(data: {}, id: "");
  }
}
