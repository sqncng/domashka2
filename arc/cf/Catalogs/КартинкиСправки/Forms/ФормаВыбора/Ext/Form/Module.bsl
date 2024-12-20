﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
		
	Если Параметры.Свойство("Проект") И ЗначениеЗаполнено(Параметры.Проект) Тогда
		Проект = Параметры.Проект;
	Иначе
		Проект = ПараметрыСеанса.ТекущийПроект;
	КонецЕсли;
	
	ЗаполнитьСпискиКартинок();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПроектПриИзменении(Элемент)
	
	ЗаполнитьСпискиКартинок(Ложь);
	
КонецПроцедуры

&НаКлиенте
Процедура ГруппаСтраницыПриСменеСтраницы(Элемент, ТекущаяСтраница)
		
	Если ТекущаяСтраница.Имя = "СтраницаНеИспользуемыеКартинки" Тогда
		ТекущаяТаблица = Элементы.НеИспользуемыеКартинки;
	ИначеЕсли ТекущаяСтраница.Имя = "СтраницаОбъектыМетаданных" Тогда
		ТекущаяТаблица = Элементы.ОбъектыМетаданных;
	КонецЕсли;
	
	Если ТекущаяТаблица.ТекущиеДанные <> Неопределено 
		И ТипЗнч(ТекущаяТаблица.ТекущиеДанные.Ссылка) = Тип("СправочникСсылка.КартинкиСправки") Тогда
		АдресКартинки = ПолучитьНавигационнуюСсылку(ТекущаяТаблица.ТекущиеДанные.Ссылка, "ХранилищеКартинки");
	Иначе
		АдресКартинки = "";
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыОбъектыМетаданных

&НаКлиенте
Процедура ОбъектыМетаданныхВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ОбработатьВыборКартинки(СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбъектыМетаданныхПриАктивизацииСтроки(Элемент)
	
	Если Элемент.ТекущиеДанные <> Неопределено 
		И ТипЗнч(Элемент.ТекущиеДанные.Ссылка) = Тип("СправочникСсылка.КартинкиСправки") Тогда
		АдресКартинки = ПолучитьНавигационнуюСсылку(Элемент.ТекущиеДанные.Ссылка, "ХранилищеКартинки");
	Иначе
		АдресКартинки = "";
	КонецЕсли;
		
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыНеИспользуемыеКартинки

&НаКлиенте
Процедура НеИспользуемыеКартинкиВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ОбработатьВыборКартинки(СтандартнаяОбработка);

КонецПроцедуры

&НаКлиенте
Процедура НеИспользуемыеКартинкиПриАктивизацииСтроки(Элемент)
	
	Если Элемент.ТекущиеДанные <> Неопределено 
		И ТипЗнч(Элемент.ТекущиеДанные.Ссылка) = Тип("СправочникСсылка.КартинкиСправки") Тогда
		АдресКартинки = ПолучитьНавигационнуюСсылку(Элемент.ТекущиеДанные.Ссылка, "ХранилищеКартинки");
	Иначе
		АдресКартинки = "";
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Выбрать(Команда)
	
	СтандартнаяОбработка = Ложь;
	ОбработатьВыборКартинки(СтандартнаяОбработка);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ЗаполнитьСпискиКартинок(ЗаполнятьНеИспользуемые = Истина)
	
	Справочники.КартинкиСправки.ЗаполнитьОбъектыМетаданных(ОбъектыМетаданных, Проект);
	
	Если ЗаполнятьНеИспользуемые Тогда
		Справочники.КартинкиСправки.ЗаполнитьНеИспользуемыеКартинки(НеИспользуемыеКартинки);
	КонецЕсли;
	
КонецПроцедуры
	
&НаКлиенте
Процедура ОбработатьВыборКартинки(СтандартнаяОбработка)
		
	ВыбранноеЗначение = ТекущийЭлемент.ТекущиеДанные.Ссылка;		
				
	Если ТипЗнч(ВыбранноеЗначение) <> Тип("СправочникСсылка.КартинкиСправки") Тогда
		Возврат;
	КонецЕсли;
	
	СтандартнаяОбработка = Ложь;

	ОповеститьОВыборе(ВыбранноеЗначение);
	
КонецПроцедуры

#КонецОбласти