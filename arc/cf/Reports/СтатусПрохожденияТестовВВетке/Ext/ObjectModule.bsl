﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

// Настройки общей формы отчета подсистемы "Варианты отчетов".
//
// Параметры:
//   Форма - ФормаКлиентскогоПриложения - Форма отчета.
//   КлючВарианта - Строка - Имя предопределенного варианта отчета или уникальный идентификатор пользовательского.
//   Настройки - Структура - см. возвращаемое значение ОтчетыКлиентСервер.ПолучитьНастройкиОтчетаПоУмолчанию().
//
Процедура ОпределитьНастройкиФормы(Форма, КлючВарианта, Настройки) Экспорт
	Настройки.События.ПриСозданииНаСервере = Истина;
	Настройки.События.ПриЗагрузкеПользовательскихНастроекНаСервере = Истина;
КонецПроцедуры

// Вызывается в обработчике одноименного события формы отчета после выполнения кода формы.
//
// Параметры:
//   ЭтаФорма - ФормаКлиентскогоПриложения - Форма отчета.
//   Отказ - Булево - Передается из параметров обработчика "как есть".
//   СтандартнаяОбработка - Булево - Передается из параметров обработчика "как есть".
//
// См. также:
//   "ФормаКлиентскогоПриложения.ПриСозданииНаСервере" в синтакс-помощнике.
//
Процедура ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка) Экспорт
	
	КомпоновщикНастроекФормы = ЭтаФорма.Отчет.КомпоновщикНастроек;
	Параметры = ЭтаФорма.Параметры;
	
	Если Параметры.Свойство("Расшифровка") И Параметры.Расшифровка <> Неопределено 
		И Параметры.Свойство("РасшифровкаОшибок") Тогда
		ЭтаФорма.Заголовок = "Статус прохождения тестов в ветке (Расшифровка)";
		КомпоновщикНастроекФормы.ЗагрузитьНастройки(Параметры.Расшифровка.ПрименяемыеНастройки);
		КомпоновщикНастроекФормы.Настройки.Структура.ИдентификаторПользовательскойНастройки = "РасшифровкаОшибок";
		СтандартнаяОбработка = Ложь;
		
		Если ЭтаФорма.КлючТекущегоВарианта <> "СтатусПрохожденияТестовВВеткеПоОшибкам" Тогда
			ФиксированныеНастройки = КомпоновщикНастроекФормы.ФиксированныеНастройки.ПараметрыДанных;
			ПараметрПериодОтбор = ПараметрПоНастройкам(ФиксированныеНастройки, "ДетализацияПоОшибкам");
			ПараметрПериодОтбор.Использование = Истина;
			ПараметрПериодОтбор.Значение = Истина;
		КонецЕсли;

	КонецЕсли;
	
КонецПроцедуры

