﻿

#Область ОбработчикиСобытийФормы

 &НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ОбработатьПереданныеПараметры(Отказ);
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	ИнициализироватьКомпоновщикСервер(НастройкиКомпоновкиДанных);

КонецПроцедуры

#КонецОбласти 

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗавершитьРедактирование(Команда)
	
	Закрыть(СтруктураВозврата());
	
КонецПроцедуры



#КонецОбласти 



#Область СлужебныеПроцедурыИФункции

Процедура ИнициализироватьКомпоновщикСервер(НастройкаКомпоновки)
	
	СхемаКомпоновки = Обработки.Планирование.ПолучитьМакет(ИмяСхемыКомпоновкиДанных);
	АдресСхемы = ПоместитьВоВременноеХранилище(СхемаКомпоновки,УникальныйИдентификатор);
	КомпоновщикНастроек.Инициализировать(Новый ИсточникДоступныхНастроекКомпоновкиДанных(АдресСхемы));
	
	Если НастройкаКомпоновки = Неопределено Тогда
		КомпоновщикНастроек.ЗагрузитьНастройки(СхемаКомпоновки.НастройкиПоУмолчанию);
	Иначе
		КомпоновщикНастроек.ЗагрузитьНастройки(НастройкаКомпоновки);
		КомпоновщикНастроек.Восстановить(СпособВосстановленияНастроекКомпоновкиДанных.ПроверятьДоступность);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбработатьПереданныеПараметры(Отказ)

	Если ПустаяСтрока(Параметры.ИмяСхемыКомпоновкиДанных) Тогда
		Отказ = Истина;
		ОбщегоНазначения.СообщитьПользователю(НСтр("ru = 'В качестве параметра не передано имя схемы компоновки данных.'"),,,, Отказ);
		Возврат;
	КонецЕсли;
	
	ИмяСхемыКомпоновкиДанных = Параметры.ИмяСхемыКомпоновкиДанных;
	
	НастройкиКомпоновкиДанных = Параметры.НастройкиКомпоновки;
	
	УникальныйИдентификаторВладельца = Параметры.УникальныйИдентификаторВладельца;
	
КонецПроцедуры

&НаСервере
Функция СтруктураВозврата()
	
	ДанныеСхемыКомпоновкиОтбора = ПланированиеКлиентСервер.НовыйДанныеСхемыКомпоновкиОтбора();
	
	ДанныеСхемыКомпоновкиОтбора.АдресХранилищаНастройкиКомпоновщика =  НастройкиКомпоновщика(КомпоновщикНастроек, УникальныйИдентификаторВладельца);
	ДанныеСхемыКомпоновкиОтбора.ИмяСхемыКомпоновкиДанных             = ИмяСхемыКомпоновкиДанных;
	
	Возврат ДанныеСхемыКомпоновкиОтбора;

КонецФункции 

&НаСервереБезКонтекста
Функция НастройкиКомпоновщика(КомпоновщикНастроек, УникальныйИдентификатор)
	
	КомпоновщикНастроек.Восстановить(СпособВосстановленияНастроекКомпоновкиДанных.ПроверятьДоступность);
	
	Возврат ПоместитьВоВременноеХранилище(КомпоновщикНастроек.ПолучитьНастройки(), УникальныйИдентификатор);
	
КонецФункции

#КонецОбласти 

