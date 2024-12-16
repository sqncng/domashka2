﻿#Область ОбработчикиСобытийФормы

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	Если ИмяСобытия = "ЗавершеноРедактированиеМакетаНастройкиТеста" Тогда
		ОбновитьМакетВСтрокеТЧ(Параметр.ИмяТЧ,Параметр.Макет,Параметр.ИсходныйНомерСтроки);
	КонецЕсли;	 
	
	// СтандартныеПодсистемы.Свойства 
	Если УправлениеСвойствамиКлиент.ОбрабатыватьОповещения(ЭтотОбъект, ИмяСобытия, Параметр) Тогда
		ОбновитьЭлементыДополнительныхРеквизитов();
		УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	СоздатьСлужебныеКолонкиДляТЧИЗаполнитьАдресДанных("ДоТеста",ТекущийОбъект);
	СоздатьСлужебныеКолонкиДляТЧИЗаполнитьАдресДанных("ПроверкаТеста",ТекущийОбъект);
	СоздатьСлужебныеКолонкиДляТЧИЗаполнитьАдресДанных("ПослеТеста",ТекущийОбъект);
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПриЧтенииНаСервере(ЭтаФорма, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПередЗаписьюНаСервере(ЭтаФорма, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
	ОбработатьЗаписьХранилищаЗначенийТЧ(ТекущийОбъект,"ДоТеста");
	ОбработатьЗаписьХранилищаЗначенийТЧ(ТекущийОбъект,"ПроверкаТеста");
	ОбработатьЗаписьХранилищаЗначенийТЧ(ТекущийОбъект,"ПослеТеста");
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
    // СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом 

КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	// СтандартныеПодсистемы.Свойства
	ЭталоннаяБаза = Объект.Владелец;
	ПроектНастройки = ЭталоннаяБаза.Владелец;
	Если Параметры.Свойство("ЗначениеОтбораПоСценарию") Тогда
		Объект.Сценарий = Параметры.ЗначениеОтбораПоСценарию;
	КонецЕсли;	 
	
	Если НЕ ЗначениеЗаполнено(ПроектНастройки) Тогда
		ПроектНастройки = ПроектПоСценарию(Объект.Сценарий);
	КонецЕсли;	 
	
	ТекущийПроект = ПроектНастройки;
	СвойстваПроекта = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(ПроектНастройки,
		"НаборСвойствДляНастроекЗапускаСценариевВыгружаемый,НаборСвойствДляНастроекЗапускаСценариевНеВыгружаемый");
	
	ГруппыДляРазмещения = Новый СписокЗначений;
	ГруппыДляРазмещения.Добавить(СвойстваПроекта.НаборСвойствДляНастроекЗапускаСценариевВыгружаемый,
		Элементы.ГруппаВыгружаемые.Имя);
	ГруппыДляРазмещения.Добавить(СвойстваПроекта.НаборСвойствДляНастроекЗапускаСценариевНеВыгружаемый,
		Элементы.ГруппаНевыгружаемые.Имя);
	ГруппыДляРазмещения.Добавить("ВсеОстальные", Элементы.ГруппаОбщие.Имя);
	
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ИмяЭлементаДляРазмещения", ГруппыДляРазмещения);
	УправлениеСвойствами.ПриСозданииНаСервере(ЭтотОбъект, ДополнительныеПараметры);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.Свойства
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ОбработкаПроверкиЗаполнения(ЭтаФорма, Отказ, ПроверяемыеРеквизиты);
	// Конец СтандартныеПодсистемы.Свойства
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыПараметрыТеста

&НаКлиенте
Процедура ПараметрыТестаЗначениеПриИзменении(Элемент)
	ЗначенияПараметров = СокрЛП(Элемент.ТекстРедактирования);
	Если Не ЗначениеЗаполнено(ЗначенияПараметров) Тогда
		Возврат;
	КонецЕсли;	
	
	ЗначенияПараметров = СтрЗаменить(ЗначенияПараметров,"\;","~ПредставлениеТочкиСЗапятой~");
	
	МассивЗначений = СтрРазделить(ЗначенияПараметров,";");
	Если МассивЗначений.Количество() <= 1 Тогда
		Элементы.ПараметрыТеста.ТекущиеДанные.НесколькоЗначений = Ложь;
	Иначе	
		Элементы.ПараметрыТеста.ТекущиеДанные.НесколькоЗначений = Истина;
	КонецЕсли;	 
	
КонецПроцедуры

&НаКлиенте
Процедура ПараметрыТестаПередНачаломИзменения(Элемент, Отказ)
	ТекущиеДанные = Элементы.ПараметрыТеста.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;	
	
	Если ТекущиеДанные.ТипПараметра = ПредопределенноеЗначение("Перечисление.ТипПараметраСценарияИлиПроцесса.Таблица") Тогда
		ПараметрыФормы = Новый Структура("ЗначениеТаблицы", ТекущиеДанные.Значение);
		ОткрытьФорму("Справочник.СценарииРаботыПользователей.Форма.ФормаУстановкиЗначенияТаблицы", ПараметрыФормы,Элементы.ПараметрыТеста,УникальныйИдентификатор);	
		Отказ = Истина;
		Возврат;
	КонецЕсли;	 
КонецПроцедуры

&НаКлиенте
Процедура ПараметрыТестаОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	Если ТипЗнч(ВыбранноеЗначение) = Тип("Структура") Тогда
		Если ВыбранноеЗначение.Свойство("ЗначениеТаблицы") Тогда
			Элементы.ПараметрыТеста.ТекущиеДанные.Значение = ВыбранноеЗначение.ЗначениеТаблицы;
		КонецЕсли;	 
	КонецЕсли;	 
КонецПроцедуры

&НаКлиенте
Процедура СценарийПриИзменении(Элемент)
	ТекущийПроект = ПроектПоСценарию(Объект.Сценарий);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыДоТеста

&НаКлиенте
Процедура СекцияДоТестаВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	ОбработкаВыбораТЧ(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка,"ДоТеста");
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыПроверкаТеста

&НаКлиенте
Процедура ПроверкаТестаВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	ОбработкаВыбораТЧ(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка,"ПроверкаТеста");
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыПослеТеста

&НаКлиенте
Процедура ПослеТестаВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	ОбработкаВыбораТЧ(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка,"ПослеТеста");
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

// СтандартныеПодсистемы.Свойства
&НаКлиенте
Процедура Подключаемый_СвойстваВыполнитьКоманду(ЭлементИлиКоманда, НавигационнаяСсылка = Неопределено, СтандартнаяОбработка = Неопределено)
	
	УправлениеСвойствамиКлиент.ВыполнитьКоманду(ЭтотОбъект, ЭлементИлиКоманда, СтандартнаяОбработка);
	
КонецПроцедуры
// Конец СтандартныеПодсистемы.Свойства

&НаКлиенте
Процедура ВыполнитьСценарииВМоейБазеДанных(Команда)
	ПараметрыЗапускаТестов = ПодготовитьПараметрыДляРаботыСЭталоннойБазой();
	
	Если ПараметрыЗапускаТестов = Неопределено Тогда
		ВызватьИсключение НСтр("ru = 'Не определены параметры для запуска сценариев в БД.'")
	КонецЕсли;	 
	
	Если НЕ ПроверитьСуществованиеПути(ПараметрыЗапускаТестов.КаталогДляДанныхТестирования) Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Не задана настройка ""КаталогДляДанныхТестирования""'"));
		Возврат;
	КонецЕсли;	 
	
	Если Прав(ПараметрыЗапускаТестов.КаталогДляДанныхТестирования,1) = "\"
			ИЛИ Прав(ПараметрыЗапускаТестов.КаталогДляДанныхТестирования,1) = "/" Тогда
		ПараметрыЗапускаТестов.КаталогДляДанныхТестирования = Лев(ПараметрыЗапускаТестов.КаталогДляДанныхТестирования,
		   СтрДлина(ПараметрыЗапускаТестов.КаталогДляДанныхТестирования)-1);
	КонецЕсли;	 
	
	ОчиститьКаталогКлиент(ПараметрыЗапускаТестов.КаталогДляДанныхТестирования);
	
	СоздатьКаталог(ПараметрыЗапускаТестов.КаталогДляДанныхТестирования + "\Fixtures");
	СоздатьКаталог(ПараметрыЗапускаТестов.КаталогДляДанныхТестирования + "\Features");
	СоздатьКаталог(ПараметрыЗапускаТестов.КаталогДляДанныхТестирования + "\Reports");
	СоздатьКаталог(ПараметрыЗапускаТестов.КаталогДляДанныхТестирования + "\ScreenShots");
	
	ОбъектТекстыСценариев = ОбъектнуюМодельТекстыСценариевСервер();
	
	ТекстСценария = ПолучитьТекстыСценариевСервер(ОбъектТекстыСценариев);
	ФД            = Новый ФорматированныйДокумент;
	ТекстФорматированныйТекстСценарияИзОбычногоТекстаСервер(ТекстСценария,ФД);
	
	ТекстовыйДокумент = Новый ТекстовыйДокумент;
	ТекстовыйДокумент.ДобавитьСтроку(ОбычныйТекстСценарияИзФорматированногоДокументаСервер(ФД));
	ТекстовыйДокумент.Записать(ПараметрыЗапускаТестов.КаталогДляДанныхТестирования + "\Features\Test.feature","UTF-8");
	
	
	МассивFixtures = ПолучитьМассивFixtures();
	Для Каждого Элемент Из МассивFixtures Цикл
		Элемент.Макет.Записать(ПараметрыЗапускаТестов.КаталогДляДанныхТестирования
		    + "\Fixtures\" + Элемент.Имя + ".mxl",ТипФайлаТабличногоДокумента.MXL);
	КонецЦикла;	
	
	СтрокаПодключенияКБазе = ПолучитьСтрокуПодключенияКБазе(ПараметрыЗапускаТестов);
	ЗаписатьТекстJsonСНастройкамиДляЗапускаФреймворка(ПараметрыЗапускаТестов.КаталогДляДанныхТестирования
	+ "\Params.json",ПараметрыЗапускаТестов,СтрокаПодключенияКБазе);
	
	Команда = """" + ОбщегоНазначенияКлиентСервер.ДобавитьКонечныйРазделительПути(
	         ПараметрыЗапускаТестов.КаталогИсполняемогоФайла) + "1cv8c"" /TestManager "
			 + СтрокаПодключенияКБазе + " /Execute " + ПолучитьФреймворкДляЗапускаТестов()
			 + " /C""StartFeaturePlayer;SPPR;DisableUserSettingsLoader;VBParams="
			 + ПараметрыЗапускаТестов.КаталогДляДанныхТестирования + "\Params.json" +"""";
			 
	ОбщегоНазначенияКлиентСервер.СообщитьПользователю(Команда);
	ЗапуститьПриложение(Команда);
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьОтчетОКачестве(Команда)
	ПараметрыЗапускаТестов = ПодготовитьПараметрыДляРаботыСЭталоннойБазой();
	
	Если ПараметрыЗапускаТестов = Неопределено Тогда
		ВызватьИсключение НСтр("ru = 'Не определены параметры для запуска сценариев в БД.'");
	КонецЕсли;	 
	
	#Если НЕ ВебКлиент Тогда
		КомандаСистемы("allure generate """
		+ ПараметрыЗапускаТестов.КаталогДляДанныхТестирования + "\Reports\allurereport""");
		КомандаСистемы("allure report open");
	#КонецЕсли
КонецПроцедуры

&НаКлиенте
Процедура ТекстыСценариев(Команда)
	ОбъектТекстыСценариев = ОбъектнуюМодельТекстыСценариевСервер();
	ОбъектТекстыСценариев.Вставить("НастройкаСценария",Объект.Ссылка);
	ТекстСценария = ПолучитьТекстыСценариевСервер(ОбъектТекстыСценариев);
	
	ПараметрыСценария = Новый Структура;
	ПараметрыСценария.Вставить("ТекстСценария",ТекстСценария);
	ПараметрыСценария.Вставить("Проект",ПроектПоЭталоннойБазе(Объект.Владелец));
	ПараметрыСценария.Вставить("Сценарий",Объект.Сценарий);
	ПараметрыСценария.Вставить("НастройкаСценария",Объект.Ссылка);
	
	ОткрытьФорму("Справочник.НастройкиЗапускаСценариев.Форма.Сценарии",ПараметрыСценария,,Истина);
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьБазуТестированияИзЭталона(Команда)
	ПараметрыБазыЭталона = ПодготовитьПараметрыДляРаботыСЭталоннойБазой();
	ТестированиеКлиент.СоздатьЛокальнуюБазуДанныхИзЭталона(ПараметрыБазыЭталона);
КонецПроцедуры

&НаКлиенте
Процедура ПерезаполнитьПараметрыТеста(Команда)
	ПерезаполнитьПараметрыТестаСервер();
	Модифицированность = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьДанныеИзСценария(Команда)
	ЗагрузитьДанныеИзСценарияНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура СтатусВыполенния(Команда)
	ДанныеОтбор = Новый Структура;
	ДанныеОтбор.Вставить("НастройкаЗапускаСценария",Объект.Ссылка);
	
	ПараметрыФормы = Новый Структура("КлючВарианта, Отбор, ВидимостьКомандВариантовОтчетов, СформироватьПриОткрытии", 
		"СтатусПрохожденияТестовВВетке",
		ДанныеОтбор, 
		Истина,
		Истина);
		
	ОткрытьФорму(
		"Отчет.СтатусПрохожденияТестовВВетке.Форма",
		ПараметрыФормы, ,
		Истина);
КонецПроцедуры


#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// СтандартныеПодсистемы.Свойства

&НаСервере
Процедура ОбновитьЭлементыДополнительныхРеквизитов()
	УправлениеСвойствами.ОбновитьЭлементыДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьЗависимостиДополнительныхРеквизитов()
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПриИзмененииДополнительногоРеквизита(Элемент)
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

// Конец СтандартныеПодсистемы.Свойства

&НаСервере
Функция ПолучитьПараметрыПроцесса(Процесс)
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	СценарииПараметрыВходящие.Имя КАК Имя,
		|	СценарииПараметрыВходящие.Значение КАК Значение,
		|	СценарииПараметрыВходящие.ФО КАК ФО,
		|	СценарииПараметрыВходящие.НомерСтроки КАК НомерСтроки,
		|	СценарииПараметрыВходящие.ТипПараметра КАК ТипПараметра
		|ИЗ
		|	Справочник.СценарииРаботыПользователей.ПараметрыВходящие КАК СценарииПараметрыВходящие
		|ГДЕ
		|	СценарииПараметрыВходящие.Ссылка = &Ссылка
		|
		|УПОРЯДОЧИТЬ ПО
		|	НомерСтроки";
	
	Запрос.УстановитьПараметр("Ссылка",Процесс);
	
	Возврат Запрос.Выполнить().Выгрузить();
КонецФункции	

&НаСервере
Процедура ОбновитьПараметрыТеста(ТекущиеПараметрыТеста,ПараметрыПроцесса)
	Для Каждого ПараметрПроцесса Из ПараметрыПроцесса Цикл
		СтрокаТекущиеПараметрыТеста = ТекущиеПараметрыТеста.Найти(ПараметрПроцесса.Имя,"Имя");
		Если СтрокаТекущиеПараметрыТеста <> Неопределено Тогда
			Продолжить;
		КонецЕсли;	 
		
		СтрокаТекущиеПараметрыТеста = ТекущиеПараметрыТеста.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаТекущиеПараметрыТеста,ПараметрПроцесса);
	КонецЦикла;	
КонецПроцедуры

&НаСервере
Процедура ЗагрузитьДанныеИзСценарияНаСервере()
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	
	Процесс = ОбъектСервер.Сценарий;
	
	ПараметрыПроцесса           = ПолучитьПараметрыПроцесса(Процесс);
	
	ТекущиеПараметрыТеста = ОбъектСервер.ПараметрыТеста.Выгрузить();
	ОбновитьПараметрыТеста(ТекущиеПараметрыТеста,ПараметрыПроцесса);
	
	ОбъектСервер.ПараметрыТеста.Загрузить(ТекущиеПараметрыТеста);
	
	ЗначениеВРеквизитФормы(ОбъектСервер,"Объект");
КонецПроцедуры

&НаСервере
Процедура СоздатьСлужебныеКолонкиДляТЧИЗаполнитьАдресДанных(ИмяТЧ,ТекущийОбъект)
   нРеквизиты = Новый Массив;
   нРеквизиты.Добавить(Новый РеквизитФормы(ИмяТЧ + "Макет",
             Новый ОписаниеТипов("Строка"), "Объект." + ИмяТЧ, "Макет", Истина));
   ИзменитьРеквизиты(нРеквизиты);
 
   нЭлемент = Элементы.Добавить(ИмяТЧ + "Макет", Тип("ПолеФормы"), Элементы[ИмяТЧ]); 
   нЭлемент.Вид = ВидПоляФормы.ПолеВвода; 
   нЭлемент.ПутьКДанным = "Объект." + ИмяТЧ + "." + ИмяТЧ + "Макет"; 
   нЭлемент.ТолькоПросмотр = Истина;
   
   
   НомерСтроки = 0;
   Для Каждого СтрокаТЧ Из ТекущийОбъект[ИмяТЧ] Цикл
	   НомерСтроки = НомерСтроки + 1;
	   Данные = СтрокаТЧ.Данные.Получить();
	   Если Данные = Неопределено Тогда
		   Продолжить;
	   КонецЕсли;	 
	   
	   СтрокаТЧ.АдресДанных = ПоместитьВоВременноеХранилище(Данные,УникальныйИдентификатор);
   КонецЦикла;	

   
   ЗначениеВРеквизитФормы(ТекущийОбъект,"Объект");
   
КонецПроцедуры

&НаСервере
Функция ПодготовитьПараметрыДляРаботыСЭталоннойБазой()
	Возврат Тестирование.ПодготовитьПараметрыДляСозданияБазыИзФайлаВыгрузки(Объект.Владелец);
КонецФункции	

&НаКлиенте
Процедура СекцияКонтекстТипШагаПриИзменении(Элемент)
	ТекущиеДанные = Элементы.ДоТеста.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;	
	
	Если ТекущиеДанные.ТипШага = ПредопределенноеЗначение("Перечисление.ТипШагаСценария.СозданиеДанных") Тогда
		ТекущиеДанные.Шаг = "И я создаю данные из макета данных ""Макет""";
		Если ЗначениеЗаполнено(ТекущиеДанные.ИмяМакета) Тогда
			ТекущиеДанные.Шаг = СтрЗаменить(
			    "И я создаю данные из макета данных ""Макет""","""Макет""","""" + ТекущиеДанные.ИмяМакета + """");
		КонецЕсли;	 
	КонецЕсли;	 
КонецПроцедуры

&НаКлиенте
Процедура СекцияКонтекстИмяПараметраПриИзменении(Элемент)
	ТекущиеДанные = Элементы.ДоТеста.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;	
	
	Если ЗначениеЗаполнено(ТекущиеДанные.ИмяМакета) Тогда
		Если ТекущиеДанные.ТипШага = ПредопределенноеЗначение("Перечисление.ТипШагаСценария.СозданиеДанных") Тогда
			ТекущиеДанные.Шаг = СтрЗаменить(
			  "И я создаю данные из макета данных ""Макет""","""Макет""","""" + ТекущиеДанные.ИмяМакета + """");
		КонецЕсли;	 
	КонецЕсли;	 
КонецПроцедуры

&НаКлиенте
Функция ПолучитьМакетИзТЧ(ИмяТЧ,СтрокаТЧ)
	Если Не ЗначениеЗаполнено(СтрокаТЧ.АдресДанных) Тогда
		Возврат Новый ТабличныйДокумент;
	КонецЕсли;	 
	
	Макет = ПолучитьИзВременногоХранилища(СтрокаТЧ.АдресДанных);
	Возврат Макет;
КонецФункции	

&НаКлиенте
Процедура ОбработкаВыбораТЧ(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка,ИмяТЧ)
	Если Поле.Имя <> (ИмяТЧ + "Макет") Тогда
		Возврат;
	КонецЕсли;	 
	
	ТекущиеДанные = Элементы[ИмяТЧ].ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;	
	
	Макет = ПолучитьМакетИзТЧ(ИмяТЧ,ТекущиеДанные);
	
	ПараметрыСценария            = Новый Структура("Макет",Макет);
	ПараметрыСценария.Вставить("ИсходныйНомерСтроки",ТекущиеДанные.ИсходныйНомерСтроки);
	ПараметрыСценария.Вставить("ИмяТЧ",ИмяТЧ);
	
	ОткрытьФорму("Справочник.НастройкиЗапускаСценариев.Форма.РедактированиеМакета",ПараметрыСценария);
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьМакетВСтрокеТЧ(ИмяТЧ,Макет,ИсходныйНомерСтроки)
	СтрокаТЧ             = Элементы[ИмяТЧ].ТекущиеДанные;
	СтрокаТЧ.АдресДанных = ПоместитьВоВременноеХранилище(Макет,УникальныйИдентификатор);
КонецПроцедуры

&НаСервере
Процедура ОбработатьЗаписьХранилищаЗначенийТЧ(ТекущийОбъект,ИмяТЧ)
	НомерСтроки = 0;
	Для Каждого СтрокаТЧ Из ТекущийОбъект[ИмяТЧ] Цикл
		НомерСтроки = НомерСтроки + 1;
		
		АдресДанных = СтрокаТЧ.АдресДанных;
		Если Не ЗначениеЗаполнено(АдресДанных) Тогда
			Продолжить;
		КонецЕсли;	 
		
		СтрокаТЧ.Данные = Новый ХранилищеЗначения(ПолучитьИзВременногоХранилища(АдресДанных));
		
	КонецЦикла;	
КонецПроцедуры

&НаСервере
Функция ОбъектнуюМодельТекстыСценариевСервер()
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("ТаблицаПараметров",
		Тестирование.ПараметрыЗапускаНастройкиСценарияТестирования(ОбъектСервер.ПараметрыТеста.Выгрузить(),ОбъектСервер.Сценарий));
	СтруктураПараметров.Вставить("ДоТеста",ОбъектСервер.ДоТеста.Выгрузить());
	СтруктураПараметров.Вставить("ПроверкаТеста",ОбъектСервер.ПроверкаТеста.Выгрузить());
	СтруктураПараметров.Вставить("ПослеТеста",ОбъектСервер.ПослеТеста.Выгрузить());
	СтруктураПараметров.Вставить("ДеревоСхемы",Неопределено);
	СтруктураПараметров.Вставить("ИсключитьСлужебныеСловаИзТекстаСценария",Ложь);
	СтруктураПараметров.Вставить("НастройкаСценария",Объект.Ссылка);
	
	Возврат ТестированиеГрафическиеСхемыСервер.ТекстыСценариев(ОбъектСервер.Сценарий,СтруктураПараметров);
КонецФункции	

&НаСервере
Функция ПолучитьТекстыСценариевСервер(ОбъектТекстыСценариев)
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	
	ПараметрыСценария = Новый Структура;
	ПараметрыСценария.Вставить("ОбъектТекстыСценариев",ОбъектТекстыСценариев);
	ПараметрыСценария.Вставить("Процесс",ОбъектСервер.Сценарий);
	ПараметрыСценария.Вставить("ШагиДоТеста",ОбъектСервер.ДоТеста.ВыгрузитьКолонку("Шаг"));
	ПараметрыСценария.Вставить("ШагиПроверка",ОбъектСервер.ПроверкаТеста.ВыгрузитьКолонку("Шаг"));
	ПараметрыСценария.Вставить("ШагиПослеТеста",ОбъектСервер.ПослеТеста.ВыгрузитьКолонку("Шаг"));
	ПараметрыСценария.Вставить("БазаДанных",ОбъектСервер.Владелец);
	ПараметрыСценария.Вставить("ИсключитьСлужебныеСловаИзТекстаСценария",Ложь);
	ПараметрыСценария.Вставить("ЧтениеИзТекста",Ложь);
	
	Возврат Тестирование.ТекстСценария(ПараметрыСценария);
КонецФункции	

&НаКлиенте
Процедура ОчиститьКаталогКлиент(Путь)
	Файлы = НайтиФайлы(Путь,"*",Ложь);
	Для Каждого Элем Из Файлы Цикл
		УдалитьФайлы(Элем.ПолноеИмя);
	КонецЦикла;	
КонецПроцедуры

&НаСервере
Процедура ДобавитьМакетыИзТЧВМассив(Массив,ТЧ)
	Для Каждого СтрокаТЧ Из ТЧ Цикл
		Если НЕ ЗначениеЗаполнено(СтрокаТЧ.АдресДанных) Тогда
			Продолжить;
		КонецЕсли;	 
		
		Макет = ПолучитьИзВременногоХранилища(СтрокаТЧ.АдресДанных);
		Массив.Добавить(Новый Структура("Макет,Имя",Макет,СтрокаТЧ.ИмяМакета));
	КонецЦикла;	
КонецПроцедуры

&НаСервере
Функция ПолучитьМассивFixtures()
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	Массив = Новый Массив;
	ДобавитьМакетыИзТЧВМассив(Массив,ОбъектСервер.ДоТеста);
	ДобавитьМакетыИзТЧВМассив(Массив,ОбъектСервер.ПроверкаТеста);
	ДобавитьМакетыИзТЧВМассив(Массив,ОбъектСервер.ПослеТеста);
	
	Возврат Массив;
КонецФункции	

&НаКлиенте
Процедура ДобавитьКлючЗначениеВJson(ЗаписьJSON,Ключ,Значение)
	ЗаписьJSON.ЗаписатьИмяСвойства(Ключ);
	ЗаписьJSON.ЗаписатьЗначение(Значение);
КонецПроцедуры

&НаКлиенте
Функция ПолучитьСтрокуПодключенияКБазе(ПараметрыЗапускаТестов)
	Стр = "ENTERPRISE";
	Если ПараметрыЗапускаТестов.ТипБазыПоУмолчанию = ПредопределенноеЗначение("Перечисление.ТипБазы.Файловый") Тогда
		Стр = Стр + " /F""" + ПараметрыЗапускаТестов.КаталогБазы + """";
	КонецЕсли;	 
	
	Если ЗначениеЗаполнено(ПараметрыЗапускаТестов.Пользователь) Тогда
		Стр = Стр + " /N""" + ПараметрыЗапускаТестов.Пользователь + """";
	КонецЕсли;	 
	Если ЗначениеЗаполнено(ПараметрыЗапускаТестов.Пароль) Тогда
		Стр = Стр + " /P""" + ПараметрыЗапускаТестов.Пароль + """";
	КонецЕсли;	 
	
	Возврат Стр;
КонецФункции	

&НаСервереБезКонтекста
Функция ПолучитьКаталогБиблиотекТестов()
	Путь = Тестирование.РепозиторийТестов();
	Слеш = ПолучитьРазделительПутиКлиента();
	Если Прав(Путь,1) <> Слеш Тогда
		Путь = Путь + Слеш;
	КонецЕсли;	 
	Возврат Путь + "features/Libraries";
КонецФункции	

&НаСервереБезКонтекста
Функция ПолучитьФреймворкДляЗапускаТестов()
	Возврат Тестирование.ФреймворкДляЗапускаТестов();
КонецФункции	

&НаКлиенте
Процедура ЗаписатьТекстJsonСНастройкамиДляЗапускаФреймворка(ИмяФайла,ПараметрыЗапускаТестов,СтрокаПодключенияКБазе)
	ЗаписьJSON = Новый ЗаписьJSON;
	ЗаписьJson.ОткрытьФайл(ИмяФайла,,Ложь,Новый ПараметрыЗаписиJSON(,Символы.Таб));
	
	ЗаписьJson.ЗаписатьНачалоОбъекта();
	
	ДобавитьКлючЗначениеВJson(ЗаписьJSON,"ИмяСборки","Тест");
	ДобавитьКлючЗначениеВJson(ЗаписьJSON,"КаталогИсполняемогоФайла",ПараметрыЗапускаТестов.КаталогИсполняемогоФайла);
	ДобавитьКлючЗначениеВJson(ЗаписьJSON,"ВыводитьСообщенияВФайл",
	            ПараметрыЗапускаТестов.КаталогДляДанныхТестирования + "\PlatformLog.txt");
	ДобавитьКлючЗначениеВJson(ЗаписьJSON,"КаталогПоискаВерсииПлатформы","C:\Program Files (x86)\1cv8");
	ДобавитьКлючЗначениеВJson(ЗаписьJSON,"СтрокаПодключенияКБазе",СтрокаПодключенияКБазе);
	ДобавитьКлючЗначениеВJson(ЗаписьJSON,"КаталогФич",ПараметрыЗапускаТестов.КаталогДляДанныхТестирования + "\Features");
	
	ФреймворкДляЗапускаТестов = ПолучитьФреймворкДляЗапускаТестов();
	Если Не ЗначениеЗаполнено(ФреймворкДляЗапускаТестов) Тогда
		ВызватьИсключение НСтр("ru = 'Не заполнена настройка ""ФреймворкДляЗапускаТестов"".'")
	КонецЕсли;	 
	
	ДобавитьКлючЗначениеВJson(ЗаписьJSON,"ФреймворкДляЗапускаТестов",ФреймворкДляЗапускаТестов);
	
	
	ФайлФреймворкДляЗапускаТестов = Новый Файл(ФреймворкДляЗапускаТестов);
	
	
	ЗаписьJSON.ЗаписатьИмяСвойства("КаталогиБиблиотек");
	ЗаписьJSON.ЗаписатьНачалоМассива();
	ЗаписьJSON.ЗаписатьЗначение(ФайлФреймворкДляЗапускаТестов.Путь + "features\Libraries");
	
	КаталогБиблиотекТестов = ПолучитьКаталогБиблиотекТестов();
	Если ЗначениеЗаполнено(КаталогБиблиотекТестов) Тогда
		ЗаписьJSON.ЗаписатьЗначение(КаталогБиблиотекТестов);
	КонецЕсли;	 
	ЗаписьJSON.ЗаписатьКонецМассива();
	
	
	
	ДобавитьКлючЗначениеВJson(ЗаписьJSON,"ВыполнитьСценарии","Истина");
	ДобавитьКлючЗначениеВJson(ЗаписьJSON,"ЗавершитьРаботуСистемы","Истина");
	ДобавитьКлючЗначениеВJson(ЗаписьJSON,"ЗакрытьTestClientПослеЗапускаСценариев","Истина");
	ДобавитьКлючЗначениеВJson(ЗаписьJSON,"ДелатьЛогВыполненияСценариевВЖР","Истина");
	ДобавитьКлючЗначениеВJson(ЗаписьJSON,"ДелатьОтчетВФорматеАллюр","Истина");
	ДобавитьКлючЗначениеВJson(ЗаписьJSON,"ДелатьОтчетВФорматеjUnit","Истина");
	ДобавитьКлючЗначениеВJson(ЗаписьJSON,"ДелатьОтчетВФорматеCucumberJson","Истина");
	ДобавитьКлючЗначениеВJson(ЗаписьJSON,"ДелатьЛогВыполненияСценариевВТекстовыйФайл","Истина");
	
	ДобавитьКлючЗначениеВJson(ЗаписьJSON,"КаталогВыгрузкиAllureБазовый",
	       ПараметрыЗапускаТестов.КаталогДляДанныхТестирования + "\Reports\allurereport");
	ДобавитьКлючЗначениеВJson(ЗаписьJSON,"КаталогВыгрузкиjUnit",
	       ПараметрыЗапускаТестов.КаталогДляДанныхТестирования + "\Reports\junitreport");
	ДобавитьКлючЗначениеВJson(ЗаписьJSON,"КаталогВыгрузкиCucumberJson",
	       ПараметрыЗапускаТестов.КаталогДляДанныхТестирования + "\Reports\cucumber");
	ДобавитьКлючЗначениеВJson(ЗаписьJSON,"СоздаватьПодкаталогВКаталогеAllureДляЭтойСборки","Истина");
	
	ДобавитьКлючЗначениеВJson(ЗаписьJSON,"ДелатьСкриншотПриВозникновенииОшибки","Истина");
	ДобавитьКлючЗначениеВJson(ЗаписьJSON,"КаталогВыгрузкиСкриншотов",
	       ПараметрыЗапускаТестов.КаталогДляДанныхТестирования + "\ScreenShots");
	ДобавитьКлючЗначениеВJson(ЗаписьJSON,"ИмяФайлаЛогВыполненияСценариев",
	       ПараметрыЗапускаТестов.КаталогДляДанныхТестирования + "\TestLog.txt");
	ДобавитьКлючЗначениеВJson(ЗаписьJSON,"КомандаСделатьСкриншот","""C:\Program Files (x86)\IrfanView\i_view32.exe"" /capture=1 /convert=");
	
	ДобавитьКлючЗначениеВJson(ЗаписьJSON,"ВыгружатьСтатусВыполненияСценариевВФайл","Истина");
	ДобавитьКлючЗначениеВJson(ЗаписьJSON,"ДобавлятьКИмениСценарияУловияВыгрузки","Истина");
	ДобавитьКлючЗначениеВJson(ЗаписьJSON,"ПутьКФайлуДляВыгрузкиСтатусаВыполненияСценариев",
	       ПараметрыЗапускаТестов.КаталогДляДанныхТестирования + "\BuildStatus.log");
	
	
	
	ЗаписьJSON.ЗаписатьИмяСвойства("СписокТеговИсключение");
	ЗаписьJSON.ЗаписатьНачалоМассива();
	ЗаписьJSON.ЗаписатьЗначение("IgnoreOnCIMainBuild");
	ЗаписьJSON.ЗаписатьКонецМассива();
	
	
	ЗаписьJson.ЗаписатьКонецОбъекта();
	
	ЗаписьJson.Закрыть();
КонецПроцедуры

&НаКлиенте
Функция ПроверитьСуществованиеПути(Путь)
	Файл = Новый Файл(Путь);
	Возврат Файл.Существует();
КонецФункции	

&НаСервере
Процедура ТекстФорматированныйТекстСценарияИзОбычногоТекстаСервер(ТекстСценария,ФД)
	ТестированиеГрафическиеСхемыСервер.ТекстФорматированныйТекстСценарияИзОбычногоТекста(ТекстСценария,ФД,Объект.Владелец);
КонецПроцедуры

&НаСервере
Функция ОбычныйТекстСценарияИзФорматированногоДокументаСервер(ФД)
	Возврат ТестированиеГрафическиеСхемыСервер.ОбычныйТекстСценарияИзФорматированногоДокумента(ФД);
КонецФункции	

&НаСервере
Процедура ПерезаполнитьПараметрыТестаСервер()
	ОбъектСервер      = РеквизитФормыВЗначение("Объект");
	ПараметрыПроцесса = ПолучитьПараметрыПроцесса(ОбъектСервер.Сценарий);
	ОбъектСервер.ПараметрыТеста.Очистить();
	
	ТекущиеПараметрыТеста = ОбъектСервер.ПараметрыТеста.Выгрузить();
	ОбновитьПараметрыТеста(ТекущиеПараметрыТеста,ПараметрыПроцесса);
	
	ОбъектСервер.ПараметрыТеста.Загрузить(ТекущиеПараметрыТеста);
	
	ЗначениеВРеквизитФормы(ОбъектСервер,"Объект");
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПроектПоЭталоннойБазе(ЭталоннаяБаза)
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ЭталонныеБазыТестирования.Владелец КАК Проект
		|ИЗ
		|	Справочник.ЭталонныеБазыТестирования КАК ЭталонныеБазыТестирования
		|ГДЕ
		|	ЭталонныеБазыТестирования.Ссылка = &Ссылка";
	
	Запрос.УстановитьПараметр("Ссылка", ЭталоннаяБаза);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Возврат ВыборкаДетальныеЗаписи.Проект; 
	КонецЦикла;
	
КонецФункции	 

&НаСервереБезКонтекста
Функция ПроектПоСценарию(Сценарий)
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	СценарииРаботыПользователей.Владелец КАК Проект
		|ИЗ
		|	Справочник.СценарииРаботыПользователей КАК СценарииРаботыПользователей
		|ГДЕ
		|	СценарииРаботыПользователей.Ссылка = &Ссылка";
	
	Запрос.УстановитьПараметр("Ссылка", Сценарий);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Возврат ВыборкаДетальныеЗаписи.Проект; 
	КонецЦикла;
	
	Возврат Справочники.Проекты.ПустаяСсылка(); 
	
КонецФункции	 

#КонецОбласти




