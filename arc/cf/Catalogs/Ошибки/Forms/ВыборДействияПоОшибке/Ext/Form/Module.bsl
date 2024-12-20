﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	СписокВыбора = Новый СписокЗначений;
	
	Если Параметры.Свойство("СписокВыбора") Тогда
		СписокВыбора = Параметры.СписокВыбора;
	КонецЕсли;
	
	СписокЗначений = Новый СписокЗначений;
	
	СписокЗначений.Добавить("Рассмотреть, исправить, проверить", НСтр("ru='Рассмотреть, исправить, проверить'"));
	СписокЗначений.Добавить("Отработать поручение", НСтр("ru='Отработать поручение'"));
	
	Для Каждого ЭлементСпискаЗначений Из СписокЗначений Цикл
		
		ЭлементСписка = Список.Добавить(ЭлементСпискаЗначений.Значение, ЭлементСпискаЗначений.Представление);
		
		Если СписокВыбора.НайтиПоЗначению(ЭлементСпискаЗначений.Значение)<>Неопределено Тогда
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
