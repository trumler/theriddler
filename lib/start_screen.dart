import 'package:flutter/material.dart';
import 'a_The_Expedition.dart';
import 'easy_one_page.dart';
import 'The mom!.dart';
class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  static const Duration pageFadeDuration = Duration(milliseconds: 1000);

  ButtonStyle get myButtonStyle => ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    side: const BorderSide(color: Colors.white, width: 2),
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'THE RIDDLER',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: myButtonStyle,
                onPressed: () {
                  Navigator.of(context).push(PageRouteBuilder(
                    transitionDuration: pageFadeDuration,
                    pageBuilder: (_, __, ___) => const IntroQuizPage(),
                    transitionsBuilder: (_, animation, __, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ));
                },
                child: const Text('THE EXPEDITION'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: myButtonStyle,
                onPressed: () {
                  Navigator.of(context).push(PageRouteBuilder(
                    transitionDuration: pageFadeDuration,
                    pageBuilder: (_, __, ___) => EasyOnePage(),
                    transitionsBuilder: (_, animation, __, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ));
                },
                child: const Text('THE EASY ONE'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: myButtonStyle,
                onPressed: () {
                  Navigator.of(context).push(PageRouteBuilder(
                    transitionDuration: pageFadeDuration,
                    pageBuilder: (_, __, ___) => const TheMom(),
                    transitionsBuilder: (_, animation, __, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  ));
                },
                child: const Text('THE MOM'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
