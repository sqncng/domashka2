﻿#Область ОписаниеПеременных

&НаКлиенте
Перем ОбновленныеСтраницы;

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ИсторияИзучения(Команда)
	
	ТекущиеДанные = Элементы.СписокСтандартов.ТекущиеДанные;
	
	Если ТекущиеДанные <> Неопределено Тогда
		ПараметрыФормы = Новый Структура;
		ПараметрыФормы.Вставить("Пользователь", Пользователь);
		ПараметрыФормы.Вставить("Стандарт", ТекущиеДанные.Стандарт);
		ОткрытьФорму("РегистрСведений.ИзучаемыеСтандарты.ФормаСписка", ПараметрыФормы);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьСтатистику(Команда = Неопределено)
	
	Статистика = СтруктураСтатистики(Пользователь);
	Изучено = Статистика.Изучено;
	Нарушено = Статистика.Нарушено;
	НеСоблюдено = Статистика.НеСоблюдено;
	Новых = Статистика.Новых;
	ТребуетИзучения = Статистика.ТребуетИзучения;
	Элементы.ИзученоИндикатор.МаксимальноеЗначение = Статистика.Всего;
	ИдикаторТекст = СтрШаблон(НСтр("ru = '(%1 из %2)'"), Изучено, Статистика.Всего);
	Элементы.ИзученоТекст.Заголовок = ИдикаторТекст;
	
КонецПроцедуры

