﻿
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	Если Не ЭтоНовый() Тогда
		Возврат;
	КонецЕсли;
	
	СтандартнаяОбработка = Ложь;
	Если ТипЗнч(ДанныеЗаполнения) = Тип("Структура") Тогда
		РазрабатываемыйОбъект = Неопределено;
		ДанныеЗаполнения.Свойство("РазрабатываемыйОбъект", РазрабатываемыйОбъект);
		Владелец = Неопределено;
		ДанныеЗаполнения.Свойство("Владелец", Владелец);

		Если РазрабатываемыйОбъект <> Неопределено Тогда
			Справочники.Ветки.ЗаполнитьРеквизитыВетки(ЭтотОбъект, РазрабатываемыйОбъект, ДанныеЗаполнения);
		Иначе
			Справочники.Ветки.ЗаполнитьРеквизитыВетки(ЭтотОбъект,,Новый Структура("Владелец", Владелец));
		КонецЕсли;
	Иначе
		Справочники.Ветки.ЗаполнитьРеквизитыВетки(ЭтотОбъект, ДанныеЗаполнения);
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	
	Ответственный = Пользователи.ТекущийПользователь();
	ДатаСоздания = ТекущаяДата();
	Статус = Перечисления.СтатусыВеток.Разрабатывается;
	ДатаПомещения = Дата(1,1,1,0,0,0);
	ДатаНачалаТестирования = Дата(1,1,1,0,0,0);
	Предшественник = Справочники.Ветки.ПустаяСсылка();
	ПриоритетТестирования = Перечисления.ПриоритетыТестированияВеток.Обычный;
	СрочностьИсправленияОшибок = Перечисления.СрочностьИсправленияОшибок.ЖелательноБыстрее; 
	ИдентификаторЗапросаНаСлияние = "";
	ВариантЗапускаТестов = Перечисления.ВариантыЗапускаТестов.ПустаяСсылка();
	ЗагружатьИзмененияОбъектовМетаданных = Ложь;
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	НепроверяемыеРеквизиты = Новый Массив;

	Если Статус <> Перечисления.СтатусыВеток.Помещена
		И Статус <> Перечисления.СтатусыВеток.Тестируется Тогда
		НепроверяемыеРеквизиты.Добавить("Приемник");
	КонецЕсли;
	
	Если Тип = Перечисления.ТипыВеток.ОсновнаяВеткаПроекта Тогда
		
		НепроверяемыеРеквизиты.Добавить("Источник");
		НепроверяемыеРеквизиты.Добавить("Приемник");
		НепроверяемыеРеквизиты.Добавить("ДатаСоздания");
		
	КонецЕсли;
	
	Если Тип = Перечисления.ТипыВеток.ВеткаВерсии Тогда
		
		НепроверяемыеРеквизиты.Добавить("Приемник");
		
	КонецЕсли;
	
	Если РежимРазработки = Перечисления.РежимРазработки.БезИзменений Тогда
		
		НепроверяемыеРеквизиты.Добавить("Имя");
		
	КонецЕсли;
	
	Если НепроверяемыеРеквизиты.Количество()>0 Тогда
		ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, НепроверяемыеРеквизиты);
	КонецЕсли;
	
	Если Статус = Перечисления.СтатусыВеток.Помещена Тогда
		Если Тип = Перечисления.ТипыВеток.ОсновнаяВеткаПроекта Или Тип = Перечисления.ТипыВеток.ВеткаВерсии Тогда
			Отказ = Истина;
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
							НСтр("ru = 'Нельзя помещать ветки с типом ""%1"".'"),
							Тип);
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, ЭтотОбъект, "Тип",,Отказ);
			Возврат;
		КонецЕсли;
		Если ЗначениеЗаполнено(Предшественник) 
			И Предшественник.Статус <> Перечисления.СтатусыВеток.Помещена Тогда
			Отказ = Истина;
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
							НСтр("ru = 'Нельзя поместить ветку, пока не помещена ветка предшественник ""%1"".'"),
							Предшественник);
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, ЭтотОбъект, "Предшественник",,Отказ);
			Возврат;
		КонецЕсли;
	КонецЕсли;

	Если Тип = Перечисления.ТипыВеток.ОсновнаяВеткаПроекта Тогда
		ОсновнаяВетка = СуществующаяОсновнаяВеткаПроекта();
		Если ОсновнаяВетка <> Неопределено Тогда
			Отказ = Истина;
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
					НСтр("ru = 'Нельзя создать две основные ветки проекта. Уже существует основная ветка %1.'"),
					ОсновнаяВетка);
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, ЭтотОбъект, "Тип",,Отказ);
			Возврат;
		КонецЕсли;
	КонецЕсли;
	
	ДубльВетки = ВеткаСДублирующимсяИменем(Имя);
	Если ДубльВетки <> Неопределено Тогда
		Отказ = Истина;
		ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
					НСтр("ru = 'Нельзя создать две ветки с одинаковым именем. Уже существует ветка с именем ""%1"".'"),
					Имя);
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, ЭтотОбъект, "Имя",,Отказ);
		Возврат;
	КонецЕсли; 
	
	Если ЗначениеЗаполнено(Ссылка) Тогда
		Если Ссылка = Источник Тогда
			Отказ = Истина;
			ТекстСообщения = НСтр("ru = 'В качестве ветки источника нельзя выбирать текущую ветку.'");
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, ЭтотОбъект, "Источник",,Отказ);
			Возврат;
		КонецЕсли;
		Если Ссылка = Приемник Тогда
			Отказ = Истина;
			ТекстСообщения = НСтр("ru = 'В качестве ветки приемника нельзя выбирать текущую ветку.'");
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, ЭтотОбъект, "Приемник",,Отказ);
			Возврат;
		КонецЕсли;
	КонецЕсли;
	
	ТипыВетокДляПроверки = Перечисления.ТипыВеток.ТипыВетокДляОтбора(Тип);
	Если ЗначениеЗаполнено(Приемник) И ТипыВетокДляПроверки.Найти(Приемник.Тип) = Неопределено Тогда
		Отказ = Истина;
		ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Для ветки с типом %1 нельзя указывать ветку приемник с типом %2.'"),
			Тип, Приемник.Тип);
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, ЭтотОбъект, "Приемник",,Отказ);
		Возврат;
	КонецЕсли;
	Если ЗначениеЗаполнено(Источник) И ТипыВетокДляПроверки.Найти(Источник.Тип) = Неопределено Тогда
		Отказ = Истина;
		ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Для ветки с типом %1 нельзя указывать ветку источник с типом %2.'"),
			Тип, Источник.Тип);
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, ЭтотОбъект, "Источник",,Отказ);
		Возврат;
	КонецЕсли;

