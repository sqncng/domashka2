﻿
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ)
	Отказ = НЕ ИдентификаторБазыУникальный(ИдентификаторБазы);
	Если Отказ Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		НСтр("ru = 'Задано неуникальное значение идентификатора базы <%1>'"),ИдентификаторБазы));
	КонецЕсли;	 
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ИдентификаторБазыУникальный(Стр)
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 1
		|	ЭталонныеБазыТестирования.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.ЭталонныеБазыТестирования КАК ЭталонныеБазыТестирования
		|ГДЕ
		|	ЭталонныеБазыТестирования.ИдентификаторБазы = &ИдентификаторБазы
		|	И ЭталонныеБазыТестирования.Ссылка <> &Ссылка
		|	И ЭталонныеБазыТестирования.Владелец = &Владелец";
	
	Запрос.УстановитьПараметр("ИдентификаторБазы", Стр);
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Запрос.УстановитьПараметр("Владелец", Владелец);
	
	РезультатЗапроса = Запрос.Выполнить();
	Возврат РезультатЗапроса.Пустой();
КонецФункции	

#КонецОбласти

#КонецЕсли