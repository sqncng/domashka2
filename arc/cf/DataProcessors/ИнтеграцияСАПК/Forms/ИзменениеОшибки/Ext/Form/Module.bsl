﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Если ТипЗнч(Параметры.ДанныеОшибки) = Тип("Структура") Тогда
		ЗаполнитьЗначенияСвойств(ЭтаФорма, Параметры.ДанныеОшибки);
	КонецЕсли;
	
	Для Каждого ТекСтр Из Параметры.ВозможныеПричиныОсобенности Цикл
		Элементы.ПричинаОсобенности.СписокВыбора.Добавить(ТекСтр.Ключ);
	КонецЦикла;
	
	УправлениеДоступностью(Элементы, Состояние);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СостояниеПриИзменении(Элемент)
	
	ЭтоОсобенность = (Состояние = ПредопределенноеЗначение("Перечисление.СостояниеОшибкиАПК.Особенность"));
	
	Если НЕ ЭтоОсобенность Тогда
		ПричинаОсобенности = "";
	КонецЕсли;
	
	УправлениеДоступностью(Элементы, Состояние);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Изменить(Команда)
	
	Если НЕ ПроверитьЗаполнение() Тогда
		Возврат;
	КонецЕсли;
	
	Результат = Новый Структура("Состояние, ПричинаОсобенности");
	ЗаполнитьЗначенияСвойств(Результат, ЭтаФорма);
	
	Закрыть(Результат);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиентеНаСервереБезКонтекста
Процедура УправлениеДоступностью(Элементы, Состояние)
	
	Элементы.ПричинаОсобенности.ТолькоПросмотр = (Состояние <> ПредопределенноеЗначение("Перечисление.СостояниеОшибкиАПК.Особенность"));
	
КонецПроцедуры

#КонецОбласти
