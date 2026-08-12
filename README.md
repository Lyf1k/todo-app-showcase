# Task tracker

Приложение-трекер задач с авторизацией, уведомлениями и локальным хранилищем.

**Проект портфолио.**
*Срок выполнения: 3-4 недели*


## Экраны

### Авторизация
![Экран авторизации](readme/auth.png)
![Валидация](readme/auth_validation.png)

### Регистрация
![Экран регистрации](readme/registration.png)
![Валидация](readme/registration_validation.png)

### Задачи
![Экран с задачами](readme/tasks.png)
![Созданные задачи](readme/tasks_w_tasks.png)

### Создание задачи
![Создание задачи](readme/create_task.png)
![Заполненные поля](readme/create_task_w_data.png)

### Настройки
*Пока не реализовано*
![Экран настроек](readme/settings.png)

## Технологии
- **Custom DI + ChangeNotifierProvider + Provider** — прокидывание зависимостей
- **flutter_local_notifications** — уведомления
- **shared_preferences** — локальное хранилище
- **intl** — определение timezone

## Архитектура
Future-first architecture

## Управление состоянием
Используется стандартный `ChangeNotifier`. В дальнейшем планируется миграция на `bloc`.

## Планы
- **Profile** — Добавить UI профиля, смену языка и смена темы приложения.
- **English support** — Интеграция мультиязычности(l10n).
- **ThemeMode** — Смена темы(в последствии через ThemeExtension).


## Дизайн
Самостоятельно разработал в Figma макет.
![Макет фигма](readme/maket_figma.png)


