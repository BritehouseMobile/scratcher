import 'package:flutter/material.dart';

import 'package:scratcher/scratcher.dart';

class BasicScreen extends StatefulWidget {
  @override
  _BasicScreenState createState() => _BasicScreenState();
}

class _BasicScreenState extends State<BasicScreen> {
  double brushSize = 30;
  double progress = 0;
  bool thresholdReached = false;
  final key = GlobalKey<ScratcherState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                child: const Text('Reset'),
                onPressed: () {
                  key.currentState.reset(
                    duration: const Duration(milliseconds: 2000),
                  );
                  setState(() => thresholdReached = false);
                },
              ),
              Column(
                children: [
                  Text('Brush size (${brushSize.round()})'),
                  Slider(
                    value: brushSize,
                    onChanged: (v) => setState(() => brushSize = v),
                    min: 5,
                    max: 100,
                  ),
                ],
              ),
              RaisedButton(
                child: const Text('Reveal'),
                onPressed: () {
                  key.currentState.reveal(
                    duration: const Duration(milliseconds: 2000),
                  );
                },
              ),
            ],
          ),
          Expanded(
            child: Stack(
              children: [
                Scratcher(
                  key: key,
                  brushSize: brushSize,
                  threshold: 30,
                  image: Image.asset('assets/background.jpg'),
                  onThreshold: () => setState(() => thresholdReached = true),
                  onChange: (value) {
                    setState(() {
                      progress = value;
                    });
                  },
                  child: Container(
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Scratch the screen!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                          ),
                        ),
                        SizedBox(height: 8),
                        const Text(
                          'Photo by Fabian Wiktor from Pexels',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 12,
                    ),
                    color: Colors.black,
                    child: Text(
                      '${progress.floor().toString()}% '
                      '(${thresholdReached ? 'done' : 'pending'})',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