КонецПроцедуры

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Предшественник) И Статус = Перечисления.СтатусыВеток.Тестируется Тогда
		СтатусПредшественника = СтатусВетки(Предшественник);
		Если СтатусПредшественника <> Перечисления.СтатусыВеток.Помещена Тогда
			Отказ = Истина;
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru='Т.к. ветка предшественник <%1> не помещена, у текущей ветки статус должен быть изменен на ""Разрабатывается"".'"),
					Предшественник);
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, ЭтотОбъект, "Предшественник",,Отказ);
			Возврат;
		КонецЕсли;
	КонецЕсли;
	
	Если Тип = Перечисления.ТипыВеток.ОсновнаяВеткаПроекта Тогда
		Источник = Справочники.Ветки.ПустаяСсылка();
		ДатаСоздания = Дата(1, 1, 1, 0, 0, 0);
		Приемник = Справочники.Ветки.ПустаяСсылка();
		ДатаПомещения = Дата(1, 1, 1, 0, 0, 0);
		РежимРазработки = Владелец.РежимРазработки;
	ИначеЕсли Тип = Перечисления.ТипыВеток.ВеткаВерсии Тогда
		Приемник = Справочники.Ветки.ПустаяСсылка();
		ДатаПомещения = Дата(1, 1, 1, 0, 0, 0);
	КонецЕсли;
	
	Если Тип <> Перечисления.ТипыВеток.ОсновнаяВеткаПроекта 
		И Тип <> Перечисления.ТипыВеток.ВеткаВерсии Тогда
		ИзмененияПомещаютсяТолькоЧерезДругиеВетки = Ложь;
	КонецЕсли;
	
	Если Статус = Перечисления.СтатусыВеток.Помещена Тогда
		Если НЕ ЗначениеЗаполнено(ДатаПомещения) Тогда
			ДатаПомещения = ТекущаяДата();
		КонецЕсли;
	Иначе
		ДатаПомещения = Дата(1, 1, 1, 0, 0, 0);
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(ДатаНачалаТестирования) Тогда
		Если Статус = Перечисления.СтатусыВеток.Тестируется Тогда
			ДатаНачалаТестирования = ТекущаяДата();
		Иначе
			ДатаНачалаТестирования = Дата(1, 1, 1, 0, 0, 0);
		КонецЕсли;
	КонецЕсли;  
	
	Если Статус = Перечисления.СтатусыВеток.Помещена Тогда
		ТестированиеЗагрузкаРезультатовТестирования.ОбновитьСостояниеТестированияВетки(Ссылка);
	КонецЕсли;	

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ВеткаСДублирующимсяИменем(ИмяВетки)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 1
		|	Ветки.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.Ветки КАК Ветки
		|ГДЕ
		|	НЕ Ветки.ПометкаУдаления
		|	И Ветки.РежимРазработки <> ЗНАЧЕНИЕ(Перечисление.РежимРазработки.БезИзменений)
		|	И Ветки.Статус В (ЗНАЧЕНИЕ(Перечисление.СтатусыВеток.Разрабатывается), ЗНАЧЕНИЕ(Перечисление.СтатусыВеток.Тестируется))
		|	И Ветки.Имя = &ИмяВетки
		|	И Ветки.Ссылка <> &Ссылка
		|	И Ветки.Владелец = &Проект";
	
	Запрос.УстановитьПараметр("ИмяВетки", ИмяВетки);
	Запрос.УстановитьПараметр("Проект", Владелец);
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	РезультатВыборки = Запрос.Выполнить().Выбрать(); 
	Если РезультатВыборки.Следующий() Тогда
		Возврат РезультатВыборки.Ссылка;
	КонецЕсли;
	
	Возврат Неопределено;
	
КонецФункции

Функция СуществующаяОсновнаяВеткаПроекта()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 1
		|	Ветки.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.Ветки КАК Ветки
		|ГДЕ
		|	НЕ Ветки.ПометкаУдаления
		|	И Ветки.Ссылка <> &Ссылка
		|	И Ветки.Тип = ЗНАЧЕНИЕ(Перечисление.ТипыВеток.ОсновнаяВеткаПроекта)
		|	И Ветки.Владелец = &Проект";
	
	Запрос.УстановитьПараметр("Проект", Владелец);
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	РезультатВыборки = Запрос.Выполнить().Выбрать(); 
	Если РезультатВыборки.Следующий() Тогда
		Возврат РезультатВыборки.Ссылка;
	КонецЕсли;
	
	Возврат Неопределено;

КонецФункции

Функция СтатусВетки(Ветка)
	Возврат ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ветка,"Статус");
КонецФункции	

#КонецОбласти

#КонецЕсли