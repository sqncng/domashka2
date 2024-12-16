﻿&НаКлиенте
Перем ОбновитьИнтерфейс;

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	МодельСервиса = ОбщегоНазначения.РазделениеВключено();
	
	// Настройки видимости при запуске.
	Элементы.ГруппаВременныеКаталогиКластераСерверов.Видимость =
		Не ОбщегоНазначения.ИнформационнаяБазаФайловая() И Пользователи.ЭтоПолноправныйПользователь(, Истина);
	
	Элементы.ПрефиксУзлаРаспределеннойИнформационнойБазы.ТолькоПросмотр = Истина;
	
	Если МодельСервиса Тогда
		
		Элементы.ОписаниеРаздела.Заголовок = Нстр("ru = 'Настройка синхронизации данных с моими приложениями.'");
		Элементы.ПояснениеНастройкиСинхронизацииДанных.Заголовок = Нстр("ru = 'Настройка и выполнение синхронизации данных с моими приложениями.'");
		Элементы.ПояснениеОткрытьДатыЗапретаЗагрузкиДанных.Заголовок = Нстр("ru = 'Запрет загрузки данных прошлых периодов из других приложений.'");
		
		Элементы.ГруппаИспользоватьСинхронизациюДанных.Видимость = Ложь;
		Элементы.ГруппаПрефиксУзлаРаспределеннойИнформационнойБазы.Видимость = Ложь;
		Элементы.ГруппаВременныеКаталогиКластераСерверов.Видимость = Ложь;
		
	КонецЕсли;
	
	// Обновление состояния элементов.
	УстановитьДоступность();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	ОбработчикОповещений(ИмяСобытия, Параметр, Источник);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	
	Если ЗавершениеРаботы Тогда
		Возврат;
	КонецЕсли;
	
	ОбновитьИнтерфейсПрограммы();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ИспользоватьСинхронизациюДанныхПриИзменении(Элемент)
	
	ОбновитьРазрешенияПрофилейБезопасности(Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура ПрефиксУзлаРаспределеннойИнформационнойБазыПриИзменении(Элемент)
	Подключаемый_ПриИзмененииРеквизита(Элемент);
КонецПроцедуры

&НаКлиенте
Процедура КаталогСообщенийОбменаДаннымиДляWindowsПриИзменении(Элемент)
	
	ОбновитьРазрешенияПрофилейБезопасности(Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура КаталогСообщенийОбменаДаннымиДляLinuxПриИзменении(Элемент)
	
	ОбновитьРазрешенияПрофилейБезопасности(Элемент);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

// Обработка оповещений от других открытых форм.
//
// Параметры:
//   ИмяСобытия - Строка - имя события. Может быть использовано для идентификации сообщений принимающими их формами.
//   Параметр - Произвольный - параметр сообщения. Могут быть переданы любые необходимые данные.
//   Источник - Произвольный - источник события. Например, в качестве источника может быть указана другая форма.
//
// Пример:
//   Если ИмяСобытия = "НаборКонстант.ПрефиксУзлаРаспределеннойИнформационнойБазы" Тогда
//     НаборКонстант.ПрефиксУзлаРаспределеннойИнформационнойБазы = Параметр;
//   КонецЕсли;
//
&НаКлиенте
Процедура ОбработчикОповещений(ИмяСобытия, Параметр, Источник)
	
	// _Демо начало примера
	Если ИмяСобытия = "НаборКонстант.ПрефиксУзлаРаспределеннойИнформационнойБазы" Тогда
		НаборКонстант.ПрефиксУзлаРаспределеннойИнформационнойБазы = Параметр;
	КонецЕсли;
	// _Демо конец примера
	
КонецПроцедуры

&НаКлиенте
Процедура НастройкиСинхронизацииДанных(Команда)
	
	ИмяОткрываемойФормы = "ОбщаяФорма.НастройкиСинхронизацииДанных";
	
	ОткрытьФорму(ИмяОткрываемойФормы);
	
КонецПроцедуры

&НаКлиенте
Процедура РезультатыСинхронизацииДанных(Команда)
	ОткрытьФорму("РегистрСведений.РезультатыОбменаДанными.Форма.Форма");
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

////////////////////////////////////////////////////////////////////////////////
// Клиент

&НаКлиенте
Процедура Подключаемый_ПриИзмененииРеквизита(Элемент, ОбновлятьИнтерфейс = Истина)
	
	Результат = ПриИзмененииРеквизитаСервер(Элемент.Имя);
	
	Если ОбновлятьИнтерфейс Тогда
		ОбновитьИнтерфейс = Истина;
		ПодключитьОбработчикОжидания("ОбновитьИнтерфейсПрограммы", 2, Истина);
	КонецЕсли;
	Если НЕ ПустаяСтрока(КонстантаИмя) Тогда
		Оповестить("Запись_НаборКонстант", Новый Структура, КонстантаИмя);
		КонстантаИмя = "";
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ОбновитьИнтерфейсПрограммы()
	
	Если ОбновитьИнтерфейс = Истина Тогда
		ОбновитьИнтерфейс = Ложь;
		ОбщегоНазначенияКлиент.ОбновитьИнтерфейсПрограммы();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьРазрешенияПрофилейБезопасности(Элемент)
	
	ОповещениеОЗакрытии = Новый ОписаниеОповещения("ОбновитьРазрешенияПрофилейБезопасностиЗавершение", ЭтотОбъект, Элемент);
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ПрофилиБезопасности") Тогда
		МассивЗапросов = СоздатьЗапросНаИспользованиеВнешнихРесурсов(Элемент.Имя);
		
		Если МассивЗапросов = Неопределено Тогда
			Возврат;
		КонецЕсли;
		
		МодульРаботаВБезопасномРежимеКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("РаботаВБезопасномРежимеКлиент");
		
		МодульРаботаВБезопасномРежимеКлиент.ПрименитьЗапросыНаИспользованиеВнешнихРесурсов(
			МассивЗапросов, ЭтотОбъект, ОповещениеОЗакрытии);
	Иначе
		ВыполнитьОбработкуОповещения(ОповещениеОЗакрытии, КодВозвратаДиалога.ОК);
	КонецЕсли;
КонецПроцедуры

&НаСервере
Функция СоздатьЗапросНаИспользованиеВнешнихРесурсов(ИмяКонстанты)
	
	КонстантаМенеджер = Константы[ИмяКонстанты];
	КонстантаЗначение = НаборКонстант[ИмяКонстанты];
	
	Если КонстантаМенеджер.Получить() = КонстантаЗначение Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Если ИмяКонстанты = "ИспользоватьСинхронизациюДанных" Тогда
		
		Если КонстантаЗначение Тогда
			
			Запрос = ОбменДаннымиСервер.ЗапросНаИспользованиеВнешнихРесурсовПриВключенииОбмена();
			
		Иначе
			
			Запрос = ОбменДаннымиСервер.ЗапросНаОчисткуРазрешенийИспользованияВнешнихРесурсов();
			
		КонецЕсли;
		
		Возврат Запрос;
		
	Иначе
		
		МенеджерЗначения = КонстантаМенеджер.СоздатьМенеджерЗначения();
		ИдентификаторКонстанты = ОбщегоНазначения.ИдентификаторОбъектаМетаданных(МенеджерЗначения.Метаданные());
		
		МодульРаботаВБезопасномРежиме = ОбщегоНазначения.ОбщийМодуль("РаботаВБезопасномРежиме");
		
		Если ПустаяСтрока(КонстантаЗначение) Тогда
			
			Запрос = МодульРаботаВБезопасномРежиме.ЗапросНаОчисткуРазрешенийИспользованияВнешнихРесурсов(ИдентификаторКонстанты);
			
		Иначе
			
			Разрешения = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(
				МодульРаботаВБезопасномРежиме.РазрешениеНаИспользованиеКаталогаФайловойСистемы(КонстантаЗначение, Истина, Истина));
			Запрос = МодульРаботаВБезопасномРежиме.ЗапросНаИспользованиеВнешнихРесурсов(Разрешения, ИдентификаторКонстанты);
			
		КонецЕсли;
		
		Возврат ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(Запрос);
		
	КонецЕсли;
	
КонецФункции

&НаКлиенте
Процедура ОбновитьРазрешенияПрофилейБезопасностиЗавершение(Результат, Элемент) Экспорт
	
	Если Результат = КодВозвратаДиалога.ОК Тогда
	
		Подключаемый_ПриИзмененииРеквизита(Элемент);
		
	Иначе
		
		ЭтотОбъект.Прочитать();
	
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Вызов сервера

&НаСервере
Функция ПриИзмененииРеквизитаСервер(ИмяЭлемента)
	
	Результат = Новый Структура;
	
	РеквизитПутьКДанным = Элементы[ИмяЭлемента].ПутьКДанным;
	
	СохранитьЗначениеРеквизита(РеквизитПутьКДанным, Результат);
	
	УстановитьДоступность(РеквизитПутьКДанным);
	
	ОбновитьПовторноИспользуемыеЗначения();
	
	Возврат Результат;
	
КонецФункции

////////////////////////////////////////////////////////////////////////////////
// Сервер

&НаСервере
Процедура СохранитьЗначениеРеквизита(РеквизитПутьКДанным, Результат)
	
	// Сохранение значений реквизитов, не связанных с константами напрямую (в отношении один-к-одному).
	Если РеквизитПутьКДанным = "" Тогда
		Возврат;
	КонецЕсли;
	
	// Определение имени константы.
	КонстантаИмя = "";
	Если НРег(Лев(РеквизитПутьКДанным, 14)) = НРег("НаборКонстант.") Тогда
		// Если путь к данным реквизита указан через "НаборКонстант".
		КонстантаИмя = Сред(РеквизитПутьКДанным, 15);
	Иначе
		// Определение имени и запись значения реквизита в соответствующей константе из "НаборКонстант".
		// Используется для тех реквизитов формы, которые связаны с константами напрямую (в отношении один-к-одному).
	КонецЕсли;
	
	// Сохранения значения константы.
	Если КонстантаИмя <> "" Тогда
		КонстантаМенеджер = Константы[КонстантаИмя];
		КонстантаЗначение = НаборКонстант[КонстантаИмя];
		
		Если КонстантаМенеджер.Получить() <> КонстантаЗначение Тогда
			КонстантаМенеджер.Установить(КонстантаЗначение);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьДоступность(РеквизитПутьКДанным = "")
	
	Если РеквизитПутьКДанным = "НаборКонстант.ИспользоватьСинхронизациюДанных" ИЛИ РеквизитПутьКДанным = "" Тогда
		
		Элементы.ПрефиксУзлаРаспределеннойИнформационнойБазы.Доступность = НаборКонстант.ИспользоватьСинхронизациюДанных;
		Элементы.НастройкиСинхронизацииДанных.Доступность = НаборКонстант.ИспользоватьСинхронизациюДанных;
		Элементы.ГруппаДатыЗапретаЗагрузки.Доступность    = НаборКонстант.ИспользоватьСинхронизациюДанных;
		Элементы.РезультатыСинхронизацииДанных.Доступность = НаборКонстант.ИспользоватьСинхронизациюДанных;
		Элементы.ГруппаВременныеКаталогиКластераСерверов.Доступность = НаборКонстант.ИспользоватьСинхронизациюДанных;
				
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
