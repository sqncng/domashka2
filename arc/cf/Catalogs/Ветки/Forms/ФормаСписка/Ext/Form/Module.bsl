﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Проекты.УстановитьОтборВСпискеПоПроекту(Список);
	Элементы.СписокКонтекстноеМенюЗапускТестирования.Видимость = ПравоДоступа("Добавление", Метаданные.Документы.ЗапускТестирования); 
	Элементы.ФормаПланированиеТестирования.Видимость = ПравоДоступа("Просмотр", Метаданные.Обработки.ПланировщикУправленияТестированием);
	
	// ОбъектыНаКонтроле
	СпискиДляВыводаКомандКонтроля = Новый Массив;
	СпискиДляВыводаКомандКонтроля.Добавить(
		ОбъектыНаКонтроле.ДанныеСпискаДляВыводаКомандКонтроля(
		"Список", "СписокГруппаКонтроль", "СписокКонтекстноеМенюГруппаКонтроль"));
	ОбъектыНаКонтроле.НастроитьЭлементыПоставитьНаКонтрольВФормеСписка(ЭтотОбъект, СпискиДляВыводаКомандКонтроля);
	// Конец ОбъектыНаКонтроле
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// Если не задан ни один отбор по статусу или типу, то устанавливаются значения по умолчанию
	Если НЕ (Разрабатывается ИЛИ Тестируется ИЛИ Помещена ИЛИ Заморожена) Тогда
		Разрабатывается = Истина;
		Тестируется = Истина;
	КонецЕсли;
	Если НЕ (ВеткиВерсии ИЛИ ВеткиТехническихПроектов ИЛИ ВеткиДляИсправленияОшибок) Тогда
		ВеткиВерсии = Истина;
		ВеткиТехническихПроектов = Истина;
		ВеткиДляИсправленияОшибок = Истина;
	КонецЕсли;
	
	УстановитьОтборПоСтатусу();
	УстановитьОтборПоОтветственному();
	УстановитьОтборПоТипу();

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ОтборОтветственныйПриИзменении(Элемент)
	УстановитьОтборПоОтветственному();
КонецПроцедуры

&НаКлиенте
Процедура РазрабатываетсяПриИзменении(Элемент)
	УстановитьОтборПоСтатусу();
КонецПроцедуры

&НаКлиенте
Процедура ТестируетсяПриИзменении(Элемент)
	УстановитьОтборПоСтатусу();
КонецПроцедуры

&НаКлиенте
Процедура ПомещенаПриИзменении(Элемент)
	УстановитьОтборПоСтатусу();
КонецПроцедуры

&НаКлиенте
Процедура ЗамороженаПриИзменении(Элемент)
	УстановитьОтборПоСтатусу();
КонецПроцедуры

&НаКлиенте
Процедура ВеткиВерсииПриИзменении(Элемент)
	УстановитьОтборПоТипу();
КонецПроцедуры

&НаКлиенте
Процедура ВеткиТехническихПроектовПриИзменении(Элемент)
	УстановитьОтборПоТипу();
КонецПроцедуры

&НаКлиенте
Процедура ВеткиДляИсправленияОшибокПриИзменении(Элемент)
	УстановитьОтборПоТипу();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийТаблицыСписок

&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)
	
	Если НЕ ЗначениеЗаполнено(Элемент.ТекущаяСтрока) 
		ИЛИ ТипЗнч(Элемент.ТекущаяСтрока) <> Тип("СправочникСсылка.Ветки") 
		ИЛИ НЕ Элемент.ТекущиеДанные.Свойство("Тип") Тогда
		Возврат;
	КонецЕсли;
	
	УстановитьВидимостьЭлементовКонтекстногоМеню(Элемент.ТекущиеДанные.Тип);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Заморозить(Команда)
	ПоменятьСтатус(ПредопределенноеЗначение("Перечисление.СтатусыВеток.Заморожена"));
КонецПроцедуры

