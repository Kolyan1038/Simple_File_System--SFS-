#!/bin/bash

# Используем абсолютный путь или $HOME вместо ~
MOUNT_DIR="$HOME/sfs_mount"

# Проверка существования точки монтирования
if [ ! -d "$MOUNT_DIR" ]; then
    echo "Ошибка: директория монтирования $MOUNT_DIR не существует!"
    echo "Создаю директорию..."
    mkdir -p "$MOUNT_DIR" || {
        echo "Не удалось создать $MOUNT_DIR"
        exit 1
    }
fi

clear
echo "=== Начало тестирования SFS в $MOUNT_DIR ==="

# Функция для проверки выполнения команд
run_test() {
    echo -e "\n$1"
    if eval "$2"; then
        echo "[OK]"
    else
        echo "[ОШИБКА] Команда не выполнена: $2"
        exit 1
    fi
}

# Тест 1: Создание файла
run_test "1. Создание testFile.txt" "touch \"$MOUNT_DIR/testFile.txt\""

# Тест 2: Чтение директории
run_test "2. Содержимое директории:" "ls -la \"$MOUNT_DIR\""

# Тест 3: Запись в файл
run_test "3. Запись 'Test' в файл" "echo "Test" >> \"$MOUNT_DIR/testFile.txt\""

# Тест 4: Чтение файла
run_test "4. Содержимое файла:" "cat \"$MOUNT_DIR/testFile.txt\""

# Тест 5: Создание директории
run_test "5. Создание testDir" "mkdir \"$MOUNT_DIR/testDir\""

# Тест 6: Перемещение файла
run_test "6. Перемещение testFile.txt в testDir" "mv \"$MOUNT_DIR/testFile.txt\" \"$MOUNT_DIR/testDir/\""

# Тест 7: Чтение файла в поддиректории
run_test "7. Содержимое перемещенного файла:" "cat \"$MOUNT_DIR/testDir/testFile.txt\""

# Тест 8: Переименование файла
run_test "8. Переименование в testFile2.txt" "mv \"$MOUNT_DIR/testDir/testFile.txt\" \"$MOUNT_DIR/testDir/testFile2.txt\""

# Тест 9: Дозапись в файл
run_test "9. Добавление строки в файл" "echo \"New line\" >> \"$MOUNT_DIR/testDir/testFile2.txt\""

# Тест 10: Финальное содержимое
run_test "10. Итоговое содержимое файла:" "cat \"$MOUNT_DIR/testDir/testFile2.txt\""

# Тест 11: Содержимое директории
run_test "11. Финальное состояние директории:" "tree \"$MOUNT_DIR\""

echo -e "\n=== Все тесты успешно завершены ==="