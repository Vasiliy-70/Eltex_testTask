# Eltex_testTask

Авторизация на сервере и вывод информации о пользователе.
При запуске приложения, если авторизация ранее не была произведена, приложение должно показать окно авторизации с предложением ввести username и password (borovik:borovik) (запрос /oauth/token) В случае успешной авторизации и при последующих запусках приложения приложение сразу должно открывать окно информации о пользователе (запрос /user). Из полученного json вывести на экран содержимое полей: roleId, username, email (UILabel), а также список permissions (UITableView).
Показ ошибок запросов осуществлять с помощью класса UIAlertController. Для работы с API использовать класс URLSession.
Документация для выполнения тестового задания
API http://smart.eltex-co.ru:8271/api/v1
Авторизация: POST /oauth/token Authorization: Basic <credentials> Где <credentials> это закодированная по стандарту Base64 строка "ios-client:<password>"
Поля в теле запроса (имя_поля значение): grant_type=password username=<username> password=<password>
Ответ: { access_token: "<new_access_token>", token_type: "bearer", refresh_token: "<new_refresh_token>", expires_in: 3599, scope: "read write trust"  }
Получение информации о пользователе: GET /user Authorization: Bearer <access_token> Где <access_token> это токен, полученный в результате успешной авторизации.
Экран авторизации реализовать на Objective C. Экран информации о пользователе реализовать на Swift. Алгоритм, осуществляющий сетевые запросы реализовать на Swift. Верстку пользовательского интерфейса осуществлять в Storyboard.

