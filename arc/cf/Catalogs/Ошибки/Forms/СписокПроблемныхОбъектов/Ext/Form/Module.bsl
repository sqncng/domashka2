﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ТипПроблемы = Параметры.ТипПроблемы;
	Проект = Параметры.Проект;
	ВерсияИсправления = Параметры.ВерсияИсправления;
	ДоступноИзменениеОшибки = Параметры.ДоступноИзменениеОшибки;
	Ошибка = Параметры.Ошибка;
	
	Если Параметры.Свойство("СписокОбъектов") Тогда
		
		ДанныеОбОбъектах = Параметры.СписокОбъектов;
		
		Если ТипЗнч(ДанныеОбОбъектах) = Тип("Массив") Тогда
			Для Каждого СтрокаТЧ из ДанныеОбОбъектах Цикл
				НоваяСтрока = СписокОбъектов.Добавить();
				ЗаполнитьЗначенияСвойств(НоваяСтрока, СтрокаТЧ);
			КонецЦикла;
		КонецЕсли;
		
	КонецЕсли;
	
	УстановитьЗаголовок();
	УстановитьВидимостьДоступностьЭлементов();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если (ИмяСобытия = "ПеренаправленаОшибкаАудита" ИЛИ ИмяСобытия = "НеПризнанаОшибкаАудита")
		И Источник = ВладелецФормы Тогда
		ЗавершитьПеренаправлениеОшибки();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийТаблицыСписокОбъектов

&НаКлиенте
Процедура СписокОбъектовПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	
	ТекущиеДанные        = Элементы.СписокОбъектов.ТекущиеДанные;
	СписокВыбораЭлемента = Элементы.СписокОбъектовПодчиненныйОбъектСтрока.СписокВыбора;
	
	Если (НоваяСтрока И Не Копирование)
	 ИЛИ Не ЗначениеЗаполнено(ТекущиеДанные.ПроблемныйОбъект) Тогда
		
		Если ТипПроблемы = ПредопределенноеЗначение("Перечисление.ТипПроблемы.ОбъектыМетаданных") Тогда
			ТекущиеДанные.ПроблемныйОбъект = ПредопределенноеЗначение("Справочник.ОбъектыМетаданных.ПустаяСсылка");
		ИначеЕсли ТипПроблемы = ПредопределенноеЗначение("Перечисление.ТипПроблемы.ОбработчикиОбновления") Тогда
			ТекущиеДанные.ПроблемныйОбъект = ПредопределенноеЗначение("Справочник.ОбработчикиОбновленияИнформационнойБазы.ПустаяСсылка");
		КонецЕсли;
		
	КонецЕсли; 
	
	Если ТипПроблемы = ПредопределенноеЗначение("Перечисление.ТипПроблемы.ОбъектыМетаданных") Тогда
		ТаблицаМетаданныеПриНачалеРедактирования(ТекущиеДанные, СписокВыбораЭлемента);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СписокОбъектовПроблемныйОбъектНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ТекущиеДанные = Элементы.СписокОбъектов.ТекущиеДанные;
	ТипПроблемы   = ТипПроблемы;
	
	Если ТипПроблемы = ПредопределенноеЗначение("Перечисление.ТипПроблемы.ОбъектыМетаданных") Тогда
		ОшибкиКлиент.ОбъектМетаданныхНачалоВыбора(ТекущиеДанные, Элемент, СтандартнаяОбработка, Проект);
	ИначеЕсли ТипПроблемы = ПредопределенноеЗначение("Перечисление.ТипПроблемы.ОбработчикиОбновления") Тогда
		ОшибкиКлиент.ОбрабочикОбновленияНачалоВыбора(ТекущиеДанные, Элемент, СтандартнаяОбработка, Проект, ВерсияИсправления);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СписокОбъектовПроблемныйОбъектОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	Если ТипПроблемы = ПредопределенноеЗначение("Перечисление.ТипПроблемы.ОбъектыМетаданных") Тогда
		
		Элементы.СписокОбъектов.ТекущиеДанные.ПодчиненныйОбъект = Неопределено;
		Элементы.СписокОбъектов.ТекущиеДанные.ПодчиненныйОбъектСтрока = "";
		СписокВыбораЭлемента = Элементы.СписокОбъектовПодчиненныйОбъектСтрока.СписокВыбора;
		ОбъектМетаданныхОбработкаВыбора(СписокВыбораЭлемента, ВыбранноеЗначение, СтандартнаяОбработка);
		
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура СписокОбъектовПодчиненныйОбъектСтрокаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.СписокОбъектов.ТекущиеДанные;
	
	Если Не ЗначениеЗаполнено(ТекущиеДанные.ПодчиненныйОбъектСтрока) Тогда
		ТекущиеДанные.ПодчиненныйОбъект = Неопределено;
	КонецЕсли;
	
	Модифицированность = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура СписокОбъектовПодчиненныйОбъектСтрокаОткрытие(Элемент, СтандартнаяОбработка)
	
	ТекущиеДанные = Элементы.СписокОбъектов.ТекущиеДанные;
	
	СтандартнаяОбработка = Ложь;
	ПодчиненныйОбъект = ТекущиеДанные.ПодчиненныйОбъект;
	ПоказатьЗначение(, ПодчиненныйОбъект);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОК(Команда)
	
	ОчиститьСообщения();
	
	СписокПроблемныхОбъектов  = Новый Массив;
	СписокОбъектовДляПереноса = Новый Массив;
	
	СтруктураРезультата = Новый Структура;
	
	ЗаполнитьСпискиОбъектовДляПереноса(СписокПроблемныхОбъектов, СписокОбъектовДляПереноса);
	
	СтруктураРезультата.Вставить("СписокОбъектов", СписокПроблемныхОбъектов);
	
	Закрыть(СтруктураРезультата);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗахватитьОбъекты(Команда)
	
	ОчиститьСообщения();
	
	СписокПроблемныхОбъектов  = Новый Массив;
	СписокОбъектовДляпереноса = Новый Массив;
	
	СтруктураРезультата = Новый Структура;
	
	ЗаполнитьСпискиОбъектовДляПереноса(СписокПроблемныхОбъектов, СписокОбъектовДляПереноса);
	
	СтруктураРезультата.Вставить("СписокОбъектов",   СписокПроблемныхОбъектов);
	СтруктураРезультата.Вставить("ЗахватитьОбъекты", Истина);
	
	Закрыть(СтруктураРезультата);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьПоСпискуОбъектов(Команда)
	
	#Если НЕ ВебКлиент Тогда
		ИмяТаблицы = "СписокОбъектов";
		ВариантЗаполнения = "СписокОбъектов";
		ОшибкиКлиент.ЗаполнитьСписокОбъектов(ИмяТаблицы, ВариантЗаполнения, СписокОбъектов, ЭтотОбъект);
	#КонецЕсли

КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьПоРезультатамПоискаСсылокНаОбъект(Команда)
	
	#Если НЕ ВебКлиент Тогда
		ИмяТаблицы = "СписокОбъектов";
		ВариантЗаполнения = "ПоискСсылок";
		ОшибкиКлиент.ЗаполнитьСписокОбъектов(ИмяТаблицы, ВариантЗаполнения, СписокОбъектов, ЭтотОбъект);
	#КонецЕсли

КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьПоРезультатамГлобальногоПоиска(Команда)
	
	#Если НЕ ВебКлиент Тогда
		ИмяТаблицы = "СписокОбъектов";
		ВариантЗаполнения = "ГлобальныйПоиск";
		ОшибкиКлиент.ЗаполнитьСписокОбъектов(ИмяТаблицы, ВариантЗаполнения, СписокОбъектов, ЭтотОбъект);
	#КонецЕсли

КонецПроцедуры

