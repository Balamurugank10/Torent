import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class B extends StatefulWidget {
  const B({super.key});

  @override
  State<B> createState() => _BState();
}

class _BState extends State<B> {
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildFututeBuilder(),
        _buildStreamBuilder(),
      ],
    ));
  }

  Widget _buildFututeBuilder() {
    return Center(
      child: FutureBuilder<int>(
        future: _cal(10),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Text("Squar ${snapshot.data}");
          }

          return CircularProgressIndicator();
        }),
      ),
    );
  }

  Future<int> _cal(int num) async {
    await Future.delayed(Duration(seconds: 5));
    return num * num;
  }

  Widget _buildStreamBuilder() {
    return Center(
      child: StreamBuilder<int>(
        stream: _stopwatch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active)
            return Text("Stopwatch = ${snapshot.data}");

          return CircularProgressIndicator();
        },
      ),
    );
  }

  // used by StreamBuilder
  Stream<int> _stopwatch() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      yield _count++;
    }
  }
}//class ends
