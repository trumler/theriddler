import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';


class StimanriddePage extends StatefulWidget {
  const StimanriddePage({Key? key}) : super(key: key);
  @override
  _StimanriddePageState createState() => _StimanriddePageState();
}

class _StimanriddePageState extends State<StimanriddePage> {
  final TextEditingController _answerController = TextEditingController();
  double _pageOpacity = 1.0;
  static const Duration _pageFadeDuration = Duration(milliseconds: 1000);
  final List<String> _wrongMessages = [
    'Wrong answer. Try again.',
    'Not quite—give it another shot!',
    'Oops, that’s not it. Keep trying!',
    'Nope, that doesn’t look right.',
    'Tik Tok, Goes the stickman clock, you have to try again!',
    'Keep going—you’ll get it!',
    'Think outside the box and try again!',
  ];
  final Random _random = Random();

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  Future<void> _checkAnswer() async {
    final answer = _answerController.text.trim().toLowerCase();
    if (answer == 'argentina') {
      setState(() => _pageOpacity = 0.0);
      await Future.delayed(_pageFadeDuration + Duration(milliseconds: 100));
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('stickmanriddle_completed', true);
      Navigator.of(context)
          .push(PageRouteBuilder(
            transitionDuration: _pageFadeDuration,
            pageBuilder: (_, __, ___) => const StickmanCongratsPage(),
            transitionsBuilder: (_, animation, __, child) =>
                FadeTransition(opacity: animation, child: child),
          ))
          .then((_) {
            // restore opacity when returning
            setState(() => _pageOpacity = 1.0);
          });
    } else {
      final message = _wrongMessages[_random.nextInt(_wrongMessages.length)];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _pageOpacity,
      duration: _pageFadeDuration,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
          ),
          title: const Text('Stickman Riddle', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: [
            // Upper half: image
            Expanded(
              flex: 1,
              child: Center(
                child: FractionallySizedBox(
                  widthFactor: 1.0,
                  heightFactor: 1.0,
                  child: Image.asset(
                    'assets/riddles/stickmanriddle.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            // Lower half: question and answer field
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  const Text(
                    'Can you figure out the code, hidden in the stickmen?',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: TextField(
                      controller: _answerController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Your answer',
                        labelStyle: const TextStyle(color: Colors.white70),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _checkAnswer(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StickmanCongratsPage extends StatelessWidget {
  const StickmanCongratsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.home, color: Colors.white),
          onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            "Congratulations! You cracked the stickman riddle,\nyou've now unlocked the stickman trophy!",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}