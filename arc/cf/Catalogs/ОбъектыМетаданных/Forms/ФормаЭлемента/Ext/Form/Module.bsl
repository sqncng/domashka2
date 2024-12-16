﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьУсловноеОформление();
	
	Если НЕ ЗначениеЗаполнено(Объект.Ссылка) Тогда
		
		СтрокаРеквизитов = "ЕстьСправочнаяИнформация,ЕстьОграниченияДоступа,ЕстьПрава,ЕстьДвиженияПоРегистру,ЕстьСсылкиИзОбъектовМетаданных";
		РеквизитыРодителя = Универсальные.ЗначенияРеквизитовСправочника(Объект.Родитель,СтрокаРеквизитов);
		ЗаполнитьЗначенияСвойств(ЭтаФорма, РеквизитыРодителя);
		
		ИмяКласса = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект.Родитель, "Имя");
		
		ЯвляетсяОснованием.Параметры.УстановитьЗначениеПараметра("Ссылка", Объект.Ссылка);
		
		СтрокаСтандартныхРеквизитов = Объект.Наименование + ".СтандартныеРеквизиты.Ссылка";
		
		Если Параметры.Свойство("СозданиеВыборРоли", СозданиеВыборРоли) Тогда
			
			ПрефиксИмениРоли = "";
			
			Если ТипЗнч(Параметры.ЗначенияЗаполнения.ПотребительРоли) = Тип("СправочникСсылка.Подсистемы") Тогда
				ПрефиксИмениРоли = "Просмотр";
			КонецЕсли;
			
			Если ЗначениеЗаполнено(ПрефиксИмениРоли) Тогда
				Объект.Имя = ПрефиксИмениРоли + Параметры.ЗначенияЗаполнения.ИмяПотребителяРоли;
			КонецЕсли;
			
		КонецЕсли;
		
		УстановитьВидимостьЭлементов();
		
	КонецЕсли;
	
	НастройкиСервер.УстановитьТекущуюСтраницу("Справочник.ОбъектыМетаданных.ФормаЭлемента", Элементы.ГруппаСтраницы, "ТекущаяСтраницаФормыОбъектаМетаданных");
	
	Если НЕ Элементы.ГруппаСтраницы.ТекущаяСтраница.Видимость Тогда
		Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.СтраницаОписание;
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(Объект.Ссылка) Тогда
		ПрочитатьПринадлежностьКПодсистемам();
		ПриСозданииЧтенииНаСервере();
	КонецЕсли;
	
	// СтандартныеПодсистемы.Свойства
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ИмяЭлементаДляРазмещения", "ГруппаДополнительныеРеквизиты");
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
Процедура ПриЧтенииНаСервере(ТекущийОбъект)

	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	СтрокаРеквизитов = "ЕстьСправочнаяИнформация,ЕстьОграниченияДоступа,ЕстьПрава,ЕстьДвиженияПоРегистру,ЕстьСсылкиИзОбъектовМетаданных";
	РеквизитыРодителя = Универсальные.ЗначенияРеквизитовСправочника(Объект.Родитель,СтрокаРеквизитов);
	ЗаполнитьЗначенияСвойств(ЭтаФорма, РеквизитыРодителя);
	
	ИмяКласса = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект.Родитель, "Имя");
	
	ЯвляетсяОснованием.Параметры.УстановитьЗначениеПараметра("Ссылка", Объект.Ссылка);
	
	СтрокаСтандартныхРеквизитов = Объект.Наименование + ".СтандартныеРеквизиты.Ссылка";
	
	УстановитьВидимостьЭлементов();
	ПрочитатьПринадлежностьКПодсистемам();
	
	ПриСозданииЧтенииНаСервере();
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПриЧтенииНаСервере(ЭтаФорма, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПередЗаписьюНаСервере(ЭтаФорма, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
	ТекущийОбъект.ДополнительныеСвойства.Вставить("ЗаписьВФорме", Истина);
	
КонецПроцедуры

&НаСервере
Процедура ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	ЗаписатьПринадлежностьКПодсистемам(Отказ, ТекущийОбъект);
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	// ЗадачиПроцессов
	ЗадачиПроцессов.ЗаписатьДанныеСогласующихРесурсыПредмета(ЭтотОбъект, Объект.Ссылка);
	// Конец ЗадачиПроцессов
	
	ЯвляетсяОснованием.Параметры.УстановитьЗначениеПараметра("Ссылка", ТекущийОбъект.Ссылка);
	УстановитьВидимостьЭлементов();
	НастроитьПанельНавигации();
	
	// Если элемент справочника является "расширенно" хранимым, то для него нужно создать
	// запись в подчиненном справочнике свойств.
	Отказ = Ложь;
	  
	Если РаботаСОбъектамиМетаданных.ЭтоЭлементРасширенногоХранения(ТекущийОбъект.Родитель) Тогда
		РаботаСОбъектамиМетаданных.СоздатьПодчиненныйЭлементСвойств(ТекущийОбъект.Ссылка, Отказ);
	КонецЕсли;
	
	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом

КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	Оповестить("Запись_ОбъектыМетаданных", ПараметрыЗаписи, Объект.Ссылка);
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	Если ЗавершениеРаботы Тогда
		Возврат;
	КонецЕсли;
	
	Если СозданиеВыборРоли И ЗначениеЗаполнено(Объект.Ссылка) Тогда
		СозданиеВыборРоли = Ложь; // сбросим значение, чтобы больше не выполнялся этот код
		Закрыть(Объект.Ссылка); // установим значение параметра РезультатДействия для обработчика ОписаниеОповещенияОЗакрытии
	КонецЕсли;
	
	СохранитьЗначения();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	// СтандартныеПодсистемы.Свойства 
	Если УправлениеСвойствамиКлиент.ОбрабатыватьОповещения(ЭтотОбъект, ИмяСобытия, Параметр) Тогда
		ОбновитьЭлементыДополнительныхРеквизитов();
		УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства
	
	Если ИмяСобытия = "ИзмененСтатусФункции" Тогда
		Элементы.РазделыПроекта.Обновить();
		Элементы.ФункцииОбъекта.Обновить();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ОбработкаПроверкиЗаполнения(ЭтаФорма, Отказ, ПроверяемыеРеквизиты);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ВладелецПриИзменении(Элемент)
	
	ПриИзмененииВладельцаСервер();
	
КонецПроцедуры

&НаКлиенте
Процедура ПоставщикПриИзменении(Элемент)
	
	УстановитьДоступностьПравилаПоддержки(ЭтаФорма);
	
	Если ЗначениеЗаполнено(Объект.Поставщик) И НЕ ЗначениеЗаполнено(Объект.ПравилоПоддержки) Тогда
		Объект.ПравилоПоддержки = ПредопределенноеЗначение("Перечисление.ПравилаПоддержки.НеРедактируется");
	Иначе
		Объект.ПравилоПоддержки = Неопределено;
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура СтоитНаПоддержкеПриИзменении(Элемент)
	
	Если НЕ СтоитНаПоддержке Тогда
		Объект.Поставщик = Неопределено;
		Объект.ПравилоПоддержки = Неопределено;
	КонецЕсли;
	
	УстановитьДоступностьПравилаПоддержки(ЭтаФорма);
	
КонецПроцедуры

// ЗадачиПроцессов

&НаКлиенте
Процедура Подключаемый_ОбработкаНавигационнойСсылкиСогласующиеРесурс(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	
	ЗадачиПроцессовКлиент.ОбработкаНавигационнойСсылкиСогласующиеРесурс(ЭтотОбъект,
	                                                                    Элемент,
	                                                                    НавигационнаяСсылкаФорматированнойСтроки,
	                                                                    СтандартнаяОбработка);
	
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ОбработатьИзменениеСогласующихРесурсыПоПредмету()
	
	ЗадачиПроцессов.ОбработатьИзменениеСогласующихРесурсыПоПредмету(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_СогласующийРесурсПриИзменении()

	ЗадачиПроцессовКлиент.ОтразитьИзменениеЕдинственногоСогласующегоРесурса(ЭтотОбъект);

КонецПроцедуры

// Конец ЗадачиПроцессов

#КонецОбласти

#Область ОбработчикиСобытийТаблицыВводитсяНаОсновании

&НаКлиенте
Процедура ВводитсяНаОснованииВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Если ВыбраннаяСтрока = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыФормы = Новый Структура("Ключ", Элементы.ВводитсяНаОсновании.ТекущиеДанные.ОбъектМетаданных);
	ОткрытьФорму("Справочник.ОбъектыМетаданных.ФормаОбъекта", ПараметрыФормы);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийТаблицыЯвляетсяОснованием

&НаКлиенте
Процедура ЯвляетсяОснованиемВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Если ВыбраннаяСтрока = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыФормы = Новый Структура("Ключ", Элементы.ЯвляетсяОснованием.ТекущиеДанные.ОбъектМетаданных);
	ОткрытьФорму("Справочник.ОбъектыМетаданных.ФормаОбъекта", ПараметрыФормы);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийТаблицыОписаниеДвиженийПоРегистру

&НаКлиенте
Процедура ОписаниеДвиженийПоРегиструПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
														
	Если НоваяСтрока И НЕ Копирование Тогда
		Если ИмяКласса = "РегистрыНакопления"
			И Объект.ВидРегистраНакопления = ПредопределенноеЗначение("Перечисление.ВидыРегистровНакопления.Обороты") Тогда
			
			Элемент.ТекущиеДанные.ВидДвижения = ПредопределенноеЗначение("Перечисление.ВидДвиженияРегистра.Оборот");
			
		ИначеЕсли ИмяКласса = "РегистрыСведений" Тогда
			Элемент.ТекущиеДанные.ВидДвижения = ПредопределенноеЗначение("Перечисление.ВидДвиженияРегистра.Запись");
			// Иначе вид движения не известен
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОписаниеДвиженийПоРегиструВидДвиженияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	// Ограничение выбора вида движения для регистров
	Если ЕстьДвиженияПоРегистру Тогда
		
		СтандартнаяОбработка = Ложь;
		ДанныеВыбора = Новый СписокЗначений;
		
		Если ИмяКласса = "РегистрыНакопления"
			И Объект.ВидРегистраНакопления = ПредопределенноеЗначение("Перечисление.ВидыРегистровНакопления.Обороты") Тогда
			
			ДанныеВыбора.Добавить(ПредопределенноеЗначение("Перечисление.ВидДвиженияРегистра.Оборот"));
			
		ИначеЕсли ИмяКласса = "РегистрыСведений" Тогда
			ДанныеВыбора.Добавить(ПредопределенноеЗначение("Перечисление.ВидДвиженияРегистра.Запись"));
		Иначе
			ДанныеВыбора.Добавить(ПредопределенноеЗначение("Перечисление.ВидДвиженияРегистра.Приход"));
			ДанныеВыбора.Добавить(ПредопределенноеЗначение("Перечисление.ВидДвиженияРегистра.Расход"));
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОписаниеДвиженийПоРегиструОписаниеДвиженияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Оповещение = Новый ОписаниеОповещения("ОписаниеДвиженияНачалоВыбораНачалоВыбораЗавершение", ЭтотОбъект);
	ОбщегоНазначенияКлиент.ПоказатьФормуРедактированияМногострочногоТекста(
		Оповещение, Элементы.ОписаниеДвиженийПоРегиструОписаниеДвижения.ТекстРедактирования, НСтр("ru='Текст описания'"));
		
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийТаблицыРазделыПроекта

&НаКлиенте
Процедура РазделыПроектаПриАктивизацииСтроки(Элемент)
	
	Если Элемент.ТекущаяСтрока <> Неопределено Тогда
		РазделыПроектаПриАктивизацииСтрокиНаСервере(Элемент.ТекущаяСтрока);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ОтборМеханизмовПоСтатусамОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	УстановитьОтборПоСтатусу(Элемент.Имя, НавигационнаяСсылкаФорматированнойСтроки);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийТаблицыФункцииОбъекта

&НаКлиенте
Процедура ОтборФункцийПоСтатусамОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	УстановитьОтборПоСтатусу(Элемент.Имя, НавигационнаяСсылкаФорматированнойСтроки);
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьСтатусФункцииНеобходимоВстроить(Команда)
	
	УстановитьСтатусФункции(ПредопределенноеЗначение("Перечисление.СтатусыВстраиванияФункцийМеханизмов.НеобходимоВстроить"));
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьСтатусФункцииНеВстраивается(Команда)
	
	УстановитьСтатусФункции(ПредопределенноеЗначение("Перечисление.СтатусыВстраиванияФункцийМеханизмов.НеВстраивается"));
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьСтатусФункцииТребуетсяАнализ(Команда)
	
	УстановитьСтатусФункции(ПредопределенноеЗначение("Перечисление.СтатусыВстраиванияФункцийМеханизмов.ТребуетсяАнализ"));
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьСтатусФункцииВстроена(Команда)
	
	УстановитьСтатусФункции(ПредопределенноеЗначение("Перечисление.СтатусыВстраиванияФункцийМеханизмов.Встроена"));
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьСтатусФункцииНеВстраиваетсяМеханизм(Команда)
	
	УстановитьСтатусФункции("НеВстраиваетсяМеханизм");
	
КонецПроцедуры

#КонецОбласти

&НаКлиенте
Процедура ФункцииОбъектаВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если Поле.Имя = "ФункцииОбъектаКомментарий"  Тогда
		СтандартнаяОбработка = Ложь;
		ПараметрыОбработчика = Новый Структура("НовыйСтатус", Неопределено);
		Обработчик = Новый ОписаниеОповещения("ОбработкаВводаКомментария",ЭтаФорма, ПараметрыОбработчика);
		ПоказатьВводСтроки(Обработчик,Элемент.ТекущиеДанные.Комментарий,НСтр("ru = 'Укажите комментарий'"));
	КонецЕсли;
	
КонецПроцедуры

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗаполнитьДвиженияРегистров(Команда)
	
	ЗаполнитьДвижения();
	
КонецПроцедуры

&НаКлиенте
Процедура ДополнительныеРазделы(Команда)
	
	ПараметрыФормы = Новый Структура;
	МассивРазделов = Новый Массив;
	
	Для Каждого СтрокаТЧ из Объект.РазделыПроекта Цикл
		МассивРазделов.Добавить(СтрокаТЧ.Раздел);
	КонецЦикла;
	
	ПараметрыФормы.Вставить("Проект", Объект.Владелец);
	ПараметрыФормы.Вставить("МассивРазделов", МассивРазделов);
    ПараметрыФормы.Вставить("ИзмененияДоступны", ДоступноИзменениеОбъектаМетаданных);
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ДополнительныеРазделыЗавершение", ЭтотОбъект);
	ОткрытьФорму("ОбщаяФорма.РазделыПроекта", ПараметрыФормы, ЭтаФорма,,,, ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура ДополнительныеРазделыЗавершение(РезультатДействия, ДополнительныеПараметры) Экспорт
    
    Результат = РезультатДействия;
    
    Если ТипЗнч(Результат) = Тип("Массив") Тогда
        
        Объект.РазделыПроекта.Очистить();
        
        КоличествоРазделов = 0;
        Для Каждого Раздел из Результат Цикл
            НоваяСтрока = Объект.РазделыПроекта.Добавить();
            НоваяСтрока.Раздел = Раздел;
            
            КоличествоРазделов = КоличествоРазделов + 1;
        КонецЦикла;
        
        ОбщегоНазначенияСППРКлиентСервер.СформироватьТекстГиперссылкиДополнительныеРазделы(Элементы.ДополнительныеРазделы,
			КоличествоРазделов);
			
		Модифицированность = Истина;
		
    КонецЕсли;

КонецПроцедуры

// СтандартныеПодсистемы.Свойства

&НаКлиенте
Процедура Подключаемый_СвойстваВыполнитьКоманду(ЭлементИлиКоманда, НавигационнаяСсылка = Неопределено, СтандартнаяОбработка = Неопределено)
	
	УправлениеСвойствамиКлиент.ВыполнитьКоманду(ЭтотОбъект, ЭлементИлиКоманда, СтандартнаяОбработка);
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.Свойства

&НаКлиенте
Процедура ОбъектПоставщика(Команда)
	
	Если ЗначениеЗаполнено(Объект.Поставщик) Тогда
		
		СсылкаНаОбъектПоставщика = ПолучитьСсылкуНаОбъектПоставщика(Объект.Поставщик, Объект.uuid);
		Если ЗначениеЗаполнено(СсылкаНаОбъектПоставщика) Тогда
			ПараметрыФормы = Новый Структура("Ключ", СсылкаНаОбъектПоставщика);
			ОткрытьФорму("Справочник.ОбъектыМетаданных.ФормаОбъекта", ПараметрыФормы);
		Иначе 
			ПоказатьПредупреждение(, НСтр("ru = 'Не удалось найти объект метаданных поставщика'"));
		КонецЕсли; 
		
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьКомментарийВстраивания(Команда)
	
	Если Элементы.ФункцииОбъекта.ВыделенныеСтроки.Количество() = 0 Тогда
		ПоказатьПредупреждение(,НСтр("ru='Не выбраны функции для установки комментария.'"));
	Иначе
		ПараметрыОбработчика = Новый Структура("НовыйСтатус", Неопределено);
		Обработчик = Новый ОписаниеОповещения("ОбработкаВводаКомментария", ЭтаФорма, ПараметрыОбработчика);
		ПоказатьВводСтроки(Обработчик,Элементы.ФункцииОбъекта.ТекущиеДанные.Комментарий,НСтр("ru = 'Укажите комментарий'"));
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьУсловноеОформление()
	
	РегистрыСведений.СтатусыВстраиванияМеханизмов.УстановитьУсловноеОформлениеСтатусовВстраивания(
		ЭтаФорма.УсловноеОформление, "ДеревоФункцииМеханизмов");
		
	УсловноеОформлениеРазделыПроекта = РазделыПроекта.КомпоновщикНастроек.Настройки.УсловноеОформление;
	УсловноеОформлениеРазделыПроекта.Элементы.Очистить();
	ОбщегоНазначенияСППР.УстановитьУсловноеОформлениеСпискаОтветственный(УсловноеОформлениеРазделыПроекта);
	РегистрыСведений.СтатусыВстраиванияМеханизмов.УстановитьУсловноеОформлениеСтатусовВстраивания(УсловноеОформлениеРазделыПроекта);
	
	УсловноеОформлениеФункции = ФункцииОбъекта.КомпоновщикНастроек.Настройки.УсловноеОформление;
	УсловноеОформлениеФункции.Элементы.Очистить();
	ОбщегоНазначенияСППР.УстановитьУсловноеОформлениеСпискаОтветственный(УсловноеОформлениеФункции);
	РегистрыСведений.СтатусыВстраиванияМеханизмов.УстановитьУсловноеОформлениеСтатусовВстраивания(УсловноеОформлениеФункции);
		
КонецПроцедуры

&НаСервере
Процедура ПриСозданииЧтенииНаСервере()
	
	ДоступноИзменениеОбъектаМетаданных = 
		УправлениеДоступомСППР.РольДоступнаПоПроекту("ДобавлениеИзменениеОбъектовМетаданных", Объект.Владелец);
		
	СтоитНаПоддержке = ЗначениеЗаполнено(Объект.Поставщик);
	
	ЗаполнитьСписокПоставщиков(Элементы.Поставщик.СписокВыбора, Объект.Владелец);
	
	НастроитьПанельНавигации();
	
	НастроитьВидимостьПолейСтраницыОписания();
	
	ОбщегоНазначенияСППРКлиентСервер.СформироватьТекстГиперссылкиДополнительныеРазделы(Элементы.ДополнительныеРазделы,
		Объект.РазделыПроекта.Количество());
	
	УстановитьДоступностьПравилаПоддержки(ЭтаФорма);
	УстановитьПараметрыСписковФункций();
	
	// ЗадачиПроцессов
	ЗадачиПроцессов.ОтобразитьИнформациюПоСогласующимВФорме(ЭтотОбъект, Объект.Ссылка, "ГруппаДополнительныеРеквизиты");
	// Конец ЗадачиПроцессов
	
КонецПроцедуры

&НаСервере
Процедура НастроитьПанельНавигации()
	
	ПараметрыНастройки = ОбщегоНазначенияСППР.ПараметрыНастройкиФормы(ЭтаФорма);
	ОбщегоНазначенияСППР.НастроитьФормуПоПараметрам(ЭтаФорма, ПараметрыНастройки);
	
КонецПроцедуры

&НаСервере
Процедура НастроитьВидимостьПолейСтраницыОписания()
	
	ПараметрыНастройки = ОбщегоНазначенияСППР.ПараметрыВидимостиЭлемнтовФормы(ЭтаФорма);
	
	Элементы.ПредставлениеОбъекта.Видимость = ПараметрыНастройки.ПредставлениеОбъекта;
	Элементы.РасширенноеПредставлениеОбъекта.Видимость = ПараметрыНастройки.РасширенноеПредставлениеОбъекта;
    Элементы.ПредставлениеСписка.Видимость = ПараметрыНастройки.ПредставлениеСписка;
    Элементы.РасширенноеПредставлениеСписка.Видимость = ПараметрыНастройки.ПредставлениеСписка;
    Элементы.Пояснение.Видимость = ПараметрыНастройки.ПредставлениеОбъекта Или ПараметрыНастройки.ПредставлениеСписка Или ПараметрыНастройки.РасширенноеПредставлениеОбъекта;
	
КонецПроцедуры

&НаСервере
Процедура СохранитьЗначения()
	
	НастройкиСервер.СохранитьТекущуюСтраницу("Справочник.ОбъектыМетаданных.ФормаЭлемента", 
												Элементы.ГруппаСтраницы, 
												"ТекущаяСтраницаФормыОбъектаМетаданных");

КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьЭлементов()
	
	Элементы.Ответственный.Видимость 				= НЕ Объект.ЭтоГруппа;
	Элементы.СтраницаДвижения.Видимость				= ЕстьДвиженияПоРегистру И Объект.РегистрПодчиненРегистратору;
	Элементы.СтраницаВводНаОсновании.Видимость     	= ДоступенВводНаОсновании(ИмяКласса);
	Элементы.ВидРегистраНакопления.Видимость		= (ИмяКласса = "РегистрыНакопления");
	Элементы.РегистрПодчиненРегистратору.Видимость	= (ИмяКласса = "РегистрыСведений");
	Элементы.ГруппаСвойстваРоли.Видимость			= (ИмяКласса = "Роли");
	Элементы.ВидИерархии.Видимость					= (ИмяКласса = "Справочники" ИЛИ ИмяКласса = "ПланыВидовХарактеристик") И ЗначениеЗаполнено(Объект.ВидИерархии);
	Элементы.НеразделенныеДанные.Видимость			=   ИмяКласса = "Константы" 
														ИЛИ ИмяКласса = "Справочники" 
														ИЛИ ИмяКласса = "Документы"
														ИЛИ ИмяКласса = "ПланыВидовХарактеристик"
														ИЛИ ИмяКласса = "ПланыСчетов"
														ИЛИ ИмяКласса = "ПланыВидовРасчета"
														ИЛИ ИмяКласса = "БизнесПроцессы"
														ИЛИ ИмяКласса = "Задачи"
														ИЛИ ИмяКласса = "РегистрыСведений"
														ИЛИ ИмяКласса = "РегистрыНакопления"
														ИЛИ ИмяКласса = "РегистрыБухгалтерии"
														ИЛИ ИмяКласса = "РегистрыРасчета"
														ИЛИ ИмяКласса = "ПланыОбмена" 
														ИЛИ ИмяКласса = "РегламентныеЗадания";
	
	Элементы.ИспользоватьСтандартныеКоманды.Видимость = 
		ИмяКласса = "КритерииОтбора"
		ИЛИ ИмяКласса = "ПланыОбмена"
		ИЛИ ИмяКласса = "ОбщиеФормы"
		ИЛИ ИмяКласса = "Константы"
		ИЛИ ИмяКласса = "Справочники"
		ИЛИ ИмяКласса = "Документы"
		ИЛИ ИмяКласса = "ЖурналыДокументов"
		ИЛИ ИмяКласса = "Перечисления"
		ИЛИ ИмяКласса = "Отчеты"
		ИЛИ ИмяКласса = "Обработки"
		ИЛИ ИмяКласса = "РегистрыСведений"
		ИЛИ ИмяКласса = "РегистрыНакопления"
		ИЛИ ИмяКласса = "РегистрыБухгалтерии"
		ИЛИ ИмяКласса = "РегистрыРасчета"
		ИЛИ ИмяКласса = "ПланыВидовХарактеристик"
		ИЛИ ИмяКласса = "ПланыВидовРасчета"
		ИЛИ ИмяКласса = "ПланыСчетов"
		ИЛИ ИмяКласса = "БизнесПроцессы"
		ИЛИ ИмяКласса = "Задачи";
	
	Элементы.СтраницаФункцииМеханизмов.Видимость = ИмяКласса = "Справочники" ИЛИ ИмяКласса = "Документы";
	
КонецПроцедуры

&НаСервере
Функция ДоступенВводНаОсновании(ИмяКласса)
	
	Классы = Новый Массив;
	Классы.Добавить("ПланыОбмена");
	Классы.Добавить("Справочники");	
	Классы.Добавить("Документы");
	Классы.Добавить("ПланыВидовХарактеристик");
	Классы.Добавить("ПланыСчетов");	
	Классы.Добавить("ПланыВидовРасчета");	
	Классы.Добавить("БизнесПроцессы");	
	Классы.Добавить("Задачи");
	
	Если Классы.Найти(ИмяКласса) <> Неопределено Тогда
		Возврат Истина;
	КонецЕсли;
	
	Возврат Ложь;
	
КонецФункции

&НаСервере
Процедура ЗаполнитьДвижения()
	
	Запрос = Новый Запрос("
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	РеквизитыОбъектовМетаданных.ТипЗначенияРеквизита КАК Регистратор
	|ИЗ
	|	Справочник.РеквизитыОбъектовМетаданных.ТипыЗначенияРеквизита КАК РеквизитыОбъектовМетаданных
	|ГДЕ
	|	РеквизитыОбъектовМетаданных.Ссылка.Владелец = &Ссылка
	|	И РеквизитыОбъектовМетаданных.Ссылка.Имя = ""Регистратор""
	|	И РеквизитыОбъектовМетаданных.Ссылка.ВидРеквизита = ЗНАЧЕНИЕ(Перечисление.ВидыРеквизитов.СтандартныйРеквизит)
	|");

	Запрос.УстановитьПараметр("Ссылка", Объект.Ссылка);

	Выборка = Запрос.Выполнить().Выбрать();
	
	Если ИмяКласса = "РегистрыНакопления"
		И Объект.ВидРегистраНакопления = Перечисления.ВидыРегистровНакопления.Обороты Тогда
		ВидДвижения = Перечисления.ВидДвиженияРегистра.Оборот;
	ИначеЕсли ИмяКласса = "РегистрыСведений" Тогда
		ВидДвижения = Перечисления.ВидДвиженияРегистра.Запись;
	Иначе
		ВидДвижения = Перечисления.ВидДвиженияРегистра.ПустаяСсылка();
	КонецЕсли;
	
	ТаблицаДвижений = Объект.ОписаниеДвиженийПоРегистру.Выгрузить();
	ДобавленыСтроки = Ложь;;
	
	Пока Выборка.Следующий() Цикл
		Если ТаблицаДвижений.Найти(Выборка.Регистратор, "Регистратор") = Неопределено Тогда
			НоваяСтрока = ТаблицаДвижений.Добавить();
			НоваяСтрока.Регистратор = Выборка.Регистратор;
			НоваяСтрока.ВидДвижения = ВидДвижения;
			ДобавленыСтроки = Истина;
		КонецЕсли;
	КонецЦикла;
	
	Если ДобавленыСтроки Тогда
		Объект.ОписаниеДвиженийПоРегистру.Загрузить(ТаблицаДвижений);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ИзменитьРодителя()
	
	ЗаполнитьСписокПоставщиков(Элементы.Поставщик.СписокВыбора, Объект.Владелец);
	
	Если ЗначениеЗаполнено(Объект.Владелец) Тогда
		
		РеквизитыРодителя = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Объект.Родитель, "Владелец, Имя");
		
		Если РеквизитыРодителя.Владелец <> Объект.Владелец Тогда
			РодительНужногоПроекта = РаботаСОбъектамиМетаданных.ГруппаОбъектовМетаданных(РеквизитыРодителя.Имя, Объект.Владелец);
			Объект.Родитель = РодительНужногоПроекта;
		КонецЕсли;
		
		Если Элементы.Поставщик.СписокВыбора.НайтиПоЗначению(Объект.Владелец) = Неопределено Тогда
		
			Объект.Поставщик = Неопределено;
			Объект.ПравилоПоддержки = Неопределено;
			СтоитНаПоддержке = Ложь;
			УстановитьДоступностьПравилаПоддержки(ЭтаФорма);
		
		КонецЕсли; 
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПрочитатьПринадлежностьКПодсистемам()
	
	Элементы.ДеревоПодсистемы.ТолькоПросмотр =
		НЕ ПравоДоступа("Изменение", Метаданные.Справочники.Подсистемы)
		ИЛИ НЕ ПравоДоступа("Изменение", Метаданные.Справочники.ОбъектыМетаданных);
	
	ДеревоПодсистемы.ПолучитьЭлементы().Очистить();
	
	Если ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект.Родитель, "ВидОбъектаМетаданныхВЕдЧисле") = "Подсистема" Тогда
		Возврат;
	КонецЕсли;
		
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
	|	ПодсистемыСостав.Ссылка КАК Подсистема
	|ПОМЕСТИТЬ ВТПодсистемыОбъекта
	|ИЗ
	|	Справочник.Подсистемы.Состав КАК ПодсистемыСостав
	|ГДЕ
	|	ПодсистемыСостав.ОбъектМетаданных = &ОбъектМетаданных
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Подсистемы.Ссылка КАК Подсистема,
	|	Подсистемы.Родитель,
	|	Подсистемы.ПометкаУдаления,
	|	Подсистемы.Имя,
	|	ВЫБОР
	|		КОГДА ВТПодсистемыОбъекта.Подсистема ЕСТЬ NULL 
	|			ТОГДА ЛОЖЬ
	|		ИНАЧЕ ИСТИНА
	|	КОНЕЦ КАК Пометка
	|ИЗ
	|	Справочник.Подсистемы КАК Подсистемы
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТПодсистемыОбъекта КАК ВТПодсистемыОбъекта
	|		ПО Подсистемы.Ссылка = ВТПодсистемыОбъекта.Подсистема
	|ГДЕ
	|	Подсистемы.Владелец = &Владелец
	|
	|УПОРЯДОЧИТЬ ПО
	|	Подсистемы.Ссылка.Наименование
	|ИТОГИ ПО
	|	Подсистема ИЕРАРХИЯ";
	
	Запрос.УстановитьПараметр("Владелец", 		  Объект.Владелец);
	Запрос.УстановитьПараметр("ОбъектМетаданных", Объект.Ссылка);
	
	Выборка = Запрос.Выполнить().Выбрать(ОбходРезультатаЗапроса.ПоГруппировкамСИерархией);
	
	Дерево = РеквизитФормыВЗначение("ДеревоПодсистемы");
	ЗаполнитьДеревоПодсистем(Дерево, Дерево, Выборка);
	ЗначениеВРеквизитФормы(Дерево, "ДеревоПодсистемы");
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьДеревоПодсистем(Дерево, ЭлементДерева, Выборка)
	
	Пока Выборка.Следующий() Цикл
		
		Если Выборка.ПометкаУдаления Тогда
			Продолжить;
		КонецЕсли;
		
		Если Выборка.ТипЗаписи() = ТипЗаписиЗапроса.ИтогПоГруппировке Тогда
			
			Выборка2 = Выборка.Выбрать();
			Выборка2.Следующий();
			
			Если ЗначениеЗаполнено(Выборка2.Родитель) Тогда
				СтрокиРодителя = Дерево.Строки.НайтиСтроки(Новый Структура("Подсистема", Выборка2.Родитель), Истина);
				Если СтрокиРодителя.Количество() = 0 Тогда
					Продолжить;
				КонецЕсли;
				Родитель = СтрокиРодителя[0];
			Иначе
				Родитель = ЭлементДерева;
			КонецЕсли;
			
			НовыйЭлемент = Родитель.Строки.Добавить();
			ЗаполнитьЗначенияСвойств(НовыйЭлемент, Выборка2, "Пометка,Подсистема,Имя");
			
		ИначеЕсли Выборка.ТипЗаписи() = ТипЗаписиЗапроса.ИтогПоИерархии Тогда
			
			Выборка2 = Выборка.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкамСИерархией, "Подсистема");
			ЗаполнитьДеревоПодсистем(Дерево, ЭлементДерева, Выборка2);
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ЗаписатьПринадлежностьКПодсистемам(Отказ, ТекущийОбъект)
	
	Если Элементы.ДеревоПодсистемы.ТолькоПросмотр Тогда
		Возврат;
	КонецЕсли;
	
	Дерево = РеквизитФормыВЗначение("ДеревоПодсистемы");
	ПомеченныеСтроки = Дерево.Строки.НайтиСтроки(Новый Структура("Пометка", Истина), Истина);
	
	МассивПодсистем = Новый Массив;
	Для Каждого ТекСтр Из ПомеченныеСтроки Цикл
		МассивПодсистем.Добавить(ТекСтр.Подсистема);
	КонецЦикла;
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
	|	ПодсистемыСостав.Ссылка КАК Подсистема
	|ПОМЕСТИТЬ ВТСтарыеПодсистемы
	|ИЗ
	|	Справочник.Подсистемы.Состав КАК ПодсистемыСостав
	|ГДЕ
	|	ПодсистемыСостав.ОбъектМетаданных = &ОбъектМетаданных
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Подсистемы.Ссылка КАК Подсистема
	|ПОМЕСТИТЬ ВТНовыеПодсистемы
	|ИЗ
	|	Справочник.Подсистемы КАК Подсистемы
	|ГДЕ
	|	Подсистемы.Ссылка В(&МассивПодсистем)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	СоставПодсистем.Подсистема КАК Подсистема,
	|	СоставПодсистем.ВходитВНовые КАК ВходитВПодсистему
	|ИЗ
	|	(ВЫБРАТЬ
	|		Подсистемы.Ссылка КАК Подсистема,
	|		ВЫБОР
	|			КОГДА ВТСтарыеПодсистемы.Подсистема ЕСТЬ NULL 
	|				ТОГДА ЛОЖЬ
	|			ИНАЧЕ ИСТИНА
	|		КОНЕЦ КАК ВходитВСтарые,
	|		ВЫБОР
	|			КОГДА ВТНовыеПодсистемы.Подсистема ЕСТЬ NULL 
	|				ТОГДА ЛОЖЬ
	|			ИНАЧЕ ИСТИНА
	|		КОНЕЦ КАК ВходитВНовые
	|	ИЗ
	|		Справочник.Подсистемы КАК Подсистемы
	|			ЛЕВОЕ СОЕДИНЕНИЕ ВТСтарыеПодсистемы КАК ВТСтарыеПодсистемы
	|			ПО Подсистемы.Ссылка = ВТСтарыеПодсистемы.Подсистема
	|			ЛЕВОЕ СОЕДИНЕНИЕ ВТНовыеПодсистемы КАК ВТНовыеПодсистемы
	|			ПО Подсистемы.Ссылка = ВТНовыеПодсистемы.Подсистема
	|	ГДЕ
	|		Подсистемы.Владелец = &Владелец) КАК СоставПодсистем
	|ГДЕ
	|	СоставПодсистем.ВходитВСтарые <> СоставПодсистем.ВходитВНовые";
	
	Запрос.УстановитьПараметр("Владелец", 		  ТекущийОбъект.Владелец);
	Запрос.УстановитьПараметр("ОбъектМетаданных", ТекущийОбъект.Ссылка);
	Запрос.УстановитьПараметр("МассивПодсистем",  МассивПодсистем);
	
	ТаблицаПодсистем = Запрос.Выполнить().Выгрузить();
	
	Если ТаблицаПодсистем.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	Блокировка = Новый БлокировкаДанных;
	ЭлементБлокировки = Блокировка.Добавить("Справочник.Подсистемы");
	ЭлементБлокировки.ИсточникДанных = ТаблицаПодсистем;
	ЭлементБлокировки.ИспользоватьИзИсточникаДанных("Ссылка", "Подсистема");
	
	НачатьТранзакцию();
	
	Попытка
		
		Блокировка.Заблокировать();
	
		Для Каждого ТекСтр Из ТаблицаПодсистем Цикл
			
			ОбъектПодсистемы = ТекСтр.Подсистема.ПолучитьОбъект();
			
			Если ТекСтр.ВходитВПодсистему Тогда
				СтрокаСостава = ОбъектПодсистемы.Состав.Добавить();
				СтрокаСостава.ОбъектМетаданных = ТекущийОбъект.Ссылка;
				ОбъектПодсистемы.Состав.Сортировать("ОбъектМетаданных");
			Иначе
				СтрокаСостава = ОбъектПодсистемы.Состав.Найти(ТекущийОбъект.Ссылка);
				ОбъектПодсистемы.Состав.Удалить(СтрокаСостава);
			КонецЕсли;
			
			ОбъектПодсистемы.Записать();
			
		КонецЦикла;
	
		ЗафиксироватьТранзакцию();
		
	Исключение
		
		Отказ = Истина;
		ОтменитьТранзакцию();
		ВызватьИсключение;
		
	КонецПопытки;
	
КонецПроцедуры

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

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьДоступностьПравилаПоддержки(Форма)
	
	Форма.Элементы.Поставщик.Доступность        = Форма.СтоитНаПоддержке;
	Форма.Элементы.ПравилоПоддержки.Доступность = ЗначениеЗаполнено(Форма.Объект.Поставщик);
	Форма.Элементы.ОбъектПоставщика.Доступность = ЗначениеЗаполнено(Форма.Объект.Поставщик);
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ЗаполнитьСписокПоставщиков(Список, Проект)

	Список.Очистить();
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	Проекты.Ссылка КАК Поставщик,
	|	Проекты.Представление
	|ИЗ
	|	Справочник.Проекты.ВключаемыеПроекты КАК ПроектыВключаемыеПроекты
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.Проекты КАК Проекты
	|		ПО ПроектыВключаемыеПроекты.Проект = Проекты.Ссылка
	|ГДЕ
	|	ПроектыВключаемыеПроекты.Ссылка = &Проект
	|
	|УПОРЯДОЧИТЬ ПО
	|	Проекты.Наименование";
	
	Запрос.УстановитьПараметр("Проект", Проект);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Список.Добавить(ВыборкаДетальныеЗаписи.Поставщик, ВыборкаДетальныеЗаписи.Представление);
	КонецЦикла;
	
КонецФункции

&НаСервере
Процедура ПриИзмененииВладельцаСервер()
	
	ДоступноИзменениеОбъектаМетаданных = 
		УправлениеДоступомСППР.РольДоступнаПоПроекту("ДобавлениеИзменениеОбъектовМетаданных", Объект.Владелец);
		
	ИзменитьРодителя();
	Объект.РазделыПроекта.Очистить();
	
	ОбщегоНазначенияСППРКлиентСервер.СформироватьТекстГиперссылкиДополнительныеРазделы(Элементы.ДополнительныеРазделы, 
		Объект.РазделыПроекта.Количество());
	
	ПрочитатьПринадлежностьКПодсистемам();
	УстановитьПараметрыСписковФункций();
	
	// СтандартныеПодсистемы.Свойства
	ОбновитьЭлементыДополнительныхРеквизитов();
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьСсылкуНаОбъектПоставщика(Поставщик, uuid)
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("uuid",     uuid);
	Запрос.УстановитьПараметр("Поставщик", Поставщик);
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ОбъектыМетаданных.Ссылка
	|ИЗ
	|	Справочник.ОбъектыМетаданных КАК ОбъектыМетаданных
	|ГДЕ
	|	ОбъектыМетаданных.uuid = &uuid
	|	И ОбъектыМетаданных.Владелец = &Поставщик";
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Возврат ?(Выборка.Следующий(), Выборка.Ссылка, Неопределено);
	
КонецФункции

&НаКлиенте
Процедура ОписаниеДвиженияНачалоВыбораНачалоВыбораЗавершение(РезультатЗакрытия, ДополнительныеПараметры) Экспорт

	Если РезультатЗакрытия <> Неопределено Тогда
		ТекущиеДанные = Элементы.ОписаниеДвиженийПоРегистру.ТекущиеДанные;
		ТекущиеДанные.ОписаниеДвижения = РезультатЗакрытия;
	КонецЕсли; 
	
КонецПроцедуры

&НаСервере
Процедура УстановитьПараметрыСписковФункций()
	 
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		РазделыПроекта,
		"Владелец",
		ПараметрыСеанса.ТекущийПроект,
		ВидСравненияКомпоновкиДанных.Равно,
		,
		ЗначениеЗаполнено(ПараметрыСеанса.ТекущийПроект));
	
	ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(
		РазделыПроекта, 
		"Ссылка", 
		Объект.Ссылка);
	
	ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(
		ФункцииОбъекта, 
		"Ссылка", 
		Объект.Ссылка);
		
	ВидОбъекта = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект.Родитель, "ВидОбъектаМетаданныхВЕдЧисле");
	ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(
		ФункцииОбъекта, 
		"ЭтоДокумент", 
		ВидОбъекта = "Документ");
	
	ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(
		ФункцииОбъекта, 
		"ЭтоСправочник", 
		ВидОбъекта = "Справочник");
		
	СформироватьОтборыМеханизмовПоСтатусам();
	СформироватьОтборыФункцийПоСтатусам();
	
КонецПроцедуры

&НаСервере
Процедура РазделыПроектаПриАктивизацииСтрокиНаСервере(ТекущийРаздел)
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		ФункцииОбъекта,
		"Владелец",
		ТекущийРаздел,
		ВидСравненияКомпоновкиДанных.Равно,
		,
		ЗначениеЗаполнено(ТекущийРаздел));
	СформироватьОтборыФункцийПоСтатусам();

КонецПроцедуры

&НаСервере
Процедура СформироватьОтборыМеханизмовПоСтатусам()
	
	ОтборМеханизмовПоСтатусам = РегистрыСведений.СтатусыВстраиванияМеханизмов.СтрокаОтборовПоСтатусам(РазделыПроекта);
	
КонецПроцедуры

&НаСервере
Процедура СформироватьОтборыФункцийПоСтатусам()
	
	ОтборФункцийПоСтатусам = РегистрыСведений.СтатусыВстраиванияМеханизмов.СтрокаОтборовПоСтатусам(ФункцииОбъекта);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьОтборПоСтатусу(Команда, ОтборСтатуса)
	
	Если Команда = "ОтборФункцийПоСтатусам" Тогда
		РегистрыСведений.СтатусыВстраиванияМеханизмов.УстановитьОтборСпискаПоСтатусу(ФункцииОбъекта, ОтборСтатуса, ОтборФункцийПоСтатусам);
	ИначеЕсли Команда = "ОтборМеханизмовПоСтатусам" Тогда
		РегистрыСведений.СтатусыВстраиванияМеханизмов.УстановитьОтборСпискаПоСтатусу(РазделыПроекта, ОтборСтатуса, ОтборМеханизмовПоСтатусам);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьСтатусФункции(НовыйСтатус) Экспорт
	
	Если Элементы.ФункцииОбъекта.ВыделенныеСтроки.Количество() = 0 Тогда
		ПоказатьПредупреждение(,НСтр("ru='Не выбраны функции для установки статуса.'"));
	ИначеЕсли НовыйСтатус = ПредопределенноеЗначение("Перечисление.СтатусыВстраиванияФункцийМеханизмов.НеобходимоВстроить") Тогда
		ПараметрыОбработчика = Новый Структура("НовыйСтатус", НовыйСтатус);
		Обработчик = Новый ОписаниеОповещения("ОбработкаВводаКомментария",ЭтаФорма, ПараметрыОбработчика);
		ПоказатьВводСтроки(Обработчик,,НСтр("ru = 'Укажите комментарий'"));
	Иначе
		УстановитьСтатусФункцииНаСервере(НовыйСтатус);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВводаКомментария(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат <> Неопределено Тогда
		УстановитьСтатусФункцииНаСервере(ДополнительныеПараметры.НовыйСтатус, Результат);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьСтатусФункцииНаСервере(НовыйСтатус, Комментарий = "")
	
	Если НовыйСтатус = Неопределено Тогда
		РегистрыСведений.СтатусыВстраиванияМеханизмов.УстановитьКомментарийВстраивания(
			Комментарий,
			Элементы.РазделыПроекта.ТекущаяСтрока,
			Объект.Ссылка,
			Элементы.ФункцииОбъекта.ВыделенныеСтроки);
	Иначе
		РегистрыСведений.СтатусыВстраиванияМеханизмов.УстановитьСтатусВстраивания(
			НовыйСтатус,
			Элементы.РазделыПроекта.ТекущаяСтрока,
			Объект.Ссылка,
			Элементы.ФункцииОбъекта.ВыделенныеСтроки,
			Комментарий);
	КонецЕсли;
	
	Элементы.ФункцииОбъекта.Обновить();
	Элементы.РазделыПроекта.Обновить();
	СформироватьОтборыФункцийПоСтатусам();
	СформироватьОтборыМеханизмовПоСтатусам();
	
КонецПроцедуры

#КонецОбласти