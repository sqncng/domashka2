﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	// СтандартныеПодсистемы.Свойства
	Процесс = Объект.Владелец;
	ПроектПроцесса = Процесс.Владелец;
	СвойстваПроекта = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Процесс.Владелец,
		"НаборСвойствДляНастроекЗапускаПроцессовВыгружаемый,НаборСвойствДляНастроекЗапускаПроцессовНеВыгружаемый");
	
	ГруппыДляРазмещения = Новый СписокЗначений;
	ГруппыДляРазмещения.Добавить(СвойстваПроекта.НаборСвойствДляНастроекЗапускаПроцессовВыгружаемый,
		Элементы.ГруппаВыгружаемые.Имя);
	ГруппыДляРазмещения.Добавить(СвойстваПроекта.НаборСвойствДляНастроекЗапускаПроцессовНеВыгружаемый,
		Элементы.ГруппаНевыгружаемые.Имя);
	ГруппыДляРазмещения.Добавить("ВсеОстальные", Элементы.ГруппаОбщие.Имя);
	
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ИмяЭлементаДляРазмещения", ГруппыДляРазмещения);
	УправлениеСвойствами.ПриСозданииНаСервере(ЭтотОбъект, ДополнительныеПараметры);
	// Конец СтандартныеПодсистемы.Свойства
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	КонецЕсли;
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПриЧтенииНаСервере(ЭтаФорма, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
    // СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом 

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.Свойства
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	// СтандартныеПодсистемы.Свойства 
	Если УправлениеСвойствамиКлиент.ОбрабатыватьОповещения(ЭтотОбъект, ИмяСобытия, Параметр) Тогда
		ОбновитьЭлементыДополнительныхРеквизитов();
		УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ОбработкаПроверкиЗаполнения(ЭтаФорма, Отказ, ПроверяемыеРеквизиты);
	// Конец СтандартныеПодсистемы.Свойства
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПередЗаписьюНаСервере(ЭтаФорма, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
КонецПроцедуры

&НаКлиенте
Процедура ВладелецПриИзменении(Элемент)
	ПроектПроцесса = ПроектПроцесса(Объект.Владелец);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

// СтандартныеПодсистемы.Свойства
&НаКлиенте
Процедура Подключаемый_СвойстваВыполнитьКоманду(ЭлементИлиКоманда, НавигационнаяСсылка = Неопределено, СтандартнаяОбработка = Неопределено)
	
	УправлениеСвойствамиКлиент.ВыполнитьКоманду(ЭтотОбъект, ЭлементИлиКоманда, СтандартнаяОбработка);
	
КонецПроцедуры
// Конец СтандартныеПодсистемы.Свойства

&НаКлиенте
Процедура ПерезаполнитьПараметрыТеста(Команда)
	ПерезаполнитьПараметрыТестаСервер();
	Модифицированность = Истина;
КонецПроцедуры

&НаКлиенте
Процедура СтатусВыполнения(Команда)
	ДанныеОтбор = Новый Структура;
	ДанныеОтбор.Вставить("НастройкаЗапускаПроцесса",Объект.Ссылка);
	
	ПараметрыФормы = Новый Структура("КлючВарианта, Отбор, ВидимостьКомандВариантовОтчетов, СформироватьПриОткрытии", 
		"СтатусПрохожденияТестовВВетке",
		ДанныеОтбор, 
		Истина,
		Истина);
		
	ОткрытьФорму(
		"Отчет.СтатусПрохожденияТестовВВетке.Форма",
		ПараметрыФормы, ,
		Истина);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// СтандартныеПодсистемы.Свойства

&НаСервере
Процедура ОбновитьЭлементыДополнительныхРеквизитов()
	УправлениеСвойствами.ОбновитьЭлементыДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьЗависимостиДополнительныхРеквизитов()
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПриИзмененииДополнительногоРеквизита(Элемент)
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

// Конец СтандартныеПодсистемы.Свойства

&НаСервере
Процедура ПерезаполнитьПараметрыТестаСервер()
	ОбъектСервер      = РеквизитФормыВЗначение("Объект");
	ПараметрыДанногоПроцесса = ПолучитьПараметрыПроцесса(ОбъектСервер.Владелец);
	ОбъектСервер.ПараметрыПроцесса.Очистить();
	
	ТекущиеПараметрыТеста = ОбъектСервер.ПараметрыПроцесса.Выгрузить();
	ОбновитьПараметрыТеста(ТекущиеПараметрыТеста,ПараметрыДанногоПроцесса);
	
	ОбъектСервер.ПараметрыПроцесса.Загрузить(ТекущиеПараметрыТеста);
	
	ЗначениеВРеквизитФормы(ОбъектСервер,"Объект");
КонецПроцедуры

&НаСервере
Функция ПолучитьПараметрыПроцесса(Процесс)
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	ПроцессыПараметрыПроцесса.Имя КАК Имя,
		|	ПроцессыПараметрыПроцесса.Значение КАК Значение,
		|	ПроцессыПараметрыПроцесса.НомерСтроки КАК НомерСтроки,
		|	ПроцессыПараметрыПроцесса.ТипПараметра КАК ТипПараметра
		|ИЗ
		|	Справочник.Процессы.ПараметрыПроцесса КАК ПроцессыПараметрыПроцесса
		|ГДЕ
		|	ПроцессыПараметрыПроцесса.Ссылка = &Ссылка
		|
		|УПОРЯДОЧИТЬ ПО
		|	НомерСтроки";
	
	Запрос.УстановитьПараметр("Ссылка",Процесс);
	
	Возврат Запрос.Выполнить().Выгрузить();
КонецФункции	

&НаСервере
Процедура ОбновитьПараметрыТеста(ТекущиеПараметрыТеста,ПараметрыПроцесса)
	Для Каждого ПараметрПроцесса Из ПараметрыПроцесса Цикл
		СтрокаТекущиеПараметрыТеста = ТекущиеПараметрыТеста.Найти(ПараметрПроцесса.Имя,"Имя");
		Если СтрокаТекущиеПараметрыТеста <> Неопределено Тогда
			Продолжить;
		КонецЕсли;	 
		
		СтрокаТекущиеПараметрыТеста = ТекущиеПараметрыТеста.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаТекущиеПараметрыТеста,ПараметрПроцесса);
	КонецЦикла;	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПроектПроцесса(Процесс)
	Возврат ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Процесс, "Владелец"); 
КонецФункции	 

#КонецОбласти