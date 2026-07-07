import 'package:flutter/material.dart';

abstract final class AppColors {
  // ========= Brand =========

  // Тканевая темно-оливковая закладка
  static const primary = Color(0xFF5F6F52);

  // Цвет текста на закладке
  static const onPrimary = Color(0xFFF8F4EA);

  // ========= Surfaces =========

  // Деревянный стол
  static const background = Color(0xFFD9CCB5);

  // Лист бумаги
  static const surface = Color(0xFFF7F1E5);

  // Немного состаренная бумага
  static const surfaceVariant = Color(0xFFEDE4D3);

  // ========= Text =========

  // Чернила
  static const textPrimary = Color(0xFF2E241C);

  // Карандаш
  static const textSecondary = Color(0xFF6F6254);

  // Старые выцветшие записи
  static const textDisabled = Color(0xFFAEA08F);

  // ========= Border =========

  // Линия карандашом
  static const outline = Color(0xFFD1C5B5);

  // ========= States =========

  // Галочка зеленой ручкой
  static const success = Color(0xFF7A9A65);
  static const onSuccess = Color(0xFFF7F1E5);

  // Красная ручка преподавателя
  static const error = Color(0xFFA34A3C);
  static const onError = Color(0xFFF7F1E5);

  // Желтый маркер
  static const warning = Color(0xFFD8A94D);
  static const onWarning = Color(0xFF2E241C);

  // Напоминание
  static const info = Color(0xFFA8B98C);
  static const onInfo = Color(0xFF2E241C);
}
