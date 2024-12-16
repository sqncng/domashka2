﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	Если ЭтоНовый() И Не ЗначениеЗаполнено(Владелец) Тогда
		Владелец = Проекты.ПроектПоУмолчанию();
	КонецЕсли;
	
КонецПроцедуры	

Процедура ПриКопировании(ОбъектКопирования)
	
	Если ЭтоГруппа Тогда
		Возврат;
	КонецЕсли;
	
	Статус = Перечисления.СтатусыЦелевыхЗадач.Запланирована;
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)

	Если ЭтоГруппа Тогда
		Возврат;
	КонецЕсли;
	
	ПроверитьКорректностьУказанияДат(Отказ);
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если НЕ ЭтоГруппа Тогда
		СкорректироватьДанныеНеСоответствующиеПроекту();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура СкорректироватьДанныеНеСоответствующиеПроекту()
	
	Если ЗначениеЗаполнено(РазделПроекта) Тогда
		
		ПроектРаздела = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(РазделПроекта, "Владелец");
		
		Если ПроектРаздела <> Владелец Тогда
			РазделПроекта = Справочники.РазделыПроекта.ПустаяСсылка();
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ПроверитьКорректностьУказанияДат(Отказ)
	
	Если ДатаОкончания < ДатаНачала И ЗначениеЗаполнено(ДатаОкончания) Тогда
		ТекстСообщения = НСтр("ru='Даты начала и окончания указаны неверно'");
		Сообщить(ТекстСообщения);
		Отказ = Истина;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли