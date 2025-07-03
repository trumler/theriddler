import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'start_screen.dart';

class TheMom extends StatefulWidget {
  const TheMom({Key? key}) : super(key: key);

  @override
  State<TheMom> createState() => _TheMomState();
}

class _TheMomState extends State<TheMom> {
  static const String _prefsKey = 'themom_progress';
  final Duration introFadeDuration = Duration(milliseconds: 2000);
  final Duration quizFadeDuration = Duration(milliseconds: 1000);

  // State flags
  bool showMenu = true;
  bool showIntro = false;
  bool showQuiz = false;
  bool showFinished = false;

  // Opacities for animations
  double menuOpacity = 1.0;
  double introOpacity = 0.0;
  double quizOpacity = 0.0;

  // Progress tracking
  int progress = 0;
  int currentTaskIndex = 0;

  // Controllers and helpers
  final TextEditingController answerController = TextEditingController();
  final List<DateTime> _snackbarTimes = [];
  DateTime? _lastAnswerTime;
  String? errorMessage;
  double errorOpacity = 0.0;

  int introIndex = 0;

  DateTime? _lastIntroTapTime;

  Timer? _introDisplayTimer;
  Timer? _introFadeTimer;

  // Replace with your wrongMessages list
  final List<String> wrongMessages = [
    'Cecilie havde kunne klare den her!',
    'Synes du ikke du skylder dine børn at kunne svaret på den?',
    'EJH MOR! nu må du lige stramme ballerne',
    'Det er ikke så svært mor, du kan det!',
    'Har du brug for en ostemad eller at slå en prut?',
    
  ];

  // Replace with your introTexts
  final List<String> introTexts = [
    'Hej mor, den her er lavet specielt til dig.',
    'Så du også har en chance for at være lidt med.',
    'Håber du kan lide den.',
    'VELKOMMEN TIL',
    'THE MOM!',
  ];

  // Replace with your tasks list
  final List<Map<String, String>> tasks = [
    {
      'message': 'Hej Mor. Du er på første side i quizzen. Det betyder, at HINTET, er det første i rækken af noget, og svaret er det andet i rækken.',
      'question': 'Matias',
      'answer': 'Nicolas',
    },
    {
      'message': 'Virkelig flot, at du kan rækkefølgen på dine børn ❤️. Nu er du på side 2, og så er hintet det andet i rækken af noget, og svaret er det tredje i rækken.',
      'question': 'Tøsen',
      'answer': 'Reici',
    },
    {
      'message': 'Nu kører det! nu er du på side 3. Altså er hintet det tredje i rækken af noget, og svaret er det fjerde i rækken.',
      'question': 'Akacievej',
      'answer': 'Birkevej',
    },
     {
      'message': 'Kan du dine planer mor?.',
      'question': 'Mars',
      'answer': 'Jupiter',
    },
     {
      'message': 'Her er det vigtigt at man kan plusse, f.eks. 1+2 osv. Ellers må man finde hjælp hos sine dejlige børn!',
      'question': '15',
      'answer': '21',
    },
     {
      'question': 'Lørdag',
      'answer': 'Søndag',
    },
     {
      'question': 'Juli',
      'answer': 'Augusst',
    },
     {
      'question': 'Klør 8',
      'answer': 'Klør 9',
    },
     {
      'message': 'Nu må du kunne en smule engelsk.',
      'question': 'Nine',
      'answer': 'Ten',
    },
    
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
    _introDisplayTimer?.cancel();
    _introFadeTimer?.cancel();
    answerController.dispose();
    super.dispose();
  }

  Future<void> _onMenuTap(int index) async {
    setState(() {
      showMenu = false;
      showIntro = false;
      showQuiz = false;
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
    // Fade in content
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