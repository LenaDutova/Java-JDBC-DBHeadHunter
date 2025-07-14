import java.sql.*;

public class JDBCRunner {

    private static final String DRIVER = "org.postgresql.Driver";       // Driver name to PostgreSQL

    private static final String PROTOCOL = "jdbc:postgresql://";        // URL-prefix
    private static final String URL_LOCALE = "localhost/";              // ваш компьютер + порт по умолчанию
    private static final String URL_REMOTE = "10.242.65.114:5432/";     // IP-адрес кафедрального сервера + явно порт (по умолчанию)
    private static final String DATABASE_NAME = "head-hunter";          // FIXME имя базы
    private static final String DATABASE_URL = PROTOCOL + URL_LOCALE + DATABASE_NAME;

    private static final String USER_NAME = "postgres";                  // FIXME имя пользователя
    private static final String DATABASE_PASS = "postgres";              // FIXME пароль базы данных

    public static void main(String[] args) {
        // проверка возможности подключения
        if (checkDriver() && checkDB())
            System.out.println("Успешное подключение к базе данных | " + DATABASE_URL + "\n");
        else return;

        // попытка открыть соединение с базой данных, которое java-закроет перед выходом из try-with-resources
        try (Connection connection = DriverManager.getConnection(DATABASE_URL, USER_NAME, DATABASE_PASS)) {
            //TODO show all tables
            getAllVillains(connection);
//            getAllMinions(connection);
//            getAllContracts(connection);

            // TODO show with param
//            getVillainByName(connection, "Грю");
//            getMinionsFromVillainByName(connection, "Грю");

            // TODO correction
//            addMinion(connection, "Тест-1");
//            addMinionAndReturnID(connection, "Тест-2");
//            addMinionAndReturnIt(connection, "Тест-3");
//            addMinionWithEyes(connection, "Тест-4", 10);
//            addMinionWithEyes(connection, "Тест-5", -10);

//            correctMinion(connection, "Тест-1", 400);
//            correctMinion(connection, "Тест-1", 0);

//            removeMinion(connection, "Тест");

        } catch (SQLException e) {
            // При открытии соединения, выполнении запросов могут возникать различные ошибки
            // Согласно стандарту SQL:2008 в ситуациях нарушения ограничений уникальности (в т.ч. дублирования данных) возникают ошибки соответствующие статусу (или дочерние ему): SQLState 23000 - Integrity Constraint Violation
            if (e.getSQLState().startsWith("23")){
                System.out.println("Произошло дублирование данных");
            } else throw new RuntimeException(e);
        }
    }

    // region // Проверка окружения и доступа к базе данных

    public static boolean checkDriver () {
        try {
            Class.forName(DRIVER);
            return true;
        } catch (ClassNotFoundException e) {
            System.out.println("Нет JDBC-драйвера! Подключите JDBC-драйвер к проекту согласно инструкции.");
            throw new RuntimeException(e);
        }
    }

    public static boolean checkDB () {
        try {
            Connection c = DriverManager.getConnection(DATABASE_URL, USER_NAME, DATABASE_PASS);
            return true;
        } catch (SQLException e) {
            System.out.println("Нет подключения к базе данных! Проверьте имя базы, путь к базе или разверните локально резервную копию согласно инструкции");
            throw new RuntimeException(e);
        }
    }

    // endregion

    // region // SELECT-запросы без параметров в одной таблице

    private static void getAllVillains(Connection connection) throws SQLException{
        // имена столбцов
        String column0 = "id", column1 = "name", column2 = "nickname";
        // значения ячеек
        int param0;
        String param1, param2;

        Statement statement = connection.createStatement();     // создаем оператор для простого запроса (без параметров)
        ResultSet rs = statement.executeQuery("SELECT * FROM villains;"); // выполняем запроса на поиск и получаем список ответов

        while (rs.next()) {  // пока есть данные, продвигаться по ним
            param2 = rs.getString(column2); // значение ячейки, можно получить по имени; по умолчанию возвращается строка
            param1 = rs.getString(column1);
            param0 = rs.getInt(column0);    // если точно уверены в типе данных ячейки, можно его сразу преобразовать
            System.out.println(param0 + " | " + param1 + " | " + param2);
        }
        System.out.println();
    }

