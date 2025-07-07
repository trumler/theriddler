import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'start_screen.dart';

class EasyOnePage extends StatefulWidget {
  const EasyOnePage({super.key});

  @override
  State<EasyOnePage> createState() => _EasyOnePageState();
}

class _EasyOnePageState extends State<EasyOnePage> {
  static const String _prefsKey = 'easy_quiz_progress';
  final Duration introFadeDuration = Duration(milliseconds: 2000);
  final Duration quizFadeDuration = Duration(milliseconds: 1000);

  double introOpacity = 0.0;
  int introIndex = 0;

  double quizOpacity = 0.0;
  double menuOpacity = 1.0;

  final TextEditingController answerController = TextEditingController();
  final List<DateTime> _snackbarTimes = [];
  DateTime? _lastAnswerTime;
  DateTime? _lastIntroTapTime;

  String? errorMessage;
  double errorOpacity = 0.0;

  bool showMenu = true;
  bool showQuiz = false;
  bool showFinished = false;
  int progress = 0;
  int currentTaskIndex = 0;

  bool showIntro = false;
  Timer? _introDisplayTimer;
  Timer? _introFadeTimer;

  final List<String> wrongMessages = [
 'Nope. Try again, genius.',
'Oof. You sure about that?',
'Ouch. That’s embarrassing.',
'Wrong. But A+ for confidence.',
'Not even close. LOL.',
'Seriously? You thought THAT was right?',
'Who hurt you?',
'Next time, try using your brain.',
'Did you even read the question?',
'I’d clap, but… no.',
'Wow. Just… wow.',
'You make this look hard.',
'Maybe guessing isn’t your thing.',
'Swing and a miss!',
'Not today, Sherlock.',
'Wrong again, champ.',
'Go sit in the corner and think about what you did.',
'Well, that’s awkward.',
'Oopsie. Someone needs a nap.',
'“Try again,” they said. “It’ll be fun,” they said.',
'Your wrong answer is showing.',
'I’d help, but this is too funny.',
'Epic fail.',
'Big brain time… maybe next time.',
'Close! …to being totally wrong.',
'Ooh, spicy. Still wrong, though.',
'Better luck next lifetime.',
'That answer aged like milk.',
'I can’t even.',
'Oof. You make this look easy — being wrong, I mean.',
'Well, at least you tried. (Kinda.)',
'Awkward silence intensifies.',
'Your answer called. It wants a refund.',
'Not all guesses are good guesses.',
'Brain.exe has stopped working.',
'Let’s pretend you didn’t say that.',
'I wish I could unsee that.',
'I’m telling your mom.',
'If wrong answers were an art, you’d be Picasso.',
'That guess? Zero stars.',
'Don’t quit your day job.',
'That made my brain hurt.',
'Maybe ask your dog next time.',
'Nope. Still nope.',
'Uhh… what?',
'That’s gonna haunt me.',
'Congratulations! You’re wrong.',
'Try using the other brain cell.',
'Is that your final wrong answer?',
'Keep going — you’re almost consistently terrible.',
  ];

  final List<String> introTexts = [
    'To you who want an easier start',
    'This is the place to be.',
    'It still might not be as easy as you think',
    'Welcome to',
    'THE EASY ONE',
  ];