&НаКлиенте
Процедура ПользовательПриИзменении(Элемент)
	
	СписокСтандартов.КомпоновщикНастроек.Настройки.ПараметрыДанных.УстановитьЗначениеПараметра("Пользователь",
		Пользователь);
	УстановитьДоступностьЭлементовПоПользователю(Элементы, Пользователь, ТекущийПользователь);
	ОбновленныеСтраницы["СтраницаСтатистика"] = Ложь;
	ОбновитьСтраницы();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ОбновлениеСтандартовПользователей" И ТекущийПользователь = Параметр Тогда
		ОбновленныеСтраницы.Очистить();
		ОбновитьСтраницы();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПользовательОчистка(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ОбновленныеСтраницы = СоответствиеОбновленныхСтраниц();
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ТекущийПользователь = Пользователи.ТекущийПользователь();
	Пользователь = ТекущийПользователь;
	СписокСтандартов.КомпоновщикНастроек.Настройки.ПараметрыДанных.УстановитьЗначениеПараметра("Пользователь",
		Пользователь);
	
	УстановитьИдентификаторыЭлементовОтбораСписка();
	
КонецПроцедуры

&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартыРазработкиКлиент.ПриВыбореСтандартаВСписке(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура СписокСтандартовПриАктивизацииСтроки(Элемент)
	
	УстановитьДоступностьЭлементов();
	
КонецПроцедуры

&НаСервере
Процедура СписокСтандартовПриОбновленииСоставаПользовательскихНастроекНаСервере(СтандартнаяОбработка)
	
	ПрименитьБыстрыйОтбор();
	
КонецПроцедуры

&НаКлиенте
Процедура СтраницыПриСменеСтраницы(Элемент, ТекущаяСтраница)
	
	ОбновитьСтраницы();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ОбновитьСтраницаСписокСтандартов()
	
	Элементы.СписокСтандартов.Обновить();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьСтраницаСтатистика()
	
	ОбновитьСтатистику();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьСтраницы()
	
	ИмяСтраницы = Элементы.Страницы.ТекущаяСтраница.Имя;
	
	Если ОбновленныеСтраницы[ИмяСтраницы] <> Истина Тогда
		Если ИмяСтраницы = "СтраницаСписокСтандартов" Тогда
			ОбновитьСтраницаСписокСтандартов();
		ИначеЕсли ИмяСтраницы = "СтраницаСтатистика" Тогда
			ОбновитьСтраницаСтатистика();
		КонецЕсли;
		
		ОбновленныеСтраницы[ИмяСтраницы] = Истина;
	КонецЕсли;
	
	УстановитьДоступностьЭлементов();
	
КонецПроцедуры

&НаСервере
Процедура ПрименитьБыстрыйОтбор()
	
	Настройки = СписокСтандартов.КомпоновщикНастроек.ПользовательскиеНастройки.Элементы;
	НастройкаПользователя = Настройки.Найти("Пользователь");
	
	Если Параметры.Свойство("СтруктураБыстрогоОтбора") И Параметры.СтруктураБыстрогоОтбора <> Неопределено Тогда
		НастройкаСтандартИзучен = Настройки.Найти("СтандартИзучен");
		НастройкаСтандартНовый = Настройки.Найти("СтандартНовый");
		НастройкаСтандартТребуетИзучения = Настройки.Найти("СтандартТребуетИзучения");
		
		Отбор = Параметры.СтруктураБыстрогоОтбора;
		НастройкаСтандартИзучен.Использование = Отбор.ПоказыватьИзученные;
		НастройкаСтандартНовый.Использование = Отбор.ПоказыватьНовые;
		НастройкаСтандартТребуетИзучения.Использование = Отбор.ПоказыватьТребующиеИзучения;
		Пользователь = Отбор.Пользователь;
		СписокСтандартов.КомпоновщикНастроек.Настройки.ПараметрыДанных.УстановитьЗначениеПараметра("Пользователь",
			Пользователь);
		
		Если Отбор.ПоказыватьТребующиеИзучения Или Отбор.ПоказыватьНовые Тогда
			Элементы.СписокСтандартов.Отображение = ОтображениеТаблицы.Список;
		КонецЕсли;
	КонецЕсли;
	
	УстановитьДоступностьЭлементовПоПользователю(Элементы, Пользователь, ТекущийПользователь);
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьДоступностьЭлементов()
	
	ТекущиеДанные = Элементы.СписокСтандартов.ТекущиеДанные;
	
	Если ТекущиеДанные <> Неопределено Тогда
		НеГруппа = СтандартныеПодсистемыКлиент.ЭтоЭлементДинамическогоСписка(ТекущиеДанные) И Не ТекущиеДанные.ЭтоГруппа;
		Состояние = ?(НеГруппа, ТекущиеДанные.Состояние, Неопределено);
		НеНовый = Состояние <> ПредопределенноеЗначение("Перечисление.СостоянияСтандартов.Новый");
		НеТребуетИзучения = Состояние <> ПредопределенноеЗначение("Перечисление.СостоянияСтандартов.ТребуетИзучения");
		ВыбранОдин = Элементы.СписокСтандартов.ВыделенныеСтроки.Количество() = 1;
		Элементы.СписокСтандартовИсторияИзучения.Доступность = НеГруппа И ВыбранОдин И НеНовый;
		ЭтотПользователь = (Пользователь = ТекущийПользователь);
		МожноИзучить = ЭтотПользователь И (НеТребуетИзучения Или Не ВыбранОдин);
		Элементы.СписокСтандартовСправочникСтандартыРазработкиИзучить.Доступность = МожноИзучить;
		Элементы.СписокСтандартовСправочникСтандартыРазработкиПодтвердитьИзучение.Доступность = ЭтотПользователь;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьДоступностьЭлементовПоПользователю(Элементы, Пользователь, ТекущийПользователь)
	
	ЭтотПользователь = (Пользователь = ТекущийПользователь);
	Элементы.СписокСтандартовСправочникСтандартыРазработкиИзучить.Доступность = ЭтотПользователь;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьИдентификаторыЭлементовОтбораСписка()
	
	ПолеСостояние = Новый ПолеКомпоновкиДанных("Состояние");
	
	Для каждого Элемент Из СписокСтандартов.КомпоновщикНастроек.Настройки.Отбор.Элементы Цикл
		Если ТипЗнч(Элемент) = Тип("ГруппаЭлементовОтбораКомпоновкиДанных") Тогда
			Для каждого ЭлементСостояния Из Элемент.Элементы Цикл
				Если ЭлементСостояния.ЛевоеЗначение = ПолеСостояние Тогда
					Если ЭлементСостояния.ПравоеЗначение = Перечисления.СостоянияСтандартов.Изучен Тогда
						ЭлементСостояния.ИдентификаторПользовательскойНастройки = "СтандартИзучен";
					ИначеЕсли ЭлементСостояния.ПравоеЗначение = Перечисления.СостоянияСтандартов.Новый Тогда
						ЭлементСостояния.ИдентификаторПользовательскойНастройки = "СтандартНовый";
					ИначеЕсли ЭлементСостояния.ПравоеЗначение = Перечисления.СостоянияСтандартов.ТребуетИзучения Тогда
						ЭлементСостояния.ИдентификаторПользовательскойНастройки = "СтандартТребуетИзучения";
					КонецЕсли;
				КонецЕсли;
			КонецЦикла;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Функция СоответствиеОбновленныхСтраниц()
	
	Соответствие = Новый Соответствие;
	Соответствие["СтраницаСписокСтандартов"] = Истина;
	Соответствие["СтраницаСтатистика"] = Ложь;
	
	Возврат Соответствие;
	
КонецФункции

&НаСервереБезКонтекста
Функция СтруктураСтатистики(Пользователь)
	
	Разделитель =
		"
		|;
		|////////////////////////////////////////////////////////////////////////////////
		|
		|";
	
	Запросы = Новый Массив;
	Запросы.Добавить(СтандартыРазработки.ТекстЗапросаСтатистикиВсего());
	Запросы.Добавить(СтандартыРазработки.ТекстЗапросаСтатистикиСостояния("СостояниеИзучен"));
	Запросы.Добавить(СтандартыРазработки.ТекстЗапросаСтатистикиНарушений());
	Запросы.Добавить(СтандартыРазработки.ТекстЗапросаСтатистикиНесоблюдений());
	Запросы.Добавить(СтандартыРазработки.ТекстЗапросаСтатистикиНовых());
	Запросы.Добавить(СтандартыРазработки.ТекстЗапросаСтатистикиСостояния("СостояниеТребуетИзучения"));
	
	Запрос = Новый Запрос(СтрСоединить(Запросы, Разделитель));
	Запрос.УстановитьПараметр("Пользователь", Пользователь);
	Запрос.УстановитьПараметр("СостояниеИзучен", Перечисления.СостоянияСтандартов.Изучен);
	Запрос.УстановитьПараметр("СостояниеТребуетИзучения", Перечисления.СостоянияСтандартов.ТребуетИзучения);
	РезультатЗапроса = Запрос.ВыполнитьПакет();
	
	Структура = Новый Структура;
	Структура.Вставить("Всего", СтандартыРазработки.КоличествоИзРезультатаЗапроса(РезультатЗапроса[0]));
	Структура.Вставить("Изучено", СтандартыРазработки.КоличествоИзРезультатаЗапроса(РезультатЗапроса[1]));
	Структура.Вставить("Нарушено", СтандартыРазработки.КоличествоИзРезультатаЗапроса(РезультатЗапроса[2]));
	Структура.Вставить("НеСоблюдено", СтандартыРазработки.КоличествоИзРезультатаЗапроса(РезультатЗапроса[3]));
	Структура.Вставить("Новых", СтандартыРазработки.КоличествоИзРезультатаЗапроса(РезультатЗапроса[4]));
	Структура.Вставить("ТребуетИзучения", СтандартыРазработки.КоличествоИзРезультатаЗапроса(РезультатЗапроса[5]));
	
	Возврат Структура;
	
КонецФункции

#КонецОбласти
