import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign up')),
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
                    const SizedBox(height: 25),
                    signupButton(Icons.health_and_safety, "Doctor"),
                    const SizedBox(height: 25),
                    signupButton(Icons.masks, "Patient"),
                    const SizedBox(height: 25),
                    signupButton(Icons.health_and_safety, "Caregiver"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
