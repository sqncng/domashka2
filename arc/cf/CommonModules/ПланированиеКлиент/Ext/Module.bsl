﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Клиентские процедуры и фунцкции подсистемы "Планирование"

#Область СлужебныйПрограммныйИнтерфейс

// Выводит пользователю оповещения после заполнения данных плана по статистике
//
// Параметры:
//  ТипЗаполнения               - Строка - тип заполнения по статистике
//  ДобавленоВидовДеятельности  - Число - количество добавленных видов деятельности.
//  ИзмененоВидовДеятельности   - Число - количество измененных видов деятельности.
//  УдаленоВидовДеятельности    - Число - количество удаленных видов деятельности.
//
Процедура ВывестиОповещенияОЗаполненииВидовДеятельностиПоСтатистике(ТипЗаполнения,
	                                                                ДобавленоВидовДеятельности,
	                                                                ИзмененоВидовДеятельности,
	                                                                УдаленоВидовДеятельности) Экспорт
	
	Если ДобавленоВидовДеятельности = 0 
		И ИзмененоВидовДеятельности = 0
		И УдаленоВидовДеятельности = 0 Тогда
		ТекстОповещения = НСтр("ru = 'Ни один вид деятельности не изменен'");
	Иначе
		
		Если ТипЗаполнения = "ЗаполнитьПоСотрудникамНеИзменятьОтсутствующие"
			Или ТипЗаполнения = "ЗаполнитьПоСотрудникамОбнулениеПлановыхТрудозатрат" Тогда
			
			ТекстОповещения = СтрШаблон(НСтр("ru = 'Добавлено - %1, изменено - %2.'"),
			                            ДобавленоВидовДеятельности, ИзмененоВидовДеятельности);
			
		Иначе
			
			ТекстОповещения = СтрШаблон(НСтр("ru = 'Добавлено - %1, изменено - %2, удалено - %3.'"),
			                            ДобавленоВидовДеятельности, ИзмененоВидовДеятельности, УдаленоВидовДеятельности);
			
		КонецЕсли;
		
	КонецЕсли;
	
	ПоказатьОповещениеПользователя(НСтр("ru = 'Заполнение видов деятельности по статистике'"),,
	                               ТекстОповещения, БиблиотекаКартинок.Информация32);
	
КонецПроцедуры

// Проверяет, есть ли изменения после работы пользователя с формой выбора участников плана
//
// Параметры:
//  Форма                - ФормаКлиентскогоПриложения - форма, из которой вызывалась форма выбора
//  Результат            - Структура - результат выбора
//  ИмяЭлементаДекорация - Строка - имя элемента формы, в котором будет обновлено представление выбора
//
// Возвращаемое значение:
//   Булево   - Истина, если результат выбора, привел к изменению ранее выбранных участников плана.
//
Функция ЕстьИзмененияПослеВыбораУчастников(Форма, Результат, ИмяЭлементаДекорация) Экспорт

	Если Результат = Неопределено
		Или Результат = КодВозвратаДиалога.Отмена Тогда
		Возврат Ложь;
	КонецЕсли;
	
	ЕстьИзменения = Ложь;
	
	Для Каждого ЭлементСписка Из Результат.ВыбранныеСотрудники Цикл
		
		НайденноеЗначение = Форма.УчастникиВидаПлана.НайтиПоЗначению(ЭлементСписка.Значение);
		Если НайденноеЗначение = Неопределено Тогда
			Продолжить;
		КонецЕсли;
		
		Если НайденноеЗначение.Пометка = ЭлементСписка.Пометка Тогда
			Продолжить;
		КонецЕсли;
		
		НайденноеЗначение.Пометка = ЭлементСписка.Пометка;
		ЕстьИзменения             = Истина;
		
	КонецЦикла;
	
	Если Не ЕстьИзменения Тогда
		Возврат Ложь;
	КонецЕсли;
		
	Форма.Элементы[ИмяЭлементаДекорация].Заголовок = 
		СтроковыеФункцииКлиент.ФорматированнаяСтрока(НСтр("ru = '<a href=""ОткрытьПодборСотрудников"">%1</a>'"), Результат.ПредставлениеВыбора);
		
	Возврат Истина;
	
КонецФункции

Процедура ОткрытьПланЗанятостиПоТехПроекту(ТехПроект) Экспорт
	
	ТехПроектыОтбор = Новый СписокЗначений;
	ТехПроектыОтбор.Добавить(ТехПроект);
	
	ПараметрыОткрытия = Новый Структура;
	ПараметрыОткрытия.Вставить("ПланЗанятостиИзСохраненныхНастроек", Истина);
	ПараметрыОткрытия.Вставить("НачальнаяСтраница",                  "ПоТехПроектам");
	ПараметрыОткрытия.Вставить("ОтборПоТехПроектам",                 ТехПроектыОтбор);
	
	ОткрытьФорму("Обработка.Планирование.Форма.ПланЗанятости", ПараметрыОткрытия,,,,,,РежимОткрытияОкнаФормы.Независимый);
	
КонецПроцедуры

#КонецОбласти

