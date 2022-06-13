import 'package:flutter/material.dart';
import 'package:word_game/styles/styles.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({
    @required this.title,
    @required this.body,
    @required this.assets,
    this.btnCancelText,
    @required this.btnAcceptText,
    this.cancelFunction,
    @required this.acceptFunction,
  });
  final String title;
  final String body;
  final String assets;
  final String btnCancelText;
  final String btnAcceptText;
  final Function cancelFunction;
  final Function acceptFunction;

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  final AppCrolor color = AppCrolor();
  final TextStyles style = TextStyles();
  bool isOneBtn;

  @override
  void initState() {
    super.initState();
    isOneBtn = widget.cancelFunction == null || widget.btnCancelText == null;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.only(bottom: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      children: <Widget>[
        topDisplayWidget(),
        widgetOfContent(),
        buttonAcceptDecline(),
      ],
    );
  }

  Stack topDisplayWidget() {
    return Stack(
      children: <Widget>[
        Container(
          height: 125.0,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            image: DecorationImage(
                image: AssetImage('assets/bg_top.png'), fit: BoxFit.cover),
            color: color.primaryDark,
          ),
          height: 75.0,
        ),
        Positioned.fill(
          top: 25.0,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: 90.0,
              width: 90.0,
              decoration: BoxDecoration(
                color: color.secondary,
                borderRadius: BorderRadius.circular(45.0),
                border: Border.all(
                    color: Colors.white, style: BorderStyle.solid, width: 4.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image(
                  image: AssetImage(widget.assets),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Padding widgetOfContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: <Widget>[
          SizedBox(height: 12),
          Text(
            widget.title,
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                fontFamily: style.secondaryFontFamily),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Center(
            child: Text(widget.body, textAlign: TextAlign.center),
          ),
          SizedBox(height: isOneBtn ? 0 : 16),
        ],
      ),
    );
  }

  Column buttonAcceptDecline() {
    var mat = MaterialStateProperty.all;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        isOneBtn
            ? Container()
            : GestureDetector(
                onTap: widget.cancelFunction,
                child: Text(
                  widget.btnCancelText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
        ElevatedButton(
          onPressed: widget.acceptFunction,
          child: Padding(
            padding:
                EdgeInsets.only(bottom: isOneBtn ? 0 : 4, left: 36, right: 36),
            child: Text(
              widget.btnAcceptText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isOneBtn ? color.secondaryDark : Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: style.defaultFontSize,
              ),
            ),
          ),
          style: ButtonStyle(
            shape: mat<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            backgroundColor:
                mat<Color>(isOneBtn ? Colors.white : color.secondaryDark),
            elevation: mat<double>(isOneBtn ? 0 : 3),
          ),
        ),
      ],
    );
  }
}
