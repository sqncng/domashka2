﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Проект = Параметры.Проект;
	
	Если Не ЗначениеЗаполнено(Проект) Тогда
		Проект = ПараметрыСеанса.ТекущийПроект;
	КонецЕсли;
	
	Если Параметры.Свойство("КомуНаправить") Тогда
		КомуНаправить = Параметры.КомуНаправить;
	КонецЕсли;
	
	Если Параметры.Свойство("Заголовок") И ЗначениеЗаполнено(Параметры.Заголовок) Тогда
		Заголовок = Параметры.Заголовок;
	КонецЕсли;
	
	Если Параметры.ЗамещатьПользователя Тогда
		Справочники.Ошибки.ЗаместитьПользователяПриРаботеСОшибкой(КомуНаправить, Проект, Комментарий, Истина);
	КОнецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОК(Команда)
	
	ОчиститьСообщения();
	
	Если НЕ ЗначениеЗаполнено(КомуНаправить) Тогда
		ТекстСообщения = НСтр("ru='Не указано, кому направляется ошибка'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,,"КомуНаправить");
		Возврат;
	КонецЕсли;
	
	Структура = Новый Структура;
	Структура.Вставить("КомуНаправлена", КомуНаправить);
	Структура.Вставить("Комментарий", Комментарий);
	
	Если Открыта() Тогда
		Закрыть(Структура);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
