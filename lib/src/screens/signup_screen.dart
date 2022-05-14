import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Flex(direction: Axis.horizontal),
            const SizedBox(height: 20),
            Image.asset(
              'assets/signup_screen/img_placeholder.png',
              width: 150,
            ),
            const SizedBox(height: 20),
            const Text("Upload your picture"),
          ],
        ),
      ),
    );
  }
}
