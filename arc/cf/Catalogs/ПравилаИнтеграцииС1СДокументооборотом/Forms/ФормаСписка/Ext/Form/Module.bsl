﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	СокращенноеНаименованиеКонфигурации = ИнтеграцияС1СДокументооборотБазоваяФункциональность.СокращенноеНаименованиеКонфигурации();
	Если ЗначениеЗаполнено(СокращенноеНаименованиеКонфигурации) Тогда
		Элементы.ПредставлениеОбъектаИС.Заголовок 
			= СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'В %1'"), СокращенноеНаименованиеКонфигурации);
	КонецЕсли;
			
	Если ЗначениеЗаполнено(Параметры.ТипОбъектаИС) Тогда
		ТипОбъектаИС = Параметры.ТипОбъектаИС;
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,
			"ТипОбъектаИС",
			ТипОбъектаИС,
			ВидСравненияКомпоновкиДанных.Равно);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Элементы.ПоказатьУдаленные.Пометка = ПоказыватьУдаленные;
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,
		"ПометкаУдаления",
		Ложь,
		ВидСравненияКомпоновкиДанных.Равно,,
		Не ПоказыватьУдаленные,
		РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный);
		
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	
	Отказ = Истина;
	
	ПараметрыФормы = Новый Структура;
	Если ЗначениеЗаполнено(ТипОбъектаИС) Тогда
		ПараметрыФормы.Вставить("ТипОбъектаИС", ТипОбъектаИС);
	КонецЕсли;
	Если Копирование Тогда
		ПараметрыФормы.Вставить("ЗначениеКопирования", Элементы.Список.ТекущаяСтрока);
	КонецЕсли;
	
	ОткрытьФорму("Справочник.ПравилаИнтеграцииС1СДокументооборотом.Форма.ФормаЭлемента",
		ПараметрыФормы,
		Элементы.Список);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПоказатьУдаленные(Команда)
	
	ПоказыватьУдаленные = Не ПоказыватьУдаленные;
	Элементы.ПоказатьУдаленные.Пометка = ПоказыватьУдаленные;
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,
		"ПометкаУдаления",
		Ложь,
		ВидСравненияКомпоновкиДанных.Равно,,
		Не ПоказыватьУдаленные,
		РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный);
	
КонецПроцедуры

#КонецОбласти