// Вызывается в одноименном обработчике формы отчета после выполнения кода формы.
//
Процедура ПриЗагрузкеПользовательскихНастроекНаСервере(Форма, НовыеПользовательскиеНастройкиКД) Экспорт
	Отчет = Форма.Отчет;
	Параметры = Форма.Параметры;
	ПользовательскиеНастройки = Отчет.КомпоновщикНастроек.ПользовательскиеНастройки;
	ФиксированныеНастройки = Отчет.КомпоновщикНастроек.ФиксированныеНастройки.ПараметрыДанных; 

	Если Параметры.Свойство("Ветка") Тогда
		СписокВеток = СписокЗначенийИзПараметров(Параметры.Ветка);
		Если СписокВеток.Количество() > 0 Тогда
			ПараметрПоНастройкам(ПользовательскиеНастройки, "Ветка").Значение = СписокВеток[0].Значение;
		КонецЕсли;
	КонецЕсли;
		
	Если Параметры.Свойство("Тесты") Тогда
		СписокТестов = СписокЗначенийИзПараметров(Параметры.Тесты);
		Если СписокТестов.Количество() > 0 Тогда
			ПараметрПоНастройкам(ФиксированныеНастройки, "Тесты").Значение = СписокТестов;
		КонецЕсли;
	КонецЕсли;
	
	Если Параметры.Свойство("ТестыОтбор") Тогда
		ТестыОтборЭлемент = ПараметрПоНастройкам(ПользовательскиеНастройки, "ТестыОтбор");
		Если ТестыОтборЭлемент <> Неопределено Тогда
			ТестыОтборЭлемент.Значение = Параметры.ТестыОтбор;
		КонецЕсли;
	КонецЕсли;
	Если Параметры.Свойство("ВключатьОшибкиОбнаруженныеВДругихВетках") Тогда
		ПараметрПоНастройкам(ПользовательскиеНастройки, "ВключатьОшибкиОбнаруженныеВДругихВетках").Значение = Параметры.ВключатьОшибкиОбнаруженныеВДругихВетках;
	КонецЕсли;
	Если Параметры.Свойство("Сборка") Тогда
		ПараметрСборка = ПараметрПоНастройкам(ФиксированныеНастройки, "СборкаВерсии");
		ПараметрСборка.Использование = Истина;
		ПараметрСборка.Значение = Параметры.Сборка;
	КонецЕсли;
	
	Если Параметры.Свойство("ПериодОтбор") Тогда
		ПараметрПериодОтбор = ПараметрПоНастройкам(ПользовательскиеНастройки, "ПериодОтбор");
		ПараметрПериодОтбор.Использование = Истина;
		ПараметрПериодОтбор.Значение = Параметры.ПериодОтбор;
	КонецЕсли;
	
	Если Параметры.Свойство("ДатаОкончания") Тогда
		ПараметрПериодОтбор = ПараметрПоНастройкам(ПользовательскиеНастройки, "ПериодОтбор");
		ПараметрПериодОтбор.Использование = Истина;
		ПараметрПериодОтбор.Значение.ДатаОкончания = Параметры.ДатаОкончания;
	КонецЕсли;
	
	Если Параметры.Свойство("ДатаНачала") Тогда
		ПараметрПериодОтбор = ПараметрПоНастройкам(ПользовательскиеНастройки, "ПериодОтбор");
		ПараметрПериодОтбор.Использование = Истина;
		ПараметрПериодОтбор.Значение.ДатаНачала = Параметры.ДатаНачала;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытий

Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка) 

	СтандартнаяОбработка = Ложь;
	ПользовательскиеНастройкиМодифицированы = Ложь;
	
	НастройкиОтчета = КомпоновщикНастроек.ПолучитьНастройки();
	
	Если НастройкиОтчета.Структура.ИдентификаторПользовательскойНастройки = "РасшифровкаОшибок" Тогда

		ДобавитьПоляВРасшифровку = Новый Массив();      
		ДобавитьПоляВРасшифровку.Добавить("Ошибка");
		ДобавитьПоляВРасшифровку.Добавить("Ошибка.Код");
		ДобавитьПоляВРасшифровку.Добавить("Ошибка.Статус");
		ДобавитьПоляВРасшифровку.Добавить("Ошибка.КомуНаправлена");  
		ДобавитьПоляВРасшифровку.Добавить("МестоОбнаруженияОшибки");
		ДобавитьПоляВРасшифровку.Добавить("ДатаИзмененияОшибки");
		ДобавитьПоляВРасшифровку.Добавить("Ошибка.ПовторяемаяОшибка");
		ДобавитьПоляВРасшифровку.Добавить("Ошибка.ПовторяемаяОшибка.Статус"); 
		ДобавитьПоляВРасшифровку.Добавить("Ошибка.ВеткаИсправления");
		ДобавитьПоляВРасшифровку.Добавить("Ошибка.ВеткаИсправления.Статус");   
		
		Для Каждого Структура Из НастройкиОтчета.Структура Цикл
			Структура.ПоляГруппировки.Элементы.Очистить();
			Структура.Выбор.Элементы.Очистить();
			
			Для Каждого Поле Из ДобавитьПоляВРасшифровку Цикл
				
				ПолеГруппировки = Структура.ПоляГруппировки.Элементы.Добавить(Тип("ПолеГруппировкиКомпоновкиДанных"));
				ПолеГруппировки.Использование = Истина;
				ПолеГруппировки.Поле = Новый ПолеКомпоновкиДанных(Поле);

				ПолеВыбора = Структура.Выбор.Элементы.Добавить(Тип("ВыбранноеПолеКомпоновкиДанных"));
				ПолеВыбора.Использование = Истина;
				ПолеВыбора.Поле = Новый ПолеКомпоновкиДанных(Поле);
				
			КонецЦикла;
		КонецЦикла;
	КонецЕсли;
	
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
	МакетКомпоновки = КомпоновщикМакета.Выполнить(СхемаКомпоновкиДанных, НастройкиОтчета, ДанныеРасшифровки);
	ПроцессорКомпоновки = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновки.Инициализировать(МакетКомпоновки, , ДанныеРасшифровки, Истина);
	ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВТабличныйДокумент;
	ПроцессорВывода.УстановитьДокумент(ДокументРезультат);
	ПроцессорВывода.Вывести(ПроцессорКомпоновки);
	
	// Фиксируется колонка с Актуальным состоянием теста
	ДокументРезультат.ФиксацияСлева = ДокументРезультат.ФиксацияСлева + 1; 
	
	// Получаем общий заголовок для колонок с запусками тестирования
	Заголовок = Метаданные.Документы.ЗапускТестирования.Представление() + Символы.ПС;
	// Общий заголовок выносится в отдельную общую ячейку
	ТестированиеСлужебныйВызовСервера.ОбъединитьЗаголовкиВТабличномДокументе(ДокументРезультат, Заголовок);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ПараметрПоНастройкам(КомпоновщикНастроек, ИмяЭлемента)
	Параметр = Новый ПараметрКомпоновкиДанных(ИмяЭлемента);
	Для Каждого Элем Из КомпоновщикНастроек.Элементы Цикл
		Если ТипЗнч(Элем) = Тип("ЗначениеПараметраНастроекКомпоновкиДанных") 
			И Элем.Параметр = Параметр Тогда
			Возврат Элем; 
		КонецЕсли;
	КонецЦикла;
КонецФункции

Функция СписокЗначенийИзПараметров(ЗначениеПараметра)
	НовыйСписок = Новый СписокЗначений;
	Если ТипЗнч(ЗначениеПараметра) = Тип("Массив") Тогда
		НовыйСписок.ЗагрузитьЗначения(ЗначениеПараметра);
	ИначеЕсли ТипЗнч(ЗначениеПараметра) = Тип("СписокЗначений") Тогда
		НовыйСписок = ЗначениеПараметра;
	Иначе
		НовыйСписок.Добавить(ЗначениеПараметра);
	КонецЕсли;
	Возврат НовыйСписок;
КонецФункции

#КонецОбласти

#КонецЕсли