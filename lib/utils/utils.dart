import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'colors.dart';

class CustomClips extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, 100);
    path.lineTo(0, 100);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

String removeDecimalZeroFormat(String num) {
  RegExp regex = RegExp(r'([.]*[0-9]+)(?!.*\d)');

  String s = num.replaceAll(regex, '');
  return s;
}

String? validateEmail(String? value) {
  final pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  final regExp = RegExp(pattern);

  if (!regExp.hasMatch(value!)) {
    return 'S\'il vous plaît, mettez une adresse email valide';
  }
  return '';
}

String? validatePassword(String? value) {
  if (value!.isEmpty || value.length < 8) {
    return 'Le mot de passe doit comporter au moins 8 caractères';
  }

  final hasLetters = RegExp(r'[a-zA-Z]').hasMatch(value);
  final hasNumbers = RegExp(r'\d').hasMatch(value);
  final hasSpecialCharacters = RegExp(r'[!@#\$&*~]').hasMatch(value);

  if (!hasLetters || !hasNumbers || !hasSpecialCharacters) {
    return 'Le mot de passe doit contenir au moins une lettre, un chiffre et un caractère spécial (!@#\$&*~)';
  }

  return '';
}

checkInternetConnectivity(context, Function isConnectedCallback) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult != ConnectivityResult.mobile &&
      connectivityResult != ConnectivityResult.wifi) {
    isConnectedCallback();
    CoolAlert.show(
        context: context,
        widget: WillPopScope(
          onWillPop: () async => false,
          child: Container(),
        ),
        type: CoolAlertType.info,
        loopAnimation: true,
        title: 'No internet connexion',
        text:
            "Vous êtes hors ligne, veuillez vérifier votre connexion Internet.",
        confirmBtnColor: Colors.black,
        barrierDismissible: false,
        showCancelBtn: false,
        confirmBtnText: 'Try again',
        backgroundColor: Colors.black,
        onConfirmBtnTap: () {
          Navigator.pop(context);
          checkInternetConnectivity(context, isConnectedCallback);
        });
  } else {
    isConnectedCallback();
  }
}

String currencyConverteur(int currencyValue, String priceValue) {
  double newValue = currencyValue.toDouble() * double.parse(priceValue);
  return newValue.toString();
}
