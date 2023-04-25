# Bolid Sample

Bolid Sample - приложение для отображения датчиков.

Приложение позволяет пользователю: 
- просматривать список всех датчиков, 
- просматривать полную информацию о датчиках, 
- а также радактировать наименование датчика.

В приложении используется [BLoC], [Go-Router], [Clean Architecture] с 3 слоями (Data, Domain и Presentation), а также утиль-методы.

<br />
<div>
  &emsp;&emsp;&emsp;
  <img src="https://github.com/ProtoCornHub/bolid_sample/blob/main/assets/ios/main.png" alt="Light theme" width="200">
  &emsp;&emsp;&emsp;&emsp;
  <img src="https://github.com/ProtoCornHub/bolid_sample/blob/main/assets/ios/details.png" alt="Dark theme" width="200">  
  &emsp;&emsp;&emsp;&emsp;
  <img src="https://github.com/ProtoCornHub/bolid_sample/blob/main/assets/ios/edit_name.png" alt="Dark theme" width="200">  
</div>
<br />

[Bloc]: https://bloclibrary.dev/#/
[Clean Architecture]: https://tech.tamara.co/architect-your-flutter-app-the-clean-way-with-bloc-703e6a8c2d23
[Go-Router]: https://pub.dev/packages/go_router

# Первый запуск

Проект настроен с фиктивными данными. 

Установите зависимости пакета с помощью

```
flutter pub get
```

# Под капотом

## Управление данными

### MockDataSource

Мок-данные представлены в виде списка с данными о событиях датчиков.

### LocalDataSource

[Hive] — это база данных, написанная на чистом Dart.

В проекте используется лишь одна коллекция "sensors" с тремя методами.

[Hive]: https://pub.dev/packages/hive

## Тесы

Проект тестами не покрыт.
