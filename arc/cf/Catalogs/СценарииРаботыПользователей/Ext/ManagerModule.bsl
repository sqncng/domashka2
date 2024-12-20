﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область ПрограммныйИнтерфейс
	
// Возвращает список реквизитов, которые не нужно редактировать
// с помощью обработки группового изменения объектов
//
// Возвращаемое значение:
//  НеРедактируемыеРеквизиты - Массив - массив имен реквизитов, не подлежащих редактированию.
//
Функция РеквизитыНеРедактируемыеВГрупповойОбработке() Экспорт
	
	НеРедактируемыеРеквизиты = Новый Массив;
	
	НеРедактируемыеРеквизиты.Добавить("ХранилищеСхемаBPMN");
	НеРедактируемыеРеквизиты.Добавить("ХранилищеСхемаТекст");
	НеРедактируемыеРеквизиты.Добавить("ХранилищеОписания");
	НеРедактируемыеРеквизиты.Добавить("ХранилищеСтруктурыСхемы");
	НеРедактируемыеРеквизиты.Добавить("СхемаТекст");
	НеРедактируемыеРеквизиты.Добавить("Шаблон");
	НеРедактируемыеРеквизиты.Добавить("ВерсияСценария");
	НеРедактируемыеРеквизиты.Добавить("СнипетСценария");
	НеРедактируемыеРеквизиты.Добавить("ОбычныйТекст");
	НеРедактируемыеРеквизиты.Добавить("Описание");
	
	Возврат НеРедактируемыеРеквизиты;
	
КонецФункции

#КонецОбласти

#Область ОбработчикиСобытий

Процедура ОбработкаПолученияДанныхВыбора(ДанныеВыбора, Параметры, СтандартнаяОбработка)
	Если Параметры.Свойство("Процесс") Тогда
		Параметры.Отбор.Вставить("РазрешеноИспользоватьВПроцессах", Истина);
	КонецЕсли;
	
	Если Параметры.Свойство("ЭталоннаяБаза") Тогда
		Если ЗначениеЗаполнено(Параметры.ЭталоннаяБаза) Тогда
			Параметры.Отбор.Вставить("Владелец", ПроектЭталоннойБазы(Параметры.ЭталоннаяБаза));
		КонецЕсли;	 
	КонецЕсли;	 
КонецПроцедуры

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Владелец)";

КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти


#Область СлужебныеПроцедурыИФункции

Функция ПолучитьНовуюВерсиюСценария() Экспорт
	Возврат Формат(ТекущаяДата(),"ДФ=yyyyMMddHHmmss");
КонецФункции	

Функция ПроектЭталоннойБазы(ЭталоннаяБаза)
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ЭталонныеБазыТестирования.Владелец КАК Проект
		|ИЗ
		|	Справочник.ЭталонныеБазыТестирования КАК ЭталонныеБазыТестирования
		|ГДЕ
		|	ЭталонныеБазыТестирования.Ссылка = &Ссылка";
	
	Запрос.УстановитьПараметр("Ссылка", ЭталоннаяБаза);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Возврат ВыборкаДетальныеЗаписи.Проект; 
	КонецЦикла;
	
	Возврат Справочники.Проекты.ПустаяСсылка(); 
КонецФункции	 

#КонецОбласти

#КонецЕсли