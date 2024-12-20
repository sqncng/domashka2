﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьУсловноеОформление();
	ОбработатьПереданныеПараметры();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ОтборВладелецСпискаПриИзменении(Элемент)
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,
	                                                                        "ВладелецСписка",
	                                                                        ОтборВладелецСписка,
	                                                                        ВидСравненияКомпоновкиДанных.Равно,
	                                                                        ,
	                                                                        ЗначениеЗаполнено(ОтборВладелецСписка));
	
КонецПроцедуры

&НаКлиенте
Процедура ТолькоДействующиеПриИзменении(Элемент)
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,
	                                                                        "Действует",
	                                                                        ТолькоДействующие,
	                                                                        ВидСравненияКомпоновкиДанных.Равно,
	                                                                        ,
	                                                                        ТолькоДействующие = Истина);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийФормы

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
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Действует");
	ОтборЭлемента.ВидСравнения   = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Ложь;
	
	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.ЗакрытыйДокумент);
	
#КонецОбласти

КонецПроцедуры

&НаСервере
Процедура ОбработатьПереданныеПараметры()
	
	Если Параметры.Отбор.Свойство("ВладелецСписка") Тогда
		
		ОтборВладелецСписка = Параметры.Отбор.ВладелецСписка;
		
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,
		                                                                        "ВладелецСписка",
		                                                                        ОтборВладелецСписка,
		                                                                        ВидСравненияКомпоновкиДанных.Равно,
		                                                                        ,
		                                                                        ЗначениеЗаполнено(ОтборВладелецСписка));

		
	КонецЕсли;
	
	Если Параметры.Отбор.Свойство("Действует") Тогда
		
		ТолькоДействующие = Параметры.Отбор.Действует;
		
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,
		                                                                        "Действует",
		                                                                        ТолькоДействующие,
		                                                                        ВидСравненияКомпоновкиДанных.Равно,
		                                                                        ,
		                                                                        ЗначениеЗаполнено(ТолькоДействующие));
		
	КонецЕсли;
	
	Параметры.Отбор.Очистить();
	
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Элементы, "ФормаВыбрать") Тогда
		
		Если Параметры.РежимВыбора Тогда
			
			Элементы.ФормаВыбрать.КнопкаПоУмолчанию = Истина;
			
		Иначе
			
			Элементы.ФормаВыбрать.Видимость = Ложь;
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

