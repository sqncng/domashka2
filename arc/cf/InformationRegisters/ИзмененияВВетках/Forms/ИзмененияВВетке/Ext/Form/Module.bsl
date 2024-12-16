﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ТекущийПользователь = Пользователи.ТекущийПользователь();
	
	СтруктураБыстрогоОтбора = Неопределено;
	Параметры.Свойство("СтруктураБыстрогоОтбора", СтруктураБыстрогоОтбора);
	
	Если Параметры.Свойство("ОтборНеУказанСогласующий") Тогда
		ОтборНеУказанСогласующий = Параметры.ОтборНеУказанСогласующий;
	КонецЕсли;
	
	Если Параметры.Свойство("ОтборНеУказанОтветственный") Тогда
		ОтборНеУказанОтветственный = Параметры.ОтборНеУказанОтветственный;
	КонецЕсли;
	
	Если ОбщегоНазначенияСППРКлиентСервер.НеобходимОтборПоКолонкеПриСозданииНаСервере("Согласующий", Согласующий, СтруктураБыстрогоОтбора) Тогда
		УстановитьОтборПоСогласующему();
	КонецЕсли;
	
	Если ОбщегоНазначенияСППРКлиентСервер.НеобходимОтборПоКолонкеПриСозданииНаСервере("Ответственный", Справочники.Пользователи.ПустаяСсылка(), СтруктураБыстрогоОтбора) Тогда
		УстановитьОтборПоОтветственному();
	КонецЕсли;
	
	Если ОбщегоНазначенияСППРКлиентСервер.НеобходимОтборПоКолонкеПриСозданииНаСервере("СтатусСогласования", СписокСтатусовСогласования, СтруктураБыстрогоОтбора) Тогда
		УстановитьОтборПоСтатусуСогласования();
	КонецЕсли;
	
	Если ОбщегоНазначенияСППРКлиентСервер.НеобходимОтборПоКолонкеПриСозданииНаСервере("ОбъектДобавлен", ОтборНовыеОбъекты, СтруктураБыстрогоОтбора) Тогда
		УстановитьОтборПоНовымОбъектам();
	КонецЕсли;
	
	УстановитьОтборПоПроекту();
	
	ДоступноИзменениеХронометража = УправлениеДоступом.ЕстьРоль("ИзменениеДанныхХронометража");
	
	ВидДеятельностиДляСогласованияИзменений = Константы.ВидДеятельностиДляСогласованияИзмененийМетаданныхВВетках.Получить();
	
	НастроитьКомандуХронометража();
	
	УстановитьДоступностьЭлементов();

	УстановитьРеквизитыФормы();
	СсылкаВРепозитории = СсылкаВРепозитории();
	
КонецПроцедуры

&НаСервере
Процедура ПередЗагрузкойДанныхИзНастроекНаСервере(Настройки)
	
	Если ОбщегоНазначенияСППРКлиентСервер.НеобходимОтборПоКолонкеПередЗагрузкойИзНастроек("Согласующий",
			"Согласующий",
			Согласующий,
			СтруктураБыстрогоОтбора,
			Настройки) Тогда
			
		УстановитьОтборПоСогласующему();
	КонецЕсли;
	
	Если ОбщегоНазначенияСППРКлиентСервер.НеобходимОтборПоКолонкеПередЗагрузкойИзНастроек("СтатусСогласования",
			"СписокСтатусовСогласования",
			СписокСтатусовСогласования,
			СтруктураБыстрогоОтбора,
			Настройки) Тогда
			
		УстановитьОтборПоСтатусуСогласования();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ПереключенХронометраж"
		И ЗначениеЗаполнено(ВидДеятельностиДляСогласованияИзменений) Тогда
		УчетВремениКлиентСервер.ОбработатьПереключениеХронометража(Параметр, ЭтаФорма, ВидДеятельностиДляСогласованияИзменений);
	КонецЕсли;

	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ОтборСогласующийПриИзменении(Элемент)
	
	УстановитьОтборПоСогласующему();
	
КонецПроцедуры

