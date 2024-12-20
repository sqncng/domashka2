﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	ЗаполнитьРеквизитыФормы();
	
	ОбновитьТаблицуОшибокСервер();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ОшибкаОтредактирована" И ТекущаяОшибка = Параметр Тогда
		ЗаполнитьРеквизитыФормы();
		Элементы.ТаблицаОшибок.Обновить();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

#КонецОбласти

#Область ОбработчикиСобытийТаблицыОшибок

&НаКлиенте
Процедура ТаблицаОшибокПриАктивизацииСтроки(Элемент)
	
	СформироватьПодвалФормы();
	
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаОшибокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ИзменитьОшибку(Неопределено);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ИзменитьОшибку(Команда)
	
	ТекущиеДанные = Элементы.ТаблицаОшибок.ТекущиеДанные;
	
	Если ТекущиеДанные = Неопределено Тогда
		ПоказатьПредупреждение(Неопределено, НСтр("ru='Не указана ошибка для изменения.'"));
		Возврат;
	КонецЕсли;
	
	ДанныеОшибки = Новый Структура("Название, Уточнение, Объект, МестоОбнаружения, Состояние, ПричинаОсобенности");
	ЗаполнитьЗначенияСвойств(ДанныеОшибки, ТекущиеДанные);
	
	ПараметрыФормы = Новый Структура("ДанныеОшибки, ВозможныеПричиныОсобенности", ДанныеОшибки, ВозможныеПричиныОсобенности);
	
	Структура = Новый Структура("ТекущиеДанные", ТекущиеДанные);
	ОписаниеОповещения = Новый ОписаниеОповещения("ИзменитьОшибкуЗавершение", ЭтотОбъект, Структура);
	
	ОткрытьФорму(
	    "Обработка.ИнтеграцияСАПК.Форма.ИзменениеОшибки",
		ПараметрыФормы,
		ЭтаФорма,
		,
		,
		,
		ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьОшибкуЗавершение(РезультатДействия, ДополнительныеПараметры) Экспорт
    
    ТекущиеДанные = ДополнительныеПараметры.ТекущиеДанные;
    
    Результат = РезультатДействия;
    
    Если НЕ ЗначениеЗаполнено(Результат) Тогда
        Возврат;
    КонецЕсли;
    
    Если НЕ ЗаписатьОшибкиАПК(Элементы.ТаблицаОшибок.ТекущаяСтрока, Результат) Тогда
        Возврат;
    КонецЕсли;
    
    ЗаполнитьЗначенияСвойств(ТекущиеДанные,	Результат);
    
    СформироватьПодвалФормы();

КонецПроцедуры

&НаКлиенте
Процедура ОтметитьКакИсправленную(Команда)
	Перем МассивСтрок;
	
	Если НЕ ПроверитьНаличиеВыделенныхСтрок(МассивСтрок) Тогда
		Возврат;
	КонецЕсли;
	
	УстановитьСостояниеОшибокАПК(МассивСтрок, ПредопределенноеЗначение("Перечисление.СостояниеОшибкиАПК.Исправлена"));
	
	СформироватьПодвалФормы();
	
КонецПроцедуры

&НаКлиенте
Процедура ОтметитьКакОсобенность(Команда)
	Перем МассивСтрок;
	
	Если НЕ ПроверитьНаличиеВыделенныхСтрок(МассивСтрок) Тогда
		Возврат;
	КонецЕсли;
	
	УстановитьСостояниеОшибокАПК(МассивСтрок, ПредопределенноеЗначение("Перечисление.СостояниеОшибкиАПК.Особенность"));
	
	СформироватьПодвалФормы();
	
КонецПроцедуры

&НаКлиенте
Процедура Перенаправить(Команда)
	Перем МассивСтрок;
	
	Если НЕ ПроверитьНаличиеВыделенныхСтрок(МассивСтрок) Тогда
		Возврат;
	КонецЕсли;
	
	УстановитьПользователяОшибокАПК(МассивСтрок);
	
	ЭтаФорма.Заголовок =
		ЗаголовокФормы(ТаблицаОшибок.Количество(), ?(ТаблицаОшибок.Количество() > 0,  ТаблицаОшибок[0].Название, ""));
	
	СформироватьПодвалФормы();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьТаблицуОшибок(Команда)
	
	ОбновитьТаблицуОшибокСервер();
	
	СформироватьПодвалФормы();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область РаботаСОшибками

&НаКлиенте
Процедура УстановитьСостояниеОшибокАПК(МассивСтрок, Состояние, ПричинаОсобенности = "")
	
	Если Состояние <> ПредопределенноеЗначение("Перечисление.СостояниеОшибкиАПК.Исправлена") Тогда
		
		ДанныеОшибки = Новый Структура(
			"Состояние, ПричинаОсобенности, КоличествоОшибок",
			Состояние, ПричинаОсобенности, МассивСтрок.Количество());
		
		ПараметрыФормы = Новый Структура("ДанныеОшибки, ВозможныеПричиныОсобенности", ДанныеОшибки, ВозможныеПричиныОсобенности);
		
		Структура = Новый Структура("МассивСтрок", МассивСтрок);
		ОписаниеОповещения = Новый ОписаниеОповещения("УстановитьСостояниеОшибокАПКЗавершение", ЭтотОбъект, Структура);
		
		ОткрытьФорму("Обработка.ИнтеграцияСАПК.Форма.ИзменениеОшибок",
					ПараметрыФормы,
					ЭтаФорма,
					,
					,
					,
					ОписаниеОповещения);
		
		
	Иначе
		
		Результат = Новый Структура("Состояние, ПричинаОсобенности", Состояние, "");
		ОбработатьУстановкуСостоянияОшибокАПК(МассивСтрок, Результат);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьСостояниеОшибокАПКЗавершение(РезультатДействия, ДополнительныеПараметры) Экспорт
	
	Если НЕ ЗначениеЗаполнено(РезультатДействия) Тогда
		Возврат;
	КонецЕсли;
	
	ОбработатьУстановкуСостоянияОшибокАПК(ДополнительныеПараметры.МассивСтрок, РезультатДействия);
		
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьУстановкуСостоянияОшибокАПК(МассивСтрок, Результат)
	
	Если НЕ ЗаписатьОшибкиАПК(МассивСтрок, Результат) Тогда
		Возврат;
	КонецЕсли;
	
	Для Каждого ИндексСтроки Из МассивСтрок Цикл
		ЗаполнитьЗначенияСвойств(ТаблицаОшибок.НайтиПоИдентификатору(ИндексСтроки), Результат);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьПользователяОшибокАПК(МассивСтрок)
	
	ДанныеОшибки   = Новый Структура(
		"ТекущаяОшибка, ТекущийОтветственный, КоличествоОшибок",
		ТекущаяОшибка, ТекущийОтветственный, МассивСтрок.Количество());
	
	ПараметрыФормы = Новый Структура("ДанныеОшибки", ДанныеОшибки);
	
	Структура = Новый Структура("МассивСтрок", МассивСтрок);
	ОписаниеОповещения = Новый ОписаниеОповещения("УстановитьПользователяОшибокАПКЗавершение", ЭтотОбъект, Структура);
	
	ОткрытьФорму("Обработка.ИнтеграцияСАПК.Форма.ПеренаправлениеОшибок",
					ПараметрыФормы,
					ЭтаФорма,
					,
					,
					,
					ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьПользователяОшибокАПКЗавершение(РезультатДействия, ДополнительныеПараметры) Экспорт
	
	Если НЕ ЗначениеЗаполнено(РезультатДействия) Тогда
		Возврат;
	КонецЕсли;
	
	ОбработатьУстановкуПользователяОшибокАПК(ДополнительныеПараметры.МассивСтрок, РезультатДействия);
		
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьУстановкуПользователяОшибокАПК(МассивСтрок, Результат)
	
	Если НЕ РазделитьТекущуюОшибку(МассивСтрок, Результат) Тогда
		Возврат;
	КонецЕсли;
	
	Для Каждого ИндексСтроки Из МассивСтрок Цикл
		ТаблицаОшибок.Удалить(ТаблицаОшибок.НайтиПоИдентификатору(ИндексСтроки));
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьТаблицуОшибокСервер()
	
	ПрочитатьСписокОшибокАПК();
	
	ЭтаФорма.Заголовок =
		ЗаголовокФормы(ТаблицаОшибок.Количество(), ?(ТаблицаОшибок.Количество() > 0,  ТаблицаОшибок[0].Название, ""));
	
КонецПроцедуры

&НаСервере
// Переносит часть ошибок АПК в новую ошибку СППР.
//
// Параметры:
//	Ошибки - Произвольный - массив строк или текущая строка таблицы ошибок
//	ИзмененныеРеквизиты - Структура - измененные реквизиты и их новые значения
//
Функция РазделитьТекущуюОшибку(Ошибки, ИзмененныеРеквизиты)
	
	БылиОшибки = Ложь;
	
	НачатьТранзакцию();
	
	Данные = Новый Структура(
		"Основание, КомуНаправлена, Комментарий",
		ТекущаяОшибка, ИзмененныеРеквизиты.Ответственный, ИзмененныеРеквизиты.Комментарий);
	НоваяОшибка = ИнтеграцияСАПК.ЗарегистрироватьОшибку(Данные);
	
	ИзмененныеРеквизиты.Вставить("ВнешнийИдентификаторОшибки", ИнтеграцияСАПК.ИдентификаторПоСсылке(НоваяОшибка));
	
	Если НЕ ЗаписатьОшибкиАПК(Ошибки, ИзмененныеРеквизиты) Тогда
		ОтменитьТранзакцию();
	Иначе
		ЗафиксироватьТранзакцию();
	КонецЕсли;
	
	Возврат НЕ БылиОшибки;
	
КонецФункции
	
#КонецОбласти

#Область ВзаимодействиеСАПК

// Получает таблицу ошибку из базы АПК.
//
&НаСервере
Процедура ПрочитатьСписокОшибокАПК()
	
	ТаблицаОшибок.Очистить();
	
	Прокси = ИнтеграцияСАПКПовтИсп.ПолучитьПрокси();
	
	// Получение списка возможных причин отнесения ошибки к особенностям
	Ответ = Прокси.GetFeatureReasons();
	ИнтеграцияСАПК.ПроверитьРезультатОперацииВебСервиса(Ответ, НСтр("ru='Метод GetFeatureReasons'"));
	
	ВозможныеПричиныОсобенности = Новый ФиксированноеСоответствие(Ответ.Получить());
	
	// Получение списка ошибок
	Ответ = Прокси.GetErrors(ИдентификаторОшибки);
	ИнтеграцияСАПК.ПроверитьРезультатОперацииВебСервиса(Ответ, НСтр("ru='Метод GetErrors'"));
	
	Для Каждого ТекСтр Из Ответ.Получить() Цикл
		
		НовСтр = ТаблицаОшибок.Добавить();
		ЗаполнитьЗначенияСвойств(НовСтр, ТекСтр,, "Требования");
		
		НовСтр.Требования = Новый ФиксированноеСоответствие(ТекСтр.Требования);
		
		Если ЗначениеЗаполнено(ТекСтр.СостояниеНаименование) Тогда
			НовСтр.Состояние = Перечисления.СостояниеОшибкиАПК[ТекСтр.СостояниеНаименование];
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

// Изменяет ошибки в базе АПК.
//
// Параметры:
//	Ошибки - Произвольный - массив строк или текущая строка таблицы ошибок
//	ИзмененныеРеквизиты - Структура - измененные реквизиты и их новые значения
//
&НаСервере
Функция ЗаписатьОшибкиАПК(Ошибки, ИзмененныеРеквизиты)
	
	Прокси = ИнтеграцияСАПКПовтИсп.ПолучитьПрокси();
	
	СоответствиеСостояний = ИнтеграцияСАПК.СоответствиеНазванийПеречисления("СостояниеОшибкиАПК");
	
	Если ТипЗнч(Ошибки) = Тип("Массив") Тогда
		МассивСтрок = Ошибки;
	Иначе
		МассивСтрок = Новый Массив;
		МассивСтрок.Добавить(Ошибки);
	КонецЕсли;
	
	Данные = Новый Структура(
		"Ошибки, Реквизиты",
		Новый Массив, Новый Структура("ВнешнийИдентификаторОшибки", ИдентификаторОшибки));
	
	Для Каждого ИндексСтроки Из МассивСтрок Цикл
		
		ДанныеОшибки = Новый Структура("ОбъектУИД, ПравилоУИД, Номер");
		ЗаполнитьЗначенияСвойств(ДанныеОшибки, ТаблицаОшибок.НайтиПоИдентификатору(ИндексСтроки));
		
		Данные.Ошибки.Добавить(ДанныеОшибки);
		
	КонецЦикла;
	
	Для Каждого КлючИЗначение Из ИзмененныеРеквизиты Цикл
		
		Если КлючИЗначение.Ключ = "Комментарий" Тогда
			
			Продолжить;
			
		ИначеЕсли КлючИЗначение.Ключ = "Состояние" Тогда
			
			Данные.Реквизиты.Вставить(
				КлючИЗначение.Ключ,
				СоответствиеСостояний.Получить(КлючИЗначение.Значение));
			
		ИначеЕсли КлючИЗначение.Ключ = "ПричинаОсобенности" Тогда
			
			Данные.Реквизиты.Вставить(
				КлючИЗначение.Ключ,
				ВозможныеПричиныОсобенности.Получить(КлючИЗначение.Значение));
			
		ИначеЕсли КлючИЗначение.Ключ = "Ответственный"
		 И ТипЗнч(КлючИЗначение.Значение) = Тип("СправочникСсылка.Пользователи") Тогда
		 
			Данные.Реквизиты.Вставить(
				КлючИЗначение.Ключ,
				ОбщегоНазначения.ЗначениеРеквизитаОбъекта(КлючИЗначение.Значение, "Наименование"));
			
		Иначе
			
			Данные.Реквизиты.Вставить(КлючИЗначение.Ключ, КлючИЗначение.Значение);
			
		КонецЕсли;
		
	КонецЦикла;
	
	Ответ = Прокси.WriteErrors(ИнтеграцияСАПК.ВернутьХранилищеЗначения(Данные));
	ИнтеграцияСАПК.ПроверитьРезультатОперацииВебСервиса(Ответ, НСтр("ru='Метод WriteErrors'"));
	
	Возврат Истина;
	
КонецФункции

#КонецОбласти

#Область Прочие

&НаСервере
Процедура ЗаполнитьРеквизитыФормы()
	
	ТекущаяОшибка 					 = Параметры.Ошибка;
	ИдентификаторОшибки				 = СокрЛП(ТекущаяОшибка.УникальныйИдентификатор());
	ТекущийОтветственный 			 = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ТекущаяОшибка, 	   "КомуНаправлена");
	ТекущийОтветственныйНаименование = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ТекущийОтветственный, "Наименование");
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция ЗаголовокФормы(Количество, НазваниеОшибки = Неопределено)
	
	Если Количество > 0 Тогда
		
		ТекстЗаголовка = НСтр("ru='Ошибки АПК (%Количество): ""%НазваниеОшибки""'");
		ТекстЗаголовка = СтрЗаменить(ТекстЗаголовка, "%Количество", 	Количество);
		ТекстЗаголовка = СтрЗаменить(ТекстЗаголовка, "%НазваниеОшибки", НазваниеОшибки);
		
	Иначе
		
		ТекстЗаголовка = НСтр("ru='Ошибки АПК отсутствуют'");
		
	КонецЕсли;
	
	Возврат ТекстЗаголовка;
	
