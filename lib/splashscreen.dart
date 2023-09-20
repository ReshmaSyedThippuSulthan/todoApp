import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Homescreen.dart';
import 'provider/adedde.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TodoAdedde>(context, listen: false).getTodo().then((value) =>
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen())));
    // Future.delayed(const Duration(seconds: 02),(){
    //   Navigator.push(context,MaterialPageRoute(builder: (context)=>const HomeScreen()));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
              "https://img.freepik.com/free-vector/businessman-holding-pencil-big-complete-checklist-with-tick-marks_1150-35019.jpg?w=740&t=st=1694419811~exp=1694420411~hmac=0938edaa44e9b058d314cced9306c96805bf0fd9c9cd0a0c7f2c15db1dfa6ef5"),
        ],
      ),
    );
  }
}
