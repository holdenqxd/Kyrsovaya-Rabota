CREATE ROLE db_admin WITH
  SUPERUSER
  CREATEDB
  CREATEROLE
  LOGIN
  PASSWORD 'AdminPassword';

  -- Добавление привилегий на базу данных
GRANT ALL PRIVILEGES ON DATABASE your_database TO db_admin;

-- Добавление привилегий на все таблицы в схеме public
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO db_admin;

-- Добавление привилегий на выполнение всех команд
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO db_admin;

-- Добавление привилегий на выполнение всех последовательностей
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO db_admin;

CREATE ROLE competition_moderator WITH
  CREATEDB
  LOGIN
  PASSWORD 'ModeratorPassword';

  -- Добавление привилегий на создание баз данных
ALTER ROLE competition_moderator CREATEDB;

-- Добавление привилегий на выполнение операций с таблицами
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO competition_moderator;

CREATE ROLE data_analyst WITH
  LOGIN
  PASSWORD 'AnalystPassword';

-- Добавление привилегий на чтение данных из базы данных
GRANT SELECT ON ALL TABLES IN SCHEMA public TO data_analyst;

-- Добавление привилегий на выполнение операций с функциями
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO data_analyst;