  final List<Map<String, String>> tasks = [
    // (keep your existing task list entries here, unchanged)
    {
    'message': 'This is the first step, and so the hint on this page is the first in a line of something. The answer you need, is then the 2nd in that line',
   'question': 'Hint: A',
   'answer': 'b',
 },
 {
      'message': 'This is the 2nd step, and so the hint on this page is the 2nd in a line of something and the answer is the third in that line.',
   'question': 'Hint: 2',
   'answer': '3',
 },
 {
      'message': 'This is the 3rd step, and so the hint on this page is the 3rd in a line of something and the answer is the fourth that in line.',
   'question': 'Hint: Three',
   'answer': 'Four',
 },
 { 'question': 'Square',          'answer': 'Pentagon'        },
 { 'question': 'So',    'answer': 'La'},
 { 'question': 'Saturday',     'answer': 'Sunday'          },
 { 'question': 'Uranus','answer': 'Neptune'},
 { 'question': 'Portuguese',        'answer': 'Russian'         },
 { 'question': 'Sagittarius',      'answer': 'Capricorn'},
 { 'question': '100',   'answer': '121'},
 { 'question': 'Pipers piping',       'answer': 'Drummers drumming'       },
 { 'question': 'Mu',         'answer': 'Nu'      },
 { 'question': 'd',          'answer': 'f'       },
 { 'question': 'Kakuna',         'answer': 'Beedrill'        },
 { 'question': 'Sudan',          'answer': 'Libya'       },
 { 'question': 'Abraham Lincoln',            'answer': 'Andrew Johnson'             },
 { 'question': 'Goodfellas',         'answer': 'Interstellar'      },
 { 'question': 'b3',          'answer': 'c3'       },//18
 { 'question': 'The Jungle Book',         'answer': 'Aristocats'        },
 { 'question': '210',          'answer': '231'       },
 { 'question': '10101',            'answer': '10110' },
 { 'question': 'Washington Redskins',            'answer': 'San Francisco 49ers'       },
 { 'question': "Vanadium",            'answer': 'Chrome'       },
 { 'question': 'Opal',            'answer': 'Silver'       },
  ];

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      progress = prefs.getInt(_prefsKey) ?? 0;
    });
  }

  Future<void> _saveProgress(int newProgress) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_prefsKey, newProgress);
  }

  Future<void> _resetProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefsKey);
    setState(() {
      progress = 0;
    });
    // ignore: avoid_print
    print('✅ Progress reset!');
  }

  @override
  void dispose() {
    _introDisplayTimer?.cancel();
    _introFadeTimer?.cancel();
    answerController.dispose();
    super.dispose();
  }

  Future<void> _onMenuTap(int index) async {
    // Fade out the progress menu
    setState(() {
      menuOpacity = 0.0;
    });
    await Future.delayed(quizFadeDuration);
    setState(() {
      showMenu = false;
      showIntro = false;
      showQuiz = false;
      showFinished = false;
    });

    if (index == 0) {
      setState(() {
        showMenu = false;
        showIntro = true;
        showQuiz = false;
        showFinished = false;
        introIndex = 0;
        introOpacity = 0.0;
      });
      // Cancel any existing timers
      _introDisplayTimer?.cancel();
      _introFadeTimer?.cancel();
      // Start intro scheduler
      Future.delayed(Duration(milliseconds: 50), _scheduleIntro);
      return;
    } else if (index > 0 && index <= tasks.length) {
      // Regular quiz
      setState(() {
        showQuiz = true;
        currentTaskIndex = index - 1;
      });
    } else if (index == tasks.length + 1) {
      // Finished page
      setState(() {
        showFinished = true;
      });
    } else {
      setState(() {
        currentTaskIndex = tasks.length - 1;
        showQuiz = true;
      });
    }
    // Prepare quiz to fade in: start with opacity 0.0, then fade in
    setState(() {
      quizOpacity = 0.0;
    });
    await Future.delayed(Duration(milliseconds: 50));
    setState(() {
      quizOpacity = (showQuiz || showFinished) ? 1.0 : 0.0;
    });
  }
  Future<void> _nextIntroLine() async {
    final now = DateTime.now();
    if (_lastIntroTapTime != null &&
        now.difference(_lastIntroTapTime!).inMilliseconds < 1000) {
      return;
    }
    _lastIntroTapTime = now;
    // Cancel automatic timers
    _introDisplayTimer?.cancel();
    _introFadeTimer?.cancel();
    // Fade out current line
    setState(() => introOpacity = 0.0);
    await Future.delayed(introFadeDuration);
    if (!mounted) return;
    if (introIndex < introTexts.length - 1) {
      // Advance to next line and fade in
      setState(() {
        introIndex++;
        introOpacity = 1.0;
      });
      _scheduleIntro();
    } else {
      // End intro: transition to quiz
      setState(() {
        showIntro = false;
        showQuiz = true;
        quizOpacity = 1.0;
        currentTaskIndex = 0;
        progress = max(progress, 1);
      });
      await _saveProgress(progress);
    }
  }

  void _scheduleIntro() {
    // Fade in current line
    if (!mounted) return;
    setState(() => introOpacity = 1.0);
    // After display duration, fade out
    _introDisplayTimer = Timer(Duration(seconds: 4), () {
      if (!mounted) return;
      setState(() {
        if (!mounted) return;
        introOpacity = 0.0;
      });
      _introFadeTimer = Timer(introFadeDuration, () {
        if (!mounted) return;
        if (introIndex < introTexts.length - 1) {
          setState(() {
            if (!mounted) return;
            introIndex++;
          });
          _scheduleIntro();
        } else {
          if (!mounted) return;
          // End of intro: go to quiz
          setState(() {
            if (!mounted) return;
            showIntro = false;
            showQuiz = true;
            quizOpacity = 1.0;
            currentTaskIndex = 0;
            progress = max(progress, 1);
          });
          _saveProgress(progress);
        }
      });
    });
  }



  Future<void> _checkAnswer() async {
    if (tasks.isEmpty) return;
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
      int newProgress = max(progress, currentTaskIndex + 2);
      setState(() => progress = newProgress);
      await _saveProgress(newProgress);
      await _fadeToTask(currentTaskIndex + 1);
    } else {
      _snackbarTimes.removeWhere((t) => now.difference(t).inSeconds > 5);
      if (_snackbarTimes.length < 3) {
        final msg = wrongMessages[Random().nextInt(wrongMessages.length)];
        _showError(msg);
        _snackbarTimes.add(now);
      }
    }
  }

  Future<void> _fadeToTask(int newIndex) async {
    setState(() {
      quizOpacity = 0.0;
    });
    await Future.delayed(quizFadeDuration);
    if (newIndex < tasks.length) {
      setState(() {
        currentTaskIndex = newIndex;
        answerController.clear();
        showQuiz = true;
        showFinished = false;
      });
    } else {
      setState(() {
        showFinished = true;
        showQuiz = false;
      });
      // Mark Easy One quiz as completed for trophy unlock
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('easyone_completed', true);
    }
    await Future.delayed(Duration(milliseconds: 50));
    setState(() {
      quizOpacity = (showQuiz || showFinished) ? 1.0 : 0.0;
    });
  }

  void _showError(String message) async {
    setState(() {
      errorMessage = message;
      errorOpacity = 1.0;
    });
    await Future.delayed(Duration(seconds: 2));
    setState(() => errorOpacity = 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.home, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => StartScreen(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
                transitionDuration: Duration(milliseconds: 500),
              ),
              (route) => false,
            );
          },
        ),
        centerTitle: true,
        title: showQuiz
            ? Text(
                '${currentTaskIndex + 1}',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 32),
              )
            : null,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: _resetProgress,
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: showMenu
          ? AnimatedOpacity(
              opacity: menuOpacity,
              duration: quizFadeDuration,
              child: _ProgressMenu(
                progress: progress,
                taskCount: tasks.length,
                onTap: _onMenuTap,
              ),
            )
          : showIntro
              ? GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: _nextIntroLine,
                  child: Center(
                    child: AnimatedOpacity(
                      opacity: introOpacity,
                      duration: introFadeDuration,
                      child: Text(
                        introTexts[introIndex],
                        style: TextStyle(color: Colors.white, fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              : showFinished
                  ? Center(
                      child: AnimatedOpacity(
                        opacity: quizOpacity,
                        duration: quizFadeDuration,
                        child: Text(
                          'You have now completed\n THE EASY ONE. GOOD JOB! the easy one trophy is now unlocked!',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : Stack(
                      children: [
                        if (tasks[currentTaskIndex]['message']?.isNotEmpty ?? false)
                          Positioned(
                            top: 100,
                            left: 20,
                            right: 20,
                            child: AnimatedOpacity(
                              opacity: quizOpacity,
                              duration: quizFadeDuration,
                              child: Text(
                                tasks[currentTaskIndex]['message']!,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        SafeArea(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.only(top: 280),
                              child: AnimatedOpacity(
                                opacity: quizOpacity,
                                duration: quizFadeDuration,
                                child: _quizWidget(),
                              ),
                            ),
                          ),
                        ),
                        if (errorMessage != null)
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 50),
                              child: AnimatedOpacity(
                                opacity: errorOpacity,
                                duration: Duration(milliseconds: 500),
                                child: Text(
                                  errorMessage!,
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
    );
  }


  Widget _quizWidget() {
    if (tasks.isEmpty) {
      return Text(
        'Ingen opgaver tilgængelige.',
        style: TextStyle(color: Colors.white, fontSize: 18),
      );
    }
    final idx = currentTaskIndex.clamp(0, tasks.length - 1);
    final current = tasks[idx];
    return Padding(
      padding: EdgeInsets.all(24),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  current['question']!,
                  style: TextStyle(
                      color: Colors.white, fontSize: 24),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: answerController,
                  style: TextStyle(color: Colors.white),
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _checkAnswer(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Your answer',
                    labelStyle: TextStyle(color: Colors.white70),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.white70),
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

class _ProgressMenu extends StatelessWidget {
  final int progress;
  final int taskCount;
  final ValueChanged<int> onTap;
  const _ProgressMenu({
    required this.progress,
    required this.taskCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final maxIndex = progress;
    final labels = List<String>.generate(
      maxIndex + 1,
      (i) {
        if (i == 0) return 'Intro';
        if (i <= (progress > taskCount ? taskCount : progress)) return '$i';
        return 'Finished';
      },
    );
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemCount: labels.length,
      itemBuilder: (context, i) {
        return GestureDetector(
          onTap: () => onTap(i),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              border:
                  Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              labels[i],
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}