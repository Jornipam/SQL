--Схема БД "Компьютерная фирма" состоит из четырех таблиц:
--1. Product(maker, model, type)
--2. PC(code, model, speed, ram, hd, cd, price)
--3. Laptop(code, model, speed, ram, hd, price, screen)
--4. Printer(code, model, color, type, price)
--Таблица Product представляет производителя (maker), номер модели (model) и тип ('PC' - ПК, 'Laptop' - ПК-блокнот или 'Printer' - принтер). Предполагается, что номера моделей в таблице Product уникальны для всех производителей и типов продуктов. 
--В таблице PC для каждого ПК, однозначно определяемого уникальным кодом – code, указаны модель – model (внешний ключ к таблице Product), скорость - speed (процессора в мегагерцах), объем памяти - ram (в мегабайтах), размер диска - hd (в гигабайтах), скорость считывающего устройства - cd (например, '4x') и цена - price (в долларах). 
--Таблица Laptop аналогична таблице РС за исключением того, что вместо скорости CD содержит размер экрана -screen (в дюймах). В таблице Printer для каждой модели принтера указывается, является ли он цветным - color ('y', если цветной), тип принтера - type (лазерный – 'Laser', струйный – 'Jet' или матричный – 'Matrix') и цена - price.

--Задание №1: Найдите номер модели, скорость и размер жесткого диска для всех ПК стоимостью менее 500 дол. Вывести: model, speed и hd

SELECT model, speed, hd FROM PC
WHERE price < 500

--Задание №2: Найдите производителей принтеров. Вывести: maker

SELECT DISTINCT maker FROM Product
WHERE type = 'printer'

--Задание №3: Найдите номер модели, объем памяти и размеры экранов ПК-блокнотов, цена которых превышает 1000 дол.

SELECT model, ram, screen FROM Laptop
WHERE price > 1000

--Задание №4: Найдите все записи таблицы Printer для цветных принтеров.

SELECT * FROM Printer
WHERE color = 'y'

--Задание №5: Найдите номер модели, скорость и размер жесткого диска ПК, имеющих 12x или 24x CD и цену менее 600 дол.

SELECT model, speed, hd FROM PC
WHERE price < 600 AND (cd = '12x' OR cd = '24x')

--Задание №6: Для каждого производителя, выпускающего ПК-блокноты c объёмом жесткого диска не менее 10 Гбайт, найти скорости таких ПК-блокнотов. Вывод: производитель, скорость.

SELECT DISTINCT Product.maker , Laptop.speed 
FROM Product JOIN Laptop
ON Product.model = Laptop.model
WHERE Laptop.hd >= 10

--Задание №7: Найдите номера моделей и цены всех имеющихся в продаже продуктов (любого типа) производителя B (латинская буква).

SELECT PC.model, price FROM Product JOIN PC
ON Product.model = PC.model
WHERE Product.maker = 'B'
UNION
SELECT Laptop.model, price FROM Product JOIN Laptop
ON Product.model = Laptop.model
WHERE Product.maker = 'B'
UNION
SELECT Printer.model, price FROM Product JOIN Printer
ON Product.model = Printer.model
WHERE Product.maker = 'B'

--Задание №8: Найдите производителя, выпускающего ПК, но не ПК-блокноты.

SELECT  maker
FROM Product
WHERE type = 'PC'
EXCEPT SELECT maker
FROM Product
WHERE type = 'Laptop'

-- или

SELECT Distinct maker FROM Product as Pr
WHERE type = 'PC' AND
maker NOT IN (SELECT Distinct maker FROM Product as Pr
WHERE type = 'Laptop')

--Задание №9: Найдите производителей ПК с процессором не менее 450 Мгц. Вывести: Maker

SELECT DISTINCT maker FROM Product JOIN PC
ON Product.model = PC.model
WHERE PC.speed >= 450

--Задание №10: Найдите модели принтеров, имеющих самую высокую цену. Вывести: model, price

SELECT Product.model, Printer.price FROM Product JOIN Printer 
ON Product.model = Printer.model
WHERE Printer.price = (SELECT MAX(price) FROM Printer)

--Задание №11: Найдите среднюю скорость ПК.

SELECT AVG(speed) FROM PC

--Задание №12: Найдите среднюю скорость ПК-блокнотов, цена которых превышает 1000 дол.

SELECT AVG(speed) FROM Laptop
WHERE price > 1000

--Задание №13: Найдите среднюю скорость ПК, выпущенных производителем A.

SELECT AVG(PC.speed) FROM PC JOIN Product
ON PC.model = Product.model
WHERE maker = 'A'

--Задание №14: Найдите размеры жестких дисков, совпадающих у двух и более PC. Вывести: HD

SELECT hd FROM PC 
GROUP BY hd
HAVING COUNT(hd) >= 2






