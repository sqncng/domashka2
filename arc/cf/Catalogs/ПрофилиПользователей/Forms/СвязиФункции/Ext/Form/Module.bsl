﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	СписокСвязей = Новый Массив;
	
	Если Параметры.Свойство("СписокСвязей") Тогда
		СписокСвязей = Параметры.СписокСвязей;
	КонецЕсли;
	
	ТекущийПользователь = Пользователи.ТекущийПользователь();
	Список.Параметры.УстановитьЗначениеПараметра("СписокСвязей", СписокСвязей);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийТаблицыСписок

&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ПараметрыФормы = Новый Структура();
	ПараметрыФормы.Вставить("Ключ", Элемент.ТекущиеДанные.Ссылка);
	
	ОткрытьФорму("Справочник.ПрофилиПользователей.ФормаОбъекта", ПараметрыФормы);
	
КонецПроцедуры

#КонецОбласти
