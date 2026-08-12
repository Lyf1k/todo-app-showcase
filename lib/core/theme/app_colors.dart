import 'package:flutter/material.dart';

abstract final class AppColors {
  // ========= Brand (Light) =========

  // Тканевая темно-оливковая закладка
  static const primary = Color(0xFF5F6F52);

  // Цвет текста на закладке
  static const onPrimary = Color(0xFFF8F4EA);

  // ========= Surfaces (Light) =========

  // Деревянный стол
  static const background = Color(0xFFD9CCB5);

  // Лист бумаги
  static const surface = Color(0xFFF7F1E5);

  // Немного состаренная бумага
  static const surfaceVariant = Color(0xFFEDE4D3);

  // ========= Text (Light) =========

  // Чернила
  static const textPrimary = Color(0xFF2E241C);

  // Карандаш
  static const textSecondary = Color(0xFF6F6254);

  // Старые выцветшие записи
  static const textDisabled = Color(0xFFAEA08F);

  // ========= Border (Light) =========

  // Линия карандашом
  static const outline = Color(0xFFD1C5B5);

  // ========= States (Light) =========

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

  // =====================================================
  // ========= Brand (Dark) =========

  // Та же закладка, но при свете ночной лампы — светлее и мягче,
  // чтобы держать контраст на тёмном фоне
  static const primaryDark = Color(0xFF8FA377);

  // Текст на закладке — почти чёрный, для контраста со светлым primary
  static const onPrimaryDark = Color(0xFF1C1712);

  // ========= Surfaces (Dark) =========

  // Тёмная столешница ночью
  static const backgroundDark = Color(0xFF211C17);

  // Бумага при тусклом свете — не белая, а тёплая тёмно-серая
  static const surfaceDark = Color(0xFF2C261F);

  // Слегка более светлый слой поверх бумаги (карточки, поля)
  static const surfaceVariantDark = Color(0xFF362F27);

  // ========= Text (Dark) =========

  // Светлые чернила на тёмной бумаге
  static const textPrimaryDark = Color(0xFFEDE4D3);

  // Приглушённый карандаш
  static const textSecondaryDark = Color(0xFFB3A996);

  // Выцветшие записи, почти не видны
  static const textDisabledDark = Color(0xFF6F6254);

  // ========= Border (Dark) =========

  // Едва заметная линия на тёмной бумаге
  static const outlineDark = Color(0xFF4A4238);

  // ========= States (Dark) =========

  // Зелёная ручка, чуть приглушённая для тёмного фона
  static const successDark = Color(0xFF8FAE79);
  static const onSuccessDark = Color(0xFF1C1712);

  // Красная ручка — чуть теплее и мягче в темноте
  static const errorDark = Color(0xFFC96A5B);
  static const onErrorDark = Color(0xFF1C1712);

  // Жёлтый маркер, приглушённый
  static const warningDark = Color(0xFFE0B96B);
  static const onWarningDark = Color(0xFF1C1712);

  // Напоминание
  static const infoDark = Color(0xFF9DAE83);
  static const onInfoDark = Color(0xFF1C1712);
}
