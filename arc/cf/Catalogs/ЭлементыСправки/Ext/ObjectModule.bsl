﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ПроектыВключающиеСправку.Свернуть("Проект");
	ПроектыВключающиеСправку.Сортировать("Проект");
	
	ПроектыВключающиеСправкуСтрока = РаботаСоСправкой.ПолучитьСтроковоеПредставлениеПроектовПовтИсп(
		ПроектыВключающиеСправку.ВыгрузитьКолонку("Проект"));
	
	Если ЗначениеЗаполнено(ПодменяющийЭлементСправки) Тогда
		Наименование="Подменяется другим элементом";
	Иначе
		Наименование=Лев(ТекстСправки,100);
	КонецЕсли;
	
	//запрещаем подчинять элементы справки не заглавным элементам.
	Если ЗначениеЗаполнено(Родитель)
		И Найти(ВРег(Родитель.СтильФорматированияСправки.Наименование), "ЗАГОЛОВОК") = 0 Тогда
		Родитель=Родитель.Родитель;	
	КонецЕсли;	
	
	Если Не ЭтоНовый() И Ссылка.Родитель <> Родитель Тогда
		Код = 0;
	КонецЕсли;
	
	ЗаписьСправочников.УстановитьКодСправочника(ЭтотОбъект);
	ЗаписьСправочников.УстановитьПолныйКодСправочника(ЭтотОбъект,2);

	Справочники.ЭлементыСправки.ОбновитьГиперссылкиСправки(ТекстСправки, ГиперссылкиДляСправки);
	Справочники.ЭлементыСправки.ОбновитьКартинкиСправки(ТекстСправки, КартинкиДляСправки, Истина, Картинка);
	
	ДополнительныеСвойства.Вставить("КоллекцияИзмененныхОбъектов", Новый Массив);
	Версионирование.ЗарегистрироватьИзмененияОбъекта(ЭтотОбъект);
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ЗаписатьДанныеОНаличииСправки();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ЗаписатьДанныеОНаличииСправки()
	
	Запрос = Новый Запрос;
	Запрос.Параметры.Вставить("Владелец", Владелец);
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ЭлементыСправки.Ссылка
	|ИЗ
	|	Справочник.ЭлементыСправки КАК ЭлементыСправки
	|ГДЕ
	|	ЭлементыСправки.ВключатьВСправку
	|	И НЕ ЭлементыСправки.ПометкаУдаления
	|	И ЭлементыСправки.Владелец = &Владелец";
	
	ЗаписьИзменилась = Ложь;
	
	УстановитьПривилегированныйРежим(Истина);
	
	Результат   = Запрос.Выполнить();
	ЕстьСправка = Не Результат.Пустой();
	
	МенеджерЗаписи = РегистрыСведений.НаличиеСправки.СоздатьМенеджерЗаписи();
	МенеджерЗаписи.ВладелецСправки = Владелец;
	МенеджерЗаписи.Прочитать();
	
	Если НЕ ЗначениеЗаполнено(МенеджерЗаписи.ВладелецСправки) Тогда
		МенеджерЗаписи.ВладелецСправки = Владелец;
		ЗаписьИзменилась = Истина;
	КонецЕсли;
	
	Если МенеджерЗаписи.ЕстьСправка <> ЕстьСправка Тогда
		МенеджерЗаписи.ЕстьСправка = ЕстьСправка;
		ЗаписьИзменилась = Истина;
	КонецЕсли; 
	
	Если ЗаписьИзменилась Тогда
		МенеджерЗаписи.Записать();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли

