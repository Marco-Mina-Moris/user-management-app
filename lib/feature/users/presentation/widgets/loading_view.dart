import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitFadingCircle(
        color: Colors.blue,
        size: 50.0,
      ),
    );
  }
}
