import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/bloc/bloc.dart';
import 'package:word_game/services/authentication.dart';
import 'package:word_game/widgets/dialog.dart';

class LoginPage extends StatefulWidget {
  LoginPage();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () async {
          // showPromptDialog(context);
          Authentication()
              .normalSignIn(email: 'r@e.com', password: '123123')
              .then((value) => BlocProvider.of<AppInitializeBloc>(context)
                  .add(AppUserLogin()));
          // BlocProvider.of<AppInitializeBloc>(context).add(AppUserLogin());
        },
        child: Text("login page"),
      ),
    );
  }

  showPromptDialog(context) {
    return showDialog(
        context: context,
        builder: (_) => CustomDialog(
              body: "This is a sample data of",
              title: "Match Found",
              assets: 'assets/maps/usa.png',
              // btnCancelText: 'Decline',
              // cancelFunction: () {
              //   Navigator.of(context).pop();
              // },
              btnAcceptText: 'OK',
              acceptFunction: () {
                Navigator.of(context).pop();
              },
            ));
  }
}
