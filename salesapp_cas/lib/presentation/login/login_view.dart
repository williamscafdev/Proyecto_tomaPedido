import 'package:flutter/material.dart';
import 'package:salesapp_cas/presentation/signup/signup_view.dart';
import '../../presentation/widgets/CurvePainter.dart';
import '../../data/services/local/local_auth_api.dart';
import '../../data/services/remote/authentication_api.dart';
import '../../domain/exceptions/auth_exception.dart';
import '../../domain/usecase/auth_usecase.dart';
import '../../presentation/home/home_view.dart';
import '../../presentation/widgets/ShowDialogMessage.dart';
import '../../utils/colors_constants.dart';
import '../../utils/dialogs.dart';
import '../../utils/navigator_utils.dart';
import 'local_widget/ButtonLogin.dart';
import 'local_widget/TextFieldPassword.dart';
import 'local_widget/TextFieldUserName.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() =>
      _LoginViewState(AuthUseCase(AuthenticationApi(), LocalAuthApi()));
}

class _LoginViewState extends State<LoginView> {
  final AuthUseCase _authUseCase;

  _LoginViewState(this._authUseCase);

  bool _vPass = true;

  _viewPass() {
    _vPass = !_vPass;
    setState(() {});
  }

  _goSignUp() async {
    return pushToPage(context, SignUpView());
  }

  Future<void> _onSubmit() async {
    try {
      ProgressDialog.show(context);
      final result = await _authUseCase.onSubmit();
      ProgressDialog.dissmiss(context);
      if (result == 'entry') {
        return popAllAndPush(context, HomeView());
      }
      if (result == 'not entry') {
        return ShowDialogMessage.showDialogMessage(
            context, 'Información', 'Error de usuario y/o contraseña.');
      }
      if (result == 'typing') {
        return ShowDialogMessage.showDialogMessage(
            context, 'Información', 'Ingrese usuario y/o contraseña.');
      }
    } on AppException catch (ex) {
      print(ex);
      return ShowDialogMessage.showDialogMessage(
          context, 'Información', 'Servidor sin respuesta.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Colors.blue[900]!,
              Colors.blue[800]!,
              Colors.blue[600]!,
            ])),
            child: CustomPaint(
              painter: CurvePainter(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: constraints.maxHeight * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text('Sales App',
                            style: TextStyle(
                              color: blackv2,
                              fontSize: 40,
                              fontFamily: 'Oswald',
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Bienvenidos',
                            style: TextStyle(
                              color: blackv2,
                              fontSize: 20,
                              fontFamily: 'Oswald',
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: blackv2,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                            )),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromRGBO(
                                                30, 144, 255, .3),
                                            blurRadius: 20,
                                            offset: Offset(0, 10))
                                      ]),
                                  child: Column(
                                    children: [
                                      TextFieldUserName(
                                        usuarioController:
                                            _authUseCase.usernameController,
                                        onChangedUserName:
                                            _authUseCase.changedUserName,
                                      ),
                                      TextFieldPassword(
                                        passwordController:
                                            _authUseCase.passwordController,
                                        secureText: _vPass,
                                        onPressedIcon: _viewPass,
                                        onChangedPasssword:
                                            _authUseCase.changedPassword,
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Text(
                                        '¿Perdiste tu contraseña?',
                                        style: TextStyle(
                                            fontFamily: 'Oswald',
                                            color: gray,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      ButtonLogin(
                                          value: true, onSubmit: _onSubmit),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        onTap: _goSignUp,
                                        child: Text(
                                          'Registrate',
                                          style: TextStyle(
                                              fontFamily: 'Oswald',
                                              color: Colors.blue,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}