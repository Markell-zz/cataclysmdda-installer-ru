#!/bin/bash
#Copyright © 2015 Markell Samodurov. All rights reserved
#Cataclysm DDA Installer v 1.0(beta)
clear
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${DIR}
werbs="$( grep "features" ${DIR}/cataclysmdda-0.B/data/motd/en.motd )" || werbs="$( grep "features" ${DIR}/cataclysmdda-0.C/data/motd/en.motd )"
version="$(echo "$werbs" | sed 's/^Major features in //')"
echo "Copyright © 2015 Markell Samodurov. All rights reserved"
echo "Cataclysm DDA Installer by Markell Samodurov is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License"
echo -e "\e[92m           z       z"
echo -e "          z         z"
echo -e "         zz         zz"
echo -e "         zz         zz"
echo -e "        zzz         zzz"
echo -e "        zzz  zzzzz  zzz"
echo -e "        zzzzzzzzzzzzzzz"
echo -e "        zzzzz     zzzzz"
echo -e "      zzzzzzz     zzzzzzz"
echo -e "      zzzzzzzzz zzzzzzzzz"
echo -e "    zz     zzzz zzzz    zz"
echo -e "   zz    zz  z \e[0m@\e[92m z  zz   zz"
echo -e "   z     zz   z z   zz    z"
echo -e "   z     zz   zzz   zz    z"
echo -e "          zz  zzz  zz"
echo -e "          zzz zzz zzz"
echo -e "           zzzzzzzzz"
echo -e "              zzz"
echo -e "    z        zzzzz      z"
echo -e "     z      zzzzzzz    z"
echo -e "       zzzzzzz   zzzzzzz"
echo "    ====|Добро пожаловать|====   "
echo -e "\e[0m|Cataclysm DDA Installer v 1.0(beta)|"
echo -n "Версия вашей игры " && echo  "${version}" || echo  "0"
while ( [ "$conf" != "1" ] ) do
echo "==|Введите цифру нужной версии|=="
echo "  ____________   ___________________"
echo -e "_|\e[92m1 Стабильная\e[0m|_|\e[31m2 Экспериментальная\e[0m|_"
read vr
echo "==|Введите цифру нужного языка|=="
echo "  _________   _____________"
echo -e "_|\e[44m1 Русский\e[0m|_|\e[104m2 Английский\e[0m|_"
read lang
if [ "$vr" -eq 1 ]; then
  version="\e[92mСтабильная\e[0m"
elif [ "$vr" -eq 2 ]; then
  version="\e[31mЭкспериментальная\e[0m"
fi
if [ "$lang" -eq 1 ]; then
  language="\e[44mРусский\e[0m"
elif [ "$lang" -eq 2 ]; then
  language="\e[104mанглийский\e[0m"
fi
echo -e "====|И так, будет установлена ${version} версия с языком ${language}?|===="
echo "  ____   _____"
echo -e  "_|\e[92m1 Да\e[0m|_|\e[31m2 Нет\e[0m|_"
read conf
done
echo "====|Начинаем установку|===="
if [ "$vr" -eq 1 ]; then
echo "====|Загрузка архива|===="
  wget http://assets.cataclysmdda.com/downloads/linux_binaries/cddasdl-current.tar.gz
echo "====|Распаковка|===="
  tar -xvzf cddasdl-current.tar.gz
  rm cddasdl-current.tar.gz
  chmod 777 cataclysmdda0.B
echo "====|Установка пакетов|===="
  sudo apt-get update
  sudo apt-get install libsdl2-image-2.0-0:i386 libsdl2-ttf-2.0-0:i386 libsdl2-mixer-2.0-0:i386 liblua5.1-0-dev:i386 && echo -e "\e[92mok\e[0m" || echo -e "\e[101merror\e[0m"
  if [ "$lang" -eq 1 ]; then
