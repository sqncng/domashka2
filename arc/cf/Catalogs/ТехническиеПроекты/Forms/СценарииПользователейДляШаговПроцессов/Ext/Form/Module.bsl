﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ШагиПроцессов = ШагиПроцессов(Параметры.Процессы);
	
	Ном = 0;
	Для Каждого СтрокаШагиПроцессов Из ШагиПроцессов Цикл
		СтрокаШагиПроцессовИСценарии = ШагиПроцессовИСценарииОригинал.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаШагиПроцессовИСценарии,СтрокаШагиПроцессов);
		Ном = Ном + 1;
		СтрокаШагиПроцессовИСценарии.НомерСтрокиОригинал = Ном;
	КонецЦикла;	 
	
	Ном = 0;
	Для Каждого СтрокаШагиПроцессовИСценарииОригинал Из ШагиПроцессовИСценарииОригинал Цикл
		Ном = Ном + 1;
		СтрокаШагиПроцессовИСценарии = ШагиПроцессовИСценарии.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаШагиПроцессовИСценарии,СтрокаШагиПроцессовИСценарииОригинал);
		СтрокаШагиПроцессовИСценарии.СтрокаОригинал = СтрокаШагиПроцессовИСценарииОригинал.НомерСтрокиОригинал;
		СтрокаШагиПроцессовИСценарии.НомерСтроки = Ном;
	КонецЦикла;	 
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПеренестиИЗакрыть(Команда)
	ПеренестиДанные(Истина);
КонецПроцедуры

&НаКлиенте
Процедура Перенести(Команда)
	ПеренестиДанные(Ложь);
КонецПроцедуры

&НаКлиенте
Процедура СоздатьИНазначитьСценарий(Команда)
	ВыделенныеСтроки = Элементы.Сценарии.ВыделенныеСтроки;
	Если ВыделенныеСтроки = Неопределено Тогда
		Возврат;
	КонецЕсли;	
	
	Если ВыделенныеСтроки.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;	
	
	КоличествоЗаполненныхСценариев = 0;
	Для Каждого ИдСтроки Из ВыделенныеСтроки Цикл
		СтрокаТаблицы = ШагиПроцессовИСценарии.НайтиПоИдентификатору(ИдСтроки);
		Если ЗначениеЗаполнено(СтрокаТаблицы.СценарийРаботыПользователя) Тогда
			КоличествоЗаполненныхСценариев = КоличествоЗаполненныхСценариев + 1;
		КонецЕсли;	 
	КонецЦикла;	 
	
	Если КоличествоЗаполненныхСценариев > 0 Тогда
		ТекстИсключения = 
		   НСтр("ru = 'Нельзя назначить новый сценарий, т.к. выбраны строки, в которых уже указан сценарий.'");
		ВызватьИсключение ТекстИсключения;
	КонецЕсли;	 
	
	ПараметрыФормы = Новый Структура;
	СтрокаТаблицы = ШагиПроцессовИСценарии.НайтиПоИдентификатору(ВыделенныеСтроки[0]);
 	ПараметрыФормы.Вставить("Наименование", СтрокаТаблицы.ИмяШага);
 	ПараметрыФормы.Вставить("РазрешеноИспользоватьВПроцессах", Истина);
	ОткрытьФорму("Справочник.СценарииРаботыПользователей.Форма.СозданиеНовогоСценария",
	    ПараметрыФормы,Элементы.Сценарии, УникальныйИдентификатор);
КонецПроцедуры