    static void getAllMinions(Connection connection) throws SQLException {
        // значения ячеек
        int param0 = -1, param2 = -1;
        String param1 = null;

        Statement statement = connection.createStatement();                 // создаем оператор для простого запроса (без параметров)
        ResultSet rs = statement.executeQuery("SELECT * FROM minions;");  // выполняем запроса на поиск и получаем список ответов

        while (rs.next()) {  // пока есть данные
            param0 = rs.getInt(1); // значение ячейки, можно также получить по порядковому номеру (начиная с 1)
            param1 = rs.getString(2);
            param2 = rs.getInt(3);
            System.out.println(param0 + " | " + param1 + " | " + param2);
        }
        System.out.println();
    }

    static void getAllContracts(Connection connection) throws SQLException {
        String param;

        Statement statement = connection.createStatement();             // создаем оператор для простого запроса (без параметров)
        ResultSet rs = statement.executeQuery("SELECT * FROM contracts;");   // выполняем запроса на поиск и получаем список ответов

        int count = rs.getMetaData().getColumnCount();  // сколько столбцов в ответе
        for (int i = 1; i <= count; i++){
            // что в этом столбце?
            System.out.println("position - " + i +
                    ", label - " + rs.getMetaData().getColumnLabel(i) +
                    ", type - " + rs.getMetaData().getColumnType(i) +
                    ", typeName - " + rs.getMetaData().getColumnTypeName(i) +
                    ", javaClass - " + rs.getMetaData().getColumnClassName(i)
            );
        }
        System.out.println();

        while (rs.next()) {  // пока есть данные
            param = "";
            for (int i = 1; i <= count; i++) {
                param += rs.getString(i);
                if (i != count) param += " | ";
            }
            System.out.println(param);
        }
        System.out.println();
    }

    // endregion

    // region // SELECT-запросы с параметрами и объединением таблиц

    private static void getVillainByName(Connection connection, String name) throws SQLException {
        if (connection == null || connection.isClosed()) return; // проверка, что соединение не "сломалось"

        if (name == null || name.isBlank()) return; // проверка "на дурака"

        String param;
        name = '%' + name + '%'; // переданное значение может быть дополнено (%) сначала и/или в конце (часть слова)

        PreparedStatement statement = connection.prepareStatement(
                "SELECT * FROM villains " +
                    "WHERE name LIKE ?;");              // создаем оператор шаблонного-запроса с "включаемыми" параметрами - ?
        statement.setString(1, name);     // "безопасное" добавление параметров в запрос; с учетом их типа и порядка (индексация с 1)
        ResultSet rs = statement.executeQuery();        // выполняем запроса на поиск и получаем список ответов
        int count = rs.getMetaData().getColumnCount();  // сколько столбцов в ответе

        while (rs.next()) {  // пока есть данные перебираем их и выводим
            param = "";
            for (int i = 1; i <= count; i++) {
                param += rs.getString(i);
                if (i != count) param += " | ";
            }
            System.out.println(param);
        }
        System.out.println();
    }

    private static void getMinionsFromVillainByName(Connection connection, String name) throws SQLException {
        if (connection == null || connection.isClosed()) return; // проверка, что соединение не "сломалось"
        if (name == null || name.isBlank()) return;// проверка "на дурака"

        String param;
        name = '%' + name + '%'; // переданное значение может быть дополнено сначала и в конце (часть слова)

        PreparedStatement statement = connection.prepareStatement(
                "SELECT villains.name, minions.name, contracts.payment, contracts.start_date " +
                        "FROM villains " +
                        "JOIN contracts ON villains.id = contracts.id_villain " +
                        "JOIN minions ON minions.id = contracts.id_minion " +
                        "WHERE villains.name LIKE ?;");       // создаем оператор шаблонного-запроса с "включаемыми" параметрами - ?
        statement.setString(1, name);      // "безопасное" добавление параметров в запрос; с учетом их типа и порядка (индексация с 1)
        ResultSet rs = statement.executeQuery();    // выполняем запроса на поиск и получаем список ответов
        int count = rs.getMetaData().getColumnCount();  // сколько столбцов в ответе

        while (rs.next()) {  // пока есть данные перебираем их и выводим
            param = "";
            for (int i = 1; i <= count; i++) {
                param += rs.getString(i);
                if (i != count) param += " | ";
            }
            System.out.println(param);
        }
        System.out.println();
    }

    // endregion

    // region // CUD-запросы на добавление, изменение и удаление записей

