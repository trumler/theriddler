import 'package:flutter/material.dart';
import 'dart:math';

class NewQuizPage extends StatefulWidget {
  const NewQuizPage({Key? key}) : super(key: key);

  @override
  State<NewQuizPage> createState() => _NewQuizPageState();
}

class _NewQuizPageState extends State<NewQuizPage> {
  String? errorMessage;
  double errorOpacity = 0.0;

  final Duration introFadeDuration = const Duration(milliseconds: 2000);
  final Duration quizFadeDuration = const Duration(milliseconds: 1000);

  double introOpacity = 0.0;
  int introIndex = 0;
  bool skipIntro = false;

  double quizOpacity = 0.0;
  bool showQuiz = false;

final List<String> wrongMessages = [
  'Incorrect. Try again.',
  'That is not the answer.',
  'Not quite right.',
  'Please check your answer.',
  'Think again.',
  'Try a different answer.',
  'No, that is not it.',
  'Keep trying.',
  'This is not correct.',
  'Double-check your logic.',
  'Wrong answer.',
  'That does not match.',
  'Not the solution.',
  'Give it another try.',
  'Reconsider your answer.',
  'That won’t do.',
  'Look closer.',
  'Almost, but not right.',
  'Try once more.',
  'That answer is wrong.',
  'Incorrect attempt.',
  'Not what I expected.',
  'That’s not the solution.',
  'Keep searching.',
  'Keep thinking.',
  'Try a new approach.',
  'Not good enough.',
  'This is not valid.',
  'No, check again.',
  'Wrong input.',
  'Try to solve it differently.',
  'Incorrect input.',
  'Not the correct response.',
  'You need to rethink this.',
  'Try another idea.',
  'This answer is invalid.',
  'Not the expected answer.',
  'Your answer is not correct.',
  'Go back and check.',
  'Review your answer.',
  'Answer is incorrect.',
  'Try something else.',
  'This one is wrong.',
  'Keep looking for clues.',
  'No match. Try again.',
  'Try to see it differently.',
  'Not matching.',
  'This won’t work.',
  'Your solution is off.',
  'Try another solution.'
];


  final List<DateTime> _snackbarTimes = [];
  DateTime? _lastAnswerTime;

  final List<String> introTexts = [
    '''This is your new quiz!
You can change this intro when you want.''',
    '''Good luck!''',
  ];

  final List<Map<String, String>> tasks = [
    {
      'message': 'Example task.',
      'question': 'Placeholder question',
      'answer': 'answer',
    },
  ];

  int currentTaskIndex = 0;
  final TextEditingController answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    skipIntro
        ? setState(() {
            showQuiz = true;
            quizOpacity = 1.0;
          })
        : startIntroAnimation();
  }

  @override
  void dispose() {
    answerController.dispose();
    super.dispose();
  }

  void startIntroAnimation() async {
    for (int i = 0; i < introTexts.length; i++) {
      setState(() {
        introIndex = i;
        introOpacity = 0.0;
      });
      await Future.delayed(const Duration(milliseconds: 500));
      await Future.delayed(const Duration(milliseconds: 20));
      setState(() => introOpacity = 1.0);
      await Future.delayed(const Duration(seconds: 6));
      setState(() => introOpacity = 0.0);
      await Future.delayed(introFadeDuration);
    }
    await Future.delayed(introFadeDuration);
    startQuizFadeTransition();
  }

  void startQuizFadeTransition() {
    setState(() => introOpacity = 0.0);
    setState(() {
      showQuiz = true;
      quizOpacity = 0.0;
    });
    setState(() => quizOpacity = 1.0);
  }

  Future<void> _fadeToTask(int newIndex) async {
    setState(() => quizOpacity = 0.0);
    await Future.delayed(quizFadeDuration);
    setState(() {
      currentTaskIndex = newIndex;
      answerController.clear();
    });
    await Future.delayed(const Duration(milliseconds: 50)); // Lille buffer delay
    setState(() => quizOpacity = 1.0);
  }

  Future<void> checkAnswer() async {
    final now = DateTime.now();
    if (_lastAnswerTime != null &&
        now.difference(_lastAnswerTime!).inMilliseconds < 1000) {
      return;
    }
    _lastAnswerTime = now;

    final userAnswer = answerController.text.trim().toLowerCase();
    final correctAnswer =
        tasks[currentTaskIndex]['answer']!.trim().toLowerCase();

    if (userAnswer == correctAnswer) {
      if (currentTaskIndex < tasks.length - 1) {
        await _fadeToTask(currentTaskIndex + 1);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tillykke! Alle opgaver klaret!')),
        );
      }
    } else {
      _snackbarTimes.removeWhere(
          (t) => now.difference(t).inSeconds > 5);
      if (_snackbarTimes.length < 3) {
        final msg = wrongMessages[Random().nextInt(wrongMessages.length)];
        showError(msg);
        _snackbarTimes.add(now);
      }
    }
  }

  void showError(String message) async {
    setState(() {
      errorMessage = message;
      errorOpacity = 1.0;
    });

    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      errorOpacity = 0.0;
    });
  }

  Future<void> nextTask() async {
    if (currentTaskIndex < tasks.length - 1) {
      await _fadeToTask(currentTaskIndex + 1);
    }
  }

  Future<void> prevTask() async {
    if (currentTaskIndex > 0) {
      await _fadeToTask(currentTaskIndex - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: showQuiz
              ? AnimatedOpacity(
                  opacity: quizOpacity,
                  duration: quizFadeDuration,
                  child: quizWidget(),
                )
              : AnimatedOpacity(
                  opacity: introOpacity,
                  duration: introFadeDuration,
                  child: introWidget(),
                ),
        ),
      ),
    );
  }

  Widget introWidget() {
    return AnimatedOpacity(
      opacity: introOpacity,
      duration: introFadeDuration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            introTexts[introIndex],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget quizWidget() {
    final currentTask = tasks[currentTaskIndex];

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: [
          Positioned(
            top: 30,
            left: 0,
            right: 0,
            child: Text(
              '${currentTaskIndex + 1}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  currentTask['message'] ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  currentTask['question'] ?? 'Ingen opgave fundet.',
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: answerController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Try your answer here!',
                    labelStyle: TextStyle(color: Colors.white70),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  cursorColor: Colors.white,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: prevTask,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      child: const Text(
                        'Forrige',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: checkAnswer,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                      ),
                      child: const Text(
                        'Tjek svar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: nextTask,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      child: const Text(
                        'Næste',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: AnimatedOpacity(
              opacity: errorOpacity,
              duration: const Duration(milliseconds: 500),
              child: errorMessage != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      child: Text(
                        errorMessage!,
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}