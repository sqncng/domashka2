﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	СписокВыбора = Новый СписокЗначений;
	
	Если Параметры.Свойство("СписокВыбора") Тогда
		СписокВыбора = Параметры.СписокВыбора;
	КонецЕсли;
	
	Для Каждого Значение Из Метаданные.Перечисления.СтатусыСогласованияИзмененийВВетках.ЗначенияПеречисления Цикл
		
		ЗначениеСсылка = Перечисления.СтатусыСогласованияИзмененийВВетках[Значение.Имя];
		ЭлементСписка = Список.Добавить(ЗначениеСсылка);
		
		Если СписокВыбора.НайтиПоЗначению(ЗначениеСсылка)<>Неопределено Тогда
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
