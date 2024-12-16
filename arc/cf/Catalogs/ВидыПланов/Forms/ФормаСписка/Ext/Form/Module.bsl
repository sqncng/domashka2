﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьУсловноеОформление();
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	УстановитьОтборыПараметрыДинамическогоСписка();
	
КонецПроцедуры

&НаСервере
Процедура ПередЗагрузкойДанныхИзНастроекНаСервере(Настройки)
	
	ОбщегоНазначенияСППРКлиентСервер.ОтборПоЗначениюСпискаПередЗагрузкойИзНастроек(Список,
	                                                                               "Статус",
	                                                                               Статус,
	                                                                               СтруктураБыстрогоОтбора, 
	                                                                               Настройки);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ОтборСтатусПриИзменении(Элемент)
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,
	                                                                        "Статус",
	                                                                        Статус,
	                                                                        ВидСравненияКомпоновкиДанных.Равно,
	                                                                        ,
	                                                                        ЗначениеЗаполнено(Статус));
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьОтборыПараметрыДинамическогоСписка()
	
	СтруктураБыстрогоОтбора = Неопределено;
	
	ОбщегоНазначенияСППРКлиентСервер.ОтборПоЗначениюСпискаПриСозданииНаСервере(Список,
	                                                                           "Статус",
	                                                                           Статус,
	                                                                           СтруктураБыстрогоОтбора);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьУсловноеОформление()
	
	// Условное оформление динамического списка "Список"
	СписокУсловноеОформление = Список.КомпоновщикНастроек.Настройки.УсловноеОформление;
	СписокУсловноеОформление.Элементы.Очистить();
	
#Область Статус
	
	// Выделение цветом состояния "Не действует"
	Элемент = СписокУсловноеОформление.Элементы.Добавить();
	Элемент.Представление = НСтр("ru = 'Выделение цветом статус ""Не действует""'");
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Статус");
	ОтборЭлемента.ВидСравнения   = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Перечисления.СтатусыВидовПланов.НеАктуален;
	
	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.ЗакрытыйДокумент);
	
#КонецОбласти

КонецПроцедуры

#КонецОбласти