echo "====|Установка русского языка|===="
  cd cataclysmdda-0.B/lang/mo/ru/LC_MESSAGES/
  rm cataclysm-dda.mo
  #wget https://docs.google.com/uc?authuser=0&id=0B6DJnmJjyDYReFdScWRCWUw1X1U&export=download
  cd ${DIR}
  cp src/ru/0.B/cataclysm-dda.mo cataclysmdda-0.B/lang/mo/ru/LC_MESSAGES/
  cd ${DIR}/cataclysmdda-0.B/
  sudo chmod 777 ./cataclysm-tiles
  echo "!++++|Для продолжения закройте игру|++++!"
  sleep 4
  ./cataclysm-tiles && echo -e "\e[92mok\e[0m" || echo -e "\e[101merror\e[0m"
  sleep 2
  cp ${DIR}/src/font/TerminusBold.ttf ${DIR}/cataclysmdda-0.B/data/font/
  cd ${DIR}/cataclysmdda-0.B/config/
  rm fonts.json
  cp ${DIR}/src/font/fonts.json ${DIR}/cataclysmdda-0.B/config/
fi
echo "====|Установка завершена!|===="
  echo "Показать список изменений? y/n"
  read readcl
  if [ ${readcl} = "y" ]; then
    echo "Для выхода из редактора нажмите ctrl+x"
    sleep 4
    nano ${DIR}/cataclysmdda-0.B/data/motd/ru.motd
  fi
elif [ "$vr" -eq 2 ]; then
  getArray() {
      local i=0
      array=""
      while IFS= read -r line
      do
          array=$line
      done < "$1"
  }

  getArray "experimental_name.txt"
 echo "====|Загрузка архива|===="
  wget http://dev.narc.ro/cataclysm/jenkins-latest/Linux/Tiles/${array}
 echo "====|Распаковка|===="
  tar -xvzf ${array}
  rm ${array}
  chmod 777 cataclysmdda0.C
 echo "====|Установка пакетов|===="
  sudo apt-get update
  sudo apt-get install libsdl2-image-2.0-0:i386 libsdl2-ttf-2.0-0:i386 libsdl2-mixer-2.0-0:i386 liblua5.1-0-dev:i386 & sudo apt-get remove liblua5.1-0-dev:i386 & sudo apt-get autoremove & sudo apt-get install liblua5.2-0-dev:i386 && echo -e "\e[92mok\e[0m" || echo -e "\e[101merror\e[0m"
  if [ "$lang" -eq 1 ]; then
  echo "====|Установка русского языка|===="
  cd cataclysmdda-0.C/lang/mo/ru/LC_MESSAGES/
  rm cataclysm-dda.mo
  #wget https://docs.google.com/uc?authuser=0&id=0B6DJnmJjyDYReFdScWRCWUw1X1U&export=download
  cd ${DIR}
  cp src/ru/0.C/cataclysm-dda.mo cataclysmdda-0.C/lang/mo/ru/LC_MESSAGES/
  cd ${DIR}/cataclysmdda-0.C/
  sudo chmod 777 ./cataclysm-tiles
  echo "!++++|Для продолжения закройте игру|++++!"
  sleep 4
  ./cataclysm-tiles && echo -e "\e[92mok\e[0m" || echo -e "\e[101merror\e[0m"
  sleep 2
  cp ${DIR}/src/font/TerminusBold.ttf ${DIR}/cataclysmdda-0.C/data/font/
  cd ${DIR}/cataclysmdda-0.C/config/
  rm fonts.json
  cp ${DIR}/src/font/fonts.json ${DIR}/cataclysmdda-0.C/config/
fi
  echo "====|Установка завершена!|===="
  echo "Показать список изменений? y/n"
  read readcl
  if [ ${readcl} = "y" ]; then
    echo "Для выхода из редактора нажмите ctrl+x"
    sleep 4
    nano ${DIR}/cataclysmdda-0.C/data/motd/ru.motd
  fi
fi
