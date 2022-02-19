import 'package:flutter/material.dart';

// import '../../../models/user_model.dart';

class NameAndAvatar extends StatelessWidget {
  // final UserModel user;
  // NameAndAvatar({required this.user});

  @override
  Widget build(BuildContext context) {
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