&НаКлиенте
Процедура СписокСтатусовСогласованияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	СтруктураПараметров = Новый Структура("СписокВыбора", СписокСтатусовСогласования);
	
	ОткрытьФорму("Перечисление.СтатусыСогласованияИзмененийВВетках.Форма.ВыборСпискаСтатусов", СтруктураПараметров, Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура СписокСтатусовСогласованияОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	СписокСтатусовСогласования = ВыбранноеЗначение;
	
КонецПроцедуры

&НаКлиенте
Процедура СписокСтатусовСогласованияПриИзменении(Элемент)
	
	УстановитьОтборПоСтатусуСогласования();
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборНовыеОбъектыПриИзменении(Элемент)
	
	УстановитьОтборПоНовымОбъектам();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура УстановитьСтатусТребуетСогласования(Команда)
	
	КлючиЗаписей = Новый Массив;
	   
	Для Каждого ВыделеннаяСтрока из Элементы.Список.ВыделенныеСтроки Цикл
		КлючиЗаписей.Добавить(ВыделеннаяСтрока);
	КонецЦикла;
	
	Если КлючиЗаписей.Количество()>0 Тогда
		ОбработатьЗаписи(КлючиЗаписей, ПредопределенноеЗначение("Перечисление.СтатусыСогласованияИзмененийВВетках.ТребуетСогласования"), Неопределено);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьСтатусНеТребуетСогласования(Команда)
	
	КлючиЗаписей = Новый Массив;
	   
	Для Каждого ВыделеннаяСтрока из Элементы.Список.ВыделенныеСтроки Цикл
		КлючиЗаписей.Добавить(ВыделеннаяСтрока);
	КонецЦикла;
	
	Если КлючиЗаписей.Количество()>0 Тогда
		ОбработатьЗаписи(КлючиЗаписей, ПредопределенноеЗначение("Перечисление.СтатусыСогласованияИзмененийВВетках.НеТребуетСогласования"), Неопределено);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьСтатусСогласовано(Команда)
	
	КлючиЗаписей = Новый Массив;
	   
	Для Каждого ВыделеннаяСтрока из Элементы.Список.ВыделенныеСтроки Цикл
		КлючиЗаписей.Добавить(ВыделеннаяСтрока);
	КонецЦикла;
	
	Если КлючиЗаписей.Количество()>0 Тогда
		
		ПараметрыФормы = Новый Структура;
		ДополнительныеПараметры = Новый Структура;
		ДополнительныеПараметры.Вставить("КлючиЗаписей", КлючиЗаписей);
	    ДополнительныеПараметры.Вставить("Статус", ПредопределенноеЗначение("Перечисление.СтатусыСогласованияИзмененийВВетках.Согласовано"));
		
		ОписаниеОповещения = Новый ОписаниеОповещения("УстановитьСтатусСогласованияЗавершение", ЭтотОбъект, ДополнительныеПараметры);
		ОткрытьФорму("РегистрСведений.ИзмененияВВетках.Форма.КомментарийСогласования",
				 ПараметрыФормы,
				 ЭтаФорма,
				 ,
				 ,
				 ,
				 ОписаниеОповещения,
				 РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьСтатусСогласованоБезКомментария(Команда)
	
	КлючиЗаписей = Новый Массив;
	   
	Для Каждого ВыделеннаяСтрока из Элементы.Список.ВыделенныеСтроки Цикл
		КлючиЗаписей.Добавить(ВыделеннаяСтрока);
	КонецЦикла;
	
	УстанавливаемыйСтатус = ПредопределенноеЗначение("Перечисление.СтатусыСогласованияИзмененийВВетках.Согласовано");
	
	Если КлючиЗаписей.Количество()>0 Тогда
		ОбработатьЗаписи(КлючиЗаписей, УстанавливаемыйСтатус, Неопределено);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьСтатусНеСогласовано(Команда)

	КлючиЗаписей = Новый Массив;
	   
	Для Каждого ВыделеннаяСтрока из Элементы.Список.ВыделенныеСтроки Цикл
		КлючиЗаписей.Добавить(ВыделеннаяСтрока);
	КонецЦикла;
	
	Если КлючиЗаписей.Количество()>0 Тогда
		
		ПараметрыФормы = Новый Структура;
		ДополнительныеПараметры = Новый Структура;
		ДополнительныеПараметры.Вставить("КлючиЗаписей", КлючиЗаписей);
	    ДополнительныеПараметры.Вставить("Статус", ПредопределенноеЗначение("Перечисление.СтатусыСогласованияИзмененийВВетках.НеСогласовано"));
		
		ОписаниеОповещения = Новый ОписаниеОповещения("УстановитьСтатусСогласованияЗавершение", ЭтотОбъект, ДополнительныеПараметры);
		ОткрытьФорму("РегистрСведений.ИзмененияВВетках.Форма.КомментарийСогласования",
				 ПараметрыФормы,
				 ЭтаФорма,
				 ,
				 ,
				 ,
				 ОписаниеОповещения,
				 РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПерейтиККоммитамВетки(Команда)
	
	Если НЕ ЗначениеЗаполнено(ВеткаОтбор) Тогда
		Возврат;
	КонецЕсли;  

	ТекстКоманды = ПерейтиККоммитамВеткиСервер(ВеткаОтбор);
	Если НЕ ЗначениеЗаполнено(ТекстКоманды) Тогда
		Возврат;
	КонецЕсли;	
	
	НачатьЗапускПриложения(Новый ОписаниеОповещения, ТекстКоманды);
	
КонецПроцедуры

&НаКлиенте
Процедура ПерейтиККоммитамПоМетаданному(Команда)
	Если НЕ ЗначениеЗаполнено(ВеткаОтбор) Тогда
		Возврат;
	КонецЕсли;	                     
	
	Если Элементы.Список.ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;	
	
	ДанныеИзЗаписиРС = ДанныеИзЗаписиРС(Элементы.Список.ТекущаяСтрока);
	
	ИзмененыеФайлы = ИзмененыеФайлыДляПереходаККоммитамПоМетаданному(
		ДанныеИзЗаписиРС.ПодробноеОписаниеИзменений, ВеткаОтбор, "commits");
		
	ОткрытьГиперссылкуПоИзмененнымФайлам(ИзмененыеФайлы);
		
КонецПроцедуры

&НаКлиенте
Процедура ПерейтиКИзменениямВнутриФайла(Команда)
	Если НЕ ЗначениеЗаполнено(ВеткаОтбор) Тогда
		Возврат;
	КонецЕсли;	
	
	Если Элементы.Список.ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;	
	
	ДанныеИзЗаписиРС = ДанныеИзЗаписиРС(Элементы.Список.ТекущаяСтрока);
	
	ИзмененыеФайлы = ИзмененыеФайлыДляПереходаККоммитамПоМетаданному(
		ДанныеИзЗаписиРС.ПодробноеОписаниеИзменений, ВеткаОтбор, "blame");
		
	ОткрытьГиперссылкуПоИзмененнымФайлам(ИзмененыеФайлы);
КонецПроцедуры
	
&НаКлиенте
Процедура ПерейтиКСравнениюСВеткойПриемником(Команда)
	Если НЕ ЗначениеЗаполнено(ВеткаОтбор) Тогда
		Возврат;
	КонецЕсли;	
	
	Если Элементы.Список.ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;	
	
	ДанныеИзЗаписиРС = ДанныеИзЗаписиРС(Элементы.Список.ТекущаяСтрока);
	
	ПодробноеОписаниеИзменений = ДанныеИзЗаписиРС.ПодробноеОписаниеИзменений; 
	
	ИзмененыеФайлы = ПерейтиКСравнениюСВеткойПриемникомСервер(ВеткаОтбор, ПодробноеОписаниеИзменений);
	
	ОткрытьГиперссылкуПоИзмененнымФайлам(ИзмененыеФайлы);
КонецПроцедуры

&НаКлиенте
Процедура ИзмененияСПредыдущегоСогласованияПоВсемОбъектам(Команда)
	Если НЕ ЗначениеЗаполнено(ВеткаОтбор) Тогда
		Возврат;
	КонецЕсли;	
	
	Если Элементы.Список.ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ДанныеИзЗаписиРС = ДанныеИзЗаписиРС(Элементы.Список.ТекущаяСтрока);
	
	ТекстКоманды = ГиперссылкаИзмененияСПредыдущегоСогласованияПоВсемОбъектам(ВеткаОтбор,
		ДанныеИзЗаписиРС.ОбъектМетаданных, ДанныеИзЗаписиРС.ПодчиненныйОбъект);
	Если НЕ ЗначениеЗаполнено(ТекстКоманды) Тогда
		Возврат;
	КонецЕсли;	
	
	НачатьЗапускПриложения(Новый ОписаниеОповещения, ТекстКоманды);
		
КонецПроцедуры

&НаКлиенте
Процедура ИзмененияСПредыдущегоСогласованияПоТекущемуОбъекту(Команда)
	Если НЕ ЗначениеЗаполнено(ВеткаОтбор) Тогда
		Возврат;
	КонецЕсли;	
	
	Если Элементы.Список.ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;	   
	
	ДанныеИзЗаписиРС = ДанныеИзЗаписиРС(Элементы.Список.ТекущаяСтрока);
	
	ИзмененыеФайлы = ИзмененыеФайлыДляПереходаКИзменениямСПоследнегоСогласования(
		ДанныеИзЗаписиРС.ПодробноеОписаниеИзменений, ВеткаОтбор,
		ДанныеИзЗаписиРС.ОбъектМетаданных, ДанныеИзЗаписиРС.ПодчиненныйОбъект);
		
	Если ИзмененыеФайлы = Неопределено Тогда
		ОбщегоНазначенияКлиент.СообщитьПользователю(НСтр("ru = 'Не найдено предыдущее согласование.'"));
		Возврат;
	КонецЕсли;		
		
	ОткрытьГиперссылкуПоИзмененнымФайлам(ИзмененыеФайлы);
КонецПроцедуры

&НаКлиенте
Процедура СравнитьСВеткойПриемникомНаКоммитСогласования(Команда)
	Если НЕ ЗначениеЗаполнено(ВеткаОтбор) Тогда
		Возврат;
	КонецЕсли;	
	
	Если Элементы.Список.ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;	 
	
	ДанныеИзЗаписиРС = ДанныеИзЗаписиРС(Элементы.Список.ТекущаяСтрока);
	
	ИзмененыеФайлы = ИзмененыеФайлыДляПереходаКСравнениюВеткиПриемникаСПредыдущимКоммитомСогласования(
		ДанныеИзЗаписиРС.ПодробноеОписаниеИзменений, ВеткаОтбор,
		ДанныеИзЗаписиРС.ОбъектМетаданных, ДанныеИзЗаписиРС.ПодчиненныйОбъект);
		
	ОткрытьГиперссылкуПоИзмененнымФайлам(ИзмененыеФайлы);
КонецПроцедуры

&НаКлиенте
Процедура ПереключитьХронометраж(Команда)
	
	Если НЕ ЗначениеЗаполнено(ВидДеятельностиДляСогласованияИзменений) Тогда
		Возврат;
	КонецЕсли;
	
	ДанныеХронометража = ПереключитьХронометражНаСервере(ВидДеятельностиДляСогласованияИзменений);
	
	Элементы.ПереключитьХронометраж.Пометка = НЕ Элементы.ПереключитьХронометраж.Пометка;
	
	Оповестить("ПереключенХронометраж", ДанныеХронометража, ЭтотОбъект);
	
	Если ДанныеХронометража.ХронометражЗавершен Тогда
		ДанныеОповещения = Новый Структура;
		ДанныеОповещения.Вставить("Начало", ДанныеХронометража.НачалоЗавершеннойРаботы);
		ДанныеОповещения.Вставить("Окончание", ДанныеХронометража.ОкончаниеЗавершеннойРаботы);
		
		Оповестить("ЗаписаныДанныеКалендаря", ДанныеОповещения, ЭтотОбъект);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СравнитьСВерсиейВеткиПриемника(Команда)
	Если НЕ ЗначениеЗаполнено(ВеткаОтбор) Тогда
		Возврат;
	КонецЕсли;	                     
	
	Если Элементы.Список.ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;	
	
	ДанныеИзЗаписиРС = ДанныеИзЗаписиРС(Элементы.Список.ТекущаяСтрока);
	
	ИзмененыеФайлы = ИзмененыеФайлыДляПереходаККоммитамПоМетаданному(
		ДанныеИзЗаписиРС.ПодробноеОписаниеИзменений, ВеткаОтбор, "commits");

	Если ИзмененыеФайлы.Количество() = 1 Тогда
		ПоказатьСравнениеФайлаССостояниемВеткиПриемника(ИзмененыеФайлы[0].ИмяФайла);
	ИначеЕсли ИзмененыеФайлы.Количество() >= 1 Тогда
		Спс = ОбщегоНазначенияСППРКлиент.СписокИзмененныхФайловДляВыбора(ИзмененыеФайлы);
		
		ОбработкаОповещения = Новый ОписаниеОповещения("СравнитьСВерсиейВеткиПриемникаЗавершение", ЭтотОбъект);
		Спс.ПоказатьВыборЭлемента(ОбработкаОповещения, НСтр("ru = 'Выберите файл'"))	
	КонецЕсли;		
		
КонецПроцедуры

&НаКлиенте
Процедура СравнитьСВерсиейПоследнегоСогласования(Команда)
	Если НЕ ЗначениеЗаполнено(ВеткаОтбор) Тогда
		Возврат;
	КонецЕсли;	                     
	
	Если Элементы.Список.ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ДанныеИзЗаписиРС = ДанныеИзЗаписиРС(Элементы.Список.ТекущаяСтрока);
	ИзмененыеФайлы = ИзмененыеФайлыДляПереходаКИзменениямСПоследнегоСогласования(
		ДанныеИзЗаписиРС.ПодробноеОписаниеИзменений, ВеткаОтбор,
		ДанныеИзЗаписиРС.ОбъектМетаданных, ДанныеИзЗаписиРС.ПодчиненныйОбъект);
		
	Если ИзмененыеФайлы = Неопределено Тогда
		ОбщегоНазначенияКлиент.СообщитьПользователю(НСтр("ru = 'Не найдено предыдущее согласование.'"));
		Возврат;
	КонецЕсли;		

	Если ИзмененыеФайлы.Количество() = 1 Тогда
		ПоказатьСравнениеФайлаССостояниемКоммитаСогласования(ИзмененыеФайлы[0]);
	ИначеЕсли ИзмененыеФайлы.Количество() >= 1 Тогда
		Спс = ОбщегоНазначенияСППРКлиент.СписокИзмененныхФайловДляВыбора(ИзмененыеФайлы);
		
		ОбработкаОповещения = Новый ОписаниеОповещения("СравнитьСВерсиейПоследнегоСогласованияЗавершение", ЭтотОбъект);
		Спс.ПоказатьВыборЭлемента(ОбработкаОповещения, НСтр("ru = 'Выберите файл'"))	
	КонецЕсли;		
		
КонецПроцедуры

&НаКлиенте
Процедура НазначитьСогласующегоОтветственного(Команда)
	
	КлючиЗаписей = Новый Массив;
	   
	Для Каждого ВыделеннаяСтрока из Элементы.Список.ВыделенныеСтроки Цикл
		КлючиЗаписей.Добавить(ВыделеннаяСтрока);
	КонецЦикла;
	
	Если КлючиЗаписей.Количество()>0 Тогда
		
		ДополнительныеПараметры = Новый Структура;
		ДополнительныеПараметры.Вставить("КлючиЗаписей", КлючиЗаписей);
		
		ОписаниеОповещения = Новый ОписаниеОповещения("НазначитьСогласующегоОтветственногоЗавершение", ЭтотОбъект, ДополнительныеПараметры);
		ОткрытьФорму("РегистрСведений.ИзмененияВВетках.Форма.НазначениеСогласующегоОтветственного",
				 ,
				 ЭтаФорма,
				 ,
				 ,
				 ,
				 ОписаниеОповещения,
				 РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
		
	КонецЕсли;
			 
КонецПроцедуры

&НаКлиенте
Процедура НазначитьСогласующего(Команда)
	
	КлючиЗаписей = Новый Массив;
	   
	Для Каждого ВыделеннаяСтрока из Элементы.Список.ВыделенныеСтроки Цикл
		КлючиЗаписей.Добавить(ВыделеннаяСтрока);
	КонецЦикла;
	
	Если КлючиЗаписей.Количество()>0 Тогда
		
		ДополнительныеПараметры = Новый Структура;
		ДополнительныеПараметры.Вставить("КлючиЗаписей", КлючиЗаписей);
		
		ОписаниеОповещения = Новый ОписаниеОповещения("НазначитьСогласующегоЗавершение", ЭтотОбъект, ДополнительныеПараметры);
		ОткрытьФорму("РегистрСведений.ИзмененияВВетках.Форма.ВыборПользователя",
				 ,
				 ЭтаФорма,
				 ,
				 ,
				 ,
				 ОписаниеОповещения,
				 РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
		
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ЯСогласующий(Команда)
	
	УстановитьОтборПоСогласующемуТекущемуПользователю();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура УстановитьСтатусСогласованияЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если ТипЗнч(Результат) = Тип("Структура") Тогда
		ОбработатьЗаписи(ДополнительныеПараметры.КлючиЗаписей, ДополнительныеПараметры.Статус, Результат);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьОтборПоСогласующему()
	
	ИспользоватьОтбор = ЗначениеЗаполнено(Согласующий) ИЛИ ОтборНеуказанСогласующий;
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,
																			"Согласующий",
																			Согласующий,
																			ВидСравненияКомпоновкиДанных.Равно,
																			,
																			ИспользоватьОтбор);
																			
КонецПроцедуры

&НаСервере
Процедура УстановитьОтборПоОтветственному()
	
	ИспользоватьОтбор = ОтборНеуказанОтветственный;
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,
																			"Ответственный",
																			Справочники.Пользователи.ПустаяСсылка(),
																			ВидСравненияКомпоновкиДанных.Равно,
																			,
																			ИспользоватьОтбор);
																			
КонецПроцедуры
																		
&НаСервере
Процедура УстановитьОтборПоСтатусуСогласования()
	
	ИспользоватьОтбор = СписокСтатусовСогласования.Количество()>0;
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,
																			"СтатусСогласования",
																			СписокСтатусовСогласования,
																			ВидСравненияКомпоновкиДанных.ВСписке,
																			,
																			ИспользоватьОтбор);
																			
КонецПроцедуры

&НаСервере
Процедура УстановитьОтборПоНовымОбъектам()
	
	ИспользоватьОтбор = ОтборНовыеОбъекты;
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,
																			"ТипИзменения",
																			Перечисления.ТипыИзмененийОбъектовМетаданных.Добавлен,
																			ВидСравненияКомпоновкиДанных.Равно,
																			,
																			ИспользоватьОтбор);
																			
КонецПроцедуры

&НаСервере
Процедура УстановитьОтборПоПроекту()
	
	Если НЕ Параметры.Отбор.Свойство("Ветка") Тогда
		Проект = ПараметрыСеанса.ТекущийПроект;
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список, "Проект", Проект, ВидСравненияКомпоновкиДанных.Равно,,ЗначениеЗаполнено(Проект));
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбработатьЗаписи(КлючиЗаписей, Статус, ДанныеИзмененияКомментария)
	
	ДатаИзмененияСтатуса = ТекущаяДата();
	
	Если ТипЗнч(ДанныеИзмененияКомментария) = Тип("Структура") Тогда
		Комментарий = ДанныеИзмененияКомментария.Комментарий;
		ИзменятьКомментарий = ДанныеИзмененияКомментария.ИзменятьКомментарий;
	Иначе
		Комментарий = "";
		ИзменятьКомментарий = Истина
	КонецЕсли;
	
	Для Каждого КлючЗаписи из КлючиЗаписей Цикл
		
		Попытка
			МенеджерЗаписи = РегистрыСведений.ИзмененияВВетках.СоздатьМенеджерЗаписи();
			ЗаполнитьЗначенияСвойств(МенеджерЗаписи, КлючЗаписи);
			МенеджерЗаписи.Прочитать();
			МенеджерЗаписи.УстановилСтатус = ТекущийПользователь;
			МенеджерЗаписи.ДатаИзмененияСтатусаСогласования = ДатаИзмененияСтатуса;
			МенеджерЗаписи.СтатусСогласования = Статус;
			
			Если ИзменятьКомментарий Тогда
				МенеджерЗаписи.КомментарийСогласования = Комментарий;
			КонецЕсли;
			
			МенеджерЗаписи.Записать();
		Исключение
			ТекстСообщения = НСтр("ru='Изменения не записаны (Ветка %Ветка%', Объект метаданных %ОбъектМетаданных%, Подчиненный объект %ПодчиненныйОбъект%");
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Ветка%", КлючЗаписи.Ветка);
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%ОбъектМетаданных%", КлючЗаписи.ОбъектМетаданных);
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%ПодчиненныйОбъект%", КлючЗаписи.ПодчиненныйОбъект);
			ТекстСообщения = ТекстСообщения + ОписаниеОшибки();
			
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения);
			Возврат;
		КонецПопытки;
		
	КонецЦикла;
	
	Элементы.Список.Обновить();
	