&НаКлиенте
Процедура ОбъединитьСценарии(Команда)
	ВыделенныеСтроки = Элементы.Сценарии.ВыделенныеСтроки;
	Если ВыделенныеСтроки = Неопределено Тогда
		Возврат;
	КонецЕсли;	
	
	Если ВыделенныеСтроки.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;	
	
	СценарийРаботыПользователя = Неопределено;
	КоличествоЗаполненныхСценариев = 0;
	Для Каждого ИдСтроки Из ВыделенныеСтроки Цикл
		СтрокаТаблицы = ШагиПроцессовИСценарии.НайтиПоИдентификатору(ИдСтроки);
		Если ЗначениеЗаполнено(СтрокаТаблицы.СценарийРаботыПользователя) Тогда
			СценарийРаботыПользователя = СтрокаТаблицы.СценарийРаботыПользователя;
			КоличествоЗаполненныхСценариев = КоличествоЗаполненныхСценариев + 1;
		КонецЕсли;	 
	КонецЦикла;	 
	
	Если КоличествоЗаполненныхСценариев > 1 Тогда
		ТекстИсключения = 
		    НСтр("ru = 'Нельзя назначить новый сценарий, т.к. выбрано больше одной строки, в которой уже указан сценарий.'");
		ВызватьИсключение ТекстИсключения;
	КонецЕсли;
	
	Если КоличествоЗаполненныхСценариев = 0 Тогда
		ТекстИсключения = 
		    НСтр("ru = 'Нельзя назначить новый сценарий, т.к. не выбрано ни одной строки, где уже указан сценарий.'");
		ВызватьИсключение ТекстИсключения;
	КонецЕсли;
	
	Для Каждого ИдСтроки Из ВыделенныеСтроки Цикл
		СтрокаТаблицы = ШагиПроцессовИСценарии.НайтиПоИдентификатору(ИдСтроки);
		Если НЕ ЗначениеЗаполнено(СтрокаТаблицы.СценарийРаботыПользователя) Тогда
			СтрокаТаблицы.СценарийРаботыПользователя = СценарийРаботыПользователя;
			СтрокаТаблицы.СтрокаИзменена = Истина;
			СтрокаШагиПроцессовИСценарииОригинал =
					ШагиПроцессовИСценарииОригинал.НайтиСтроки(Новый Структура("НомерСтрокиОригинал",СтрокаТаблицы.СтрокаОригинал));
			СтрокаШагиПроцессовИСценарииОригинал[0].СценарийРаботыПользователя = СценарийРаботыПользователя;
			СтрокаШагиПроцессовИСценарииОригинал[0].СтрокаИзменена = Истина;
		КонецЕсли;	 
	КонецЦикла;	 
	
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ФильтрПоШагамСоСценариямиПриИзменении(Элемент)
	ОбновитьТаблицуСценариев();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийТаблицыСценарии

&НаКлиенте
Процедура СценарииСценарийПриИзменении(Элемент)
	Если Элементы.Сценарии.ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;	 
	
	СтрокаОригинал = Элементы.Сценарии.ТекущиеДанные.СтрокаОригинал;
	СтрокаШагиПроцессовИСценарииОригинал =
		ШагиПроцессовИСценарииОригинал.НайтиСтроки(Новый Структура("НомерСтрокиОригинал",СтрокаОригинал));
	СтрокаШагиПроцессовИСценарииОригинал[0].СценарийРаботыПользователя =
		Элементы.Сценарии.ТекущиеДанные.СценарийРаботыПользователя;
		
	Элементы.Сценарии.ТекущиеДанные.СтрокаИзменена = Истина;
	СтрокаШагиПроцессовИСценарииОригинал[0].СтрокаИзменена = Истина;
		
	Если ФильтрПоШагамСоСценариями = 2 Тогда
		ОбновитьТаблицуСценариев();
	КонецЕсли;	
КонецПроцедуры

