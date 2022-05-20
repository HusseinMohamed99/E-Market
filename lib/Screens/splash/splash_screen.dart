import 'package:flutter/material.dart';
import 'package:mego_market/shared/mode_cubit/cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
          child: ModeCubit.get(context).isDark
              ? const Image(
                  image: AssetImage('assets/images/Dark Logo.png'),
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                )
              : const Image(
                  image: AssetImage('assets/images/Light Logo.png'),
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                )),
    );
  }
}
