﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриЗагрузкеДанныхИзНастроекНаСервере(Настройки)
	
	Если Настройки.Получить("Ответственный")<>Неопределено Тогда
		УстановитьОтборПоОтветственному(Список, Ответственный);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ОтборОтветственныйПриИзменении(Элемент)
	
	УстановитьОтборПоОтветственному(Список, Ответственный);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьОтборПоОтветственному(Список, Ответственный)
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,
																			"Ответственный",
																			Ответственный,
																			ВидСравненияКомпоновкиДанных.Равно,
																			,
																			ЗначениеЗаполнено(Ответственный));
	
КонецПроцедуры

#КонецОбласти