&НаКлиенте
Процедура СценарииОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	Если ТипЗнч(ВыбранноеЗначение) = Тип("Структура") Тогда
		Если ВыбранноеЗначение.Свойство("СозданныйСценарий") Тогда
			ВыделенныеСтроки = Элементы.Сценарии.ВыделенныеСтроки;
			Для Каждого ИдСтроки Из ВыделенныеСтроки Цикл
				СтрокаТаблицы = ШагиПроцессовИСценарии.НайтиПоИдентификатору(ИдСтроки);
				СтрокаТаблицы.СценарийРаботыПользователя = ВыбранноеЗначение.СозданныйСценарий;
				СтрокаТаблицы.СтрокаИзменена = Истина;
				СтрокаШагиПроцессовИСценарииОригинал =
					ШагиПроцессовИСценарииОригинал.НайтиСтроки(Новый Структура("НомерСтрокиОригинал",СтрокаТаблицы.СтрокаОригинал));
				СтрокаШагиПроцессовИСценарииОригинал[0].СценарийРаботыПользователя = ВыбранноеЗначение.СозданныйСценарий;
				СтрокаШагиПроцессовИСценарииОригинал[0].СтрокаИзменена = Истина;
			КонецЦикла;	 
		КонецЕсли;	 
	КонецЕсли;	 
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервереБезКонтекста
Функция ШагиПроцессов(Процессы)
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ШагиПроцесса.Ссылка КАК ШагПроцесса,
		|	ШагиПроцесса.Владелец КАК Процесс,
		|	ШагиПроцесса.Наименование КАК ИмяШага,
		|	ШагиПроцесса.ВложенныйПроцесс КАК ВложенныйПроцесс,
		|	ШагиПроцесса.ТипШага КАК ТипШага,
		|	ШагиПроцесса.СценарийРаботыПользователя КАК СценарийРаботыПользователя,
		|	ШагиПроцесса.ФункцияСистемы КАК ФункцияСистемы
		|ИЗ
		|	Справочник.ШагиПроцесса КАК ШагиПроцесса
		|ГДЕ
		|	ШагиПроцесса.Владелец В(&Процессы)
		|	И НЕ ШагиПроцесса.ПометкаУдаления
		|
		|УПОРЯДОЧИТЬ ПО
		|	ИмяШага";
	
	Запрос.УстановитьПараметр("Процессы", Процессы);
	
	Возврат Запрос.Выполнить().Выгрузить();
КонецФункции	 

&НаКлиенте
Процедура ОбновитьТаблицуСценариев()
	ШагиПроцессовИСценарии.Очистить();
	Ном = 0;
	Для Каждого СтрокаШагиПроцессовИСценарииОригинал Из ШагиПроцессовИСценарииОригинал Цикл
		Если ФильтрПоШагамСоСценариями = 1 Тогда
			Если НЕ ЗначениеЗаполнено(СтрокаШагиПроцессовИСценарииОригинал.СценарийРаботыПользователя) Тогда
				Продолжить;
			КонецЕсли;	 
		ИначеЕсли ФильтрПоШагамСоСценариями = 2 Тогда
			Если ЗначениеЗаполнено(СтрокаШагиПроцессовИСценарииОригинал.СценарийРаботыПользователя) Тогда
				Продолжить;
			КонецЕсли;	 
		КонецЕсли;	 
		
		Ном = Ном + 1;
		СтрокаШагиПроцессовИСценарии = ШагиПроцессовИСценарии.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаШагиПроцессовИСценарии,СтрокаШагиПроцессовИСценарииОригинал);
		СтрокаШагиПроцессовИСценарии.СтрокаОригинал = СтрокаШагиПроцессовИСценарииОригинал.НомерСтрокиОригинал;
		СтрокаШагиПроцессовИСценарии.НомерСтроки = Ном;
	КонецЦикла;	 
КонецПроцедуры 

&НаКлиенте
Функция СтруктураЗначения(СтрокаТаблицы)
	Структура = Новый Структура;
	Структура.Вставить("СценарийРаботыПользователя",СтрокаТаблицы.СценарийРаботыПользователя);
	Структура.Вставить("Процесс",СтрокаТаблицы.Процесс);
	Структура.Вставить("ИмяШага",СтрокаТаблицы.ИмяШага);
	Структура.Вставить("ШагПроцесса",СтрокаТаблицы.ШагПроцесса);
	Структура.Вставить("СтрокаИзменена",СтрокаТаблицы.СтрокаИзменена);
	Возврат Структура;
КонецФункции	 

&НаКлиенте
Процедура ПеренестиДанные(Закрывать)
	Данные = Новый Структура;
	ДанныеСценариев = Новый Массив;
	Для Каждого СтрокаШагиПроцессовИСценарииОригинал Из ШагиПроцессовИСценарииОригинал Цикл
		ДанныеСценариев.Добавить(СтруктураЗначения(СтрокаШагиПроцессовИСценарииОригинал));
	КонецЦикла;	 
	Данные.Вставить("ДанныеСценариев",ДанныеСценариев);
	ЭтаФорма.ЗакрыватьПриВыборе = Закрывать;
	ОповеститьОВыборе(Данные);
КонецПроцедуры 

#КонецОбласти