КонецПроцедуры

&НаСервере
Процедура УстановитьДоступностьЭлементов()
	
	ДоступноИзменениеРегистра = УправлениеДоступом.ЕстьРоль("ИзменениеДанныхОбИзмененииВВетках");
	
	ДоступноИзменениеОбъектовМетаданных = УправлениеДоступом.ЕстьРоль("ДобавлениеИзменениеОбъектовМетаданных");
	
	Если Элементы.Найти("СписокКонтекстноеМенюУстановитьСтатусСогласовано") <> Неопределено Тогда
		Элементы.СписокКонтекстноеМенюУстановитьСтатусСогласовано.Доступность = ДоступноИзменениеРегистра;
	КонецЕсли;
	
	Если Элементы.Найти("СписокКонтекстноеМенюУстановитьСтатусНеСогласовано") <> Неопределено Тогда
		Элементы.СписокКонтекстноеМенюУстановитьСтатусНеСогласовано.Доступность = ДоступноИзменениеРегистра;
	КонецЕсли;
	
	Если Элементы.Найти("СписокУстановитьСтатусСогласованоБезКомментария") <> Неопределено Тогда
		Элементы.СписокУстановитьСтатусСогласованоБезКомментария.Доступность = ДоступноИзменениеРегистра;
	КонецЕсли;
	
	Если Элементы.Найти("СписокУстановитьСтатусНеСогласовано") <> Неопределено Тогда
		Элементы.СписокУстановитьСтатусНеСогласовано.Доступность = ДоступноИзменениеРегистра;
	КонецЕсли;
	
	Если Элементы.Найти("СписокКонтекстноеМенюУстановитьСтатусТребуетСогласования") <> Неопределено Тогда
		Элементы.СписокКонтекстноеМенюУстановитьСтатусТребуетСогласования.Доступность = ДоступноИзменениеРегистра;
	КонецЕсли;
	
	Если Элементы.Найти("СписокКонтекстноеМенюУстановитьСтатусНеТребуетСогласования") <> Неопределено Тогда
		Элементы.СписокКонтекстноеМенюУстановитьСтатусНеТребуетСогласования.Доступность = ДоступноИзменениеРегистра;
	КонецЕсли;
	
	Если Элементы.Найти("СписокКонтекстноеМенюНазначитьОтветственногоИСогласующего") <> Неопределено Тогда
		Элементы.СписокКонтекстноеМенюНазначитьОтветственногоИСогласующего.Доступность =
			ДоступноИзменениеРегистра И ДоступноИзменениеОбъектовМетаданных;
	КонецЕсли;
	
	Если Элементы.Найти("СписокКонтекстноеМенюНазначитьСогласующего") <> Неопределено Тогда
		Элементы.СписокКонтекстноеМенюНазначитьСогласующего.Доступность = ДоступноИзменениеРегистра;
	КонецЕсли;
		
