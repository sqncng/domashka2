﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ИнициализироватьДанныеФормы();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыЯКонтролирую

&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если ВыбраннаяСтрока = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	СтандартнаяОбработка = Ложь;
	
	ДанныеСтроки = Элементы.Список.ДанныеСтроки(ВыбраннаяСтрока);
	
	Если ТипЗнч(ВыбраннаяСтрока) = Тип("СтрокаГруппировкиДинамическогоСписка") Тогда
		
		ПоказатьЗначение( ,ВыбраннаяСтрока.Ключ);
		
	ИначеЕсли Поле.Имя = "СписокОбъектКонтроля" Тогда
		
		ПоказатьЗначение(, ДанныеСтроки.ОбъектКонтроля);
		
	ИначеЕсли Поле.Имя = "СписокТехническийПроект" Тогда
		
		Если ЗначениеЗаполнено(ДанныеСтроки.ТехническийПроект) Тогда
			ПоказатьЗначение(, ДанныеСтроки.ТехническийПроект);
		Иначе
			ПоказатьЗначение(, ДанныеСтроки.ОбъектКонтроля);
		КонецЕсли;
		
	Иначе
		
		ОткрытьФормуУказанияРезультата();
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область КомандыФормы

&НаКлиенте
Процедура ИсторияКонтроля(Команда)
	
	ОчиститьСообщения();
	
	ОбъектыНаКонтролеКлиент.ОткрытьИсториюКонтроляИзСпискаКонтроля(Элементы.Список);
	
КонецПроцедуры

&НаКлиенте
Процедура УказатьРезультат(Команда)
	
	ОткрытьФормуУказанияРезультата();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ОткрытьФормуУказанияРезультата()

	ОчиститьСообщения();
	
	Отказ = Ложь;
	
	ИзменяемыеСтрокиСписка = ОбъектыНаКонтролеКлиент.ИзменяемыеСтрокиСписка(Элементы.Список, Отказ);
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ИзменяемыеСтрокиСписка", ИзменяемыеСтрокиСписка);
	
	ИзменяемыеСтрокиСпискаСписок = Новый СписокЗначений;
	ИзменяемыеСтрокиСпискаСписок.ЗагрузитьЗначения(ИзменяемыеСтрокиСписка);
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ИзменяемыеСтрокиСписка", ИзменяемыеСтрокиСпискаСписок);
	
	ДанныеИзменяемыхСтрок = ОбъектыНаКонтролеКлиент.ДанныеИзменяемыхСтрок(Элементы.Список, ИзменяемыеСтрокиСписка);
	
	ИмяОткрываемойФормы = "ИзменениеРезультат";
	Если ДанныеИзменяемыхСтрок <> Неопределено Тогда
		ПараметрыФормы.Вставить("ТекущееСостояниеДел", ДанныеИзменяемыхСтрок.Результат);
		ПараметрыФормы.Вставить("ДатаКонтроля",        ДанныеИзменяемыхСтрок.ДатаКонтроля);
		ПараметрыФормы.Вставить("Решение",             ДанныеИзменяемыхСтрок.Решение);
	КонецЕсли;
	
	ОповещениеОИзмененииЗаписей = Новый ОписаниеОповещения("ПослеУказанияРезультата", 
	                                                        ЭтотОбъект,
	                                                        ДополнительныеПараметры);
	
	ОткрытьФорму("Обработка.КонтрольОбъектов.Форма.ИзменениеРезультат", 
	             ПараметрыФормы, ЭтотОбъект,,,,
	             ОповещениеОИзмененииЗаписей, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры 


&НаСервере
Процедура ИнициализироватьДанныеФормы()
	
	ТекущийПользователь = Пользователи.ТекущийПользователь();
	
	ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(Список, "ТекущийПользователь", ТекущийПользователь);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеУказанияРезультата(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено
		Или Результат = КодВозвратаДиалога.Отмена Тогда
		
		Возврат;
		
	КонецЕсли;
	
	ОтразитьИзменениеРезультата(Результат, ДополнительныеПараметры.ИзменяемыеСтрокиСписка);
	
	Элементы.Список.Обновить();
	
КонецПроцедуры

&НаСервере
Процедура ОтразитьИзменениеРезультата(СостояниеДел, КлючиЗаписей)
	
	Для Каждого КлючЗаписи Из КлючиЗаписей Цикл
		
		РегистрыСведений.ОбъектыНаКонтроле.ОтразитьИзменениеРезультата(КлючЗаписи, СостояниеДел);
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

