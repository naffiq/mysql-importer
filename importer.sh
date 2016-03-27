#!/bin/bash

# Imports sql files from specific folder. Author: naffiq <abdu.galymzhan@gmail.com>

if [ -z $1 ] || [-z $2]; then
	echo "Wrong syntax: ./importer.sh SQLS_FOLDER DBNAME"
	exit
fi

# Получаем хост БД
echo "DB host [127.0.0.1]:"
read input
export dbHost=${input:-127.0.0.1}

# Получаем имя пользователя БД
echo "Username [root]:"
read input
export dbUser=${input:-root}

# Получаем пароль
echo "${dbUser} password [no password]:"
read -s input
export dbPass=${input:-""}

for file in ${1}/*.sql
do
	if [[ -z $dbPass ]]; then
		mysql -h ${dbHost} -u ${dbUser} -D ${2} < ${file}
	else
		mysql -h ${dbHost} -u ${dbUser} -D ${2} -p --password=${dbPass} < ${file}
	fi
done
