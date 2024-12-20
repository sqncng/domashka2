﻿

#Область ОбработчикиСобытий

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	НастройкиОсновнойСхемы = КомпоновщикНастроек.ПолучитьНастройки();
	
	ЭлементыОтбора =  НастройкиОсновнойСхемы.ПараметрыДанных.Элементы;
	
	ЭлементОтборПоРесурсу = ЭлементыОтбора.Найти("ОтборПоРесурсу");
	
	Если ЭлементОтборПоРесурсу <> Неопределено Тогда
		
		Если Не ЗначениеЗаполнено(ЭлементОтборПоРесурсу.Значение) Тогда
			
			ТекстСообщения = НСтр("ru = 'Не указан планируемый ресурс, для которого формируется отчет.'");
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,,,, Отказ);
			
		КонецЕсли;
		
		Если Не ЭлементОтборПоРесурсу.Использование Тогда
		
			ТекстСообщения = НСтр("ru = 'Небходимо включить использование отбора по планируемый ресурса, для которого формируется отчет.'");
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,,,, Отказ);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

