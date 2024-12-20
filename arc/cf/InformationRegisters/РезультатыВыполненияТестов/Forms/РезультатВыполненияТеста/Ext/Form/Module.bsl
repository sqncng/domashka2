﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ПараметрКоманды = Неопределено;
	Параметры.Свойство("ПараметрКоманды", ПараметрКоманды);
	ТипПараметра = ТипЗнч(ПараметрКоманды);

	ИмяПараметра = "Тест";
	Если ТипПараметра = Тип("СправочникСсылка.СценарииРаботыПользователей") Тогда
		ИмяПараметра = "Сценарий";
	ИначеЕсли ТипПараметра = Тип("СправочникСсылка.НастройкиЗапускаСценариев") Тогда
		ИмяПараметра = "НастройкаЗапускаСценария";
	ИначеЕсли ТипПараметра = Тип("СправочникСсылка.Процессы") Тогда
		ИмяПараметра = "Процесс";
	ИначеЕсли ТипПараметра = Тип("СправочникСсылка.НастройкиЗапускаПроцессов") Тогда
		ИмяПараметра = "НастройкаЗапускаПроцесса";
	ИначеЕсли ТипПараметра = Тип("СправочникСсылка.Ветки") Тогда
		ИмяПараметра = "Ветка";
	КонецЕсли;
	Список.Параметры.УстановитьЗначениеПараметра(ИмяПараметра, ПараметрКоманды);
	
	Если ТипПараметра = Тип("СправочникСсылка.НастройкиЗапускаСценариев") 
		ИЛИ ТипПараметра = Тип("СправочникСсылка.Процессы") 
		ИЛИ ТипПараметра = Тип("СправочникСсылка.НастройкиЗапускаПроцессов") Тогда
		Элементы.Список.ПодчиненныеЭлементы.СписокТест.Видимость = Ложь;
	ИначеЕсли ТипПараметра = Тип("СправочникСсылка.СценарииРаботыПользователей") Тогда
		Элементы.Список.ПодчиненныеЭлементы.СценарийПроцесс.Видимость = Ложь;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийТаблицыСписок

&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	Если ВыбраннаяСтрока = Неопределено Тогда
		Возврат;
	КонецЕсли;	 
	
	СтандартнаяОбработка = Ложь;
	Если Поле.Имя = "СсылкаНаСборку" Тогда
		ПерейтиПоНавигационнойСсылке(АдресСсылки(Элемент.ТекущиеДанные.Проект,
		Элемент.ТекущиеДанные.СсылкаНаСборку));
		Возврат;
	ИначеЕсли Поле.Имя = "СписокВетка" Тогда
		Если ТипЗнч(Элемент.ТекущиеДанные.Ветка) = Тип("СправочникСсылка.Ветки") Тогда
			Структура = Новый Структура;
			Структура.Вставить("Ключ",Элемент.ТекущиеДанные.Ветка);
			ОткрытьФорму("Справочник.Ветки.ФормаОбъекта",Структура);
		КонецЕсли;	 
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервереБезКонтекста
Функция АдресСсылки(Проект,СсылкаНаСборку)
	Возврат Документы.ЗапускТестирования.АдресСсылки(Проект, СсылкаНаСборку);
КонецФункции

#КонецОбласти