    private static void addMinion(Connection connection, String name)  throws SQLException {
        if (connection == null || connection.isClosed()) return; // проверка, что соединение не "сломалось"
        if (name == null || name.isBlank()) return;

        PreparedStatement statement = connection.prepareStatement(
                "INSERT INTO minions(name) VALUES (?);");    // создаем оператор шаблонного-запроса с "включаемыми" параметрами - ?
        statement.setString(1, name);    // "безопасное" добавление имени

        int count = statement.executeUpdate();  // выполняем запрос на коррекцию и возвращаем количество измененных строк
        System.out.println("INSERTed " + count + " minions");

        getAllMinions(connection);
    }

    private static void addMinionWithEyes(Connection connection, String name, int eyesCount)  throws SQLException {
        if (connection == null || connection.isClosed()) return; // проверка, что соединение не "сломалось"
        if (name == null || name.isBlank()) return;

        PreparedStatement statement = connection.prepareStatement(
                "INSERT INTO minions(name, eyes) VALUES (?, ?);");    // создаем оператор шаблонного-запроса с "включаемыми" параметрами - ?
        statement.setString(1, name);    // "безопасное" добавление строки - имени
        statement.setInt(2, eyesCount);    // "безопасное" добавление числа - количества глаз

        int count = statement.executeUpdate();  // выполняем запрос на коррекцию и возвращаем количество измененных строк
        System.out.println("INSERTed " + count + " minions");

        getAllMinions(connection);
    }

    private static void addMinionAndReturnID(Connection connection, String name)  throws SQLException {
        if (connection == null || connection.isClosed()) return; // проверка, что соединение не "сломалось"
        if (name == null || name.isBlank()) return;

        PreparedStatement statement = connection.prepareStatement(
                "INSERT INTO minions(name) VALUES (?) returning id;", Statement.RETURN_GENERATED_KEYS);    // создаем оператор шаблонного-запроса с "включаемыми" параметрами - ?
        statement.setString(1, name);    // "безопасное" добавление имени
        statement.executeUpdate();  // выполняем запрос на коррекцию и возвращаем количество измененных строк

        ResultSet rs = statement.getGeneratedKeys(); // прочитать запрошенные данные от БД
        while (rs.next()) { // прокрутить к первой записи, если они есть
            System.out.println("Идентификатор созданного миньона " + rs.getInt(1));
        }

        getAllMinions(connection);
    }

    private static void addMinionAndReturnIt(Connection connection, String name)  throws SQLException {
        if (connection == null || connection.isClosed()) return; // проверка, что соединение не "сломалось"
        if (name == null || name.isBlank()) return;

        PreparedStatement statement = connection.prepareStatement(
                "INSERT INTO minions(name) VALUES (?) returning *;", Statement.RETURN_GENERATED_KEYS);    // создаем оператор шаблонного-запроса с "включаемыми" параметрами - ?
        statement.setString(1, name);    // "безопасное" добавление имени
        statement.executeUpdate();  // выполняем запрос на коррекцию и возвращаем количество измененных строк

        ResultSet rs = statement.getGeneratedKeys(); // прочитать запрошенные данные от БД
        while (rs.next()) { // прокрутить к первой записи, если они есть
            System.out.println("Идентификатор созданного миньона " + rs.getInt(1) + ", количество глаз " + + rs.getInt(3));
        }

        getAllMinions(connection);
    }

    private static void correctMinion (Connection connection, String name, int eyesCount) throws SQLException {
        if (connection == null || connection.isClosed()) return; // проверка, что соединение не "сломалось"
        if (name == null || name.isBlank() || eyesCount < 0) return;

        PreparedStatement statement = connection.prepareStatement("UPDATE minions SET eyes=? WHERE name=?;");
        statement.setInt(1, eyesCount); // сначала что передаем
        statement.setString(2, name);   // затем по чему ищем

        int count = statement.executeUpdate();  // выполняем запрос на коррекцию и возвращаем количество измененных строк

        System.out.println("UPDATEd " + count + " minions");

        getAllMinions(connection);
    }

    private static void removeMinion(Connection connection, String name) throws SQLException {
        if (connection == null || connection.isClosed()) return; // проверка, что соединение не "сломалось"
        if (name == null || name.isBlank()) return;
        name = '%' + name + '%'; // переданное значение может быть дополнено сначала и в конце (часть слова)

        PreparedStatement statement = connection.prepareStatement("DELETE from minions WHERE name LIKE ?;");
        statement.setString(1, name);

        int count = statement.executeUpdate(); // выполняем запрос на удаление и возвращаем количество измененных строк
        System.out.println("DELETEd " + count + " minions");

        getAllMinions(connection);
    }

    // endregion
}
