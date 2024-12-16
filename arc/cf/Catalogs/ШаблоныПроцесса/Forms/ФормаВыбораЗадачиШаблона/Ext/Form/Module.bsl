﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ДеревоЗадачШаблона = ПолучитьИзВременногоХранилища(Параметры.АдресДереваЗадач);
	
	ЗначениеВРеквизитФормы(ДеревоЗадачШаблона, "ДеревоЗадач");
	
	УстановитьУсловноеОформление();
	
	ЗадачаШаблона = Параметры.ЗадачаШаблона;
	
	Если Параметры.Свойство("ВыбраннаяЗадача") И ЗначениеЗаполнено(Параметры.ВыбраннаяЗадача) Тогда
		ВыбраннаяЗадача = Параметры.ВыбраннаяЗадача;
		ИдентификаторВыбраннойЗадачи = ЗадачиПроцессовКлиентСервер.НайтиСтрокуВДанныхФормыДерево(ДеревоЗадач, ВыбраннаяЗадача, "ЗадачаШаблона", Истина);
	Иначе
		ИдентификаторВыбраннойЗадачи = -1;
	КонецЕсли;
	
	ИдентификаторНайденнойСтроки = ЗадачиПроцессовКлиентСервер.НайтиСтрокуВДанныхФормыДерево(ДеревоЗадач, ЗадачаШаблона, "ЗадачаШаблона", Истина);
	Если ИдентификаторНайденнойСтроки <> - 1 Тогда
		ТекущиеДанные = ДеревоЗадач.НайтиПоИдентификатору(ИдентификаторНайденнойСтроки);
		Если ТекущиеДанные <> Неопределено Тогда
			ТекущиеДанные.Наименование = Параметры.НаименованиеТекущейЗадачи;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Если ИдентификаторВыбраннойЗадачи = -1 Тогда
		ЗадачиПроцессовКлиент.РаскрытьСтрокиВерхнегоУровня(ЭтотОбъект, "ДеревоЗадач");
	Иначе
		Элементы.ДеревоЗадач.ТекущаяСтрока = ИдентификаторВыбраннойЗадачи;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормы

&НаКлиенте
Процедура ДеревоЗадачВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ВыбратьЗадачу();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Выбрать(Команда)
	
	ВыбратьЗадачу();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ВыбратьЗадачу()

	ТекущиеДанные = Элементы.ДеревоЗадач.ТекущиеДанные;
	
	Если ТекущиеДанные = Неопределено Тогда
		СтруктураВозврата = Неопределено;
		Возврат;
	Иначе
		
		Если СписокНедоступныхЗадач.НайтиПоЗначению(ТекущиеДанные.ЗадачаШаблона) <> Неопределено Тогда
			Возврат;
		КонецЕсли;
		
		СтруктураВозврата = Новый Структура;
		СтруктураВозврата.Вставить("ЗадачаШаблона", ТекущиеДанные.ЗадачаШаблона);
		СтруктураВозврата.Вставить("ПредставлениеЗадачи", ?(ЗначениеЗаполнено(ТекущиеДанные.ЗадачаШаблона),
		                                                  ТекущиеДанные.ПолныйКод + " " + ТекущиеДанные.Наименование,
		                                                  ""));
		СтруктураВозврата.Вставить("ВыбраннаяЗадача", ВыбраннаяЗадача);
	КонецЕсли;
	
	Закрыть(СтруктураВозврата);
	
КонецПроцедуры

&НаСервере
Функция СписокЗадачиСПодчиненными()
	
	СписокЗадач = Новый СписокЗначений;
	СписокЗадач.Добавить(Параметры.ЗадачаШаблона);
	
	ИдентификаторНайденнойСтроки = ЗадачиПроцессовКлиентСервер.НайтиСтрокуВДанныхФормыДерево(ДеревоЗадач, Параметры.ЗадачаШаблона, "ЗадачаШаблона", Истина);
	
	Если ИдентификаторНайденнойСтроки <> - 1 Тогда
		ТекущиеДанные = ДеревоЗадач.НайтиПоИдентификатору(ИдентификаторНайденнойСтроки);
		ДобавитьПодчиненныеЗадачиВСписок(ТекущиеДанные, СписокЗадач);
	КонецЕсли;
	
	Возврат СписокЗадач;
	
КонецФункции

&НаСервере
Процедура ДобавитьПодчиненныеЗадачиВСписок(СтрокаДерева, СписокЗадач)
	
	ПодчиненныеСтроки = СтрокаДерева.ПолучитьЭлементы();
	
	Для Каждого ПодчиненнаяСтрока Из ПодчиненныеСтроки Цикл
		СписокЗадач.Добавить(ПодчиненнаяСтрока.ЗадачаШаблона);
		ДобавитьПодчиненныеЗадачиВСписок(ПодчиненнаяСтрока, СписокЗадач);
	КонецЦикла;

КонецПроцедуры

&НаСервере
Процедура УстановитьУсловноеОформление()

	УсловноеОформление.Элементы.Очистить();
	
	СписокНедоступныхЗадач = Новый СписокЗначений;
	
	Если Параметры.Свойство("НедоступенВыборПодчиненныхЗадачТекущейЗадачи") 
		И Параметры.НедоступенВыборПодчиненныхЗадачТекущейЗадачи Тогда
		
		СписокНедоступныхЗадач = СписокЗадачиСПодчиненными();
		
	КонецЕсли;
		
	Если Параметры.Свойство("СписокПодобранныхЗадач") 
		     И ТипЗнч(Параметры.СписокПодобранныхЗадач) = Тип("СписокЗначений") Тогда
			 
		Для Каждого ПодобраннаяЗадача ИЗ Параметры.СписокПодобранныхЗадач Цикл
			СписокНедоступныхЗадач.Добавить(ПодобраннаяЗадача.Значение);
		КонецЦикла;
		
	КонецЕсли;
	
	Элемент = УсловноеОформление.Элементы.Добавить();
	
	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ДеревоЗадач.Имя);
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение  = Новый ПолеКомпоновкиДанных("ДеревоЗадач.ЗадачаШаблона");
	ОтборЭлемента.ВидСравнения   = ВидСравненияКомпоновкиДанных.ВСписке;
	ОтборЭлемента.ПравоеЗначение = СписокНедоступныхЗадач;

	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста",     ЦветаСтиля.НедоступнаяДляВыбораЗадача);
	Элемент.Оформление.УстановитьЗначениеПараметра("ТолькоПросмотр", Истина);

КонецПроцедуры


#КонецОбласти
