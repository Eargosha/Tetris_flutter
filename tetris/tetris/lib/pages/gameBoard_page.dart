// ignore_for_file: must_be_immutable
/// Author: Eargosha
import 'package:flutter/material.dart';
import 'package:tetris/models/pixel_model.dart';
import 'package:tetris/models/tetrisEngine_model.dart';
import 'package:tetris/values.dart';

class GameBoard extends StatefulWidget {
  String difficultyOfTheGame;

  GameBoard({
    super.key,
    required this.difficultyOfTheGame, 
  });

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  /// Ссылка на обьект игры
  late TetrisEngine theGame;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theGame = TetrisEngine(
      difficultyOfTheGame: widget.difficultyOfTheGame,
      setStateFunction: () {
        setState(() {});
      },
      gameoverCallback: showGameOverDialog,
      gamePauseCallback: showPauseGameDialog,
    );
    // начинаем игру когда приложение запускается
    theGame.startGame();
  }

  // окно окончания игры
  void showGameOverDialog() {
    showDialog(
      // делаем окно модальным этим false
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color.fromRGBO(160, 53, 53, 1),
        // название окна
        title: const Text(
          'Game Over',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        // показываем результат
        content: Text(
          "Your score is: ${theGame.currentScore}",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          // кнопка первая - начать снова
          TextButton(
            onPressed: () {
              //метод сыграть снова
              theGame.resetGame();
              Navigator.pop(context);
            },
            child: const Text(
              'Play Again!',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.lightGreen,
              ),
            ),
          ),
          // кнопкка вторая - вернутсья в меню
          TextButton(
            onPressed: () {
              // метод очистки "наигранных" данных и остановки цикла игры
              theGame.resetGameInfo();
              // дважды убираем контекст, первый - убираем диалог, второй - саму страницу игры
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text(
              'Go to menu',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Показать диалог паузы
  void showPauseGameDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color.fromRGBO(22, 71, 145, 1),
        title: const Text(
          'Game Paused',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Your score is: ${theGame.currentScore}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "Difficult is: ${widget.difficultyOfTheGame}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                // метод продолжения игры
                theGame.resumeGame();
                Navigator.pop(context);
              },
              child: const Text(
                'Back to game',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreen,
                ),
              )),
          TextButton(
            onPressed: () {
              // метод верунться в меню
              // метод очистки "наигранных" данных и остановки цикла игры
              theGame.resetGameInfo();
              // дважды убираем контекст, первый - убираем диалог, второй - саму страницу игры
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text(
              'Go to menu',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      //создаем сетку по параметрам с помощью Grid
      body: Column(
        children: [
          //игровое поле
          Expanded(
            child: GridView.builder(
              itemCount: rowLenght * colLenght,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: rowLenght),
              itemBuilder: (context, index) {
                int row = (index / rowLenght).floor();
                int col = index % rowLenght;
                // задаем цвет движущейся фигуры
                if (theGame.currentPiece.position.contains(index)) {
                  return Pixel(
                    color: theGame.currentPiece.color,
                  );
                }

                // задаем цвет приземлившееся фигуры, из GameBoard берется тот тип фигурки, что лежит в матрице и в зависимости от этого меняется цвет.
                else if (gameBoard[row][col] != null) {
                  final Tetromino? tetrominoType = gameBoard[row][col];
                  return Pixel(
                    color: tetrominoColors[tetrominoType],
                  );
                }

                // задаем цвет всех остальных ячеек
                else {
                  return Pixel(
                    color: Colors.grey[900],
                  );
                }
              },
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Your score:           ${theGame.currentScore}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                ),
              ),
              //пауза игры
              IconButton(
                color: Colors.white,
                onPressed: () {
                  theGame.pauseGame();
                },
                icon: const Icon(Icons.pause_circle_outline_rounded),
              ),
            ],
          ),

          // кнопки управления
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0, top: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //двигать лево фигуру
                IconButton(
                  color: Colors.white,
                  onPressed: theGame.moveLeft,
                  icon: const Icon(Icons.chevron_left_rounded),
                ),

                //повернуть фигуру по часовой
                IconButton(
                  color: Colors.white,
                  onPressed: theGame.rotatePiece,
                  icon: const Icon(Icons.rotate_left_sharp),
                ),

                //двигать вниз фигуру
                IconButton(
                  color: Colors.white,
                  onPressed: theGame.moveDown,
                  icon: const Icon(Icons.arrow_downward_rounded),
                ),

                //двигать право фигуру
                IconButton(
                  color: Colors.white,
                  onPressed: theGame.moveRight,
                  icon: const Icon(Icons.chevron_right_rounded),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