КонецПроцедуры

&НаСервере
Функция ДанныеЗагрузкиМетаданных(Ветка)
	
	Результат = Новый Структура;
	Результат.Вставить("ДанныеКоммита", Неопределено);
	Результат.Вставить("ДатаЗагрузки", Неопределено);
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	СостояниеЗагрузкиМетаданныхВВетках.ДанныеКоммита КАК ДанныеКоммита,
		|	СостояниеЗагрузкиМетаданныхВВетках.ДатаЗагрузки КАК ДатаЗагрузки
		|ИЗ
		|	РегистрСведений.СостояниеЗагрузкиМетаданныхВВетках КАК СостояниеЗагрузкиМетаданныхВВетках
		|ГДЕ
		|	СостояниеЗагрузкиМетаданныхВВетках.Ветка = &Ветка";
	
	Запрос.УстановитьПараметр("Ветка", Ветка);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		ЗаполнитьЗначенияСвойств(Результат, ВыборкаДетальныеЗаписи);
	КонецЦикла;
	
	Возврат Результат;

КонецФункции	

&НаСервере
Процедура УстановитьРеквизитыФормы()
	
	Если НЕ Параметры.Отбор.Свойство("Ветка") Тогда
		Возврат;
	КонецЕсли;
	
	ВеткаОтбор = Параметры.Отбор.Ветка;
