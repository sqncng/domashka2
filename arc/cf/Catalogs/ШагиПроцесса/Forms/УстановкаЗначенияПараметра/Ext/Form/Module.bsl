﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ДопПараметры = Новый Структура;
	ПараметрыПроцесса      = Тестирование.ПараметрыПроцесса(Параметры.Процесс);
	ПараметрыШаговПроцесса = Тестирование.ПараметрыШаговПроцессаПоСценарию(Параметры.Процесс,Параметры.ШагПроцесса);
	
	ТаблицаПараметров.Очистить();
	
	НомерПараметра = 0;
	Для Каждого СтрокаПараметрыПроцесса Из ПараметрыПроцесса Цикл
		НомерПараметра = НомерПараметра + 1;
		СтрокаТаблицаПараметров = ТаблицаПараметров.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаТаблицаПараметров,СтрокаПараметрыПроцесса);
		СтрокаТаблицаПараметров.НомерПараметра = НомерПараметра;
		СтрокаТаблицаПараметров.Источник = "Общий параметр";
		
		
		Если СтрокаТаблицаПараметров.Источник = Параметры.ШагПроцессаЗначениеПоСсылке 
			И СтрокаТаблицаПараметров.Имя = Параметры.ИмяПараметраПоСсылке Тогда
				СтрокаТаблицаПараметров.АктивнаяСтрока = Истина;
		ИначеЕсли СтрокаТаблицаПараметров.Источник = "Общий параметр"
			И СтрокаТаблицаПараметров.Имя = Параметры.ИмяПараметраПоСсылке Тогда
				СтрокаТаблицаПараметров.АктивнаяСтрока = Истина;
		КонецЕсли;	 
	КонецЦикла;	 
	
	
	Для Каждого СтрокаПараметрыШаговПроцесса Из ПараметрыШаговПроцесса Цикл
		НомерПараметра = НомерПараметра + 1;
		СтрокаТаблицаПараметров = ТаблицаПараметров.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаТаблицаПараметров,СтрокаПараметрыШаговПроцесса);
		СтрокаТаблицаПараметров.НомерПараметра = НомерПараметра;
		СтрокаТаблицаПараметров.Источник = СтрокаПараметрыШаговПроцесса.ШагПроцесса;
		
		
		Если СтрокаТаблицаПараметров.Источник = Параметры.ШагПроцессаЗначениеПоСсылке 
			И СтрокаТаблицаПараметров.Имя = Параметры.ИмяПараметраПоСсылке Тогда
				СтрокаТаблицаПараметров.АктивнаяСтрока = Истина;
		КонецЕсли;	 
	КонецЦикла;	 
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Для Каждого СтрокаТаблицаПараметров Из ТаблицаПараметров Цикл
		Если СтрокаТаблицаПараметров.АктивнаяСтрока Тогда
			Элементы.ТаблицаПараметров.ТекущаяСтрока = СтрокаТаблицаПараметров.ПолучитьИдентификатор();
		КонецЕсли;	 
	КонецЦикла;	 
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийТаблицаПараметров

&НаКлиенте
Процедура ТаблицаПараметровВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	Если ВыбраннаяСтрока = Неопределено Тогда
		Возврат;
	КонецЕсли;	 
	
	Данные = ТаблицаПараметров[ВыбраннаяСтрока];
	ВозвращаемоеЗначение = Новый Структура;
	ВозвращаемоеЗначение.Вставить("УстановкаПараметра",ПолучитьЗначенияПараметров(Данные));
	ОповеститьОВыборе(ВозвращаемоеЗначение);
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаПараметровЗначениеПроизвольноеПриИзменении(Элемент)
	Элемент.Родитель.ТекущиеДанные.Значение              = Неопределено;
	Элемент.Родитель.ТекущиеДанные.КлючЗначенияПараметра = Неопределено;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОК(Команда)
	Если Элементы.ТаблицаПараметров.ТекущиеДанные = Неопределено Тогда
		Закрыть();
	КонецЕсли;	 
	
	ОповеститьОВыборе(ПолучитьЗначенияПараметров(Элементы.ТаблицаПараметров.ТекущиеДанные));
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Функция ПолучитьЗначенияПараметров(Данные)
	Структура = Новый Структура;
	Структура.Вставить("Источник",Данные.Источник);
	Структура.Вставить("Имя",Данные.Имя);
	Структура.Вставить("ТипПараметра",Данные.ТипПараметра);
	Структура.Вставить("Значение",Данные.Значение);
	Структура.Вставить("ЗначениеПроизвольное",Данные.ЗначениеПроизвольное);
	Возврат Структура;
КонецФункции	

#КонецОбласти