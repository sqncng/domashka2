﻿#Область ОбработчикиСобытий

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("ОтборВетка") Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
			Список, "Ветка", Параметры.ОтборВетка, ВидСравненияКомпоновкиДанных.Равно,,Истина);
	КонецЕсли;	 
		
КонецПроцедуры

#КонецОбласти