КонецПроцедуры

&НаСервере
Функция СсылкаВРепозитории()
	
	Если НЕ ЗначениеЗаполнено(ВеткаОтбор) Тогда
		Возврат Неопределено;
	КонецЕсли;	
	
	Ветка = ВеткаОтбор;
	РежимРазработки = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ветка ,"РежимРазработки");
	
	Если РежимРазработки = Перечисления.РежимРазработки.ВХранилище Тогда
		Возврат Неопределено;
	КонецЕсли;	
	
	Проект = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ветка, "Владелец");
	ДанныеЗагрузкиМетаданных = ДанныеЗагрузкиМетаданных(Ветка);
	Если НЕ ЗначениеЗаполнено(ДанныеЗагрузкиМетаданных.ДанныеКоммита) Тогда
		Возврат НСтр("ru = 'Загрузка не выполнялась.'");
	КонецЕсли;	
	
	ДанныеПодключенияПроектаКGitСерверу = Тестирование.ДанныеПодключенияПроектаКGitСерверу(Проект);
	Стр = "https://" + ДанныеПодключенияПроектаКGitСерверу.РедактированиеСценариевВGitАдресСервера + "/"
		+ ДанныеПодключенияПроектаКGitСерверу.РедактированиеСценариевВGitИмяПроекта + "/-/commit/" + ДанныеЗагрузкиМетаданных.ДанныеКоммита;
		
	Стр = Тестирование.ЭкранироватьСпецсимволыWeb(Стр);	
	МассивСтрок = Новый Массив;
	МассивСтрок.Добавить(Новый ФорматированнаяСтрока(СтрШаблон(НСтр("ru = 'Последняя загрузка от %1 на коммит %2'"),
		ДанныеЗагрузкиМетаданных.ДатаЗагрузки, ДанныеЗагрузкиМетаданных.ДанныеКоммита)
		,,,,Стр));
	Возврат Новый ФорматированнаяСтрока(МассивСтрок);
