import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../blocs/signup_bloc.dart';

import '../widgets/login/stream_text_field.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SignupBloc signupBloc = Provider.of<SignupBloc>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: .1,
        backgroundColor: const Color.fromRGBO(49, 87, 110, 1.0),
        title: Row(
          children: [
            Image.asset(
              'assets/signup_screen/signup_heart.png',
              height: 35,
              color: Colors.white,
            ),
            const SizedBox(width: 20),
            const Text('Sign up'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Flex(direction: Axis.horizontal),
              const SizedBox(height: 20),
              Image.asset(
                'assets/signup_screen/img_placeholder.png',
                width: 150,
              ),
              const SizedBox(height: 15),
              const Text("Upload your picture"),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    StreamTextField(
                      hintText: "John",
                      labelText: "First name",
                      stream: signupBloc.firstNameStream,
                      onChanged: signupBloc.changeFirstName,
                    ),
                    // const SizedBox(height: 5),
                    StreamTextField(
                      hintText: "Doe",
                      labelText: "Last name",
                      stream: signupBloc.lastNameStream,
                      onChanged: signupBloc.changeLastName,
                    ),
                    // const SizedBox(height: 5),
                    StreamTextField(
                      hintText: "example@example.com",
                      labelText: "Email",
                      stream: signupBloc.emailStream,
                      onChanged: signupBloc.changeEmail,
                      textInputType: TextInputType.emailAddress,
                    ),
                    StreamTextField(
                      hintText: "Username",
                      labelText: "Username",
                      stream: signupBloc.usernameStream,
                      onChanged: signupBloc.changeUsername,
                      textInputType: TextInputType.emailAddress,
                    ),
                    // const SizedBox(height: 5),
                    StreamTextField(
                      hintText: "Password",
                      labelText: "Password",
                      stream: signupBloc.passwordStream,
                      onChanged: signupBloc.changePassword,
                      textInputType: TextInputType.visiblePassword,
                      obscureText: true,
                    ),
                    // const SizedBox(height: 5),
                    StreamTextField(
                      hintText: "1234567",
                      labelText: "Phone number",
                      stream: signupBloc.phoneNoStream,
                      onChanged: signupBloc.changePhoneNo,
                    ),
                    submitButton(signupBloc, context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget submitButton(SignupBloc signupBloc, BuildContext context) {
    return StreamBuilder(
        stream: signupBloc.submitValid,
        builder: (context, snapshot) {
          return ElevatedButton(
            onPressed: snapshot.hasData
                ? () {
                    signupBloc.submit();
                  }
                : null,
            child: const Text(
              'Sign up',
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
