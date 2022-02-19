import 'package:flutter/material.dart';

import 'data_rows.dart';

var _montserrat = const TextStyle(
  fontSize: 12,
  fontFamily: "Consolas",
);

class ProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 45),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            nameAndAvatar(),
            userDetails(),
            const SizedBox(height: 40),
            metricsRow(),
            const SizedBox(height: 8)
          ],
        ),
      ),
    );
  }

  Widget nameAndAvatar() {
    return SizedBox(
      height: 150,
      child: Stack(
        children: [
          ClipPath(
            clipper: AvatarClipper(),
            child: Container(
              height: 100,
              decoration: const BoxDecoration(
                // color: darkColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
            ),
          ),
          Positioned(
            left: 11,
            top: 50,
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 50,
                  foregroundImage: NetworkImage(
                      "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Sajeel Hassan",
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "AIDS Victim",
                      style: TextStyle(
                        fontSize: 20,
                        // color: darkColor,
                      ),
                    ),
                    SizedBox(height: 8)
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget userDetails() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        top: 30,
      ),
      child: DataRows(
        const <List<String>>[
          ["Twitter Account", "@sjwalker"],
          ["Github Account", "walker-syed"],
          ["Official Start", "28.01.2020"],
          ["Occupation", "Sn. Software Engg"],
        ],
      ),
    );
  }

  Widget dataRow(String label, String value) {
    return Container(
      width: 280,
      color: Colors.amber,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("$label:", style: _montserrat),
          const SizedBox(width: 10),
          Text(value, style: _montserrat),
        ],
      ),
    );
  }

  Widget metricsRow() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          metric("Subscribers", 6280),
          divider(),
          metric("Followers", 1745),
          divider(),
          metric("Videos", 163),
        ],
      ),
    );
  }

  Widget metric(String metricName, int value) {
    return Column(
      children: [
        Text(
          "$value",
          // style: buildMontserrat(
          //   const Color(0xFF000000),
          //   fontWeight: FontWeight.bold,
          // ),
        ),
        Text(
          metricName,
          // style: buildMontserrat(darkColor),
        )
      ],
    );
  }

  Widget divider() {
    return const SizedBox(
      height: 50,
      child: VerticalDivider(
        color: Color(0xFF9A9A9A),
      ),
    );
  }
}

class AvatarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(0, size.height)
      ..lineTo(8, size.height)
      ..arcToPoint(Offset(114, size.height), radius: const Radius.circular(1))
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