КонецФункции

&НаСервере
Функция ПерейтиККоммитамВеткиСервер(Ветка)
	
	Возврат РаботаCGit.ПерейтиККоммитамВетки(Ветка);
	
КонецФункции

&НаСервереБезКонтекста
Функция ИзмененыеФайлыДляПереходаККоммитамПоМетаданному(Исходник, Ветка, Тип)
	
	Возврат РаботаCGit.ИзмененыеФайлыДляПереходаККоммитамПоМетаданному(Исходник, Ветка, Тип);
	
КонецФункции

&НаСервере
Функция ИзмененыеФайлыДляПереходаКСравнениюВеткиПриемникаСПредыдущимКоммитомСогласования(Исходник, Ветка, ОбъектМетаданных, ПодчиненныйОбъект)
	
	Возврат РаботаCGit.ИзмененыеФайлыДляПереходаКСравнениюВеткиПриемникаСПредыдущимКоммитомСогласования(Исходник, Ветка, ОбъектМетаданных, ПодчиненныйОбъект);
	
КонецФункции

&НаКлиенте
Процедура ВыборФайлаДляПереходаНаГитСерверЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	НачатьЗапускПриложения(Новый ОписаниеОповещения, Результат.Значение.Гиперссылка);
	
КонецПроцедуры	

&НаКлиенте
Процедура СравнитьСВерсиейВеткиПриемникаЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ПоказатьСравнениеФайлаССостояниемВеткиПриемника(Результат.Значение.ИмяФайла)
	
КонецПроцедуры	

&НаКлиенте
Процедура СравнитьСВерсиейПоследнегоСогласованияЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ПоказатьСравнениеФайлаССостояниемКоммитаСогласования(Результат.Значение)
	
КонецПроцедуры	

