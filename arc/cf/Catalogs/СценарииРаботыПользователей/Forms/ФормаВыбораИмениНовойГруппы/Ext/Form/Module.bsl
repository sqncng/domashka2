﻿#Область ОбработчикиСобытий

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Наименование = НСтр("ru='Новая группа'");
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗакрытьФорму(Команда)
	Закрыть();
КонецПроцедуры

&НаКлиенте
Процедура СоздатьГруппу(Команда)
	Если ПустаяСтрока(Наименование) Тогда
		ВызватьИсключение НСтр("ru = 'Не указано имя новой группы.'");
	КонецЕсли;	 
	
	Данные = Новый Структура;
	Данные.Вставить("СозданиеГруппы", Истина);
	Данные.Вставить("Наименование", Наименование);
	Данные.Вставить("ГруппаВерхнегоУровня", ГруппаВерхнегоУровня);
	ОповеститьОВыборе(Данные);
КонецПроцедуры

#КонецОбласти