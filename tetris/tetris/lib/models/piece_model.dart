/// Author: Eargosha
import 'package:flutter/material.dart';
import 'package:tetris/values.dart';

/// Класс фигурки. Типы фигурок описаны в Tetromino(): L, J, I, O, S, Z, T
class Piece {
  // Тип одной фигуры
  Tetromino type;

  Piece({required this.type});

  // Одна фигурка есть список чисел, что указывают на ячейку grid, в position этот список чисел и находится
  List<int> position = [];

  Color get color {
    return tetrominoColors[type] ?? Color.fromARGB(255, 255, 254, 254);
  }

  // Генератор фигур
  void initializePiece() {
    switch (type) {
      case Tetromino.L:
        position = [
          -26,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.J:
        position = [
          -25,
          -15,
          -5,
          -6,
        ];
        break;
      case Tetromino.I:
        position = [
          -4,
          -5,
          -6,
          -7,
        ];
        break;
      case Tetromino.O:
        position = [
          -15,
          -16,
          -5,
          -6,
        ];
        break;
      case Tetromino.S:
        position = [
          -15,
          -14,
          -6,
          -5,
        ];
      case Tetromino.Z:
        position = [
          -17,
          -16,
          -6,
          -5,
        ];
      case Tetromino.T:
        position = [
          -26,
          -16,
          -6,
          -15,
        ];
        break;

      default:
    }
  }

  // Метод движения фигуры
  void movePiece(Directions direction) {
    switch (direction) {
      case Directions.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rowLenght;
        }
        break;
      case Directions.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
      case Directions.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;
      default:
    }
  }