&НаКлиенте
Процедура ОткрытьГиперссылкуПоИзмененнымФайлам(ИзмененыеФайлы)
	
	Если ИзмененыеФайлы = Неопределено Тогда
		Возврат;
	КонецЕсли;	
	
	Если ИзмененыеФайлы.Количество() = 1 Тогда
		НачатьЗапускПриложения(Новый ОписаниеОповещения, ИзмененыеФайлы[0].Гиперссылка);
	ИначеЕсли ИзмененыеФайлы.Количество() >= 1 Тогда
		Спс = ОбщегоНазначенияСППРКлиент.СписокИзмененныхФайловДляВыбора(ИзмененыеФайлы);
		
		ОбработкаОповещения = Новый ОписаниеОповещения("ВыборФайлаДляПереходаНаГитСерверЗавершение", ЭтотОбъект);
		Спс.ПоказатьВыборЭлемента(ОбработкаОповещения, НСтр("ru = 'Выберите файл'"))	
	КонецЕсли;		
	
КонецПроцедуры

&НаСервере
Функция ГиперссылкаИзмененияСПредыдущегоСогласованияПоВсемОбъектам(Ветка, ОбъектМетаданных, ПодчиненныйОбъект)
	
	Возврат РаботаCGit.ГиперссылкаИзмененияСПредыдущегоСогласованияПоВсемОбъектам(Ветка, ОбъектМетаданных, ПодчиненныйОбъект);
	
КонецФункции   

&НаСервере
Функция ИзмененыеФайлыДляПереходаКИзменениямСПоследнегоСогласования(Исходник, Ветка, ОбъектМетаданных, ПодчиненныйОбъект)
	
	Возврат РаботаCGit.ИзмененыеФайлыДляПереходаКИзменениямСПоследнегоСогласования(Исходник, Ветка, ОбъектМетаданных, ПодчиненныйОбъект);
	
КонецФункции

&НаСервереБезКонтекста
Функция ПерейтиКСравнениюСВеткойПриемникомСервер(ВеткаОтбор, Исходник)
	
	Возврат РаботаCGit.ПерейтиКСравнениюСВеткойПриемникомСервер(ВеткаОтбор, Исходник);
	
КонецФункции	

&НаСервере
Функция ПереключитьХронометражНаСервере(Ссылка)
	
	Возврат УчетВремени.ПереключитьХронометраж(Ссылка);
	
КонецФункции

&НаСервере
Процедура НастроитьКомандуХронометража()
	
	КнопкаХронометража = Элементы.Найти("ПереключитьХронометраж");
	
	Если КнопкаХронометража <> Неопределено Тогда
		
		Если ЗначениеЗаполнено(ВидДеятельностиДляСогласованияИзменений) И ДоступноИзменениеХронометража Тогда
			
			КнопкаХронометража.Доступность = Истина;
			Если УчетВремени.ХронометражВключен(ТекущийПользователь, ВидДеятельностиДляСогласованияИзменений, "") Тогда
				КнопкаХронометража.Пометка = Истина;
			Иначе
				КнопкаХронометража.Пометка = Ложь;
			КонецЕсли;
		Иначе
			КнопкаХронометража.Доступность = Ложь;
		КонецЕсли;
		
	КонецЕсли;
		
КонецПроцедуры

&НаСервереБезКонтекста
Функция ТекущийТекстФайлаСервер(ВеткаОтбор, ИмяФайла)
	
	Ветка = ВеткаОтбор;
	ДанныеВетки = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Ветка, "Владелец,Имя");
	Возврат ТестированиеЗапускТестирования.ТекстФайлаИзРепозитория(ДанныеВетки.Владелец, ИмяФайла, ДанныеВетки.Имя);
	
КонецФункции

&НаСервереБезКонтекста
Функция ТекстФайлаВВеткеПриемнике(ВеткаОтбор, ИмяФайла)
	
	Ветка = ВеткаОтбор;
	ДанныеВетки = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Ветка, "Владелец,Приемник.Имя");
	Возврат ТестированиеЗапускТестирования.ТекстФайлаИзРепозитория(ДанныеВетки.Владелец, ИмяФайла, ДанныеВетки.ПриемникИмя);
	
КонецФункции

&НаСервереБезКонтекста
Функция ТекстФайлаНаКоммит(ВеткаОтбор, Коммит, ИмяФайла)
	
	Ветка = ВеткаОтбор;
	ДанныеВетки = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Ветка, "Владелец");
	Возврат ТестированиеЗапускТестирования.ТекстФайлаИзРепозитория(ДанныеВетки.Владелец, ИмяФайла, Коммит);
	
КонецФункции

&НаКлиенте
Процедура ПоказатьСравнениеФайлаССостояниемВеткиПриемника(ИмяФайла)
	ТекущийТекстФайла = ТекущийТекстФайлаСервер(ВеткаОтбор, ИмяФайла);
	ТекстФайлаВВеткеПриемнике = ТекстФайлаВВеткеПриемнике(ВеткаОтбор, ИмяФайла);
	
	ПараметрыСравнения = Новый Структура;
	ПараметрыСравнения.Вставить("ТекстДляСравнения2", ТекущийТекстФайла);
	ПараметрыСравнения.Вставить("ОписаниеТекста2", НСтр("ru = 'Текущее значение в ветке'"));
	ПараметрыСравнения.Вставить("ТекстДляСравнения1", ТекстФайлаВВеткеПриемнике);
	ПараметрыСравнения.Вставить("ОписаниеТекста1", НСтр("ru = 'Значение в ветке приемнике'"));
	ПараметрыСравнения.Вставить("ИмяФайлаРепозитория", ИмяФайла);
	ТестированиеКлиент.ПоказатьОкноСравнениеТекста(ПараметрыСравнения);
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьСравнениеФайлаССостояниемКоммитаСогласования(ДанныеФайла)
	ИмяФайла = ДанныеФайла.ИмяФайла;
	ТекущийТекстФайла = ТекущийТекстФайлаСервер(ВеткаОтбор, ИмяФайла);
	ТекстФайлаНаКоммит = ТекстФайлаНаКоммит(ВеткаОтбор, ДанныеФайла.КоммитСогласования, ИмяФайла);
	
	ПараметрыСравнения = Новый Структура;
	ПараметрыСравнения.Вставить("ТекстДляСравнения2", ТекущийТекстФайла);
	ПараметрыСравнения.Вставить("ОписаниеТекста2", НСтр("ru = 'Текущее значение в ветке'"));
	ПараметрыСравнения.Вставить("ТекстДляСравнения1", ТекстФайлаНаКоммит);
	ПараметрыСравнения.Вставить("ОписаниеТекста1", НСтр("ru = 'Значение на момент согласования'"));
	ПараметрыСравнения.Вставить("ИмяФайлаРепозитория", ИмяФайла);
	ТестированиеКлиент.ПоказатьОкноСравнениеТекста(ПараметрыСравнения);
