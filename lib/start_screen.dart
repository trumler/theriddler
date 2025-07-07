import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'a_The_Expedition.dart';
import 'easy_one_page.dart';
import 'the mom.dart';
import 'dart:ui';
import 'sticksgame.dart';
import 'stimanridde.dart';
// ...existing code...
class StartScreen extends StatefulWidget {
  const StartScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _StartScreenState createState() => _StartScreenState();
}
class _StartScreenState extends State<StartScreen> {
  static const Duration pageFadeDuration = Duration(milliseconds: 1000);
  double _pageOpacity = 1.0;
  final TextEditingController _momPasswordController = TextEditingController();

  ButtonStyle get myButtonStyle => ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.black),
    side: MaterialStateProperty.resolveWith<BorderSide>((states) {
      if (states.contains(MaterialState.hovered) || states.contains(MaterialState.pressed)) {
        return const BorderSide(color: Colors.purple, width: 2);
      }
      return const BorderSide(color: Colors.white, width: 2);
    }),
    foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.contains(MaterialState.hovered) || states.contains(MaterialState.pressed)) {
        return Colors.purple;
      }
      return Colors.white;
    }),
    overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
      if (states.contains(MaterialState.pressed)) {
        return Colors.purple.withOpacity(0.1);
      }
      return null;
    }),
    padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12)),
  );

  @override
  void dispose() {
    _momPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _pageOpacity,
      duration: pageFadeDuration,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        onPressed: () async {
                          setState(() => _pageOpacity = 0.0);
                          await Future.delayed(pageFadeDuration);
                          Navigator.of(context).push(PageRouteBuilder(
                            transitionDuration: pageFadeDuration,
                            pageBuilder: (_, __, ___) => const IntroQuizPage(),
                            transitionsBuilder: (_, animation, __, child) {
                              return FadeTransition(opacity: animation, child: child);
                            },
                          ));
                        },
                        child: const Text('THE EXPEDITION'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: myButtonStyle,
                        onPressed: () async {
                          setState(() => _pageOpacity = 0.0);
                          await Future.delayed(pageFadeDuration);
                          Navigator.of(context).push(PageRouteBuilder(
                            transitionDuration: pageFadeDuration,
                            pageBuilder: (_, __, ___) => EasyOnePage(),
                            transitionsBuilder: (_, animation, __, child) {
                              return FadeTransition(opacity: animation, child: child);
                            },
                          ));
                        },
                        child: const Text('THE EASY ONE'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: myButtonStyle,
                        onPressed: () async {
                          setState(() => _pageOpacity = 0.0);
                          await Future.delayed(pageFadeDuration);
                          Navigator.of(context).push(PageRouteBuilder(
                            transitionDuration: pageFadeDuration,
                            pageBuilder: (_, __, ___) => const PuzzlesPage(),
                            transitionsBuilder: (_, animation, __, child) {
                              return FadeTransition(opacity: animation, child: child);
                            },
                          )).then((_) => setState(() => _pageOpacity = 1.0));
                        },
                        child: const Text('PUZZLES'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: myButtonStyle,
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierColor: Colors.black.withOpacity(0.8),
                            barrierDismissible: false,
                            builder: (BuildContext dialogContext) {
                              return AlertDialog(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                title: const Text(
                                  'A tribute to my loving mother',
                                  style: TextStyle(color: Colors.white),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'This is a tribute to my mother, and so the password for her quiz is her last name. '
                                      'The password to unlock her trophy, is a word that always reconnects you with your mother.',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(height: 16),
                                    TextField(
                                      controller: _momPasswordController,
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        hintText: 'Enter password',
                                        hintStyle: TextStyle(color: Colors.white54),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white54),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      side: BorderSide(color: Colors.white, width: 2),
                                      foregroundColor: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.of(dialogContext).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      side: BorderSide(color: Colors.white, width: 2),
                                      foregroundColor: Colors.purple,
                                    ),
                                    onPressed: () async {
                                      final input = _momPasswordController.text.trim().toLowerCase();
                                      if (input == 'rasmussen') {
                                        Navigator.of(dialogContext).pop();
                                        setState(() => _pageOpacity = 0.0);
                                        await Future.delayed(pageFadeDuration);
                                        Navigator.of(context).push(PageRouteBuilder(
                                          transitionDuration: pageFadeDuration,
                                          pageBuilder: (_, __, ___) => const TheMom(),
                                          transitionsBuilder: (_, animation, __, child) =>
                                              FadeTransition(opacity: animation, child: child),
                                        ));
                                      } else if (input == 'love') {
                                        final prefs = await SharedPreferences.getInstance();
                                        await prefs.setBool('mom_completed', true);
                                        Navigator.of(dialogContext).pop();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('The Mom trophy unlocked!')),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Wrong password')),
                                        );
                                      }
                                      _momPasswordController.clear();
                                    },
                                    child: const Text('Submit'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text('THE MOM'),
                      ),
                    ],
                  ),
                ),
              ),
            ), // closes Center
            Positioned(
              bottom: 20,
              right: 20,
              child: InkWell(
                onTap: () async {
                  setState(() => _pageOpacity = 0.0);
                  await Future.delayed(pageFadeDuration);
                  // After TrophyScreen pops, reload trophy state in TrophyScreen
                  await Navigator.of(context).push(PageRouteBuilder(
                    transitionDuration: pageFadeDuration,
                    pageBuilder: (_, __, ___) => const TrophyScreen(),
                    transitionsBuilder: (_, animation, __, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  ));
                  setState(() => _pageOpacity = 1.0);
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Theme.of(context).primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.emoji_events, // trophy icon
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrophyScreen extends StatefulWidget {
  const TrophyScreen({Key? key}) : super(key: key);
  @override
  _TrophyScreenState createState() => _TrophyScreenState();
}

class _TrophyScreenState extends State<TrophyScreen> {
  /// Returns the display order: unlocked trophies first, then locked, preserving original order within groups.
  List<int> get _displayOrder {
    // Unlocked first, then locked
    final List<int> order = List<int>.generate(_trophyAssets.length, (i) => i);
    order.sort((a, b) {
      if (_unlocked[a] && !_unlocked[b]) return -1;
      if (!_unlocked[a] && _unlocked[b]) return 1;
      return a.compareTo(b); // preserve original order among same state
    });
    return order;
  }
  final List<String> _trophyAssets = [
    'assets/trophies/theexpedition.png',
    'assets/trophies/staircase.png',
    'assets/trophies/theeasyone.png',
    'assets/trophies/themom.png',
    'assets/trophies/labyrinth.png',
    'assets/trophies/20sticksgame.png',
    'assets/trophies/stickmanriddle.png',
    // add more asset paths as needed
  ];
  final List<bool> _unlocked = [false, false, false, false, false, false, false]; // all locked initially

  double _opacity = 0.0;

  /// Returns a color interpolated between [startColor] and [endColor]
  /// based on the trophy index.
  Color _borderGradientColor(int idx) {
    final int count = _trophyAssets.length;
    final double t = count > 1 ? idx / (count - 1) : 0.0;
    // Define your start and end colors here:
  
    const Color startColor = Colors.red;
    const Color endColor   = Colors.blue;
    return Color.lerp(startColor, endColor, t)!;
  }

  @override
  void initState() {
    super.initState();
    _loadUnlocked();
    Future.delayed(Duration.zero, () {
      setState(() => _opacity = 1.0);
    });
  }

  Future<void> _loadUnlocked() async {
    final prefs = await SharedPreferences.getInstance();
    final expeditionDone = prefs.getBool('expedition_completed') ?? false;
    final easyOneDone = prefs.getBool('easyone_completed') ?? false;
    final momDone = prefs.getBool('mom_completed') ?? false;
    final labyrinthDone = prefs.getBool('labyrinth_completed') ?? false;
    final sticksgameDone = prefs.getBool('20sticksgame') ?? false;
    final stickmanDone = prefs.getBool('stickmanriddle_completed') ?? false;
    setState(() {
      _unlocked[0] = expeditionDone;
      _unlocked[2] = easyOneDone;
      _unlocked[3] = momDone;
      _unlocked[4] = labyrinthDone;
      _unlocked[5] = sticksgameDone;
      _unlocked[6] = stickmanDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: _StartScreenState.pageFadeDuration,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () async {
              // fade back to start screen
              setState(() => _opacity = 0.0);
              await Future.delayed(_StartScreenState.pageFadeDuration);
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.count(
            crossAxisCount: 4,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1,
            children: _displayOrder.map((idx) {
              final trophyTile = Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(color: _borderGradientColor(idx), width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Image.asset(
                    _trophyAssets[idx],
                    fit: BoxFit.contain,
                  ),
                ),
              );
              if (!_unlocked[idx]) {
                return Opacity(
                  opacity: 0.4,
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                    child: trophyTile,
                  ),
                );
              }
              return trophyTile;
            }).toList(),
          ),
        ),
      ),
    );
  }
}


class PuzzlesPage extends StatefulWidget {
  const PuzzlesPage({Key? key}) : super(key: key);
  @override
  _PuzzlesPageState createState() => _PuzzlesPageState();
}

class _PuzzlesPageState extends State<PuzzlesPage> {
  double _opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: _StartScreenState.pageFadeDuration,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
          title: const Text('Puzzles', style: TextStyle(color: Colors.white)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  side: MaterialStateProperty.all(
                    const BorderSide(color: Colors.white, width: 2),
                  ),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                onPressed: () async {
                  setState(() => _opacity = 0.0);
                  await Future.delayed(_StartScreenState.pageFadeDuration);
                  Navigator.of(context)
                      .push(PageRouteBuilder(
                        transitionDuration: _StartScreenState.pageFadeDuration,
                        pageBuilder: (_, __, ___) => SticksGamePage(),
                        transitionsBuilder: (_, animation, __, child) =>
                            FadeTransition(opacity: animation, child: child),
                      ))
                      .then((_) => setState(() => _opacity = 1.0));
                },
                child: const Center(
                  child: Text(
                    'SticksGame',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  side: MaterialStateProperty.all(const BorderSide(color: Colors.white, width: 2)),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                onPressed: () async {
                  setState(() => _opacity = 0.0);
                  await Future.delayed(_StartScreenState.pageFadeDuration);
                  Navigator.of(context)
                      .push(PageRouteBuilder(
                        transitionDuration: _StartScreenState.pageFadeDuration,
                        pageBuilder: (_, __, ___) => const StimanriddePage(),
                        transitionsBuilder: (_, animation, __, child) =>
                            FadeTransition(opacity: animation, child: child),
                      ))
                      .then((_) => setState(() => _opacity = 1.0));
                },
                child: const Center(
                  child: Text(
                    'The Stickman Riddle',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              // Add more puzzle tiles here...
            ],
          ),
        ),
      ),
    );
  }
}
