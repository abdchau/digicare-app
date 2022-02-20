import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../blocs/login_provider.dart';
import '../blocs/login_bloc.dart';
import '../blocs/user_bloc.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginBloc bloc = Provider.of<LoginBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        elevation: .1,
        backgroundColor: const Color.fromRGBO(49, 87, 110, 1.0),
      ),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset("assets/login_cover.jpg", height: 200),
              emailField(bloc),
              passwordField(bloc),
              submitButton(bloc, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget emailField(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, snapshot) {
        return TextField(
          decoration: InputDecoration(
            hintText: 'you@example.com',
            labelText: 'Email address',
            errorText: snapshot.hasError ? snapshot.error.toString() : "",
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: bloc.changeEmail,
        );
      },
    );
  }

  Widget passwordField(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, snapshot) {
        return TextField(
          decoration: InputDecoration(
            hintText: 'Password',
            labelText: 'Password',
            errorText: snapshot.hasError ? snapshot.error.toString() : "",
          ),
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          onChanged: bloc.changePassword,
        );
      },
    );
  }

  Widget submitButton(LoginBloc bloc, BuildContext context) {
    return StreamBuilder(
        stream: bloc.submitValid,
        builder: (context, snapshot) {
          return ElevatedButton(
            onPressed: snapshot.hasData
                ? () {
                    bloc.submit(
                        context, Provider.of<UserBloc>(context, listen: false));
                  }
                : null,
            child: const Text('Submit'),
          );
        });
  }
}
