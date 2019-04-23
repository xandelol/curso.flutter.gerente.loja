import 'package:flutter/material.dart';
import 'package:gerente_loja_app/blocs/login_bloc.dart';
import 'package:gerente_loja_app/screens/home_screen.dart';
import 'package:gerente_loja_app/widgets/input_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _loginBloc = LoginBloc();

  @override
  void initState() {
    super.initState();
    _loginBloc.outState.listen((state){
      switch(state){
        case LoginState.SUCCESS:
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context)=>HomeScreen())
          );
          break;
        case LoginState.FAIL:
          showDialog(context: context, builder: (context)=>AlertDialog(
            title: Text("Erro"),
            content: Text("Você não possui os privilágios necessários!"),
          ));
          break;
        case LoginState.IDLE:
          break;
        case LoginState.LOADING:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: StreamBuilder<LoginState>(
        stream: _loginBloc.outState,
        initialData: LoginState.LOADING,
        builder: (context, snapshot) {
          switch(snapshot.data){
            case LoginState.SUCCESS:
            case LoginState.FAIL:
            case LoginState.IDLE:
              return Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(),
                  SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Icon(
                            Icons.store_mall_directory,
                            color: Colors.pinkAccent,
                            size: 160,
                          ),
                          InputField(
                            hint: "Usuário",
                            icon: Icons.person_outline,
                            obscure: false,
                            stream: _loginBloc.outEmail,
                            onChanged: _loginBloc.changeEmail,
                          ),
                          InputField(
                            hint: "Senha",
                            icon: Icons.lock_outline,
                            obscure: true,
                            stream: _loginBloc.outPassword,
                            onChanged: _loginBloc.changePassword,
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          StreamBuilder<bool>(
                              stream: _loginBloc.outSubmitValid,
                              builder: (context, snapshot) {
                                return SizedBox(
                                  height: 50,
                                  child: RaisedButton(
                                    color: Colors.pinkAccent,
                                    child: Text("Entrar"),
                                    textColor: Colors.white,
                                    onPressed: snapshot.hasData ? _loginBloc.submit : null,
                                    disabledColor: Colors.pinkAccent.withAlpha(140),
                                    disabledTextColor: Colors.white.withAlpha(140),
                                  ),
                                );
                              }
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
              break;
            case LoginState.LOADING:
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
                ),
              );
            break;
          }
        }
      ),
    );
  }
}
