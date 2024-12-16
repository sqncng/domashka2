﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	СписокВыбора = Новый СписокЗначений;
	
	Если Параметры.Свойство("СписокВыбора") Тогда
		СписокВыбора = Параметры.СписокВыбора;
	КонецЕсли;
	
	Список.Добавить("Вчера");
	Список.Добавить("Сегодня");
	Список.Добавить("Завтра");
	Список.Добавить("Потом");
	
	Для Каждого ЭлементСписка из Список Цикл
		Если СписокВыбора.НайтиПоЗначению(ЭлементСписка.Значение)<>Неопределено Тогда
			ЭлементСписка.Пометка = Истина;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОК(Команда)
	
	СписокВыбора = Новый СписокЗначений;
	
	ИсключеныЗначения = Ложь;
	
	Для Каждого ЭлементСписка из Список Цикл
		Если ЭлементСписка.Пометка Тогда
			СписокВыбора.Добавить(ЭлементСписка.Значение);
		Иначе
			ИсключеныЗначения = Истина;
		КонецЕсли;
	КонецЦикла;
	
	Если НЕ ИсключеныЗначения Тогда
		СписокВыбора = Новый СписокЗначений;
	КонецЕсли;
	
	ОповеститьОВыборе(СписокВыбора);
	
КонецПроцедуры

#КонецОбласти