  // метод повора фигуры
  int rotationState = 1;
  void rotatePeice() {
    // новая позиция
    List<int> newPosition = [];

    switch (type) {
      //L
      case Tetromino.L:
        switch (rotationState) {
          case 0:
            // создание новой позиции
            newPosition = [
              position[1] - rowLenght,
              position[1],
              position[1] + rowLenght,
              position[1] + rowLenght + 1,
            ];
            // проверка на правильность позиции
            if (_piecePositionIsValid(newPosition)) {
              // обновление позиции и состояния поворота
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLenght - 1,
            ];
            // проверка на правильность позиции
            if (_piecePositionIsValid(newPosition)) {
              // обновление позиции и состояния поворота
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] + rowLenght,
              position[1],
              position[1] - rowLenght,
              position[1] - rowLenght - 1,
            ];
            // проверка на правильность позиции
            if (_piecePositionIsValid(newPosition)) {
              // обновление позиции и состояния поворота
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[1] - rowLenght + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            // проверка на правильность позиции
            if (_piecePositionIsValid(newPosition)) {
              // обновление позиции и состояния поворота
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      //J
      case Tetromino.J:
        switch (rotationState) {
          case 0:
            // создание новой позиции
            newPosition = [
              position[1] - rowLenght,
              position[1],
              position[1] + rowLenght,
              position[1] + rowLenght - 1,
            ];
            // проверка на правильность позиции
            if (_piecePositionIsValid(newPosition)) {
              // обновление позиции и состояния поворота
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - rowLenght - 1,
              position[1],
              position[1] - 1,
              position[1] + 1,
            ];
            // проверка на правильность позиции
            if (_piecePositionIsValid(newPosition)) {
              // обновление позиции и состояния поворота
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] + rowLenght,
              position[1],
              position[1] - rowLenght,
              position[1] - rowLenght + 1,
            ];
            // проверка на правильность позиции
            if (_piecePositionIsValid(newPosition)) {
              // обновление позиции и состояния поворота
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] + rowLenght + 1,
            ];
            // проверка на правильность позиции
            if (_piecePositionIsValid(newPosition)) {
              // обновление позиции и состояния поворота
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      //I
      case Tetromino.I:
        switch (rotationState) {
          case 0:
            // создание новой позиции
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2,
            ];
            // проверка на правильность позиции
            if (_piecePositionIsValid(newPosition)) {
              // обновление позиции и состояния поворота
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - rowLenght,
              position[1],
              position[1] + rowLenght,
              position[1] + 2 * rowLenght,
            ];
            // проверка на правильность позиции
            if (_piecePositionIsValid(newPosition)) {
              // обновление позиции и состояния поворота
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2,
            ];
            // проверка на правильность позиции
            if (_piecePositionIsValid(newPosition)) {
              // обновление позиции и состояния поворота
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[1] + rowLenght,
              position[1],
              position[1] - rowLenght,
              position[1] - 2 * rowLenght,
            ];
            // проверка на правильность позиции
            if (_piecePositionIsValid(newPosition)) {
              // обновление позиции и состояния поворота
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          }
        break;
      //O
      case Tetromino.O:
        // А вот O это O, вращай не вращай ничего не получишь
        break;
      //S
      case Tetromino.S:
        switch (rotationState) {
          case 0:
            // создание новой позиции
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLenght - 1,
              position[1] + rowLenght,
            ];
            // проверка на правильность позиции
            if (_piecePositionIsValid(newPosition)) {
              // обновление позиции и состояния поворота
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[0] - rowLenght,
              position[0],
              position[0] + 1,
              position[0] + rowLenght + 1,
            ];
            // проверка на правильность позиции
            if (_piecePositionIsValid(newPosition)) {
              // обновление позиции и состояния поворота
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLenght - 1,
              position[1] + rowLenght,
            ];
            // проверка на правильность позиции
            if (_piecePositionIsValid(newPosition)) {
              // обновление позиции и состояния поворота
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[0] - rowLenght,
              position[0],
              position[0] + 1,
              position[0] + rowLenght + 1,
            ];
            // проверка на правильность позиции
            if (_piecePositionIsValid(newPosition)) {
              // обновление позиции и состояния поворота
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          }
        break;  
      //Z
      case Tetromino.Z:
        switch (rotationState) {
          case 0:
            // создание новой позиции
            newPosition = [
              position[0] + rowLenght - 2,
              position[1],
              position[2] + rowLenght - 1,
              position[3] + 1,
            ];
            // проверка на правильность позиции
            if (_piecePositionIsValid(newPosition)) {
              // обновление позиции и состояния поворота
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[0] - rowLenght + 2,
              position[1],
              position[2] - rowLenght + 1,
              position[3] - 1,
            ];
            // проверка на правильность позиции
            if (_piecePositionIsValid(newPosition)) {
              // обновление позиции и состояния поворота
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[0] + rowLenght -2,
              position[1],
              position[2] + rowLenght - 1,
              position[3] + 1,
            ];
            // проверка на правильность позиции
            if (_piecePositionIsValid(newPosition)) {
              // обновление позиции и состояния поворота
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[0] - rowLenght + 2,
              position[1],
              position[2] - rowLenght + 1,
              position[3] - 1,
            ];
            // проверка на правильность позиции
            if (_piecePositionIsValid(newPosition)) {
              // обновление позиции и состояния поворота
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          }
      //T
      case Tetromino.T:
        switch (rotationState) {
          case 0:
            // создание новой позиции
            newPosition = [
              position[2] - rowLenght,
              position[2],
              position[2] + 1,
              position[2] + rowLenght,
            ];
            // проверка на правильность позиции
            if (_piecePositionIsValid(newPosition)) {
              // обновление позиции и состояния поворота
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLenght,
            ];
            // проверка на правильность позиции
            if (_piecePositionIsValid(newPosition)) {
              // обновление позиции и состояния поворота
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] - rowLenght,
              position[1] - 1,
              position[1],
              position[1] + rowLenght,
            ];
            // проверка на правильность позиции
            if (_piecePositionIsValid(newPosition)) {
              // обновление позиции и состояния поворота
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[2] - rowLenght,
              position[2] - 1,
              position[2],
              position[2] + 1,
            ];
            // проверка на правильность позиции
            if (_piecePositionIsValid(newPosition)) {
              // обновление позиции и состояния поворота
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          }
        break;   
    }
  }

  // проверка позиции на правильность, ибо возникали баги в вращении рядом с краями поля
  bool _positionIsValid(int position) {
    // получим позицию
    int row = (position / rowLenght).floor();
    int col = position % rowLenght;

    // если позиция занята, возращаем false
    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    } else {
      return true;
    }
  }

  //проверяем позицию каждой фигурки
  bool _piecePositionIsValid(List<int> piecePosition) {
    // проверка выхода за границы
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    for (int pos in piecePosition) {
      // веренм false если позиция у фигурки забрана
      if (!_positionIsValid(pos)) {
        return false;
      }

      int col = pos % rowLenght;

      // проверить первую и последнюю колонку на занятость
      if (col == 0) {
        firstColOccupied = true;
      }
      if (col == rowLenght - 1) {
        lastColOccupied = true;
      }
    }

    //если первая колонка занята и последняя, то нельзя вращать
    return !(firstColOccupied && lastColOccupied);
  }
}
