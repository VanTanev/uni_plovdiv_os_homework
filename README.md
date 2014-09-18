Условия:
========

Направи един BASH скрипт, който прави следното:

1. получава за вход две поддиректории;
2. трябва да се копират всичките файлове от първата поддиректория във втората при следните условия:
  а) ако файловете не съществуват във втората директория, те се копират, като се запазва дървото на поддиректориите;
  б) ако един файл съществува под същото име на мястото, където копираме, независимо от поддиректорията в която се намира:
   б1) ако е със същия размер (може да се провери дали са еднакви), файлът не се копира
   б2) ако е със друг размер, файлът се копира на местото, където е оригинала, но с променено име (напр. 
         document1.txt да стане document1(1).doc), ако има повече от един файл, да получават следващи номера.
   (може да се пита дали да се копира при оригинала или да се пропусне)
  (ако се окаже, че в поддиректорията, където копираме има файлове с еднакви имена, се взима мястото на първия намерен)
3. да се изведе информация, колко файла са копирани и колко файла вече са съществували, там където копираме.

за някои от функциите, може да се използват и предварително компилирани програми на C
