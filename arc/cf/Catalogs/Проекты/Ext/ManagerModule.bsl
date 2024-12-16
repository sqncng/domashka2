﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

Функция РасписаниеРегламентногоЗаданияПоУмолчанию() Экспорт
	
	Месяцы = Новый Массив;
	Месяцы.Добавить(1);
	Месяцы.Добавить(2);
	Месяцы.Добавить(3);
	Месяцы.Добавить(4);
	Месяцы.Добавить(5);
	Месяцы.Добавить(6);
	Месяцы.Добавить(7);
	Месяцы.Добавить(8);
	Месяцы.Добавить(9);
	Месяцы.Добавить(10);
	Месяцы.Добавить(11);
	Месяцы.Добавить(12);
	
	ДниНедели = Новый Массив;
	ДниНедели.Добавить(1);
	ДниНедели.Добавить(2);
	ДниНедели.Добавить(3);
	ДниНедели.Добавить(4);
	ДниНедели.Добавить(5);
	ДниНедели.Добавить(6);
	ДниНедели.Добавить(7);
	
	Расписание = Новый РасписаниеРегламентногоЗадания;
	Расписание.ДниНедели                = ДниНедели;
	Расписание.ПериодПовтораВТечениеДня = 0; // раз в день
	Расписание.ПериодПовтораДней        = 1; // каждый день
	Расписание.Месяцы                   = Месяцы;
	
	Возврат Расписание;
КонецФункции

// Получает расписание регл. задания. Если регл. задание не задано, то возвращает пустое расписание (по умолчанию)
Функция ПолучитьРасписаниеЗагрузкиМетаданных(Проект) Экспорт
	
	Возврат ПолучитьРасписаниеПоGUID(Проект.РегламентноеЗаданиеСинхронизацииКонфигурацииGUID);
	
КонецФункции

// Получает расписание регл. задания. Если регл. задание не задано, то возвращает пустое расписание (по умолчанию)
Функция ПолучитьРасписаниеФормированияСОобщенийПоОшибкам(Проект) Экспорт
	
	Возврат ПолучитьРасписаниеПоGUID(Проект.РегламентноеЗаданиеСообщенийПоОшибкамGUID);
	
КонецФункции

// Получает расписание регл. задания. Если регл. задание не задано, то возвращает пустое расписание (по умолчанию)
Функция ПолучитьРасписаниеЗагрузкиИзмененийВВетках(Проект) Экспорт
	
	Возврат ПолучитьРасписаниеПоGUID(Проект.РегламентноеЗаданиеЗагрузкиИзмененийВВеткахGUID);
	
КонецФункции

Процедура ОбновитьДанныеРегламентногоЗадания(Отказ, РасписаниеРегламентногоЗадания, ТекущийОбъект, ИмяРеквизитаСИдентификаторомЗадания, ИмяРегламентногоЗадания, НаименованиеРегламентногоЗадания, ИспользоватьЗадание) Экспорт
	
	// Получаем регламентное задание по идентификатору, если объект не находим, то создаем новый
	РегламентноеЗаданиеОбъект = СоздатьРегламентноеЗаданиеПриНеобходимости(Отказ, 
	                            ТекущийОбъект[ИмяРеквизитаСИдентификаторомЗадания], 
	                            ИмяРегламентногоЗадания);
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	// Обновляем свойства РЗ
	УстановитьПараметрыРегламентногоЗадания(РегламентноеЗаданиеОбъект, РасписаниеРегламентногоЗадания, ТекущийОбъект,
	                                        НаименованиеРегламентногоЗадания, ИспользоватьЗадание);
	
	// Записываем измененное задание
	ЗаписатьРегламентноеЗадание(Отказ, РегламентноеЗаданиеОбъект);
	
	//Запоминаем GUID регл. задания в реквизите объекта
	ТекущийОбъект[ИмяРеквизитаСИдентификаторомЗадания] = Строка(РегламентноеЗаданиеОбъект.УникальныйИдентификатор);
	
КонецПроцедуры

Функция ВариантСогласованиеИзмененийМетаданныхПоУмолчанию(Проект) Экспорт
	
	Если ЗначениеЗаполнено(Проект) Тогда
		Возврат ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Проект, "СогласованиеИзмененийДляНовыхОбъектовМетаданных");
	Иначе
		Возврат Перечисления.ВариантыСогласованияИзмененияВВетках.ПустаяСсылка();
	КонецЕсли;
	
КонецФункции

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Ссылка)";

КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция СоздатьРегламентноеЗаданиеПриНеобходимости(Отказ, GUIDРегламентногоЗадания, ИмяЗадания)
	
	РегламентноеЗаданиеОбъект = НайтиРегламентноеЗаданиеПоПараметру(GUIDРегламентногоЗадания);
	
	// при необходимости создаем регл. задание
	Если РегламентноеЗаданиеОбъект = Неопределено Тогда
		РегламентноеЗаданиеОбъект = РегламентныеЗадания.СоздатьРегламентноеЗадание(ИмяЗадания);
	КонецЕсли;
	
	Возврат РегламентноеЗаданиеОбъект;
	
КонецФункции

Процедура УстановитьПараметрыРегламентногоЗадания(РегламентноеЗаданиеОбъект, РасписаниеРегламентногоЗадания, ТекущийОбъект,
	                                                НаименованиеРегламентногоЗадания, Использование)
	
	Если НЕ ЗначениеЗаполнено(ТекущийОбъект.Ссылка) Тогда
		Ссылка = Справочники.Проекты.ПолучитьСсылку(Новый УникальныйИдентификатор);
		ТекущийОбъект.УстановитьСсылкуНового(Ссылка);
	Иначе
		Ссылка = ТекущийОбъект.Ссылка;
	КонецЕсли;
	
	ПараметрыРегламентногоЗадания = Новый Массив;
	ПараметрыРегламентногоЗадания.Добавить(Ссылка);
	
	РегламентноеЗаданиеОбъект.Наименование  = Лев(НаименованиеРегламентногоЗадания, 120);
	РегламентноеЗаданиеОбъект.Использование = Использование;
	РегламентноеЗаданиеОбъект.Параметры     = ПараметрыРегламентногоЗадания;
	РегламентноеЗаданиеОбъект.Ключ          = Ссылка.УникальныйИдентификатор();
	
	// обновляем расписание, если оно было изменено
	Если РасписаниеРегламентногоЗадания <> Неопределено Тогда
		РегламентноеЗаданиеОбъект.Расписание = РасписаниеРегламентногоЗадания;
	КонецЕсли;
	
КонецПроцедуры

// Выполняет запись регламентного задания
//
// Параметры:
//  Отказ                     - Булево - флаг отказа. Если в процессе выполнения процедуры были обнаружены ошибки,
//                                       то флаг отказа устанавливается в значение Истина
//  РегламентноеЗаданиеОбъект - объект регламентного задания, которое необходимо записать
// 
Процедура ЗаписатьРегламентноеЗадание(Отказ, РегламентноеЗаданиеОбъект)
	
	УстановитьПривилегированныйРежим(Истина);
	
	Попытка
		
		// записываем задание
		РегламентноеЗаданиеОбъект.Записать();
		
	Исключение
		
		СтрокаСообщения = НСтр("ru = 'Произошла ошибка при сохранении расписания регламентного задания. Подробное описание ошибки: %1'");
		СтрокаСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(СтрокаСообщения, КраткоеПредставлениеОшибки(ИнформацияОбОшибке()));
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(СтрокаСообщения,,,, Отказ);
		
	КонецПопытки;
	
КонецПроцедуры

// Находит регламентное задание по GUID
//
// Параметры:
//  УникальныйНомерЗадания - Строка - строка с GUID регламентного задания
// 
// Возвращаемое значение:
//  Неопределено        - если поиск регламентного задания по GUID не дал результатов или
//  РегламентноеЗадание - найденное по GUID регламентное задание.
//
Функция НайтиРегламентноеЗаданиеПоПараметру(Знач УникальныйНомерЗадания)
	
	Если ПустаяСтрока(УникальныйНомерЗадания) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Истина);
	
	Возврат РегламентныеЗадания.НайтиПоУникальномуИдентификатору(Новый УникальныйИдентификатор(УникальныйНомерЗадания));
КонецФункции

Функция ПолучитьРасписаниеПоGUID(GUIDРегламентногоЗадания)
	
	РегламентноеЗаданиеОбъект = НайтиРегламентноеЗаданиеПоПараметру(GUIDРегламентногоЗадания);
	
	Если РегламентноеЗаданиеОбъект <> Неопределено Тогда
		РасписаниеРегламентногоЗадания = РегламентноеЗаданиеОбъект.Расписание;
	Иначе
		РасписаниеРегламентногоЗадания = Новый РасписаниеРегламентногоЗадания;
	КонецЕсли;
	
	Возврат РасписаниеРегламентногоЗадания;
	
КонецФункции

#КонецОбласти

#КонецЕсли