&НаКлиенте
Процедура ВернутьВРазработку(Команда)
	ПоменятьСтатус(ПредопределенноеЗначение("Перечисление.СтатусыВеток.Разрабатывается"));
КонецПроцедуры

&НаКлиенте
Процедура НаправитьНаТестирование(Команда)
	ПоменятьСтатус(ПредопределенноеЗначение("Перечисление.СтатусыВеток.Тестируется"));
КонецПроцедуры

&НаКлиенте
Процедура Поместить(Команда)
	ПоменятьСтатус(ПредопределенноеЗначение("Перечисление.СтатусыВеток.Помещена"));
КонецПроцедуры

&НаКлиенте
Процедура СоздатьВеткуВерсии(Команда)
	
	Если НЕ ЗначениеЗаполнено(Элементы.Список.ТекущаяСтрока) Тогда
		Возврат;
	КонецЕсли;
	
	ЗначениеЗаполнения = Новый Структура("РазрабатываемыйОбъект, Тип", 
					Элементы.Список.ТекущаяСтрока, 
					ПредопределенноеЗначение("Перечисление.ТипыВеток.ВеткаВерсии"));

	ОткрытьФорму(
		"Справочник.Ветки.ФормаОбъекта",
		Новый Структура("ЗначенияЗаполнения", ЗначениеЗаполнения)
		,
		Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьВеткуТехническогоПроекта(Команда)
	
	Если НЕ ЗначениеЗаполнено(Элементы.Список.ТекущаяСтрока) Тогда
		Возврат;
	КонецЕсли;
	
	ЗначениеЗаполнения = Новый Структура("РазрабатываемыйОбъект, Тип", 
					Элементы.Список.ТекущаяСтрока, 
					ПредопределенноеЗначение("Перечисление.ТипыВеток.ВеткаТехническогоПроекта"));

	ОткрытьФорму(
		"Справочник.Ветки.ФормаОбъекта",
		Новый Структура("ЗначенияЗаполнения", ЗначениеЗаполнения)
		,
		Истина);

КонецПроцедуры

&НаКлиенте
Процедура СоздатьВеткуДляИсправленияОшибок(Команда)
	
	Если НЕ ЗначениеЗаполнено(Элементы.Список.ТекущаяСтрока) Тогда
		Возврат;
	КонецЕсли;
	
	ЗначениеЗаполнения = Новый Структура("РазрабатываемыйОбъект, Тип", 
					Элементы.Список.ТекущаяСтрока, 
					ПредопределенноеЗначение("Перечисление.ТипыВеток.ВеткаДляИсправленияОшибок"));

	ОткрытьФорму(
		"Справочник.Ветки.ФормаОбъекта",
		Новый Структура("ЗначенияЗаполнения", ЗначениеЗаполнения)
		,
		Истина);

КонецПроцедуры

&НаКлиенте
Процедура СтатусТестов(Команда)
	
	Если НЕ ЗначениеЗаполнено(Элементы.Список.ТекущаяСтрока) Тогда
		Возврат;
	КонецЕсли;

	Ветки = Новый Массив;
	Ветки.Добавить(Элементы.Список.ТекущаяСтрока);
	
	ПараметрыФормы = Новый Структура("КлючВарианта, ВидимостьКомандВариантовОтчетов, СформироватьПриОткрытии, Ветка", 
		"СтатусПрохожденияТестовВВетке",
		Истина, 
		Истина, 
		Ветки);
		
	ОткрытьФорму(
		"Отчет.СтатусПрохожденияТестовВВетке.Форма",
		ПараметрыФормы, ,
		Истина);

КонецПроцедуры

&НаКлиенте
Процедура ЗапуститьТестирование(Команда)
	
	Если НЕ ЗначениеЗаполнено(Элементы.Список.ТекущаяСтрока) Тогда
		Возврат;
	КонецЕсли;

	ОткрытьФорму(
		"Документ.ЗапускТестирования.Форма.ФормаДокумента",
		Новый Структура("Ветка", Элементы.Список.ТекущаяСтрока),
		Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗапуститьТестыВыполненныеСОшибкой(Команда)
	
	Если НЕ ЗначениеЗаполнено(Элементы.Список.ТекущаяСтрока) Тогда
		Возврат;
	КонецЕсли;

	ОткрытьФорму(
		"Документ.ЗапускТестирования.Форма.ФормаДокумента",
		Новый Структура("Ветка, ЗапуститьТестыВыполненныеСОшибкой", Элементы.Список.ТекущаяСтрока, Истина),
		Истина);
		
КонецПроцедуры

&НаКлиенте
Процедура ПланированиеТестирования(Команда)
	ОткрытьФорму("Обработка.ПланировщикУправленияТестированием.Форма.Форма",, ЭтаФорма,,,,);
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьВыделенные(Команда)
	
	ГрупповоеИзменениеОбъектовКлиент.ИзменитьВыделенные(Элементы.Список);
	
КонецПроцедуры

// ОбъектыНаКонтроле
&НаКлиенте
Процедура Подключаемый_ВыполнитьКомандуПостановкиНаКонтроль(Команда)
	
	ОбъектыНаКонтролеКлиент.ВыполнитьКомандуПостановкиНаКонтрольИзФормыСписка(ЭтотОбъект, Команда);
	
КонецПроцедуры
// Конец ОбъектыНаКонтроле

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура УстановитьОтборПоСтатусу()
	ОтборПоСтатусам = Новый Массив;
	Если Заморожена Тогда
		ОтборПоСтатусам.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыВеток.Заморожена"));
	Конецесли;
	Если Разрабатывается Тогда
		ОтборПоСтатусам.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыВеток.Разрабатывается"));
	Конецесли;
	Если Тестируется Тогда
		ОтборПоСтатусам.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыВеток.Тестируется"));
	Конецесли;
	Если Помещена Тогда
		ОтборПоСтатусам.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыВеток.Помещена"));
	Конецесли;

	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,
																			"Статус",
																			ОтборПоСтатусам,
																			ВидСравненияКомпоновкиДанных.ВСписке);
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьОтборПоОтветственному()
	
	ИспользоватьОтбор = ЗначениеЗаполнено(ОтборОтветственный);
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,
																			"Ответственный",
																			ОтборОтветственный,
																			ВидСравненияКомпоновкиДанных.Равно,
																			,
																			ИспользоватьОтбор);
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьОтборПоТипу()
	
	МассивТипов = Новый Массив;
	Если ВеткиВерсии Тогда
		МассивТипов.Добавить(ПредопределенноеЗначение("Перечисление.ТипыВеток.ОсновнаяВеткаПроекта"));
		МассивТипов.Добавить(ПредопределенноеЗначение("Перечисление.ТипыВеток.ВеткаВерсии"));
	КонецЕсли;
	Если ВеткиТехническихПроектов Тогда
		МассивТипов.Добавить(ПредопределенноеЗначение("Перечисление.ТипыВеток.ВеткаТехническогоПроекта"));
	КонецЕсли;
	Если ВеткиДляИсправленияОшибок Тогда
		МассивТипов.Добавить(ПредопределенноеЗначение("Перечисление.ТипыВеток.ВеткаДляИсправленияОшибок"));
	КонецЕсли;
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,
																			"Тип",
																			МассивТипов,
																			ВидСравненияКомпоновкиДанных.ВСписке);
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьВидимостьЭлементовКонтекстногоМеню(Тип)
	
	Элементы.СписокКонтекстноеМенюСоздатьВеткуВерсии.Видимость = 
			Тип = ПредопределенноеЗначение("Перечисление.ТипыВеток.ОсновнаяВеткаПроекта") 
			ИЛИ Тип = ПредопределенноеЗначение("Перечисление.ТипыВеток.ВеткаВерсии");
			
	Элементы.СписокКонтекстноеМенюСоздатьВеткуТехническогоПроекта.Видимость =
			Тип = ПредопределенноеЗначение("Перечисление.ТипыВеток.ОсновнаяВеткаПроекта") 
			ИЛИ Тип = ПредопределенноеЗначение("Перечисление.ТипыВеток.ВеткаВерсии") 
			ИЛИ Тип = ПредопределенноеЗначение("Перечисление.ТипыВеток.ВеткаТехническогоПроекта");
	
	Элементы.СписокКонтекстноеМенюСоздатьВеткуДляИсправленияОшибок.Видимость =
			Тип = ПредопределенноеЗначение("Перечисление.ТипыВеток.ОсновнаяВеткаПроекта") 
			ИЛИ Тип = ПредопределенноеЗначение("Перечисление.ТипыВеток.ВеткаВерсии") 
			ИЛИ Тип = ПредопределенноеЗначение("Перечисление.ТипыВеток.ВеткаТехническогоПроекта");
	
