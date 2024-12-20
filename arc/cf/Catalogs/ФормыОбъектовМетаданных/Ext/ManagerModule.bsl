﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Возвращает список реквизитов, которые разрешается редактировать
// с помощью обработки группового изменения объектов
//
Функция РеквизитыРедактируемыеВГрупповойОбработке() Экспорт
	
	РедактируемыеРеквизиты = Новый Массив;
	
	РедактируемыеРеквизиты.Добавить("Ответственный");
	
	Возврат РедактируемыеРеквизиты;
	
КонецФункции

Функция СформироватьПечатныеФормы(Объекты, СУчетомПриемника=Ложь, ДанныеСоответствия=Неопределено) Экспорт
	
	Если ТипЗнч(Объекты) = Тип("Массив") Тогда
		МассивСсылок = Объекты;
	Иначе
		МассивСсылок = Новый Массив;
		МассивСсылок.Добавить(Объекты);
	КонецЕсли;
	
	ПечатныеФормы = Новый Соответствие;
	
	Для Каждого Ссылка из МассивСсылок Цикл
		
		СтруктураПечатныхФорм = Новый Структура();
		СтруктураПечатныхФорм.Вставить("ВариантыСправки", ФормированиеСправкиСервер.СформироватьВариантыСправки(Ссылка));
		
		ПечатныеФормы.Вставить(Ссылка, СтруктураПечатныхФорм);
		
	КонецЦикла;
	
	Возврат ПечатныеФормы;
	
КонецФункции

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Владелец.Владелец)";

КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область ОбработчикиСобытий

Процедура ОбработкаПолученияДанныхВыбора(ДанныеВыбора, Параметры, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ДанныеВыбора = Новый СписокЗначений;
	
	Если НЕ Параметры.Отбор.Свойство("Владелец")
	 ИЛИ НЕ ЗначениеЗаполнено(Параметры.Отбор.Владелец)
	 ИЛИ ТипЗнч(Параметры.Отбор.Владелец) <> Тип("СправочникСсылка.ОбъектыМетаданных") Тогда
		Возврат;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ОбъектыМетаданных.Родитель.Имя КАК ИмяКлассаМетаданных
	|ИЗ
	|	Справочник.ОбъектыМетаданных КАК ОбъектыМетаданных
	|ГДЕ
	|	ОбъектыМетаданных.Ссылка = &Владелец
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	Формы.Ссылка КАК Значение,
	|	Формы.Представление КАК Представление
	|ИЗ
	|	Справочник.ФормыОбъектовМетаданных КАК Формы
	|ГДЕ //%1
	|
	|УПОРЯДОЧИТЬ ПО
	|	Представление";
	
	ТекстОтбора = "";
	Для Каждого КлючИЗначение Из Параметры.Отбор Цикл
		ТекстОтбора = ТекстОтбора + "
			|	" + ?(ТекстОтбора = "", "", " И ") + "Формы." + КлючИЗначение.Ключ + " = &" + КлючИЗначение.Ключ;
		Запрос.УстановитьПараметр(КлючИЗначение.Ключ, КлючИЗначение.Значение);
	КонецЦикла;
	
	Если ЗначениеЗаполнено(Параметры.СтрокаПоиска) Тогда
		ТекстОтбора = ТекстОтбора + "
			|	И (Формы.Имя ПОДОБНО &СтрокаПоиска
			|		ИЛИ Формы.Наименование ПОДОБНО &СтрокаПоиска)";
		Запрос.УстановитьПараметр("СтрокаПоиска", Параметры.СтрокаПоиска + "%");
	КонецЕсли;
	
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "//%1", ТекстОтбора);
	
	Результаты = Запрос.ВыполнитьПакет();
	
	Выборка = Результаты[0].Выбрать();
	Если Выборка.Следующий() Тогда
		
		СписокТиповФорм = РаботаСОбъектамиМетаданныхКлиентСервер.СписокДоступныхТиповФорм(Выборка.ИмяКлассаМетаданных);
		
		Для Каждого ТекЭлемент Из СписокТиповФорм Цикл
			
			Если ТекЭлемент.Значение = Перечисления.ТипыФорм.ПроизвольнаяФорма Тогда
				Продолжить;
			КонецЕсли;
			
			ПредставлениеФормы = СокрЛП(ТекЭлемент.Значение);
			Если ЗначениеЗаполнено(Параметры.СтрокаПоиска)
			 И Найти(НРег(ПредставлениеФормы), НРег(Параметры.СтрокаПоиска)) <> 1 Тогда
				Продолжить;
			КонецЕсли;
			
			ДанныеВыбора.Добавить(ТекЭлемент.Значение, ПредставлениеФормы);
			
		КонецЦикла;
		
	КонецЕсли;
	
	Выборка = Результаты[1].Выбрать();
	Пока Выборка.Следующий() Цикл
		ДанныеВыбора.Добавить(Выборка.Значение, Выборка.Представление);
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
