import 'dart:async';

import 'package:flutter/material.dart';

class MyCountDownTimer extends StatefulWidget {
  MyCountDownTimer({super.key});

  @override
  State<MyCountDownTimer> createState() => _MyCountDownTimerState();
}

class _MyCountDownTimerState extends State<MyCountDownTimer> {
  Duration duration = Duration();
  final Color color = Color.fromARGB(255, 38, 156, 179);

  // The seconds, minutes and hours
  int _seconds = 0;

  int _minutes = 0;

  int _hours = 0;

  // The state of the timer (running or not)
  bool _isRunning = false;

  // The timer
  Timer? _timer;

  @override
  void initState() {
    super.initState();
  }

  void _startTimer() {
    setState(() {
      _isRunning = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          if (_minutes > 0) {
            _minutes--;
            _seconds = 59;
          } else {
            if (_hours > 0) {
              _hours--;
              _minutes = 59;
              _seconds = 59;
            } else {
              _isRunning = false;
              _timer?.cancel();
            }
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildTime(),
    );
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final days = twoDigits(duration.inDays.remainder(12));
    final hours = twoDigits(duration.inHours.remainder(12));
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "GLOBAL HEALTH FORUM",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Health For All",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                buildTimeCard(time: days, header: "DAYS"),
                buildTimeCard(time: hours, header: "HOURS"),
                buildTimeCard(time: minutes, header: "MINUTES"),
                buildTimeCard(time: seconds, header: "SECONDS"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

buildTimeCard({required String time, required String header}) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            //padding: EdgeInsets.all(4),
            // decoration: BoxDecoration(
            //   color: Colors.white,
            //   borderRadius: BorderRadius.circular(12),
            // ),
            child: Text(
              time,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(header,
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 10,
                      color: Colors.white)),
            ),
          )
        ],
      ),
    );
