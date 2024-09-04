/// Author: Eargosha
import 'dart:async';
import 'dart:math';
import 'package:tetris/models/piece_model.dart';
import 'package:tetris/values.dart';

/// Класс "движка" тетриса, содержит в себе основные методы и поля для реализации игры
class TetrisEngine {
  ///Сложность игры (Easy||Medium||Hard||ExHard)
  String difficultyOfTheGame = 'Medium';

  ///Фигурка на тетрисе сейчас
  Piece currentPiece = Piece(type: Tetromino.L);

  ///Игровой счет
  int currentScore = 0;

  ///Статус прогиранной игры
  bool _gameOver = false;

  ///Статус остановленной игры
  bool _gamePause = false;

  ///CallBack функции первая для обноваления состояния виджета
  Function setStateFunction;
  ///Вторая для показа окна о проигрыше
  Function? gameoverCallback;
  ///Третья для показа окна паузы
  Function? gamePauseCallback;

  TetrisEngine({
    required this.difficultyOfTheGame,
    required this.setStateFunction,
    this.gameoverCallback,
    this.gamePauseCallback,
  });

  void setSetStateFunction(Function setStateFunction) {
    this.setStateFunction = setStateFunction;
  }

  ///Метод начала игры
  void startGame() {
    if (!_gamePause) {
      currentPiece.initializePiece();
    }

    /// задается базовое значение скорости игры
    Duration speedOfTheGame = Duration(milliseconds: 500);

    // кадры в секунду - скорость игры
    switch (difficultyOfTheGame) {
      case 'Easy':
        speedOfTheGame = Duration(milliseconds: 1000);
        break;
      case 'Medium':
        speedOfTheGame = Duration(milliseconds: 500);
        break;
      case 'Hard':
        speedOfTheGame = Duration(milliseconds: 250);
        break;
      case 'ExHard':
        speedOfTheGame = Duration(milliseconds: 100);
        break;
    }
    _gameLoop(speedOfTheGame);
  }

  ///Цикл игры, заканчивается, когда bool gameOver = true, приостанавливается, если bool gamePause = true
  void _gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      // чистим победные линии если те есть
      _clearLines();

      // проверяем фигурку на призмеление
      _checkLanding();

      // проверяем достиг ли игрок проигрыша или нет
      if (_gameOver) {
        timer.cancel();
        if (gameoverCallback != null) {
          gameoverCallback!();
        }
      }

      // проверяем нажата ли пауза
      if (_gamePause) {
        timer.cancel();
        if (gamePauseCallback != null) {   
          gamePauseCallback!();
        }
      }

      // двигаем фигурку вниз
      currentPiece.movePiece(Directions.down);
      // Вызов setStateFunction для обновления состояния page
      setStateFunction();
    });
  }

  ///Метод сыграть снова
  void resetGame() {
    // очищаем прошлое игровое поле
    // создаем новую фигурку
    // начинаем игру
    resetGameInfo();
    _createNewPiece();
    startGame();
  }

  ///Метод очистки игры перед началом игры, перед выходом в меню, необходимо, чтобы остановить gameLoop
  void resetGameInfo() {
    // очищаем прошлое игровое поле
    gameBoard = List.generate(
      colLenght,
      (i) => List.generate(
        rowLenght,
        (j) => null,
      ),
    );
    // новые данные
    _gameOver = false;
    currentScore = 0;
  }

  ///Проверка коллизии для будущих позиций фигуры, true или false
  bool _checkCollision(Directions direction) {
    // создаем список с позициями всех фигур на доске
    List<int> occupiedPositions = [];

    // заполняем список занятыми позициями
    for (int i = 0; i < colLenght; i++) {
      for (int j = 0; j < rowLenght; j++) {
        if (gameBoard[i][j] != null) {
          occupiedPositions.add(i * rowLenght + j);
        }
      }
    }

    // проверяем каждую фигуру на коллизию
    for (int i = 0; i < currentPiece.position.length; i++) {
      // находим позицию строки и колонки для фигуры сейчас
      int row = (currentPiece.position[i] / rowLenght).floor();
      int col = currentPiece.position[i] % rowLenght;

      // изменяем в зависимости от направления
      if (direction == Directions.left) {
        col -= 1;
      } else if (direction == Directions.right) {
        col += 1;
      } else if (direction == Directions.down) {
        row += 1;
      }

      // проверяем находится ли фигурка за пределами (слишком низко, близко к правому краю и левому)
      // или находится ли она на занятой позиции
      if (row >= colLenght ||
          col < 0 ||
          col >= rowLenght ||
          occupiedPositions.contains(row * rowLenght + col)) {
        return true;
      }
    }
    // если коллизии не найдено, вернем false
    return false;
  }

  ///Метод проверки приземления фигурки
  void _checkLanding() {
    // если фигура идет вниз
    if (_checkCollision(Directions.down)) {
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLenght).floor();
        int col = currentPiece.position[i] % rowLenght;
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }

      // если фигура приземлилась, то создаем новую
      _createNewPiece();
    }
  }

  ///Метод создания фигуры
  void _createNewPiece() {
    // рандомные фигурки
    Random rand = Random();

    Tetromino randomType =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();

    // при создании новой фигуры проверяем, проиграл ли игрок
    if (_isGameOver()) {
      _gameOver = true;
    }
  }

  ///Двигать фигуру <--- (использовать setState в виджете)
  void moveLeft() {
    // проверить можно ли двигаться
    if (!_checkCollision(Directions.left)) {
      currentPiece.movePiece(Directions.left);
    }
    setStateFunction();
  }

  ///Метод: Двигать фигуру ---> (использовать setState в виджете)
  void moveRight() {
    // проверить можно ли двигаться
    if (!_checkCollision(Directions.right)) {
      currentPiece.movePiece(Directions.right);
    }
    setStateFunction();
  }

  ///Метод: Двигать фигуру вниз (использовать setState в виджете)
  void moveDown() {
    // проверить можно ли двигаться
    if (!_checkCollision(Directions.down)) {
      currentPiece.movePiece(Directions.down);
    }
    setStateFunction();
  }

  ///Метод: Вращать фигурку по часовой стрелке (использовать setState в виджете)
  void rotatePiece() {
    // проверить можно ли двигаться
    if (!_checkCollision(Directions.right)) {
      currentPiece.rotatePeice();
    }
    setStateFunction();
  }

  ///Метод очищения линии - смысл игры
  void _clearLines() {
    // просматриваем все игровое поле с низу вверх
    for (int row = colLenght - 1; row >= 0; row--) {
      // переменная для отслеживания, что линия заполнена
      bool rowIsFull = true;
      // проверяем
      for (int col = 0; col < rowLenght; col++) {
        // если пустая колонка то false и конец циклу
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }

      // если линия пустая чистим
      if (rowIsFull) {
        // двигаем все фигурки на 1 позицию вниз
        for (int r = row; r > 0; r--) {
          //скопировать строку
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }
        // очищаем
        gameBoard[0] = List.generate(row, (index) => null);
        // увеличим кол-во очков
        currentScore++;
      }
    }
  }

  /// Метод проверки окончания игры
  bool _isGameOver() {
    // проверить заполенна ли верхняя строка
    for (int col = 0; col < rowLenght; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }

    // если такого нет
    return false;
  }

  /// Метод остановки игры
  void pauseGame() {
    _gamePause = true;
  }

  /// Метод возобновления игры
  void resumeGame() {
    startGame();
    _gamePause = false;
  }
}
