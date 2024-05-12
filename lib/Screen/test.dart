import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isContainerBVisible = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: isContainerBVisible ? 3 : 1, // Adjust flex dynamically
          child: Container(
            color: Colors.blue,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isContainerBVisible = !isContainerBVisible;
                  });
                },
                child: Text(isContainerBVisible
                    ? 'Hide Container B'
                    : 'Show Container B'),
              ),
            ),
          ),
        ),
        if (isContainerBVisible)
          Expanded(
            flex: 1,
            child: AnimatedOpacity(
              opacity: isContainerBVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                color: Colors.red,
                child: const Center(
                  child: Text('Container B'),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
