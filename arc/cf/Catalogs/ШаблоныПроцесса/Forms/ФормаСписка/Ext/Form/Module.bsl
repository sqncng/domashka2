﻿

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьУсловноеОформление();
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ЗадачиПроцессов.ЗаполнитьСписокВыбораДоступныхПредметовШаблона(Элементы.ОтборНазначение, Истина);
	УстановитьОтборыПараметрыДинамическогоСписка();
	
КонецПроцедуры

&НаСервере
Процедура ПередЗагрузкойДанныхИзНастроекНаСервере(Настройки)
	
	ОбщегоНазначенияСППРКлиентСервер.ОтборПоЗначениюСпискаПередЗагрузкойИзНастроек(Список,
	                                                                               "Статус",
	                                                                               Статус,
	                                                                               СтруктураБыстрогоОтбора, 
	                                                                               Настройки);
	
	ОбщегоНазначенияСППРКлиентСервер.ОтборПоЗначениюСпискаПередЗагрузкойИзНастроек(Список,
	                                                                               "Ответственный",
	                                                                               Ответственный,
	                                                                               СтруктураБыстрогоОтбора, 
	                                                                               Настройки);
	
	ОбщегоНазначенияСППРКлиентСервер.ОтборПоЗначениюСпискаПередЗагрузкойИзНастроек(Список,
	                                                                               "ТипПредмета",
	                                                                               ТипПредмета,
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

&НаКлиенте
Процедура ОтбррОтветственныйПриИзменении(Элемент)
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,
	                                                                        "Ответственный",
	                                                                        Ответственный,
	                                                                        ВидСравненияКомпоновкиДанных.Равно,
	                                                                        ,
	                                                                        ЗначениеЗаполнено(Ответственный));
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборНазначениеПриИзменении(Элемент)
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,
	                                                                        "ТипПредмета",
	                                                                        ТипПредмета,
	                                                                        ВидСравненияКомпоновкиДанных.Равно,
	                                                                        ,
	                                                                        ЗначениеЗаполнено(ТипПредмета));

	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьОтборыПараметрыДинамическогоСписка()

	ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(Список, "СтрокаДляВсехПредметов", НСтр("ru = 'Для всех предметов'"));
	СтруктураБыстрогоОтбора = Неопределено;
	
	ОбщегоНазначенияСППРКлиентСервер.ОтборПоЗначениюСпискаПриСозданииНаСервере(Список,
	                                                                           "Статус",
	                                                                           Статус,
	                                                                           СтруктураБыстрогоОтбора);
	
	ОбщегоНазначенияСППРКлиентСервер.ОтборПоЗначениюСпискаПриСозданииНаСервере(Список,
	                                                                           "Ответственный",
	                                                                           Ответственный,
	                                                                           СтруктураБыстрогоОтбора);
	
	ОбщегоНазначенияСППРКлиентСервер.ОтборПоЗначениюСпискаПриСозданииНаСервере(Список,
	                                                                           "ТипПредмета",
	                                                                           ТипПредмета,
	                                                                           СтруктураБыстрогоОтбора);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьУсловноеОформление()
	
	// Условное оформление динамического списка "Список"
	СписокУсловноеОформление = Список.КомпоновщикНастроек.Настройки.УсловноеОформление;
	СписокУсловноеОформление.Элементы.Очистить();
	
#Область ТипПредмета
	
	// Выделение цветом состояния "Не действует"
	Элемент = СписокУсловноеОформление.Элементы.Добавить();
	Элемент.Представление = НСтр("ru = 'Выделение цветом статус ""Не действует""'");
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Статус");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Перечисления.СтатусыШаблонаПроцесса.НеАктуален;
	
	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.ЗакрытыйДокумент);
	
	#КонецОбласти

КонецПроцедуры

#КонецОбласти
