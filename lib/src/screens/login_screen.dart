import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../blocs/login_provider.dart';
import '../blocs/login_bloc.dart';
import '../blocs/user_bloc.dart';

import '../widgets/login/card.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                child: LoginCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