КонецПроцедуры

&НаКлиенте
Процедура НазначитьСогласующегоЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если ТипЗнч(Результат) = Тип("СправочникСсылка.Пользователи") Тогда
		НазначитьСогласующегоСервер(ДополнительныеПараметры.КлючиЗаписей, Результат);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура НазначитьСогласующегоОтветственногоЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если ТипЗнч(Результат) = Тип("Структура") Тогда
		НазначитьСогласующегоОтветственногоСервер(ДополнительныеПараметры.КлючиЗаписей, Результат);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура НазначитьСогласующегоОтветственногоСервер(КлючиЗаписей, НазначаемыеПОльзователи)
	
	Для Каждого КлючЗаписи из КлючиЗаписей Цикл
		
		Попытка
			
			Если ЗначениеЗаполнено(КлючЗаписи.ОбъектМетаданных) Тогда
				
				Если ЗначениеЗаполнено(НазначаемыеПОльзователи.СогласующийПоУмолчанию)
					ИЛИ ЗначениеЗаполнено(НазначаемыеПОльзователи.Ответственный) Тогда
					
					ОбъектМетаданныхДляИзменения = КлючЗаписи.ОбъектМетаданных.ПолучитьОбъект();
					ОбъектМетаданныхДляИзменения.Заблокировать();
					
					Если ЗначениеЗаполнено(НазначаемыеПОльзователи.СогласующийПоУмолчанию) Тогда
						ОбъектМетаданныхДляИзменения.СогласующийИзменения = НазначаемыеПОльзователи.СогласующийПоУмолчанию;
					КонецЕсли;
					
					Если ЗначениеЗаполнено(НазначаемыеПОльзователи.Ответственный) Тогда
						ОбъектМетаданныхДляИзменения.Ответственный = НазначаемыеПОльзователи.Ответственный;
					КонецЕсли;
					
					ОбъектМетаданныхДляИзменения.Записать();
					ОбъектМетаданныхДляИзменения.Разблокировать();
				
				КонецЕсли;
				
			КонецЕсли;
			
		Исключение
			ТекстСообщения = НСтр("ru='Назначение для объекта метаданных %ОбъектМетаданных% не выполнено");
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%ОбъектМетаданных%", КлючЗаписи.ОбъектМетаданных);
			ТекстСообщения = ТекстСообщения + ОписаниеОшибки();
			
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
			Продолжить;
		КонецПопытки;
		
	КонецЦикла;
	
	Элементы.Список.Обновить();
	
КонецПроцедуры

&НаСервере
Процедура НазначитьСогласующегоСервер(КлючиЗаписей, Пользователь)
	
	Для Каждого КлючЗаписи из КлючиЗаписей Цикл
		
		Попытка
			МенеджерЗаписи = РегистрыСведений.ИзмененияВВетках.СоздатьМенеджерЗаписи();
			ЗаполнитьЗначенияСвойств(МенеджерЗаписи, КлючЗаписи);
			МенеджерЗаписи.Прочитать();
			МенеджерЗаписи.Согласующий = Пользователь;
			МенеджерЗаписи.Записать();
		Исключение
			ТекстСообщения = НСтр("ru='Изменения не записаны (Ветка %Ветка%', Объект метаданных %ОбъектМетаданных%, Подчиненный объект %ПодчиненныйОбъект%");
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Ветка%", КлючЗаписи.Ветка);
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%ОбъектМетаданных%", КлючЗаписи.ОбъектМетаданных);
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%ПодчиненныйОбъект%", КлючЗаписи.ПодчиненныйОбъект);
			ТекстСообщения = ТекстСообщения + ОписаниеОшибки();
			
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения);
			Возврат;
		КонецПопытки;
		
	КонецЦикла;
	
	Элементы.Список.Обновить();
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ДанныеИзЗаписиРС(Знач КлючЗаписи)
	
	Запись = РегистрыСведений.ИзмененияВВетках.СоздатьМенеджерЗаписи();
	ЗаполнитьЗначенияСвойств(Запись, КлючЗаписи);
	Запись.Прочитать();
	
	Результат = Новый Структура;
	Результат.Вставить("ОбъектМетаданных", КлючЗаписи.ОбъектМетаданных);
	Результат.Вставить("ПодчиненныйОбъект", КлючЗаписи.ПодчиненныйОбъект);
	Результат.Вставить("ПодробноеОписаниеИзменений", Запись.ПодробноеОписаниеИзменений);
	
	Возврат Результат;
	
КонецФункции

&НаСервере
Процедура УстановитьОтборПоСогласующемуТекущемуПользователю()

	Согласующий = Пользователи.ТекущийПользователь();
	УстановитьОтборПоСогласующему();
	
КонецПроцедуры

#КонецОбласти