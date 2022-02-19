import 'package:digicare/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;

import '../../../blocs/user_bloc.dart';
import 'name_avatar.dart';
import 'data_rows.dart';

var _montserrat = const TextStyle(
  fontSize: 12,
  fontFamily: "Consolas",
);

class ProfileWidget extends StatelessWidget {
  final UserModel user;

  ProfileWidget(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
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
            NameAndAvatar(user),
            userDetails(),
            const SizedBox(height: 8),
            metricsRow(),
            const SizedBox(height: 8)
          ],
        ),
      ),
    );
  }

  Widget userDetails() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
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
