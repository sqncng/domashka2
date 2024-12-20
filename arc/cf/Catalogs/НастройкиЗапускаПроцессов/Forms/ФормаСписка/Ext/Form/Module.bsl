﻿#Область ОбработчикиСобытий

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("ОтборЭталоннаяБаза") Тогда
		ОтборПоГруппе = Список.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		ОтборПоГруппе.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ЭталоннаяБаза");
		ОтборПоГруппе.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
		ОтборПоГруппе.ПравоеЗначение = Параметры.ОтборЭталоннаяБаза;
	Иначе
		УстановитьОтборПоПроекту();
	КонецЕсли;	 
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ВыгрузитьСценарии(Команда)
	Строки = Элементы.Список.ВыделенныеСтроки;
	
	Если Строки = Неопределено Тогда
		Возврат;
	КонецЕсли;	
	
	Если Строки.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;	
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("СписокТестов",НастройкиЗапускаИзВыделенныхСтрок(Строки));
	ПараметрыФормы.Вставить("ТипВыгрузки","Процессы");
	ОткрытьФорму("Обработка.ВыгрузкаНастроекЗапускаСценариевТестированияИПроцессов.Форма.Форма",ПараметрыФормы,,"КлючУникальностиВыгрузкаТестов");
	Оповестить("ВыгрузкаНастроекПроцессов",ПараметрыФормы);
КонецПроцедуры

#КонецОбласти


#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьОтборПоПроекту()
	Проект = ПараметрыСеанса.ТекущийПроект;
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список, "Владелец.Владелец",
		Проект, ВидСравненияКомпоновкиДанных.Равно,,ЗначениеЗаполнено(Проект));
КонецПроцедуры

&НаКлиенте
Функция НастройкиЗапускаИзВыделенныхСтрок(Массив)
	Результат = Новый Массив;
	Для Каждого Элем Из Массив Цикл
		Если ТипЗнч(Элем) = Тип("СправочникСсылка.НастройкиЗапускаПроцессов") Тогда
			Результат.Добавить(Элем);
		КонецЕсли;	
	КонецЦикла;	
	Возврат Результат;
КонецФункции

#КонецОбласти