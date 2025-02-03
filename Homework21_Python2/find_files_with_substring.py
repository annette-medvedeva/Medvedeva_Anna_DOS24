import os

def find_files_with_substring(files, substring):
    matching_files = [file for file in files if substring in file]
    return matching_files

def main():
    directory = input("Введите путь к директории: ").strip()
    substring = input("Введите подстроку для поиска в именах файлов: ").strip()

    if not os.path.isdir(directory):
        print("Указанная директория не существует.")
        return

    files = os.listdir(directory)

    matching_files = find_files_with_substring(files, substring)

    if matching_files:
        print("Найденные файлы:")
        for file in matching_files:
            print(file)
    else:
        print("Файлы с указанной подстрокой не найдены.")

    # Записываем результат в файл
    with open("found_files.txt", "w") as f:
        f.write(f"Поиск по подстроке: {substring}\n")
        if matching_files:
            f.write("Найденные файлы:\n" + "\n".join(matching_files) + "\n")
        else:
            f.write("Файлы с указанной подстрокой не найдены.\n")

if __name__ == "__main__":
    main()
