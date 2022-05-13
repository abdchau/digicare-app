import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../blocs/login_bloc.dart';
import '../../blocs/user_bloc.dart';

class LoginCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    LoginBloc bloc = Provider.of<LoginBloc>(context);
    return IndexedStack(
      index: _index,
      children: <Widget>[
        LoginCard(bloc),
        SignupCard(context),
      ],
    );
  }

  Widget LoginCard(LoginBloc bloc) {
    return Column(
      children: [
        const Text(
          "Login",
          style: TextStyle(
            color: Color.fromARGB(255, 0, 109, 119),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        imageField(Icons.person, emailField(bloc)),
        imageField(Icons.lock_outlined, passwordField(bloc)),
        submitButton(bloc, context),
        const SizedBox(height: 10),
        const Text(
          "Forgot password?",
          style: TextStyle(
            color: Color.fromARGB(255, 0, 109, 119),
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: const [
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('OR'),
            ),
            Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 10),
        indexButton("Sign up", Icons.arrow_forward),
      ],
    );
  }

  Widget imageField(IconData icon, Widget field) {
    return Container(
      decoration: const BoxDecoration(
        // color: Color.fromARGB(255, 97, 175, 182),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 0, 109, 119),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: field),
        ],
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
            child: const Text(
              'Log in',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          );
        });
  }

  Widget indexButton(String text, IconData iconData) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: OutlinedButton(
              onPressed: () {
                setState(() {
                  _index = _index == 0 ? 1 : 0;
                });
              },
              style: ButtonStyle(
                minimumSize:
                    MaterialStateProperty.all<Size>(const Size.fromHeight(49)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 0, 109, 119),
                    ),
                  ),
                  Icon(
                    iconData,
                    color: const Color.fromARGB(255, 0, 109, 119),
                    size: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget SignupCard(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/signup_screen/signup_heart.png',
          width: 50,
        ),
        const Text(
          "Sign up as",
          style: TextStyle(
            color: Color.fromARGB(255, 0, 109, 119),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 20),
        signupButton(Icons.health_and_safety, "Doctor"),
        const SizedBox(height: 20),
        signupButton(Icons.masks, "Patient"),
        const SizedBox(height: 20),
        signupButton(Icons.health_and_safety, "Caregiver"),
        const SizedBox(height: 10),
        Row(
          children: const [
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('OR'),
            ),
            Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 2),
        indexButton("Log in", Icons.arrow_back),
      ],
    );
  }

  Widget signupButton(final IconData iconData, final String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(iconData),
        const SizedBox(width: 15),
        Expanded(
          child: SizedBox(
            height: 45,
            child: TextButton(
              onPressed: () {},
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 0, 109, 119))),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
