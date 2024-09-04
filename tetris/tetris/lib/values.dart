/// Author: Eargosha
/// Этот файл содержит в себе так скажем "правила" игры: сетка(кол-во строк и столбцов)
///                                                    направления движения фигурок
///                                                    игровую доску(в ней хранятся положения фигурок, что уже приземлились)
///                                                    перечисление типов фигурок
///                                                    цвета для каждой фигурки
import 'package:flutter/material.dart';

///Обьявление сетки тетриса
int rowLenght = 10;
int colLenght = 15;

///Обьявление направлений для фигурок
enum Directions {
  left,
  right,
  down,
}

/// Оюбявление GameBoard
/// это сетка - матрица, где null есть пустое пространство
/// непустое пространство будет иметь цвет, что означает приземлившеюся фигуру
/// 
/// gameBoard представляет собой двумерную матрицу размером colLenght x rowLenght, где каждый элемент изначально равен null. 
/// Когда падающая фигура приземляется на игровое поле, соответствующие элементы матрицы gameBoard будут заполнены значениями из перечисления Tetromino, 
/// которые представляют тип приземлившейся фигуры. 
/// Например, если фигура типа L приземлится, соответствующие элементы gameBoard будут заполнены значением Tetromino.L.
/// Пример заполнения лежит в картинке "Пример GameBoard" по пути проекта
/// null null null null J null null
/// null null null null J null null

List<List<Tetromino?>> gameBoard = List.generate(
  colLenght,
  (i) => List.generate(
    rowLenght,
    (j) => null,
  ),
);

///Обьявление видов фикрок
enum Tetromino {
  L,
  J,
  I,
  O,
  S,
  Z,
  T,
}

///Обьявление цветов фигурок (тип фигурки : цвет фигурки)
const Map<Tetromino, Color> tetrominoColors = {
  Tetromino.L: Color(0xFFFFA500),
  Tetromino.J: Color.fromARGB(255, 0, 47, 255), 
  Tetromino.I: Color.fromARGB(255, 255, 0, 234), 
  Tetromino.O: Color.fromARGB(255, 251, 255, 0), 
  Tetromino.S: Color.fromARGB(255, 9, 255, 0),
  Tetromino.Z: Color.fromARGB(255, 255, 0, 0), 
  Tetromino.T: Color.fromARGB(255, 132, 0, 255), 
};
