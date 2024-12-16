﻿#Область ОбработчикиКомандФормы

// СтандартныеПодсистемы.Свойства

&НаКлиенте
Процедура Подключаемый_СвойстваВыполнитьКоманду(ЭлементИлиКоманда, НавигационнаяСсылка = Неопределено, СтандартнаяОбработка = Неопределено)
	
	УправлениеСвойствамиКлиент.ВыполнитьКоманду(ЭтотОбъект, ЭлементИлиКоманда, СтандартнаяОбработка);
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.Свойства

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаКлиенте
Процедура ВнешнийПриИзменении(Элемент)
	
	Если Объект.Внешний Тогда
		СохранитьОписание();
		Описание = "";
	Иначе
		ЗагрузитьОписание();
	КонецЕсли;
	
	УстановитьДоступностьЭлементов(Элементы, Объект);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	// СтандартныеПодсистемы.Свойства 
	Если УправлениеСвойствамиКлиент.ОбрабатыватьОповещения(ЭтотОбъект, ИмяСобытия, Параметр) Тогда
		ОбновитьЭлементыДополнительныхРеквизитов();
		УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства
	
	Если ИмяСобытия = "ОбновлениеСтандартовПользователей" И ТекущийПользователь = Параметр Тогда
		Состояние = ТекущееСостояние(ТекущийПользователь, Объект.Ссылка);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	СохранитьОписание(ТекущийОбъект);
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПередЗаписьюНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	Ссылка = СтандартыРазработкиВызовСервера.НавигационнаяСсылкаНаСтандарт(Объект.Ссылка);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.Свойства
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ИмяЭлементаДляРазмещения", "ГруппаДополнительныеРеквизиты");
	ДополнительныеПараметры.Вставить("ОтложеннаяИнициализация", Истина);
	УправлениеСвойствами.ПриСозданииНаСервере(ЭтотОбъект, ДополнительныеПараметры);
	// Конец СтандартныеПодсистемы.Свойства
	
	ТекущийПользователь = Пользователи.ТекущийПользователь();
	Элементы.ДополнительныеРеквизиты.Видимость = УправлениеСвойствами.ИспользоватьДопРеквизиты(Объект.Ссылка);
	Ссылка = СтандартыРазработкиВызовСервера.НавигационнаяСсылкаНаСтандарт(Объект.Ссылка);
	Состояние = ТекущееСостояние(ТекущийПользователь, Объект.Ссылка);
	УстановитьДоступностьЭлементов(Элементы, Объект.Ссылка);
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
	ЗагрузитьОписание();
	УстановитьДоступностьЭлементов(Элементы, Объект);
	
КонецПроцедуры

&НаКлиенте
Процедура СтраницыПриСменеСтраницы(Элемент, ТекущаяСтраница)
	
	// СтандартныеПодсистемы.Свойства
	Если ТекущаяСтраница.Имя = "СтраницаДополнительно"
	И Не ЭтотОбъект.ПараметрыСвойств.ВыполненаОтложеннаяИнициализация Тогда
		СвойстваВыполнитьОтложеннуюИнициализацию();
		УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область СтандартныеПодсистемыСвойства

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

&НаСервере
Процедура СвойстваВыполнитьОтложеннуюИнициализацию()
	
	УправлениеСвойствами.ЗаполнитьДополнительныеРеквизитыВФорме(ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

&НаСервере
Процедура ЗагрузитьОписание()
	
	Если Не Объект.Внешний Тогда
		РедактируемыйОбъект = РеквизитФормыВЗначение("Объект");
		ОбщегоНазначенияСППР.УстановитьФорматированноеОписаниеИзХранилища(Описание, РедактируемыйОбъект.ХранилищеОписания);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура СохранитьОписание(ТекущийОбъект = Неопределено)
	
	Если Не Объект.Внешний Тогда
		Если ТекущийОбъект = Неопределено Тогда
			РедактируемыйОбъект = РеквизитФормыВЗначение("Объект");
		Иначе
			РедактируемыйОбъект = ТекущийОбъект;
		КонецЕсли;
		
		ОбщегоНазначенияСППР.ПоместитьФорматированноеОписаниеВХранилище(Описание, РедактируемыйОбъект.ХранилищеОписания);
		ТекущийОбъект.Описание = Описание.ПолучитьТекст();
		
		Если ТекущийОбъект = Неопределено Тогда
			ЗначениеВРеквизитФормы(РедактируемыйОбъект, "Объект");
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьДоступностьЭлементов(Элементы, Объект)
	
	Внешний = Объект.Внешний;
	Элементы.СтраницаОписание.Видимость = Не Внешний;
	Элементы.ФормаКоманднаяПанель.ПодчиненныеЭлементы.ФормаСправочникСтандартыРазработкиОткрыть.Доступность = Внешний;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ТекущееСостояние(Пользователь, Стандарт)
	
	Запрос = СтандартыРазработки.ЗапросПоследнегоСостоянияСтандарта(Пользователь, Стандарт);
	Выборка = Запрос.Выполнить().Выбрать();
	Выборка.Следующий();
	
	Возврат Выборка.Состояние;
	
КонецФункции

#КонецОбласти
