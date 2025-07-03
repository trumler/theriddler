import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'start_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroQuizPage extends StatefulWidget {
  const IntroQuizPage({Key? key}) : super(key: key);

  @override
  State<IntroQuizPage> createState() => _IntroQuizPageState();
}

class _IntroQuizPageState extends State<IntroQuizPage> {
  static const String _prefsKey = 'expedition_quiz_progress';

  Timer? _introDisplayTimer;
  Timer? _introFadeTimer;

  bool showMenu = true;
  bool showQuiz = false;
  bool showFinished = false;
  bool showIntro = false;
  int progress = 0;
  int currentTaskIndex = 0;

  String? errorMessage;
  double errorOpacity = 0.0;

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

  bool get hasFinished => currentTaskIndex >= tasks.length;

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
    'To you who see this page.\nI am no longer here.',
    'I delved too far into the world of riddles.',
    'I am here to bring you with me on a journey through my mind.',
    'So join me if you dare, and try to solve my riddles.',
    'You will now enter',
    'THE EXPEDITION',
  ];

  final List<Map<String, String>> tasks = [
    {
      'message': 'This is the first task, and so the hint on the page is the first in line of something. The answer is the 2nd in line',
      'question': 'Hint: 1',
      'answer': '2',
    },
    {
      'message': 'This is the 2nd task, and so the hint is the 2nd in line of something and the answer is the third in line.',
      'question': 'two',
      'answer': 'three',
    },
    {
      'message': 'This is the 3rd task, and so the hint is the 3rd in line of something and the answer is the fourth in line.',
      'question': 'Mi',
      'answer': 'Fa',
    },
    { 'question': 'Mars',          'answer': 'Jupiter'        },
    { 'question': 'John Glenn',    'answer': 'Scott Carpenter'},
    { 'question': 'Australia',     'answer': 'India'          },
    { 'question': 'Andrew Jackson','answer': 'Martin Van Buren'},
    { 'question': 'Octane',        'answer': 'Nonane'         },
    { 'question': 'Max Park',      'answer': 'Phillipp Weyer'},
    { 'question': 'Jesse Owens',   'answer': 'Harrison Dillard'},
    { 'question': 'Jack',       'answer': 'Queen'       },
    { 'question': 'Italy',         'answer': 'Argentina'      },
    { 'question': 'mike',          'answer': 'november'       },
    { 'question': 'Ivory',         'answer': 'Crystal'        },
    { 'question': 'Ezra',          'answer': 'Nehemiah'       },
    { 'question': 'TN',            'answer': 'OH'             },
    { 'question': 'Q',         'answer': 'R'      },
    { 'question': 'Argon',          'answer': 'Potassium'       },
    { 'question': 'Neetenin',         'answer': 'Ytnewt'        },
    { 'question': 'Upsilon',          'answer': 'Phi'       },
    { 'question': 'Dromedary',            'answer': 'Water Buffalo' },
    { 'question': 'woreaF',            'answer': 'snakE'       },
    { 'question': "Al-Mu'minun",            'answer': 'An-nur'       },
    { 'question': 'Dudley',            'answer': 'Horatio'       },
    { 'question': '97',            'answer': '101'       },
    { 'question': 'Atlanta',            'answer': 'Sydney'       },
    { 'question': 'XXVII',            'answer': 'XXVIII'       },
    { 'question': '11100',            'answer': '11101'       },
    { 'question': 'Niogtyve',            'answer': 'Tredive'       },
    { 'question': 'Celtics',            'answer': 'Trail Blazers'       },
    { 'question': 'Aladdin',            'answer': 'The Lion King'       },
    { 'question': 'The Pianist',            'answer': 'Gladiator'       },
    { 'question': 'MNE',            'answer': 'NL'       },
    { 'question': 'Triacontatetragon',            'answer': 'triacontapentagon'       },
    { 'question': '9227465',            'answer': '14930352'       },
    { 'question': 'John XXIII',            'answer': 'Martin Luther King Jr.'       },
    { 'question': 'Julie Andrews',            'answer': 'Julie Christie'       },
    { 'question': '741',            'answer': '780'       },
    { 'question': 'Comoros',            'answer': 'Congo'       },
    { 'question': '4409 °C',            'answer': '4744'       },
    { 'question': '1681',            'answer': '1764'       },
    { 'question': 'Emperor-Monmu',            'answer': 'empress-genmei'       },
    { 'question': 'Cardinals',            'answer': 'saints'       },
    { 'question': 'ffoorrtuy',            'answer': 'effiortvy'       },
    { 'question': 'Denmark',            'answer': 'estonia'       },
    { 'question': 'gpsuztfwfo',            'answer': 'gpsuzfjhiu'       },
    { 'question': 'c6',            'answer': 'd6'       },
    { 'question': 'Bunche',            'answer': 'jouhaux'       },
    { 'question': 'afbocrdteyfngihniej',            'answer': 'afbicfdteyf' }, 
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
    print('✅ Progress reset!');
  }

  @override
  void dispose() {
    // Cancel intro timers to prevent callbacks after dispose
    _introDisplayTimer?.cancel();
    _introFadeTimer?.cancel();
    answerController.dispose();
    super.dispose();
  }

  Future<void> _onMenuTap(int index) async {
    setState(() {
      showMenu = false;
      showQuiz = false;
      showIntro = false;
      showFinished = false;
    });
    await Future.delayed(quizFadeDuration);

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
        currentTaskIndex = index - 1;
        showQuiz = true;
      });
    } else if (index == tasks.length + 1) {
      // Finished page
      setState(() {
        showFinished = true;
      });
    } else {
      // Out-of-range: clamp to last quiz
      setState(() {
        currentTaskIndex = tasks.length - 1;
        showQuiz = true;
      });
    }
    // Fade in content
    await Future.delayed(Duration(milliseconds: 50));
    setState(() {
      quizOpacity = (showQuiz || showFinished) ? 1.0 : 0.0;
    });
  }
  Future<void> _nextIntroLine() async {
    final now = DateTime.now();
    if (_lastIntroTapTime != null && now.difference(_lastIntroTapTime!).inMilliseconds < 1000) {
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
    setState(() => introOpacity = 1.0);
    // After display duration, fade out
    _introDisplayTimer = Timer(Duration(seconds: 4), () {
      if (!mounted) return;
      setState(() => introOpacity = 0.0);
      _introFadeTimer = Timer(introFadeDuration, () {
        if (!mounted) return;
        if (introIndex < introTexts.length - 1) {
          setState(() => introIndex++);
          _scheduleIntro();
        } else {
          if (!mounted) return;
          // End of intro: go to quiz
          setState(() {
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

  // _startIntroAnimation method removed (dead code)

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
        centerTitle: true,
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
                          'You have now completed\n THE EASY ONE. GOOD JOB!',
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
  final ValueChanged<int> onTap;
  const _ProgressMenu(
      {required this.progress, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final maxIndex = progress;
    final taskCount = 24; // or pass tasks.length as a parameter if you refactor
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