import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../blocs/login_provider.dart';
import '../blocs/login_bloc.dart';
import '../blocs/user_bloc.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginBloc bloc = Provider.of<LoginBloc>(context);
    print(MediaQuery.of(context).size.height);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        elevation: .1,
        backgroundColor: const Color.fromRGBO(49, 87, 110, 1.0),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: const Color.fromARGB(255, 0, 109, 119),
        // child: SingleChildScrollView(
        //   padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(height: 20),
            Image.asset("assets/doctors.png", height: 200),
            // const SizedBox.expand(),
            const SizedBox(height: 30),
            Expanded(
              // alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25),
                  ),
                ),
                child: Column(
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
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: OutlinedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all<Size>(
                                    const Size.fromHeight(49)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Sign up',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 109, 119),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_sharp,
                                    color: Color.fromARGB(255, 0, 109, 119),
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
}