&НаКлиенте
Процедура ПеренаправитьОшибкуПоАудиту(Команда)
	
	ОчиститьСообщения();
	
	СписокПроблемныхОбъектов  = Новый Массив;
	СписокОбъектовДляпереноса = Новый Массив;
	
	СтруктураРезультата = Новый Структура;
	
	ЗаполнитьСпискиОбъектовДляПереноса(СписокПроблемныхОбъектов, СписокОбъектовДляПереноса);
	
	СтруктураРезультата.Вставить("СписокОбъектов",            СписокПроблемныхОбъектов);
	СтруктураРезультата.Вставить("СписокОбъектовДляПереноса", СписокОбъектовДляПереноса);
	
	СтруктураРезультата.Вставить("ОбновлятьСписокОбъектов", Истина);
	
	Оповестить("ПеренаправитьОшибкуПоАудиту", СтруктураРезультата, ЭтаФорма);
				
КонецПроцедуры

&НаКлиенте
Процедура НеПризнаватьОшибкуПоАудиту(Команда)
	
	ОчиститьСообщения();
	
	СписокПроблемныхОбъектов  = Новый Массив;
	СписокОбъектовДляпереноса = Новый Массив;
	
	СтруктураРезультата = Новый Структура;
	
	ЗаполнитьСпискиОбъектовДляПереноса(СписокПроблемныхОбъектов, СписокОбъектовДляПереноса);
	
	СтруктураРезультата.Вставить("СписокОбъектов",            СписокПроблемныхОбъектов);
	СтруктураРезультата.Вставить("СписокОбъектовДляПереноса", СписокОбъектовДляПереноса);
	
	СтруктураРезультата.Вставить("ОбновлятьСписокОбъектов", Истина);
	
	Оповестить("НеПризнаватьОшибкуПоАудиту", СтруктураРезультата, ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗарегистрироватьОшибкуПоОбработчикамОбновления(Команда)
	
	ИмяТЧ = "СписокОбъектов";
	
	ВыделенныеСтроки = Элементы.СписокОбъектов.ВыделенныеСтроки;
	
	Если ВыделенныеСтроки.Количество() = 0 Тогда
		ТекстСообщения = НСтр("ru = 'Выделите строки, по которым нужно зарегистрировать ошибку.'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, , ИмяТЧ);
		Возврат;
	КонецЕсли;
	
	МассивОбъектов = Новый Массив;
	Для Каждого ИндексСтроки Из ВыделенныеСтроки Цикл
		СтрокаТаблицы = СписокОбъектов.НайтиПоИдентификатору(ИндексСтроки);
		МассивОбъектов.Добавить(СтрокаТаблицы.ПроблемныйОбъект);
	КонецЦикла;
	
	ЗначенияЗаполнения = Новый Структура;
	ЗначенияЗаполнения.Вставить("Ошибка", Ошибка);
	ЗначенияЗаполнения.Вставить("СписокОбъектов", МассивОбъектов);
	ЗначенияЗаполнения.Вставить("МетодВыявленияОшибки", ПредопределенноеЗначение("Перечисление.МетодыВыявленияОшибок.АудитКода"));
	
	ОткрытьФорму("Справочник.Ошибки.ФормаОбъекта", Новый Структура("ЗначенияЗаполнения", ЗначенияЗаполнения));
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ТаблицаМетаданныеПриНачалеРедактирования(ТекущиеДанные, СписокВыбораЭлемента)
	
	СписокВыбораЭлемента.Очистить();
	
	ОбъектМетаданных = ТекущиеДанные.ПроблемныйОбъект;
	
	Если ОбъектМетаданных <> Неопределено И Не ОбъектМетаданных.Пустая() Тогда
		
		СписокВыбора = Новый СписокЗначений;
		УстановитьСписокВыбораПодчиненныхОбъектов(ОбъектМетаданных, СписокВыбора, СписокПодчиненныхОбъектов);
		
		Для Каждого ЭлементСписка Из СписокВыбора Цикл
			СписокВыбораЭлемента.Добавить(ЭлементСписка.Значение, ЭлементСписка.Представление);
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбъектМетаданныхОбработкаВыбора(СписокВыбораЭлемента, ВыбранноеЗначение, СтандартнаяОбработка)
	
	Если ТипЗнч(ВыбранноеЗначение) = Тип("Тип") Тогда
		Возврат;
	КонецЕсли; 
	
	СписокВыбораЭлемента.Очистить();
	
	СписокВыбора = Новый СписокЗначений;
	УстановитьСписокВыбораПодчиненныхОбъектов(ВыбранноеЗначение, СписокВыбора, СписокПодчиненныхОбъектов);
	
	Для Каждого ЭлементСписка Из СписокВыбора Цикл
		СписокВыбораЭлемента.Добавить(ЭлементСписка.Значение, ЭлементСписка.Представление);
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьСписокВыбораПодчиненныхОбъектов(ОбъектМетаданных, СписокВыбора, СписокПодчиненныхОбъектов)
	
	Справочники.Ошибки.УстановитьСписокВыбораПодчиненныхОбъектов(ОбъектМетаданных, СписокВыбора, СписокПодчиненныхОбъектов);
	
КонецПроцедуры

&НаКлиенте
Процедура СписокОбъектовПодчиненныйОбъектСтрокаОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	ТекущиеДанные = Элементы.СписокОбъектов.ТекущиеДанные;
	СписокВыбораЭлемента = Элементы.СписокОбъектовПодчиненныйОбъектСтрока.СписокВыбора;
	
	ИндексЭлемента = СписокВыбораЭлемента.Индекс(СписокВыбораЭлемента.НайтиПоЗначению(ВыбранноеЗначение));
	ТекущиеДанные.ПодчиненныйОбъект = СписокПодчиненныхОбъектов.Получить(ИндексЭлемента).Значение;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьЗаголовок()
	
	Если ТипПроблемы = Перечисления.ТипПроблемы.ОбъектыМетаданных Тогда
		Заголовок = НСтр("ru='Объекты метаданных'");
	ИначеЕсли ТипПроблемы = Перечисления.ТипПроблемы.ОбработчикиОбновления Тогда
		Заголовок = НСтр("ru='Обработчики обновления'");
	Иначе
		Заголовок = НСтр("ru='Проблемные объекты'");
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьДоступностьЭлементов()
	
	ПроблемаМетаданных     = (ТипПроблемы = ПредопределенноеЗначение("Перечисление.ТипПроблемы.ОбъектыМетаданных"));
	ПроблемаОбработчиков   = (ТипПроблемы = ПредопределенноеЗначение("Перечисление.ТипПроблемы.ОбработчикиОбновления"));
	
	РежимРазработкиПроекта = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Проект, "РежимРазработки");
	
	Если ПроблемаМетаданных Тогда
		Элементы.СписокОбъектовПроблемныйОбъект.Заголовок = "Объект метаданных";
	ИначеЕсли ПроблемаОбработчиков Тогда
		Элементы.СписокОбъектовПроблемныйОбъект.Заголовок = "Обработчик обновления";
	КонецЕсли; 
	
	Элементы.СписокОбъектовПроблемныйОбъект.Видимость        = ПроблемаМетаданных ИЛИ ПроблемаОбработчиков;
	Элементы.СписокОбъектовПодчиненныйОбъектСтрока.Видимость = ПроблемаМетаданных;

	Элементы.ГруппаЗаполнить.Видимость = ПроблемаМетаданных И ДоступноИзменениеОшибки;
	Элементы.ЗахватитьОбъекты.Видимость = ПроблемаМетаданных И ДоступноИзменениеОшибки И РежимРазработкиПроекта = Перечисления.РежимРазработки.ВХранилище;
	Элементы.ЗарегистрироватьОшибкуПоОбработчикамОбновления.Видимость = ПроблемаОбработчиков И ДоступноИзменениеОшибки;
	Элементы.ПеренаправитьОшибкуПоАудиту.Видимость = СписокОбъектов.Количество() > 1;
	Элементы.НеПризнаватьОшибкуПоАудиту.Видимость = СписокОбъектов.Количество() > 1;
	
	ТолькоПросмотр = НЕ ДоступноИзменениеОшибки;
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ЗаполнитьТаблицуОбъектовМетаданныхЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Не ЗначениеЗаполнено(Результат) Тогда
		Возврат;
	КонецЕсли;
	
	ЗаполнитьПоРезультатамПоискаСервер(Результат, ДополнительныеПараметры);
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьПоРезультатамПоискаСервер(Результат, ДополнительныеПараметры)
	
	ПараметрыВыполнения = ДополнительныеПараметры.ПараметрыВыполнения;
	ИмяТаблицы          = ДополнительныеПараметры.ИмяТаблицы;
	ТаблицаМетаданные   = СписокОбъектов.Выгрузить();

	ТаблицаОбъектов = Справочники.Ошибки.ТаблицаОбъектовПоРезультатамПоиска(ТаблицаМетаданные,
	                                                      ИмяТаблицы,
														  Проект,
														  Результат,
														  ПараметрыВыполнения);
														  
	Для Каждого СтрокаТаблицы из ТаблицаОбъектов Цикл
		НоваяСтрока = СписокОбъектов.Добавить();
		НоваяСтрока.ПроблемныйОбъект = СтрокаТаблицы.ОбъектМетаданных;
		ЗаполнитьЗначенияСвойств(НоваяСтрока, СтрокаТаблицы);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьСпискиОбъектовДляПереноса(СписокПроблемныхОбъектов, СписокОбъектовДляПереноса)
	
	Для Каждого СтрокаТаблицы из СписокОбъектов Цикл
		
		Структура = Новый Структура;
		Структура.Вставить("ПроблемныйОбъект", СтрокаТаблицы.ПроблемныйОбъект);
		Структура.Вставить("ПодчиненныйОбъект", СтрокаТаблицы.ПодчиненныйОбъект);
		Структура.Вставить("ПодчиненныйОбъектСтрока", СтрокаТаблицы.ПодчиненныйОбъектСтрока);
		Структура.Вставить("Уточнение", СтрокаТаблицы.Уточнение);
		Структура.Вставить("ХешУточнения", СтрокаТаблицы.ХешУточнения);
		Структура.Вставить("Комментарий", СтрокаТаблицы.Комментарий);
		
		ВыделенныеСтроки = Элементы.СписокОбъектов.ВыделенныеСтроки;
		
		ИдентификаторСтроки = СтрокаТаблицы.ПолучитьИдентификатор();
		
		Переносить = Ложь;
		Если ВыделенныеСтроки.Найти(ИдентификаторСтроки) <> Неопределено Тогда
			Переносить = Истина;
		КонецЕсли;
		
		Структура.Вставить("Переносить", Переносить);
		
		Если Переносить Тогда
			СписокОбъектовДляПереноса.Добавить(Структура);
		КонецЕсли;
		
		СписокПроблемныхОбъектов.Добавить(Структура);
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗавершитьПеренаправлениеОшибки()
	
	МассивИдентификаторов = Элементы.СписокОбъектов.ВыделенныеСтроки;
	УдаляемыеСтроки = Новый Массив;
	Для Каждого ИдентификаторСтроки из МассивИдентификаторов Цикл
		СтрокаТаблицы = СписокОбъектов.НайтиПоИдентификатору(ИдентификаторСтроки);
		УдаляемыеСтроки.Добавить(СтрокаТаблицы);
	КонецЦикла;
	
	Для Каждого СтрокаТаблицы из УдаляемыеСтроки Цикл
		СписокОбъектов.Удалить(СтрокаТаблицы);
	КонецЦикла;
	
	МОдифицированность = Ложь;
	
	Если СписокОбъектов.Количество() = 0 Тогда
		Закрыть();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти