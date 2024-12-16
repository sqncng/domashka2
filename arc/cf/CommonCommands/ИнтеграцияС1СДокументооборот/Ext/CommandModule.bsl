﻿#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	Настройки = ИнтеграцияС1СДокументооборотБазоваяФункциональностьВызовСервера.ИспользоватьИнтеграцию();
	Если Настройки.ИспользоватьИнтеграциюДО2 Тогда
		ИмяФормы = "Обработка.ИнтеграцияС1СДокументооборот.Форма.Документооборот";
	ИначеЕсли Настройки.ИспользоватьИнтеграциюДО3 Тогда
		ИмяФормы = "Обработка.ИнтеграцияС1СДокументооборот3.Форма.Документооборот";
	КонецЕсли;
	
	ПараметрыФормы = Новый Структура("ВнешнийОбъект", ПараметрКоманды);
	ОткрытьФорму(
		ИмяФормы,
		ПараметрыФормы,
		ПараметрыВыполненияКоманды.Источник,
		ПараметрыВыполненияКоманды.Уникальность,
		ПараметрыВыполненияКоманды.Окно);
	
КонецПроцедуры

#КонецОбласти