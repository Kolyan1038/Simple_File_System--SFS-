# Файловая система SFS (Simple File System)

Simple File System (SFS) — это простая файловая система, реализованная с использованием FUSE (Filesystem in Userspace) на языке программирования C. Она представляет собой учебный проект, демонстрирующий основные принципы работы файловых систем.

## Содержание

- [Установка зависимостей](#установка-зависимостей)
- [Описание](#описание)
- [Структура данных](#структура-данных)
- [Функциональность](#функциональность)
- [Использование](#использование)
- [Примечания](#примечания)

## Установка зависимостей

Перед сборкой и запуском файловой системы SFS необходимо установить следующие зависимости:

### GCC (GNU Compiler Collection)

GCC — это набор компиляторов для различных языков программирования, включая C. Для установки GCC на Fedora выполните следующую команду:

```
sudo dnf install gcc
```

### FUSE (Filesystem in Userspace)

FUSE — это модуль ядра, который позволяет создавать файловые системы в пространстве пользователя. Для установки FUSE на Fedora выполните следующие команды:

```
sudo dnf install fuse-devel
sudo modprobe fuse
```

> **Примечание:** Если используется FUSE 3, возможно потребуется заменить `fuse` на `fuse3` в некоторых командах и заголовках.

## Описание

Проект состоит из следующих файлов:

1. `filetype.h` и `filetype.c` — определяют структуру filetype для представления файлов и директорий, а также функции для работы с путями.
2. `fs_init.h` и `fs_init.c` — отвечают за инициализацию файловой системы, включая корневую директорию, сохранение и восстановление состояния.
3. `inode.h` и `inode.c` — содержат структуру inode для хранения метаданных и функции для управления индексными дескрипторами.
4. `operations.h` и `operations.c` — реализуют основные операции файловой системы (FUSE), такие как создание, чтение, запись, удаление и переименование файлов и директорий.
5. `superblock.h` и `superblock.c` — определяют структуру superblock и функции для управления суперблоком и битовыми картами.
6. `utilities.h` и `utilities.c` — предоставляют вспомогательные функции для сериализации, десериализации и работы с путями.
7. `shell.c` — программа, которая монтирует файловую систему SFS в заданную точку монтирования с использованием FUSE.

## Структура данных

Файловая система SFS использует следующие основные структуры данных:

1. `superblock` — заголовок метаданных файловой системы, который отслежива:
   - `data_blocks` — массив блоков данных.
   - `data_bitmap` — битовая карта для отслеживания свободных блоков данных.
   - `inode_bitmap` — битовая карта для отслеживания свободных индексных дескрипторов.
  
3. `inode` — хранит метаданные файла или директории, включая:
   - Номера блоков данных (`datablocks`).
   - Размер, права доступа, идентификаторы пользователя и группы.
   - Временные метки (время создания, изменения, доступа).
  
6. `filetype` — представляет файл или директорию и содержит:
   - Имя, путь, тип (файл или директория).
   - Указатель на связанный `inode`
   - Ссылки на родительскую и дочерние структуры.
   - Количество детей и ссылок.

## Функциональность

На данный момент файловая система SFS поддерживает следующие операции:
- Создание директорий (`sfs_mkdir`)
- Получение атрибутов файлов/директорий (`sfs_getattr`)
- Чтение содержимого директорий (`sfs_readdir`)
- Создание файлов (`sfs_create`)
- Удаление файлов (`sfs_rm`)
- Удаление директорий (`sfs_rmdir`)
- Открытие файлов (`sfs_open`)
- Чтение из файлов (`sfs_read`)
- Запись в файлы (`sfs_write`)
- Переименование файлов/директорий (`sfs_rename`)
- Обновление временных меток (`sfs_utimens`)

## Использование

Для сборки и запуска файловой системы SFS выполните следующие шаги:

1. Убедитесь, что на вашей системе установлены компилятор GCC и библиотека FUSE.
2. Скомпилируйте файлы проекта с помощью утилиты `make` и команды:
```
make clean && make
```
3. Создайте директорию для монтирования файловой системы, например:
```
mkdir ~/sfs_mount
```
4. Для удобного доступа к исполняемому файлу можно добавить путь к `./build/release` в переменную PATH:
Перейдите в папку проекта:
```
cd ~/ваш/путь/к/проекту/
```
4.1 Добавьте путь к исполняемому файлу в PATH:
```
echo 'export PATH=$PATH:'$(pwd)'/build/release' >> ~/.bashrc
source ~/.bashrc
```
4.2 Для временного использования:
```
export PATH=$PATH:$(pwd)/build/release
```
5. Запустите файловую систему SFS с указанием точки монтирования:
```
shell -f ~/sfs_mount
```
6. После завершения работы с файловой системой размонтируйте её с помощью следующей команды:
```
fusermount -u ~/sfs_mount
```
> **Примечание:** Если у вас установлена новая версия FUSE, используйте `fusermount3 -u` вместо `fusermount -u`.

## Примечания

- Файловая система SFS является упрощённой версией и предназначена для обучения и демонстрации основных принципов работы файловых систем.
- Проект находится в стадии разработки, и функциональность может быть расширена в будущем.
- Для получения дополнительной информации и поддержки обратитесь к документации FUSE и другим ресурсам, связанным с разработкой файловых систем.
