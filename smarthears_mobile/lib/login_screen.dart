import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:smarthears_mobile/device_info.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smarthears_mobile/helpers/apple_signin.dart';
import 'package:smarthears_mobile/helpers/google_signin.dart';
import 'package:smarthears_mobile/repositories/auth_repository.dart';
import 'package:smarthears_mobile/modules/home_page.dart';

final GetIt getIt = GetIt.instance;

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key, this.dynamicLink}) : super(key: key);

  final Uri? dynamicLink;
  static const String routeName = '/login';
  final authRepo = getIt<AuthRepository>();
  static final email = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

  static Route route() =>
      MaterialPageRoute<void>(builder: (_) => LoginScreen());

  String? emailValidator(String value) =>
      (value.isEmpty) ? 'Mandatory Login' : null;

  String? emailValidatorRegister(String value) => (value.isEmpty)
      ? 'Mandatory Login'
      : (!email.hasMatch(value))
          ? 'Email incorrect'
          : null;

  String? passwordValidator(String value) => (value.isEmpty)
      ? 'Mandatory Password'
      : (value.length < 6)
          ? 'Short Password'
          : null;

  Duration get loginTime => const Duration(milliseconds: 1250);

  Future<String?> _authUser(LoginData data) async {
    try {
      var deviceInfo = getIt<DeviceInfo>().getDeviceData();
      await authRepo.logIn();
      return null;
    } catch (e) {
      return 'Username or Password invalid';
    }
  }

  Future<String?> _recoverPassword(String email) => authRepo
          .recoverPassword(login: email)
          .then((value) => null)
          .catchError((error) {
        print(error);
        return null;
      });

  Future<String?> _registerUser(BuildContext context, SignupData data) async {
    if (data.name != null && emailValidatorRegister(data.name ?? '') != null) {
      return emailValidatorRegister(data.name ?? '');
    }
    try {
      var deviceInfo = getIt<DeviceInfo>().getDeviceData();
      await authRepo.register();
      return "";
    } catch (e) {
      return 'Error during register';
    }
  }

  List<LoginProvider> getProvider(context) {
    List<LoginProvider> result = [];
    result.add(LoginProvider(
        icon: FontAwesomeIcons.google,
        callback: () async => await _authenticateSocialUser(
            context, await GoogleSign.signInWithGoogle())));
    if (Platform.isIOS) {
      result.add(LoginProvider(
          icon: FontAwesomeIcons.apple,
          callback: () async => await _authenticateSocialUser(
              context, await AppleSignIn.signInWithApple())));
    }
    return result;
  }

  Future<String> _authenticateSocialUser(
      BuildContext context, UserCredential user) async {
    try {
      Map<String, dynamic>? profile = user.additionalUserInfo?.profile;
      DeviceData deviceInfo = getIt<DeviceInfo>().getDeviceData();
      await getIt<AuthRepository>().socialLoginOrRegister();
      return "";
    } catch (e) {
      print(e);
      return 'Une erreur est survenue';
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Stack(children: [
      FlutterLogin(
          onLogin: _authUser,
          navigateBackAfterRecovery: true,
          disableCustomPageTransformer: true,
          onSignup: (loginData) => _registerUser(context, loginData),
          onSubmitAnimationCompleted: () => Get.offAll(() => HomePage()),
          userValidator: (value) => emailValidator(value ?? ''),
          passwordValidator: (value) => passwordValidator(value ?? ''),
          loginProviders: getProvider(context),
          onRecoverPassword: _recoverPassword,
          messages: LoginMessages(
              userHint: 'Login',
              passwordHint: 'Password',
              confirmPasswordHint: 'Confirm password',
              forgotPasswordButton: 'Forgot pqsszord',
              loginButton: 'Login',
              signupButton: 'Signup',
              recoverPasswordButton: 'Recover password',
              recoverPasswordIntro: 'Recover password',
              recoverPasswordDescription: 'Recover your password',
              goBackButton: 'back',
              confirmPasswordError: 'Error password confirmation',
              recoverPasswordSuccess: 'Recover success',
              providersTitleFirst: 'Title'),
          theme: LoginTheme(
              switchAuthTextColor: Colors.red,
              primaryColor: Colors.black,
              authButtonPadding: const EdgeInsets.only(
                  left: 30.0, right: 30.0, top: 30.0, bottom: 10.0),
              textFieldStyle: const TextStyle(color: const Color(0xFFD3AF5F)),
              inputTheme: const InputDecorationTheme(
                  fillColor: Colors.black, filled: true),
              buttonStyle: const TextStyle(
                  fontWeight: FontWeight.w500, color: const Color(0xFFD3AF5F)),
              footerBottomPadding: 25,
              buttonTheme: LoginButtonTheme(
                  splashColor: Colors.black54,
                  backgroundColor: theme.backgroundColor,
                  highlightColor: Colors.black54,
                  elevation: 9.0,
                  highlightElevation: 6.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              bodyStyle: const TextStyle(color: Colors.white70)),
          footer: "SmartHears"),
      Positioned(
          top: 65,
          left: 25,
          child: FloatingActionButton(
              backgroundColor: const Color.fromRGBO(95, 131, 211, 0.7),
              child: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => {Navigator.pop(context)}))
    ]);
  }
}
