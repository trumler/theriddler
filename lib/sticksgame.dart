import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(TwentySticksGame());
}

class TwentySticksGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '20 Sticks Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SticksGamePage(),
    );
  }
}

class SticksGamePage extends StatefulWidget {
  @override
  _SticksGamePageState createState() => _SticksGamePageState();
}

class _SticksGamePageState extends State<SticksGamePage> {
  List<bool> sticks = List<bool>.filled(20, true);
  int sticksRemovedThisTurn = 0;
  static const int maxRemovals = 3;
  static const List<int> safeIndices = [0, 4, 8, 12, 16];

  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    side: const BorderSide(color: Colors.white, width: 2),
    foregroundColor: Colors.white,
  );

  int get totalSticks => sticks.where((s) => s).length;

  bool isPlayerTurn = true;
  String message = ' Welcome to the 20 sticks game! you can remove 1-3 sticks per round. The goal is to NOT! grab the last stick.\nWho goes first?';

  void resetGame() {
    setState(() {
      sticks = List<bool>.filled(20, true);
      isPlayerTurn = true;
      message = 'So you have to try again? better luck this time!\nWho goes first?';
      sticksRemovedThisTurn = 0;
    });
  }

  Future<void> _unlockTrophy() async {
    final prefs = await SharedPreferences.getInstance();
    // Use the asset name (without extension) as the key:
    await prefs.setBool('20sticksgame', true);
  }

  int computerMove(int sticksLeft) {
    int take = (sticksLeft - 1) % 4;
    if (take == 0 || take > 3) {
      // No winning move: pick random valid move
      List<int> choices = [1, 2, 3].where((n) => n <= sticksLeft).toList();
      choices.shuffle();
      return choices.first;
    }
    return take;
  }

  void computerTurn() {
    int take = computerMove(totalSticks);
    // Remove 'take' sticks, avoiding safe positions first
    int removed = 0;
    // First pass: remove non-safe sticks
    for (int i = sticks.length - 1; i >= 0 && removed < take; i--) {
      if (sticks[i] && !safeIndices.contains(i)) {
        sticks[i] = false;
        removed++;
      }
    }
    // Second pass: if still need removals, remove any remaining sticks
    for (int i = sticks.length - 1; i >= 0 && removed < take; i--) {
      if (sticks[i]) {
        sticks[i] = false;
        removed++;
      }
    }

    if (totalSticks == 0) {
      _unlockTrophy();
      setState(() {
        message = 'Computer removed the last stick.\nYou win! A man vs. robot trophy has been unlocked!';
        sticksRemovedThisTurn = 0;
      });
      return;
    }
    setState(() {
      message = 'Computer removed $take sticks.\nSticks left: $totalSticks.\nYour turn!';
      isPlayerTurn = true;
      sticksRemovedThisTurn = 0;
    });
  }

  Widget buildStartButtons() {
    if (totalSticks != 20) return Container();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: buttonStyle,
          onPressed: () {
            setState(() {
              isPlayerTurn = true;
              message = 'Your turn! Sticks left: $totalSticks';
            });
          },
          child: Text('I go first'),
        ),
        SizedBox(width: 20),
        ElevatedButton(
          style: buttonStyle,
          onPressed: () {
            setState(() {
              isPlayerTurn = false;
            });
            computerTurn();
          },
          child: Text('Computer goes First'),
        ),
      ],
    );
  }

  Widget buildEndTurnButton() {
    if (!isPlayerTurn || sticksRemovedThisTurn == 0) return SizedBox();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: buttonStyle,
        onPressed: () {
          setState(() {
            isPlayerTurn = false;
          });
          Future.delayed(Duration(milliseconds: 400), () {
            computerTurn();
          });
        },
        child: Text('End Turn'),
      ),
    );
  }

  Widget buildResetButton() {
    if (totalSticks > 0) return Container();
    return ElevatedButton(
      onPressed: resetGame,
      child: Text('Play Again'),
    );
  }

  Widget buildSticksGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.5,
      ),
      itemCount: sticks.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (isPlayerTurn && sticksRemovedThisTurn < maxRemovals && sticks[index]) {
              setState(() {
                sticks[index] = false;
                sticksRemovedThisTurn++;
                message = 'You removed $sticksRemovedThisTurn stick(s).';
              });
              // After removing maxRemovals or if game over, hand to computer
              if (sticksRemovedThisTurn >= maxRemovals || totalSticks == 0) {
                setState(() => isPlayerTurn = false);
                Future.delayed(Duration(milliseconds: 400), () {
                  computerTurn();
                });
              }
            }
          },
          child: AnimatedOpacity(
            opacity: sticks[index] ? 1.0 : 0.0,
            duration: Duration(milliseconds: 300),
            child: Center(
              child: FractionallySizedBox(
                widthFactor: 0.5,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text(
          '20 Sticks Game',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FractionallySizedBox(
                widthFactor: 0.8, // adjust this factor to change overall width
                child: buildSticksGrid(),
              ),
              const SizedBox(height: 8),
              Text(
                'Sticks left: $totalSticks',
                style: TextStyle(fontSize: 28, color: Colors.white),
              ),
              SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(height: 20),
              buildStartButtons(),
              buildEndTurnButton(),
              buildResetButton(),
            ],
          ),
        ),
      ),
    );
  }
}