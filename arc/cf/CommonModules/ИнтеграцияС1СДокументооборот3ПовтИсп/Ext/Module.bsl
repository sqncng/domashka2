﻿////////////////////////////////////////////////////////////////////////////////
// Подсистема "Интеграция с 1С:Документооборотом"
// Модуль ИнтеграцияС1СДокументооборотБазоваяФункциональностьПовтИсп, сервер, повт. использование
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

// Возвращает выборку подходящих правил интеграции без отбора по ключевым реквизитам.
//
// Параметры:
//   ТипОбъектаДО - Строка - тип объекта ДО, указанного в правилах.
//   ВидДокументаДОID - Строка - заполняется если объект ДО является документом.
//
// Возвращаемое значение:
//   ВыборкаИзРезультатаЗапроса
//
Функция ОбщийНаборПравилИнтеграции(ТипОбъектаДО, ВидДокументаДОID = "") Экспорт
	
	Запрос = Новый Запрос(
		"ВЫБРАТЬ
		|	ПравилаИнтеграцииС1СДокументооборотом3.Ссылка КАК Ссылка,
		|	ПравилаИнтеграцииС1СДокументооборотом3.ПредставлениеОбъектаДОСКлючевымиПолями КАК ПредставлениеОбъектаДОСКлючевымиПолями,
		|	ВЫРАЗИТЬ(ПравилаИнтеграцииС1СДокументооборотом3.ПредставлениеОбъектаИССКлючевымиПолями КАК СТРОКА(1024)) КАК ПредставлениеОбъектаИССКлючевымиПолями,
		|	ПравилаИнтеграцииС1СДокументооборотом3.ТипОбъектаДО КАК ТипОбъектаДО,
		|	ПравилаИнтеграцииС1СДокументооборотом3.ТипОбъектаИС КАК ТипОбъектаИС,
		|	ПравилаИнтеграцииС1СДокументооборотом3.ВидДокументаДОID КАК ИдентификаторВидаДокумента,
		|	ПравилаИнтеграцииС1СДокументооборотом3.КлючевыеРеквизитыДО.(
		|		Имя КАК Имя,
		|		ЗначениеРеквизита КАК ЗначениеРеквизита,
		|		ЗначениеРеквизитаID КАК ЗначениеРеквизитаID,
		|		ЗначениеРеквизитаТип КАК ЗначениеРеквизитаТип,
		|		ЭтоДополнительныйРеквизитДО КАК ЭтоДополнительныйРеквизитДО
		|	) КАК КлючевыеРеквизитыДО
		|ИЗ
		|	Справочник.ПравилаИнтеграцииС1СДокументооборотом3 КАК ПравилаИнтеграцииС1СДокументооборотом3
		|ГДЕ
		|	НЕ ПравилаИнтеграцииС1СДокументооборотом3.ПометкаУдаления
		|	И ПравилаИнтеграцииС1СДокументооборотом3.ТипОбъектаДО = &ТипОбъектаДО
		|	И ПравилаИнтеграцииС1СДокументооборотом3.ВидДокументаДОID = &ВидДокументаДОID
		|
		|УПОРЯДОЧИТЬ ПО
		|	ПредставлениеОбъектаИССКлючевымиПолями");
	Запрос.УстановитьПараметр("ТипОбъектаДО", ТипОбъектаДО);
	Запрос.УстановитьПараметр("ВидДокументаДОID", ВидДокументаДОID);
	
	Возврат Запрос.Выполнить().Выбрать();
	
КонецФункции

#КонецОбласти