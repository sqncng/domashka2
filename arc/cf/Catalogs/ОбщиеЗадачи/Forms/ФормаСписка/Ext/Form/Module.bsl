﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриЗагрузкеДанныхИзНастроекНаСервере(Настройки)
	
	Если Настройки.Получить("Автор")<>Неопределено Тогда
		УстановитьОтборПоАвтору();
	КонецЕсли;
	
	Если Настройки.Получить("Раздел")<>Неопределено Тогда
		УстановитьОтборПоРазделу();
	КонецЕсли;
	
	Если Настройки.Получить("Ответственный")<>Неопределено Тогда
		УстановитьОтборПоОтветственному();
	КонецЕсли;
	
	Если Настройки.Получить("СписокСтатусов")<>Неопределено Тогда
		УстановитьОтборПоСтатусу();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СписокСтатусовПриИзменении(Элемент)
	
	УстановитьОтборПоСтатусу();
	
КонецПроцедуры

&НаКлиенте
Процедура СписокСтатусовНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	СтруктураПараметров = Новый Структура("СписокВыбора", СписокСтатусов);
	
	ОткрытьФорму("Перечисление.СтатусыОбщихЗадач.Форма.ВыборСпискаСтатусов", СтруктураПараметров, Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура СписокСтатусовОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	СписокСтатусов = ВыбранноеЗначение;
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборАвторПриИзменении(Элемент)
	
	УстановитьОтборПоАвтору();
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборРазделПриИзменении(Элемент)
	
	УстановитьОтборПоРазделу();
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборОтветственныйПриИзменении(Элемент)
	
	УстановитьОтборПоОтветственному();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ИзменитьВыделенные(Команда)
	
	ГрупповоеИзменениеОбъектовКлиент.ИзменитьВыделенные(Элементы.Список);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьОтборПоАвтору()
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список, "Автор", Автор, ВидСравненияКомпоновкиДанных.Равно,,ЗначениеЗаполнено(Автор));
		
КонецПроцедуры

&НаСервере
Процедура УстановитьОтборПоРазделу()
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список, "Раздел", Раздел, ВидСравненияКомпоновкиДанных.Равно,,ЗначениеЗаполнено(Раздел));
		
КонецПроцедуры

&НаСервере
Процедура УстановитьОтборПоОтветственному()
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список, "Ответственный", Ответственный, ВидСравненияКомпоновкиДанных.Равно,,ЗначениеЗаполнено(Ответственный));
		
КонецПроцедуры

&НаСервере
Процедура УстановитьОтборПоСтатусу()
	
	ИспользоватьОтбор = СписокСтатусов.Количество()>0;
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,
																			"Статус",
																			СписокСтатусов,
																			ВидСравненияКомпоновкиДанных.ВСписке,
																			,
																			ИспользоватьОтбор);
																			
КонецПроцедуры
																		
#КонецОбласти
