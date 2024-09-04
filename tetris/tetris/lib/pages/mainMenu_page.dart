// ignore_for_file: must_be_immutable
/// Author: Eargosha
import "package:flutter/material.dart";
import 'package:tetris/pages/gameBoard_page.dart';

/// Страница главного меню игры
class MainMenuPage extends StatefulWidget {
  MainMenuPage({super.key});

  /// Переменная, что хранит в себе сложность игры
  late String newDifficultyOfTheGame;

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  /// Переменная, что хранит в себе новую сложность игры
  late String _newDifficultyOfTheGame = "";
  // сеттер и геттер
  String get newDifficultyOfTheGame => _newDifficultyOfTheGame;

  set newDifficultyOfTheGame(String value) {
    setState(() {
      _newDifficultyOfTheGame = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    String currentDifficultyOfTheGame = 'Medium';

    /// Метод, что показывает всплывающее окно-уведомление снизу
    void showNotification(String message) {
      // для реализации этого используем SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0))),
          backgroundColor: Color.fromRGBO(1, 16, 35, 1),
          content: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          duration: const Duration(
              seconds: 3), // продолжительность отображения уведомления
        ),
      );
    }

    /// Метод, в котором вызывается окно для выбора сложности
    void showSettings() {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color.fromRGBO(194, 232, 255, 1),
            title: const Text(
              'Difficulty Levels',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ЛЕГКО
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFA2C5DB),
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),
                    leading: const Icon(
                      Icons.baby_changing_station_rounded,
                      color: Colors.green,
                      size: 30,
                    ),
                    title: const Text(
                      'Geometric puzzle',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text(
                      'Easy',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    onTap: () {
                      newDifficultyOfTheGame = 'Easy';
                      Navigator.pop(context);
                      showNotification('Difficult is Easy now');
                    },
                  ),
                ),
                // СРЕДНЕ
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFA2C5DB),
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.symmetric(
                    vertical: 5,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),
                    leading: const Icon(
                      Icons.surfing_outlined,
                      color: Colors.orangeAccent,
                      size: 30,
                    ),
                    title: const Text(
                      'Checkered move',
                      style: TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text(
                      'Medium',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent,
                      ),
                    ),
                    onTap: () {
                      newDifficultyOfTheGame = 'Medium';
                      Navigator.pop(context);
                      showNotification('Difficult is Medium now');
                    },
                  ),
                ),
                // СЛОЖНАААА
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFA2C5DB),
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.symmetric(
                    vertical: 5,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),
                    leading: const Icon(
                      Icons.error_outline_rounded,
                      color: Colors.redAccent,
                      size: 30,
                    ),
                    title: const Text(
                      'Tetrahedral trash',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text(
                      'Hard',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                    onTap: () {
                      newDifficultyOfTheGame = 'Hard';
                      Navigator.pop(context);
                      showNotification('Difficult is Hard now');
                    },
                  ),
                ),
                // СЛОЖНАААААААААААААААААААААААААААААААААА оч
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFA2C5DB),
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.symmetric(
                    vertical: 5,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),
                    leading: const Icon(
                      Icons.broken_image_rounded,
                      color: Color.fromARGB(255, 114, 8, 0),
                      size: 30,
                    ),
                    title: const Text(
                      'CUBIC CHAOS',
                      style: TextStyle(
                        color: Color.fromARGB(255, 114, 8, 0),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text(
                      'EXTRA HARD',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 114, 8, 0),
                      ),
                    ),
                    onTap: () {
                      newDifficultyOfTheGame = 'ExHard';
                      Navigator.pop(context);
                      showNotification('Difficult is Extra Hard now');
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/settingsBackground.png'),
          fit: BoxFit.cover, // растянуть изображение на всю страницу
        ),
      ),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(83, 136, 206, 0.452),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 80,
                    right: 80,
                  ),
                  child: Image.asset(
                    'assets/images/mainMenuPicture2.png',
                    fit: BoxFit.scaleDown,
                  ),
                ),
                const Text(
                  'TETRIS',
                  style: TextStyle(
                    fontSize: 70,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Color(0xFF7CCDFF),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        shadowColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 119, 34, 34)),
                        elevation: MaterialStateProperty.all(5),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => GameBoard(
                              difficultyOfTheGame: newDifficultyOfTheGame == ''
                                  ? currentDifficultyOfTheGame
                                  : newDifficultyOfTheGame,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Play',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Color(0xFF7CCDFF),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        shadowColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 119, 34, 34)),
                        elevation: MaterialStateProperty.all(5),
                      ),
                      onPressed: showSettings,
                      child: const Text(
                        'Select Difficult',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