КонецФункции

&НаКлиенте
Процедура СформироватьПодвалФормы()
	
	ОписаниеОшибки 			= "";
	ТребованиеТекущейОшибки = Неопределено;
	
	ТекущиеДанные = Элементы.ТаблицаОшибок.ТекущиеДанные;
	
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	// Заполним текст сводной информации об ошибке
	ОписаниеОшибки = НСтр("ru='
		|Состояние ошибки:	%Состояние
		|Место обнаружения:	%Место
		|
		|Название ошибки: 	%Название
		|Уточнение ошибки:	%Уточнение'");
	ОписаниеОшибки = СтрЗаменить(
		ОписаниеОшибки,
		"%Состояние",
		СокрЛП(ТекущиеДанные.Состояние) + ?(ПустаяСтрока(ТекущиеДанные.ПричинаОсобенности), "",  " (" + ТекущиеДанные.ПричинаОсобенности + ")"));
	ОписаниеОшибки = СтрЗаменить(
		ОписаниеОшибки,
		"%Место",
		ТекущиеДанные.Объект + ?(ПустаяСтрока(ТекущиеДанные.МестоОбнаружения), "",  " (" + ТекущиеДанные.МестоОбнаружения + ")"));
	ОписаниеОшибки = СтрЗаменить(
		СокрЛП(ОписаниеОшибки),
		"%Название",
		СокрЛП(ТекущиеДанные.Название));
	ОписаниеОшибки = СтрЗаменить(
		СокрЛП(ОписаниеОшибки),
		"%Уточнение",
		?(СтрЧислоСтрок(ТекущиеДанные.Уточнение) < 2, "", Символы.ПС) + СокрЛП(ТекущиеДанные.Уточнение));
	
	// Заполним список нарушенных требований
	МассивСтрок = Новый Массив;
	Количество  = 0;
	
	Для Каждого ТекСтр Из ТекущиеДанные.Требования Цикл
		Количество = Количество + 1;
		Если Количество > 1 Тогда
			МассивСтрок.Добавить(Символы.ПС);
		КонецЕсли;
		Если ПустаяСтрока(ТекСтр.Значение) Тогда
			МассивСтрок.Добавить(ТекСтр.Ключ);
		Иначе
			МассивСтрок.Добавить(Новый ФорматированнаяСтрока(ТекСтр.Ключ,,,, ТекСтр.Значение));
		КонецЕсли;
	КонецЦикла;
	
	ТребованиеТекущейОшибки = Новый ФорматированнаяСтрока(МассивСтрок);
	
	Если Элементы.ТребованиеТекущейОшибки.Высота < Количество Тогда
		Элементы.ТребованиеТекущейОшибки.Высота = Количество;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Функция ПроверитьНаличиеВыделенныхСтрок(МассивСтрок)
	
	МассивСтрок = Элементы.ТаблицаОшибок.ВыделенныеСтроки;
	
	Если МассивСтрок.Количество() = 0 Тогда
		ПоказатьПредупреждение(Неопределено, НСтр("ru='Не указаны ошибки для изменения.'"));
		Возврат Ложь;
	КонецЕсли;
	
	Возврат Истина;
	
КонецФункции

#КонецОбласти

#КонецОбласти
