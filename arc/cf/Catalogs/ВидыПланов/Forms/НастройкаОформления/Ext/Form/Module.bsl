﻿
#Область ОбработчикиСобытийФормы

 &НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ПустойЦвет = Новый Цвет(0, 0, 0);
	
	ОбработатьПереданныеПараметры();
	УправлениеДоступностью(ЭтотОбъект);
	
КонецПроцедуры


#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОК(Команда)
	
	Отказ = Ложь;
	
	ПроверитьЗаполнениеПередЗакрытием(Отказ);
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
		
	Закрыть(СтруктураВозврата());
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ИспользоватьЦветФонаПриИзменении(Элемент)
	УправлениеДоступностью(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьТекстПриИзменении(Элемент)
	
	Если Не ИспользоватьТекст Тогда
		ИспользоватьЦветТекста = Ложь;
	КонецЕсли;
	
	УправлениеДоступностью(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьЦветТекстаПриИзменении(Элемент)
	УправлениеДоступностью(ЭтотОбъект);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ПроверитьЗаполнениеПередЗакрытием(Отказ)
	
	Если ИспользоватьТекст
		И ПустаяСтрока(Текст) Тогда 
		
		ОбщегоНазначенияКлиент.СообщитьПользователю(НСтр("ru = 'Указано использование текст подсказки, но сам текст не указан'"), , "Текст",, Отказ);
		
	КонецЕсли;
	
КонецПроцедуры

 &НаСервере
Процедура ОбработатьПереданныеПараметры()
	
	Если Не ПустаяСтрока(Параметры.Текст) Тогда
		
		ИспользоватьТекст = Истина;
		Текст             = Параметры.Текст;
		
		Если Параметры.ЦветТекста <> ПустойЦвет Тогда
			ИспользоватьЦветТекста = Истина;
			ЦветТекста             = Параметры.ЦветТекста
		КонецЕсли;
		
	КонецЕсли;
	
	Если Параметры.ЦветФона <> ПустойЦвет Тогда
		ИспользоватьЦветФона = Истина;
		ЦветФона             = Параметры.ЦветФона;
	КонецЕсли;
	
	Если Параметры.АвтоотметкаНезаполненного Тогда
		АвтоотметкаНезаполненного = Истина;
	КонецЕсли;

КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УправлениеДоступностью(Форма)
	
	Элементы = Форма.Элементы;
	
	Элементы.ЦветФона.Доступность               = Форма.ИспользоватьЦветФона;
	Элементы.Текст.Доступность                  = Форма.ИспользоватьТекст;
	Элементы.ИспользоватьЦветТекста.Доступность = Форма.ИспользоватьТекст;
	Элементы.ЦветТекста.Доступность             = Форма.ИспользоватьЦветТекста И Форма.ИспользоватьТекст;
	
КонецПроцедуры

&НаКлиенте
Функция СтруктураВозврата() 
	
	СтруктураВозврата = Новый Структура;
	СтруктураВозврата.Вставить("Текст",                     "");
	СтруктураВозврата.Вставить("ЦветТекста",                ПустойЦвет);
	СтруктураВозврата.Вставить("ЦветФона",                  ПустойЦвет);
	СтруктураВозврата.Вставить("АвтоотметкаНезаполненного", Ложь);
	
	Если ИспользоватьТекст Тогда
		СтруктураВозврата.Текст = Текст;
	КонецЕсли;
	
	Если ИспользоватьТекст 
		И ИспользоватьЦветТекста Тогда
		СтруктураВозврата.ЦветТекста = ЦветТекста;
	КонецЕсли;
	
	Если ИспользоватьЦветФона Тогда
		СтруктураВозврата.ЦветФона = ЦветФона;
	КонецЕсли;
	
	СтруктураВозврата.АвтоотметкаНезаполненного = АвтоотметкаНезаполненного;
	
	Возврат СтруктураВозврата;
	
КонецФункции

#КонецОбласти

