#!/bin/bash

# Функция для поиска папок
search_folders() {
    echo "Введите название папки, которую хотите найти:"
    read query

    # Используем find для рекурсивного поиска папок в указанной директории
    results=$(find /var/lib/docker/overlay2/ -type d -name "*$query*")

    # Проверяем, есть ли результаты
    if [ -z "$results" ]; then
        echo "Не найдено папок с названием, содержащим '$query'"
    else
        echo "Результаты поиска:"
        echo "$results" | awk -F/ '{print NR ". Название папки: \033[0;31m" $(NF-3) "/" $(NF-2) "/" $(NF-1) "/" $NF "\033[0m\nАдрес: \033[0;31m" $0 "\033[0m"}'
    fi
}

# Функция для поиска файлов
search_files() {
    echo "Введите название файла, который хотите найти:"
    read query

    # Используем find для рекурсивного поиска файлов в указанной директории
    results=$(find /var/lib/docker/overlay2/ -type f -name "*$query*")

    # Проверяем, есть ли результаты
    if [ -z "$results" ]; then
        echo "Не найдено файлов с названием, содержащим '$query'"
    else
        echo "Результаты поиска:"
        echo "$results" | awk -F/ '{print NR ". Название файла: \033[0;31m" $(NF-3) "/" $(NF-2) "/" $(NF-1) "/" $NF "\033[0m\nАдрес: \033[0;31m" $0 "\033[0m"}'
    fi
}

# Функция для поиска как папок, так и файлов
search_any() {
    echo "Введите название папки или файла, который хотите найти:"
    read query

    # Используем find для рекурсивного поиска папок и файлов в указанной директории
    results=$(find /var/lib/docker/overlay2/ -name "*$query*")

    # Проверяем, есть ли результаты
    if [ -z "$results" ]; then
        echo "Не найдено папок или файлов с названием, содержащим '$query'"
    else
        echo "Результаты поиска:"
        echo "$results" | awk -F/ '{print NR ". Название: \033[0;31m" $(NF-3) "/" $(NF-2) "/" $(NF-1) "/" $NF "\033[0m\nАдрес: \033[0;31m" $0 "\033[0m"}'
    fi
}

# Запрашиваем у пользователя выбор типа поиска
echo "Выберите что искать:"
echo "1. Папку"
echo "2. Файл"
echo "3. Любое"
read choice

# Выполняем соответствующую функцию в зависимости от выбора пользователя
case $choice in
    1)
        search_folders
        ;;
    2)
        search_files
        ;;
    3)
        search_any
        ;;
    *)
        echo "Неверный выбор"
        ;;
esac
