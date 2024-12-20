﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если НЕ ЗначениеЗаполнено(Объект.Ссылка) Тогда
		
		СтатусКонтроля = "Добавлено";
		ПриЧтенииСозданииНаСервере();
		
		Если ЗначениеЗаполнено(Параметры.ЗначениеКопирования) Тогда
			СкопироватьДанныеКопируемогоОбъекта(Параметры.ЗначениеКопирования);
		КонецЕсли;
	
	КонецЕсли;
	
	НастройкиСервер.УстановитьТекущуюСтраницу("Справочник.ВидыДоступа.ФормаЭлемента", Элементы.ГруппаСтраницы, "ТекущаяСтраницаФормыВидаДоступа");
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)

	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	СтатусКонтроля = КонтрольИзменений.СтатусКонтроля(Объект.Ссылка);
	
	ПриЧтенииСозданииНаСервере();
		
	РедактируемыйОбъект = РеквизитФормыВЗначение("Объект");
	ОбщегоНазначенияСППР.УстановитьФорматированноеОписаниеИзХранилища(Описание, РедактируемыйОбъект.ХранилищеОписания);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ИзменениеИнформацииОбИспользованииИсточника" И Параметр= Объект.Ссылка Тогда
		ПриИзмененииДанныхОбИспользованииИсточникаНаСервере();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	ОбщегоНазначенияСППР.ПоместитьФорматированноеОписаниеВХранилище(Описание, ТекущийОбъект.ХранилищеОписания);
	ТекущийОбъект.Описание = Описание.ПолучитьТекст();
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	СтатусКонтроля = КонтрольИзменений.СтатусКонтроля(Объект.Ссылка);
	ОбщегоНазначенияСППРКлиентСервер.УстановитьОтображениеСостоянияКонтроля(ЭтаФорма);
	
	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	
	Если ЗавершениеРаботы Тогда
		Возврат;
	КонецЕсли;
	
	СохранитьЗначения();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ВладелецПриИзменении(Элемент)
	
	Объект.РазделыПроекта.Очистить();
	
	ОбщегоНазначенияСППРКлиентСервер.СформироватьТекстГиперссылкиДополнительныеРазделы(Элементы.ДополнительныеРазделы, 
		Объект.РазделыПроекта.Количество());
		
	ПриИзмененииВладельцаНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ПредставлениеИсточникаНажатие(Элемент)
	
	Если ЗначениеЗаполнено(ОбъектИсточник) Тогда
		ПоказатьЗначение(,ОбъектИсточник);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПравилоИспользованияНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ПараметрыОткрытия = Новый Структура;
	ПараметрыОткрытия.Вставить("Приемник", Объект.Ссылка);
	ПараметрыОткрытия.Вставить("Источник", ОбъектИсточник);
	ПараметрыОткрытия.Вставить("ПравилоИспользования", ПравилоИспользования);
	
	ОткрытьФорму("ОбщаяФорма.ИнформацияОбИспользованииОбъектаИсточника", ПараметрыОткрытия);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ДополнительныеРазделы(Команда)
	
	ПараметрыФормы = Новый Структура;
	МассивРазделов = Новый Массив;
	
	Для Каждого СтрокаТЧ из Объект.РазделыПроекта Цикл
		МассивРазделов.Добавить(СтрокаТЧ.Раздел);
	КонецЦикла;
	
	ПараметрыФормы.Вставить("Проект", Объект.Владелец);
	ПараметрыФормы.Вставить("МассивРазделов", МассивРазделов);
	ПараметрыФормы.Вставить("ИзмененияДоступны", ДоступноИзменениеВидаДоступа);
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ДополнительныеРазделыЗавершение", ЭтотОбъект);
	ОткрытьФорму("ОбщаяФорма.РазделыПроекта", ПараметрыФормы, ЭтаФорма,,,, ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура ДополнительныеРазделыЗавершение(РезультатДействия, ДополнительныеПараметры) Экспорт
    
    Результат = РезультатДействия;
    
    Если ТипЗнч(Результат) = Тип("Массив") Тогда
        
        Объект.РазделыПроекта.Очистить();
        
        КоличествоРазделов = 0;
        Для Каждого Раздел из Результат Цикл
            НоваяСтрока = Объект.РазделыПроекта.Добавить();
            НоваяСтрока.Раздел = Раздел;
            
            КоличествоРазделов = КоличествоРазделов + 1;
        КонецЦикла;
        
        ОбщегоНазначенияСППРКлиентСервер.СформироватьТекстГиперссылкиДополнительныеРазделы(Элементы.ДополнительныеРазделы, КоличествоРазделов);
		
		Модифицированность = Истина;
        
    КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ПриЧтенииСозданииНаСервере()
	
	ДоступноИзменениеВидаДоступа = 
		УправлениеДоступомСППР.РольДоступнаПоПроекту("ДобавлениеИзменениеВидовДоступа", Объект.Владелец);
		
	ДоступноИзменениеИнформацииПоИспользованиюОбъектов =
		УправлениеДоступомСППР.РольДоступнаПоПроекту("ДобавлениеИзменениеИнформацииОбИспользованииОбъектов", Объект.Владелец);
		
	Если ЗначениеЗаполнено(Объект.Ссылка) Тогда
		ЗаполнитьДанныеОбИспользованииОбъектаИсточника();
	КонецЕсли;
		
	Если ЗначениеЗаполнено(ОбъектИсточник)
		И ПравилоИспользования = Перечисления.ПравилаИспользованияОбъектов.БезИзменений Тогда
		ТребуетсяБлокировкаПоИспользованиюИсточника = Истина;
	Иначе
		ТребуетсяБлокировкаПоИспользованиюИсточника = Ложь;
	КонецЕсли;
	
	ОбщегоНазначенияСППРКлиентСервер.УстановитьОтображениеСостоянияКонтроля(ЭтаФорма);
	ОбщегоНазначенияСППРКлиентСервер.СформироватьТекстГиперссылкиДополнительныеРазделы(Элементы.ДополнительныеРазделы,
		Объект.РазделыПроекта.Количество());
	
	УстановитьВидимостьДанныхОбИспользованииИсточника();
	УстановитьДоступностьИзмененияПравилаИспользования();
	УстановитьДоступностьЭлементов();
	
КонецПроцедуры

&НаСервере
Процедура СохранитьЗначения()
	
	НастройкиСервер.СохранитьТекущуюСтраницу("Справочник.ВидыДоступа.ФормаЭлемента", Элементы.ГруппаСтраницы, "ТекущаяСтраницаФормыВидаДоступа");
	
КонецПроцедуры

&НаСервере
Процедура УстановитьДоступностьЭлементов()
	
	ТолькоПросмотрПоИмени = 
		(Объект.Имя = "Пользователи" 
		ИЛИ Объект.Имя = "ВнешниеПользователи"
		ИЛИ Объект.Имя = "ПоОбъектуДоступа"
		ИЛИ Объект.Имя = "ПоУсловию");
		
	ТолькоПросмотрТипов = (Объект.Имя = "ПоОбъектуДоступа" ИЛИ Объект.Имя = "ПоУсловию");
	
	ИспользуемыеЭлементы = ИспользуемыеПоляОбъектаИсточника();
	
	Для Каждого ИспользуемыйЭлемент из ИспользуемыеЭлементы Цикл
		
		Если НЕ Доступность ИЛИ ТолькоПросмотр ИЛИ НЕ ДоступноИзменениеВидаДоступа Тогда
			ИспользуемыйЭлемент.ТолькоПросмотр = Истина;
			Продолжить;
		КонецЕсли;
		
		Если ИспользуемыйЭлемент.Имя = "Имя" ИЛИ ИспользуемыйЭлемент.Имя = "Наименование" Тогда
			
			Если ТолькоПросмотрПоИмени ИЛИ ТребуетсяБлокировкаПоИспользованиюИсточника Тогда
				ИспользуемыйЭлемент.ТолькоПросмотр = Истина;
			Иначе
				ИспользуемыйЭлемент.ТолькоПросмотр = Ложь;
			КонецЕсли;
			
		ИначеЕсли ИспользуемыйЭлемент.Имя = "ТипыЗначенийРеквизитов" Тогда
			
			Если ТолькоПросмотрТипов ИЛИ ТребуетсяБлокировкаПоИспользованиюИсточника Тогда
				ИспользуемыйЭлемент.ТолькоПросмотр = Истина;
			Иначе
				ИспользуемыйЭлемент.ТолькоПросмотр = Ложь;
			КонецЕсли;
		
		Иначе
			ИспользуемыйЭлемент.ТолькоПросмотр = ТребуетсяБлокировкаПоИспользованиюИсточника;
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Функция ИспользуемыеПоляОбъектаИсточника()
	
	Поля = Новый Массив;
	
	Поля.Добавить(Элементы.Наименование);
	Поля.Добавить(Элементы.Имя);
	Поля.Добавить(Элементы.Описание);
	Поля.Добавить(Элементы.ТипыЗначенийРеквизитов);
	
	Возврат Поля;
	
КонецФункции

&НаСервере
Процедура ПриИзмененииВладельцаНаСервере()
	
	ДоступноИзменениеВидаДоступа = 
		УправлениеДоступомСППР.РольДоступнаПоПроекту("ДобавлениеИзменениеВидовДоступа", Объект.Владелец);
		
	ДоступноИзменениеИнформацииПоИспользованиюОбъектов =
		УправлениеДоступомСППР.РольДоступнаПоПроекту("ДобавлениеИзменениеИнформацииОбИспользованииОбъектов", Объект.Владелец);
	
	УстановитьДоступностьИзмененияПравилаИспользования();
	УстановитьДоступностьЭлементов();
	
КонецПроцедуры

&НаСервере
Процедура СкопироватьДанныеКопируемогоОбъекта(КопируемыйОбъект)
	
	УстановитьПривилегированныйРежим(Истина);
	
	ТекстЗапроса = 
	"ВЫБРАТЬ
	|	ВидыДоступа.ХранилищеОписания КАК ХранилищеОписания
	|ИЗ
	|	Справочник.ВидыДоступа КАК ВидыДоступа
	|ГДЕ
	|	ВидыДоступа.Ссылка = &Ссылка"
	;
	
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.УстановитьПараметр("Ссылка", КопируемыйОбъект);
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Выборка.Следующий() Тогда
		
		ОписаниеИзХранилища = Выборка.ХранилищеОписания.Получить();
		Если ТипЗнч(ОписаниеИзХранилища) = Тип("ФорматированныйДокумент") Тогда
			Описание = ОписаниеИзХранилища;
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьДанныеОбИспользованииОбъектаИсточника()
	
	ДанныеОбИспользовании = РегистрыСведений.ИспользованиеОбъектов.ДанныеОбИспользованииОбъектаИсточника(Объект.Ссылка);
	
	ОбъектИсточник = ДанныеОбИспользовании.Источник;
	ПравилоИспользования = ДанныеОбИспользовании.ПравилоИспользования;
	
	Элементы.ПредставлениеИсточника.Заголовок = ДанныеОбИспользовании.НаименованиеИсточника;
	УстановитьКартинкуИспользованияИсточника();
	
КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьДанныхОбИспользованииИсточника()

	Элементы.ГруппаПравилоИспользования.Видимость = ЗначениеЗаполнено(ПравилоИспользования);
	
КонецПроцедуры

&НаСервере
Процедура ПриИзмененииДанныхОбИспользованииИсточникаНаСервере()
	
	ЗаполнитьДанныеОбИспользованииОбъектаИсточника();
	УстановитьВидимостьДанныхОбИспользованииИсточника();
	
	Если ЗначениеЗаполнено(ОбъектИсточник)
		И ПравилоИспользования = Перечисления.ПравилаИспользованияОбъектов.БезИзменений Тогда
		ТребуетсяБлокировкаПоИспользованиюИсточника = Истина;
	Иначе
		ТребуетсяБлокировкаПоИспользованиюИсточника = Ложь;
	КонецЕсли;
	
	УстановитьДоступностьЭлементов();
	
КонецПроцедуры

&НаСервере
Процедура УстановитьКартинкуИспользованияИсточника()
	
	Если ПравилоИспользования = Перечисления.ПравилаИспользованияОбъектов.СИзменениями Тогда
		Элементы.КартинкаПравилоИспользованияИсточника.Картинка = БиблиотекаКартинок.ОбъектИспользуетсяСИзменениями;
	Иначе
		Элементы.КартинкаПравилоИспользованияИсточника.Картинка = БиблиотекаКартинок.ОбъектИспользуетсяБезИзменений;
	КонецЕсли;
	
КОнецПроцедуры

&НаСервере
Процедура УстановитьДоступностьИзмененияПравилаИспользования()
	
	Элементы.ПравилоИспользования.Гиперссылка = ДоступноИзменениеИнформацииПоИспользованиюОбъектов;
	
КонецПроцедуры

#КонецОбласти