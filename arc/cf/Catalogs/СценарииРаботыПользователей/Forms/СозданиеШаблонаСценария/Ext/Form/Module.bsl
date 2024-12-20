﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ФункцияСистемы = Параметры.Функция;
	ТекстШаблона   = Параметры.Текст;
	Если Параметры.Свойство("ЧтениеИзGit") Тогда
		ЧтениеИзGit = Параметры.ЧтениеИзGit;
		АдресСлужебныеДанныеСценариев = Параметры.АдресСлужебныеДанныеСценариев;
		Ветка = Параметры.Ветка;
		ИдентификаторКоммита = Параметры.ИдентификаторКоммита;
		Проект = Параметры.Проект;
		ТокенПользователя = Параметры.ТокенПользователя;
		ДанныеИерархии = Параметры.ДанныеИерархии;
	КонецЕсли;	 
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура СоздатьШаблон(Команда)
	Если НЕ ЗначениеЗаполнено(ИмяШаблона) Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Не заполнено имя шаблона.'"),,"ИмяШаблона");
		Возврат;
	КонецЕсли;	 
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("СоздатьШаблон",Истина);
	ПараметрыФормы.Вставить("Текст",ТекстШаблона);
	ПараметрыФормы.Вставить("ИмяШаблона",ИмяШаблона);
	ПараметрыФормы.Вставить("ФункцияСистемы",ФункцияСистемы);
	ПараметрыФормы.Вставить("ЭтоНовыйЭлемент",Истина);
	ЗначенияЗаполнения = Новый Структура;
	ЗначенияЗаполнения.Вставить("Шаблон",Истина);
	ЗначенияЗаполнения.Вставить("ФункцияСистемы",ФункцияСистемы);
	ЗначенияЗаполнения.Вставить("Наименование",ИмяШаблона);
	ПараметрыФормы.Вставить("ЗначенияЗаполнения",ЗначенияЗаполнения);
	
	Если ЧтениеИзGit Тогда
		ДанныеДляПолученияСценария = Новый Структура;
		ДанныеДляПолученияСценария.Вставить("АдресСлужебныеДанныеСценариев", АдресСлужебныеДанныеСценариев);
		ДанныеДляПолученияСценария.Вставить("ТокенПользователя", ТокенПользователя);
		ДанныеДляПолученияСценария.Вставить("Ветка", Ветка);
		ДанныеДляПолученияСценария.Вставить("Проект", Проект);
		ДанныеДляПолученияСценария.Вставить("ИдентификаторКоммита", ИдентификаторКоммита);
		ДанныеДляПолученияСценария.Вставить("ДанныеИерархии", ДанныеИерархии);
		ДанныеДляПолученияСценария.Вставить("ЭтоНовыйЭлемент", Истина);
		ДанныеДляПолученияСценария.Вставить("UIDСценария", Неопределено);
		ДанныеДляПолученияСценария.Вставить("ПараметрыФормы", ПараметрыФормы);
		ТестированиеКлиент.ОткрытьСценарийДляРедактированияВРепозитории(ДанныеДляПолученияСценария);
	Иначе	
		ОткрытьФорму("Справочник.СценарииРаботыПользователей.Форма.ФормаЭлемента",ПараметрыФормы);
	КонецЕсли;	 
	
	ПараметрыОповещения = Новый Структура;
	ПараметрыОповещения.Вставить("ИмяСобытия","СозданиеШаблонаСценария");
	ПараметрыОповещения.Вставить("ИмяШаблона",ИмяШаблона);
	
	ОповеститьОВыборе(ПараметрыОповещения);
КонецПроцедуры

#КонецОбласти