КонецПроцедуры

&НаКлиенте
Процедура ПоменятьСтатус(НовыйСтатус)
	ОчиститьСообщения();
	ИзмененныеВетки = Новый Массив;
	Если Элементы.Список.ВыделенныеСтроки.Количество() > 0 Тогда
		ВеткиДляИзменения = Новый Массив;
		Для Каждого Строка из Элементы.Список.ВыделенныеСтроки Цикл
			ВеткиДляИзменения.Добавить(Строка);
		КонецЦикла;
		ПоменятьСтатусНаСервере(ВеткиДляИзменения, ИзмененныеВетки, НовыйСтатус);
	КонецЕсли;
	
	Элементы.Список.Обновить();
	
	ТекстОповещения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru='Статус изменен у %1 веток'"), 
			ИзмененныеВетки.Количество());
	
	ПоказатьОповещениеПользователя(НСтр("ru='Ветки изменены'"),,ТекстОповещения, БиблиотекаКартинок.Информация32);

КонецПроцедуры

&НаСервере
Процедура ПоменятьСтатусНаСервере(ВеткиДляИзменения, ИзмененныеВетки, НовыйСтатус)
	
	РеквизитыВеток = ОбщегоНазначения.ЗначенияРеквизитовОбъектов(ВеткиДляИзменения, "Владелец, Приемник, Статус, Тип, Имя");

	Для Каждого Ссылка Из ВеткиДляИзменения Цикл
		РеквизитыВетки = РеквизитыВеток[Ссылка];
		ПользовательМожетУправлятьВетками = УправлениеДоступомСППР.РольДоступнаПоПроекту("УправлениеВетками", РеквизитыВетки.Владелец);
		Если РеквизитыВетки.Статус = НовыйСтатус Тогда
			// Статус уже установлен
			Продолжить;
		КонецЕсли;
		
		Если НЕ ПользовательМожетУправлятьВетками 
			И (РеквизитыВетки.Статус = ПредопределенноеЗначение("Перечисление.СтатусыВеток.Помещена")
				Или НовыйСтатус = ПредопределенноеЗначение("Перечисление.СтатусыВеток.Помещена")) Тогда
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
							НСтр("ru='Недостаточно прав для изменения статуса у ветки ""%1"".'"), Ссылка));
			Продолжить;
		КонецЕсли;
		ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
							НСтр("ru='Возникли ошибки при проверке ветки ""%1"".'"), Ссылка);
		
		Если ПроверятьЗапросНаСлияниеПриПередачеВеткиВТестирование(РеквизитыВетки.Владелец)
			И (РеквизитыВетки.Тип = ПредопределенноеЗначение("Перечисление.ТипыВеток.ВеткаТехническогоПроекта")
					ИЛИ РеквизитыВетки.Тип = ПредопределенноеЗначение("Перечисление.ТипыВеток.ВеткаДляИсправленияОшибок") )								
			Тогда
			Если НовыйСтатус = ПредопределенноеЗначение("Перечисление.СтатусыВеток.Тестируется") Тогда
				ДанныеОткрытогоЗапросаНаСлияние = ДанныеОткрытогоЗапросаНаСлияние(
					РеквизитыВетки.Владелец, РеквизитыВетки.Имя, РеквизитыВетки.Приемник);
				Если ДанныеОткрытогоЗапросаНаСлияние = Неопределено Тогда
					ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
					НСтр("ru='При проверке ветки ""%1"" не обнаружен запрос на слияние.'"), Ссылка);
					ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
					Продолжить;
				КонецЕсли;	
			ИначеЕсли НовыйСтатус = ПредопределенноеЗначение("Перечисление.СтатусыВеток.Заморожена") Тогда
				ДанныеОткрытогоЗапросаНаСлияние = Неопределено;
				Попытка
					ДанныеОткрытогоЗапросаНаСлияние = ДанныеОткрытогоЗапросаНаСлияние(
						РеквизитыВетки.Владелец, РеквизитыВетки.Имя, РеквизитыВетки.Приемник);
				Исключение
					ТекстОшибки = ОписаниеОшибки();
					Если Найти(ТекстОшибки, "не найдена на гит сервере") = 0 Тогда
						ВызватьИсключение ТекстОшибки;
					КонецЕсли;	
				КонецПопытки;
				Если ДанныеОткрытогоЗапросаНаСлияние <> Неопределено Тогда
					ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
					НСтр("ru='При проверке ветки ""%1"" обнаружен запрос на слияние ""%2"".'"),
						Ссылка, XMLСтрока(ДанныеОткрытогоЗапросаНаСлияние.iid));
					ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
					Продолжить;
				КонецЕсли;	
			КонецЕсли;	
		КонецЕсли;	
		
		Ответ = Новый Структура("ПроверкаВыполненаУспешно", Истина);
		Если НовыйСтатус = ПредопределенноеЗначение("Перечисление.СтатусыВеток.Тестируется") Тогда
			Ответ = Справочники.Ветки.ПроверкаИсправленияОшибокВВетке(Ссылка);
		ИначеЕсли НовыйСтатус = ПредопределенноеЗначение("Перечисление.СтатусыВеток.Заморожена") Тогда
			Ответ = Справочники.Ветки.ПроверкаПередЗакрытиемВетки(Ссылка);
		КонецЕсли;
		Если НЕ Ответ.ПроверкаВыполненаУспешно Тогда
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения + Символы.ПС + Ответ.Сообщение);
			Продолжить;
		КонецЕсли;
		
		Ветка = Ссылка.ПолучитьОбъект();
		Ветка.Статус = НовыйСтатус;
			
		Если НЕ Ветка.ПроверитьЗаполнение() Тогда
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
		Иначе
			Попытка
				Ветка.Записать();
				ИзмененныеВетки.Добавить(Ссылка);
			Исключение
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
			КонецПопытки;
		КонецЕсли;

	КонецЦикла;

	Если НовыйСтатус = Перечисления.СтатусыВеток.Помещена
		И ИзмененныеВетки.Количество()>0 Тогда
		
		Для Каждого Ветка из ИзмененныеВетки Цикл
			Справочники.Ветки.ОповеститьСогласующихПоИзменениямВВетке(Ветка);
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ДанныеОткрытогоЗапросаНаСлияние(Проект, ИмяВетки, ВеткаПриемник)
	
	Возврат ТестированиеЗапускТестирования.ДанныеОткрытогоЗапросаНаСлияниеПоВетке(Проект, ИмяВетки,
		ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ВеткаПриемник, "Имя"));
	
КонецФункции

&НаСервереБезКонтекста
Функция ПроверятьЗапросНаСлияниеПриПередачеВеткиВТестирование(Проект)
	Возврат ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Проект, "ПроверятьНаличиеЗапросаНаПомещениеПриСменеСтатусаВетки")
			И ПолучитьФункциональнуюОпцию("ИспользоватьТестирование");
КонецФункции	 
		
#КонецОбласти
