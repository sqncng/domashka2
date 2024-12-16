﻿
#Область ПрограммныйИнтерфейс

// Возвращает признак предопределенного узла этой информационной базы по переданному значению ссылки
//
// Параметры:
//  УзелПланаОбмена - ПланОбменаСсылка - любой узел плана обмена
// 
// Возвращаемое значение:
//  Булево - признак предопределенного узла этой информационной базы
//
Функция ЭтоПредопределенныйУзелПланаОбмена(УзелПланаОбмена) Экспорт
	
	Если Не ЗначениеЗаполнено(УзелПланаОбмена) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Возврат ПолучитьЭтотУзелПланаОбменаПоСсылке(УзелПланаОбмена) = УзелПланаОбмена;
	
КонецФункции

// Получает предопределенный узел плана обмена по ссылке на узел плана обмена
//
// Параметры:
//  УзелПланаОбмена - ПланОбменаСсылка - любой узел плана обмена
// 
// Возвращаемое значение:
//  ЭтотУзел - ПланОбменаСсылка - предопределенный узел плана обмена
//
Функция ПолучитьЭтотУзелПланаОбменаПоСсылке(УзелПланаОбмена) Экспорт
	
	Возврат ПолучитьЭтотУзелПланаОбмена(ПолучитьИмяПланаОбмена(УзелПланаОбмена));
	
КонецФункции

// Получает предопределенный узел плана обмена
//
// Параметры:
//  ИмяПланаОбмена - Строка - имя плана обмена как оно задано в конфигураторе
// 
// Возвращаемое значение:
//  ЭтотУзел - ПланОбменаСсылка - предопределенный узел плана обмена
//
Функция ПолучитьЭтотУзелПланаОбмена(ИмяПланаОбмена) Экспорт
	
	Возврат ПланыОбмена[ИмяПланаОбмена].ЭтотУзел()
	
КонецФункции

// Получает имя плана обмена как объекта метаданного для заданного узла
//
// Параметры:
//  УзелПланаОбмена - ПланОбменаСсылка, ПланОбменаОбъект - узел плана обмена
// 
// Возвращаемое значение:
//  Имя - Строка - имя плана обмена как объекта метаданного
//
Функция ПолучитьИмяПланаОбмена(УзелПланаОбмена) Экспорт
	
	Возврат УзелПланаОбмена.Метаданные().Имя;
	
КонецФункции

// Создает список доступных для создания планов обмена
Процедура СписокПлановОбмена(ПланыОбменаПодсистемы) Экспорт
	
	ЭтоБазоваяВерсия = СтандартныеПодсистемыСервер.ЭтоБазоваяВерсияКонфигурации();
	
	Если Не ЭтоБазоваяВерсия Тогда
		ПланыОбменаПодсистемы.Добавить(Метаданные.ПланыОбмена.РИБСОтборами);
	КонецЕсли;
	
КонецПроцедуры

// Возвращает признак доступности плана обмена, для базовой или проф версии
// Возвращаемое значение:
//  Булево - признак доступности
//
Функция ЭтоСозданиеУзлаОбмена(ПланОбмена) Экспорт
	
	Если СтандартныеПодсистемыСервер.ЭтоБазоваяВерсияКонфигурации() Тогда
		Возврат ДоступностьПланаОбменаВБазовойВерсии(ПланОбмена.Метаданные().Имя);
	КонецЕсли;

	Возврат Истина;
	
КонецФункции

// Производит регистрацию объектов для начальной выгрузки 
// с помощью оптимизированного алгоритма.
Процедура РегистрацияИзмененияДляНачальнойВыгрузки(Получатель, СтандартнаяОбработка, Отбор) Экспорт
	
КонецПроцедуры

// Блокирует изменение настроек узла плана обмена
//
Процедура УстановитьДоступностьНастроекУзлаИнформационнойБазы(Форма) Экспорт
	
	Если ОбменДаннымиПовтИспСППР.ЭтоПодчиненныйУзелРИБСОтбором() Тогда
	
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Форма.Элементы,
			"ГруппаПояснениеБлокировки",
			"Видимость",
			Истина);
			
		РазрешенныеНастройки = НастройкиДоступныеДляИзмененияВПодчиненномУзле();
		
		Для Каждого ЭлементФормы Из Форма.Элементы Цикл
			
			Если ТипЗнч(ЭлементФормы) = Тип("ПолеФормы")
				И РазрешенныеНастройки.Найти(ЭлементФормы.ПутьКДанным)= Неопределено Тогда
				
				ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
					Форма.Элементы,
					ЭлементФормы.Имя,
					"Доступность",
					Ложь);
					
			КонецЕсли;
				
		КонецЦикла; 
		
	КонецЕсли;
	
КонецПроцедуры

#Область ОбщиеПроцедурыИФункцииДляПланаОбменаРибСОтборами

// Возвращает массив узлов-получателей объекта
Функция ПолучитьУзлыДляОбъекта(ЭлементДанных,ТипЗначенияОбъекта = Неопределено) Экспорт
	Запрос = Неопределено;
	
	Если ТипЗначенияОбъекта = Неопределено Тогда
		ТипЗначенияОбъекта = ТипЗнч(ЭлементДанных);
	КонецЕсли;
	СтроковоеПредставлениеТипа = Метаданные.НайтиПоТипу(ТипЗначенияОбъекта).ПолноеИмя();
	СтроковоеПредставлениеТипа = СтрЗаменить(СтроковоеПредставлениеТипа,"ПланВидовХарактеристик.","ПланВидовХарактеристикОбъект.");
	СтроковоеПредставлениеТипа = СтрЗаменить(СтроковоеПредставлениеТипа,"Справочник.","СправочникОбъект.");
	СтроковоеПредставлениеТипа = СтрЗаменить(СтроковоеПредставлениеТипа,"РегистрСведений.","РегистрСведенийЗапись.");
	
	Если ТипЗначенияОбъекта = Тип("СправочникОбъект.Пользователи")
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.ГруппыДоступа")
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.ГруппыПользователей")
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.ПапкиФайлов")
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.Проекты") Тогда
		
		ТекстЗапроса = ОбменДаннымиПовтИспСППР.СформироватьЗапросУзловДляОбъекта(СтроковоеПредставлениеТипа);
		Запрос = Новый Запрос(ТекстЗапроса);
		Запрос.УстановитьПараметр("СвойствоОбъекта_Ссылка",ЭлементДанных.Ссылка);
	ИначеЕсли ТипЗначенияОбъекта = Тип("СправочникОбъект.Ошибки") Тогда
		ТекстЗапроса = ОбменДаннымиПовтИспСППР.СформироватьЗапросУзловДляОбъекта(СтроковоеПредставлениеТипа);
		Запрос = Новый Запрос(ТекстЗапроса);
		Запрос.УстановитьПараметр("СвойствоОбъекта_Ссылка",ЭлементДанных.Владелец);
		Запрос.УстановитьПараметр("СвойствоОбъекта_Публикуется",СтатусПубликацииДляОбъекта(ЭлементДанных.Ссылка));
		Запрос.УстановитьПараметр("СвойствоОбъекта_МассивРазделов",ОбменДаннымиПовтИспСППР.МассивРазделовПроектаИзСсылки(ЭлементДанных.Ссылка));
	ИначеЕсли ТипЗначенияОбъекта = Тип("СправочникОбъект.Техническиепроекты") Тогда
		ТекстЗапроса = ОбменДаннымиПовтИспСППР.СформироватьЗапросУзловДляОбъекта(СтроковоеПредставлениеТипа);
		Запрос = Новый Запрос(ТекстЗапроса);
		Запрос.УстановитьПараметр("СвойствоОбъекта_Ссылка",ЭлементДанных.Владелец);
		Запрос.УстановитьПараметр("СвойствоОбъекта_МассивРазделов",ОбменДаннымиПовтИспСППР.МассивРазделовПроектаИзСсылки(ЭлементДанных.Ссылка));
		Запрос.УстановитьПараметр("СвойствоОбъекта_Публикуется",СтатусПубликацииДляОбъекта(ЭлементДанных.Ссылка));
	ИначеЕсли ТипЗначенияОбъекта = Тип("СправочникОбъект.Регламенты")
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.Процессы")
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.ПрофилиПользователей")
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.ВерсииПроекта")
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.ВидыДоступа")
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.Подсистемы")
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.РазделыПроекта")
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.ОбъектыМетаданных")
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.ШагиПроцесса")
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.СборкиВерсии")
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.WebСервисыСвойства")
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.WSСсылкиСвойства")
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.ПакетыXDTOСвойства")
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.ГруппыКомандСвойства")
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.КритерииОтбораСвойства")
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.ОбщиеМодулиСвойства")
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.ОбщиеКомандыСвойства")
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.ОбщиеМакетыСвойства")
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.ОбщиеРеквизитыСвойства")
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.ПодпискиНаСобытияСвойства")
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.ПоследовательностиСвойства")
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.РегламентныеЗаданияСвойства")
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.ФункциональныеОпцииСвойства")
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.ФормыОбъектовМетаданных")
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.КомандыОбъектовМетаданных")
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.МакетыОбъектовМетаданных")
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.РеквизитыОбъектовМетаданных")
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.ПредопределенныеДанные")
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.ЭлементыСправки")
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.МестаИсправленияОшибок")
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.Ветки") 
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.НастройкиЗапускаТестирования") Тогда
		
		ТекстЗапроса = ОбменДаннымиПовтИспСППР.СформироватьЗапросУзловДляОбъекта(СтроковоеПредставлениеТипа);
		Запрос = Новый Запрос(ТекстЗапроса);
		Запрос.УстановитьПараметр("СвойствоОбъекта_Ссылка",ЭлементДанных.Владелец);
	ИначеЕсли ТипЗначенияОбъекта = Тип("СправочникОбъект.ЗадачиПроцесса")
		Или ТипЗначенияОбъекта = Тип("РегистрСведенийЗапись.ИерархияЗадачПроцесса")
		Или ТипЗначенияОбъекта = Тип("РегистрСведенийЗапись.ИтогиСогласованияЗадачРесурсов")
		Или ТипЗначенияОбъекта = Тип("РегистрСведенийЗапись.СостоянияЗадачПроцессов")
		Или ТипЗначенияОбъекта = Тип("РегистрСведенийЗапись.ЭтапыПроцесса")
		Или ТипЗначенияОбъекта = Тип("РегистрСведенийЗапись.ПротоколСогласованияРесурсов") Тогда
		
		Если ТипЗначенияОбъекта = Тип("РегистрСведенийЗапись.СостоянияЗадачПроцессов") 
			Или ТипЗначенияОбъекта = Тип("РегистрСведенийЗапись.ИтогиСогласованияЗадачРесурсов")
			Или ТипЗначенияОбъекта = Тип("РегистрСведенийЗапись.ИерархияЗадачПроцесса") Тогда
			
			Предмет = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ЭлементДанных.ЗадачаПроцесса, "Предмет");
			
		ИначеЕсли ТипЗначенияОбъекта = Тип("РегистрСведенийЗапись.ПротоколСогласованияРесурсов") Тогда
			
			Предмет = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ЭлементДанных.Задача, "Предмет");
			
		Иначе
			Предмет = ЭлементДанных.Предмет;
		КонецЕсли;
		Отказ = Ложь;
		ИспользоватьКэш = Ложь;
		ТекстЗапроса = "";
		ПараметрыЗапроса = Новый Структура();
		ОбработатьРегистрациюЗадачиПроцесса(Предмет, Отказ, ИспользоватьКэш, ТекстЗапроса, ПараметрыЗапроса);
		Запрос = Новый Запрос(ТекстЗапроса);
		Для Каждого ИсходныйПараметр Из ПараметрыЗапроса Цикл
			Запрос.УстановитьПараметр("СвойствоОбъекта_"+ИсходныйПараметр.Ключ, ИсходныйПараметр.Значение);
		КонецЦикла;
		Если НЕ Отказ Тогда
			Если ТипЗначенияОбъекта = Тип("СправочникОбъект.ЗадачиПроцесса") Тогда
				ЗадачаПроцесса = ЭлементДанных.Ссылка;
			ИначеЕсли ТипЗначенияОбъекта = Тип("РегистрСведенийЗапись.ПротоколСогласованияРесурсов") Тогда
				ЗадачаПроцесса = ЭлементДанных.Задача;
			Иначе
				ЗадачаПроцесса = ЭлементДанных.ЗадачаПроцесса;
			КонецЕсли;
			Запрос.УстановитьПараметр("СвойствоОбъекта_ЗадачаПубликуется",СтатусПубликацииДляОбъекта(ЗадачаПроцесса));
		КонецЕсли;
	ИначеЕсли ТипЗначенияОбъекта = Тип("СправочникОбъект.Идеи")
		Или ТипЗначенияОбъекта = Тип("СправочникОбъект.Целевыезадачи") Тогда
		ТекстЗапроса = ОбменДаннымиПовтИспСППР.СформироватьЗапросУзловДляОбъекта(СтроковоеПредставлениеТипа);
		Запрос = Новый Запрос(ТекстЗапроса);
		Запрос.УстановитьПараметр("СвойствоОбъекта_Ссылка",ЭлементДанных.Владелец);
		Запрос.УстановитьПараметр("СвойствоОбъекта_МассивРазделов",ОбменДаннымиПовтИспСППР.МассивРазделовПроектаИзСсылки(ЭлементДанных.Ссылка));
	ИначеЕсли ТипЗначенияОбъекта = Тип("СправочникОбъект.ДополнительныеОтчетыИОбработки") Тогда
		
		ТекстЗапроса = ОбменДаннымиПовтИспСППР.СформироватьЗапросУзловДляОбъекта(СтроковоеПредставлениеТипа);
		Запрос = Новый Запрос(ТекстЗапроса);
		
	ИначеЕсли ТипЗначенияОбъекта = Тип("РегистрСведенийЗапись.ИзмененияВВетках")  Тогда
		
		ТекстЗапроса = ОбменДаннымиПовтИспСППР.СформироватьЗапросУзловДляОбъекта(СтроковоеПредставлениеТипа);
		Запрос = Новый Запрос(ТекстЗапроса);
		Запрос.УстановитьПараметр("СвойствоОбъекта_Ссылка",ЭлементДанных.Ветка);
	
	ИначеЕсли ТипЗначенияОбъекта = Тип("РегистрСведенийЗапись.ПраваДоступаКОбъектамМетаданных")  Тогда
		
		ТекстЗапроса = ОбменДаннымиПовтИспСППР.СформироватьЗапросУзловДляОбъекта(СтроковоеПредставлениеТипа);
		Запрос = Новый Запрос(ТекстЗапроса);
		Запрос.УстановитьПараметр("СвойствоОбъекта_Ссылка",ЭлементДанных.Роль);
		
	ИначеЕсли ТипЗначенияОбъекта = Тип("РегистрСведенийЗапись.НаличиеФайлов") Тогда
		
		ТекстЗапроса = ОбменДаннымиПовтИспСППР.СформироватьЗапросУзловДляОбъекта(СтроковоеПредставлениеТипа);
		Запрос = Новый Запрос(ТекстЗапроса);
		Запрос.УстановитьПараметр("СвойствоОбъекта_Ссылка",ЭлементДанных.ОбъектСФайлами);
		Запрос.УстановитьПараметр("СвойствоОбъекта_Публикуется",СтатусПубликацииДляОбъекта(ЭлементДанных.ОбъектСФайлами));
	ИначеЕсли ТипЗначенияОбъекта = Тип("РегистрСведенийЗапись.ВерсииОбъектов") Тогда
		
		ТекстЗапроса = ОбменДаннымиПовтИспСППР.СформироватьЗапросУзловДляОбъекта(СтроковоеПредставлениеТипа);
		Запрос = Новый Запрос(ТекстЗапроса);
		Запрос.УстановитьПараметр("СвойствоОбъекта_Ссылка",ЭлементДанных.ВерсионируемыйОбъект);
		
	ИначеЕсли ТипЗначенияОбъекта = Тип("РегистрСведенийЗапись.ДатыИзмененияОбъектов")
		Или ТипЗначенияОбъекта = Тип("РегистрСведенийЗапись.КонтрольИзменений") Тогда
		
		ТекстЗапроса = ОбменДаннымиПовтИспСППР.СформироватьЗапросУзловДляОбъекта(СтроковоеПредставлениеТипа);
		Запрос = Новый Запрос(ТекстЗапроса);
		Запрос.УстановитьПараметр("СвойствоОбъекта_Ссылка",ЭлементДанных.КонтролируемыйОбъект);
		
	ИначеЕсли ТипЗначенияОбъекта = Тип("РегистрСведенийЗапись.РезультатыПроверкиОбъектов")  Тогда
		
		ТекстЗапроса = ОбменДаннымиПовтИспСППР.СформироватьЗапросУзловДляОбъекта(СтроковоеПредставлениеТипа);
		Запрос = Новый Запрос(ТекстЗапроса);
		Запрос.УстановитьПараметр("СвойствоОбъекта_Ссылка",ЭлементДанных.ОбъектПроверки);
		
	ИначеЕсли ТипЗначенияОбъекта = Тип("РегистрСведенийЗапись.ДвоичныеДанныеФайлов") 
		Или ТипЗначенияОбъекта = Тип("РегистрСведенийЗапись.КодировкиФайлов")
		Или ТипЗначенияОбъекта = Тип("РегистрСведенийЗапись.СведенияОФайлах") Тогда
		
		ТекстЗапроса = ОбменДаннымиПовтИспСППР.СформироватьЗапросУзловДляОбъекта(СтроковоеПредставлениеТипа);
		Запрос = Новый Запрос(ТекстЗапроса);
		Запрос.УстановитьПараметр("СвойствоОбъекта_Ссылка",ЭлементДанных.Файл);
		ВладелецФайла = ?(ТипЗнч(ЭлементДанных.Файл) = Тип("СправочникСсылка.Файлы"), ЭлементДанных.Файл.ВладелецФайла, ЭлементДанных.Файл.Владелец.ВладелецФайла);
		Запрос.УстановитьПараметр("СвойствоОбъекта_Публикуется",СтатусПубликацииДляОбъекта(ЭлементДанных.Файл) 
														И СтатусПубликацииДляОбъекта(ВладелецФайла));
	ИначеЕсли ТипЗначенияОбъекта = Тип("СправочникОбъект.ВерсииФайлов") Тогда 
		
		ТекстЗапроса = ОбменДаннымиПовтИспСППР.СформироватьЗапросУзловДляОбъекта(СтроковоеПредставлениеТипа);
		Запрос = Новый Запрос(ТекстЗапроса);
		Запрос.УстановитьПараметр("СвойствоОбъекта_Ссылка",ЭлементДанных.Владелец.ВладелецФайла);
		Запрос.УстановитьПараметр("СвойствоОбъекта_Публикуется",СтатусПубликацииДляОбъекта(ЭлементДанных.Владелец));
	ИначеЕсли ТипЗначенияОбъекта = Тип("СправочникОбъект.Файлы") Тогда 
		
		ТекстЗапроса = ОбменДаннымиПовтИспСППР.СформироватьЗапросУзловДляОбъекта(СтроковоеПредставлениеТипа);
		Запрос = Новый Запрос(ТекстЗапроса);
		Запрос.УстановитьПараметр("СвойствоОбъекта_Ссылка",ЭлементДанных.Ссылка);
		Запрос.УстановитьПараметр("СвойствоОбъекта_Публикуется", СтатусПубликацииДляОбъекта(ЭлементДанных.Ссылка));
	ИначеЕсли ТипЗначенияОбъекта = Тип("РегистрСведенийЗапись.НаследованиеНастроекПравОбъектов") Тогда 
		
		ТекстЗапроса = ОбменДаннымиПовтИспСППР.СформироватьЗапросУзловДляОбъекта(СтроковоеПредставлениеТипа);
		Запрос = Новый Запрос(ТекстЗапроса);
		Запрос.УстановитьПараметр("СвойствоОбъекта_Родитель",ЭлементДанных.Родитель);
		Запрос.УстановитьПараметр("СвойствоОбъекта_Объект",ЭлементДанных.Объект);
		
	ИначеЕсли ТипЗначенияОбъекта = Строка(Тип("РегистрСведенийЗапись.НастройкиВариантовОтчетов")) 
		Или ТипЗначенияОбъекта = Строка(Тип("РегистрСведенийЗапись.ПользовательскиеНастройкиДоступаКОбработкам")) Тогда	
		
		ТекстЗапроса = ОбменДаннымиПовтИспСППР.СформироватьЗапросУзловДляОбъекта(СтроковоеПредставлениеТипа);
		Запрос = Новый Запрос(ТекстЗапроса);
		Запрос.УстановитьПараметр("СвойствоОбъекта_Ссылка", ЭлементДанных.Пользователь);
		
		
	ИначеЕсли ТипЗначенияОбъекта = Строка(Тип("СправочникОбъект.ВидыПланов")) Тогда
		
		ТекстЗапроса = ОбменДаннымиПовтИспСППР.СформироватьЗапросУзловДляОбъекта(СтроковоеПредставлениеТипа);
		Запрос = Новый Запрос(ТекстЗапроса);
		Запрос.УстановитьПараметр("СвойствоОбъекта_Пользователи", ЭлементДанных.УчастникиПланирования.ВыгрузитьКолонку("Участник"));
		
	ИначеЕсли ТипЗначенияОбъекта = Строка(Тип("РегистрСведенийЗапись.ЗаписиПлана")) Тогда
		
		МассивСотрудников = Новый Массив();
		ТекстЗапроса = ОбменДаннымиПовтИспСППР.СформироватьЗапросУзловДляОбъекта(СтроковоеПредставлениеТипа);
		Запрос = Новый Запрос(ТекстЗапроса);
		Запрос.УстановитьПараметр("СвойствоОбъекта_Пользователи", МассивСотрудников.Добавить(ЭлементДанных.Сотрудник));
	
	ИначеЕсли ТипЗначенияОбъекта = Тип("РегистрСведенийЗапись.ДополнительныеСведения") Тогда
		
		Возврат ПолучитьУзлыДляОбъекта(ЭлементДанных.Объект.ПолучитьОбъект()); 
		
	ИначеЕсли ТипЗначенияОбъекта = Тип("РегистрСведенийЗапись.НомераОтсканированныхФайлов") Тогда
		
		Возврат ПолучитьУзлыДляОбъекта(ЭлементДанных.Владелец.ПолучитьОбъект())
	Иначе		
		ТекстЗапроса = ОбменДаннымиПовтИспСППР.СформироватьЗапросУзловДляОбъекта();
		Запрос = Новый Запрос(ТекстЗапроса);
	КонецЕсли;
	
	Если Запрос <> Неопределено И Не ЗначениеЗаполнено(Запрос.Текст) Тогда
		Возврат Новый Массив();
	ИначеЕсли Запрос <> Неопределено И ЗначениеЗаполнено(Запрос.Текст) Тогда
		РезультатВыполненияЗапроса = Запрос.Выполнить().Выгрузить();
		Если РезультатВыполненияЗапроса.Количество()=0 Тогда
			Возврат Новый Массив();
		Иначе
			МассивРезультат = РезультатВыполненияЗапроса.ВыгрузитьКолонку("Ссылка");
		КонецЕсли;
		Возврат МассивРезультат;
	КонецЕсли;
КонецФункции

// Возвращает массив с разделами проекта, которые указаны в шапке и в табличной части объекта, еще не записанного в ИБ.
// Параметры:
//  ПроверяемыйОбъект - Произвольный - Объект, из которого необходимо получить разделы проекта
// Возвращаемое значение:
//  Массив, содержит элементы типа СправочникСсылка.РазделыПроекта.
Функция МассивРазделовПроектаИзОбъекта(ПроверяемыйОбъект) Экспорт
	МассивРазделов = Новый Массив;
	Если ЗначениеЗаполнено(ПроверяемыйОбъект.РазделПроекта) Тогда
		МассивРазделов.Добавить(ПроверяемыйОбъект.РазделПроекта);
	КонецЕсли;
	Для Каждого СтрокаТЧ Из ПроверяемыйОбъект.РазделыПроекта Цикл
		Если ЗначениеЗаполнено(СтрокаТЧ.Раздел) Тогда
			МассивРазделов.Добавить(СтрокаТЧ.Раздел);
		КонецЕсли;
	КонецЦикла;
	Возврат МассивРазделов;
КонецФункции

// Готовит структуру данных, в которую будут помещены исходные данные для заполнения настроек состава и отборов.
// Возвращаемое значение:
//  Структура
Функция ИсточникЗаполненияНастроекСоставаИОтборов() Экспорт
	ИсточникЗаполнения = Новый Структура();
	ИсточникЗаполнения.Вставить("Проекты");
	ИсточникЗаполнения.Вставить("ИспользоватьОтборПоРазделамПроектов");
	ИсточникЗаполнения.Вставить("РазделыПроектов");
	ИсточникЗаполнения.Вставить("ИспользоватьОтборПоПапкамФайлов");
	ИсточникЗаполнения.Вставить("ПапкиФайлов");
	ИсточникЗаполнения.Вставить("ИспользоватьСкрытиеИменПользователей");
	ИсточникЗаполнения.Вставить("Пользователи");
	ИсточникЗаполнения.Вставить("ИспользоватьОтборПоГруппамДоступа");
	ИсточникЗаполнения.Вставить("ГруппыДоступа");
	Возврат ИсточникЗаполнения;
КонецФункции

// Заполняет таблицы с составом отправляемых данных и с настройками отборов на основании реквизитов узла.
// Параметры:
//  ИсточникЗаполнения - Структура - Переменные формы узла или реквизиты самого узла.
//  РезультатЗаполнения - Структура, содержит заполняемые коллекции значений
//   * СоставДанных - СписокЗначений - заполняется списком отправляемых данных.
//   * НастройкаОтборов - ТаблицаЗначений - заполняется настройками отборов
Процедура ЗаполнитьНастройкиСоставаИОтборов(ИсточникЗаполнения, РезультатЗаполнения) Экспорт
	
	СтрФильтр = РезультатЗаполнения.НастройкаОтборов.Добавить();
	СтрФильтр.Использовать = ИсточникЗаполнения.ИспользоватьОтборПоРазделамПроектов;
	СтрФильтр.ВидФильтра = "По разделам проектов";
	СтрФильтр.СоставФильтра = ОбменДаннымиСППРКлиентСервер.СтроковоеПредставлениеОтбора(ИсточникЗаполнения, 
								"РазделыПроектов", "РазделПроекта", СтрФильтр.Использовать);
	
	СтрФильтр = РезультатЗаполнения.НастройкаОтборов.Добавить();
	СтрФильтр.Использовать = ИсточникЗаполнения.ИспользоватьОтборПоПапкамФайлов;
	СтрФильтр.ВидФильтра = "По папкам файлов";
	СтрФильтр.СоставФильтра = ОбменДаннымиСППРКлиентСервер.СтроковоеПредставлениеОтбора(ИсточникЗаполнения, 
								"ПапкиФайлов", "ПапкаФайлов", СтрФильтр.Использовать);
	
	СтрФильтр = РезультатЗаполнения.НастройкаОтборов.Добавить();
	СтрФильтр.Использовать = ИсточникЗаполнения.ИспользоватьСкрытиеИменПользователей;
	СтрФильтр.ВидФильтра = "По пользователям";
	СтрФильтр.СоставФильтра = ОбменДаннымиСППРКлиентСервер.СтроковоеПредставлениеОтбора(ИсточникЗаполнения, 
								"Пользователи", "Пользователь", СтрФильтр.Использовать);
	
	СтрФильтр = РезультатЗаполнения.НастройкаОтборов.Добавить();
	СтрФильтр.Использовать = ИсточникЗаполнения.ИспользоватьОтборПоГруппамДоступа;
	СтрФильтр.ВидФильтра = "По группам доступа";
	СтрФильтр.СоставФильтра = ОбменДаннымиСППРКлиентСервер.СтроковоеПредставлениеОтбора(ИсточникЗаполнения, 
								"ГруппыДоступа", "ГруппаДоступа", СтрФильтр.Использовать);
КонецПроцедуры

// Возвращает статус публикации для ошибки или для технического проекта.
Функция СтатусПубликацииДляОбъекта(ПроверяемыйОбъект) Экспорт
	
	Если ТипЗнч(ПроверяемыйОбъект) = Тип("СправочникСсылка.Ошибки") Тогда
		
		СтатусПубликации = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ПроверяемыйОбъект, "СтатусПубликации");
		Возврат (СтатусПубликации = Перечисления.СтатусыПубликацииОшибок.Публикуется);
		
	ИначеЕсли ТипЗнч(ПроверяемыйОбъект) = Тип("СправочникОбъект.Ошибки") Тогда
		
		Возврат ПроверяемыйОбъект.СтатусПубликации = Перечисления.СтатусыПубликацииОшибок.Публикуется;
		
	ИначеЕсли ТипЗнч(ПроверяемыйОбъект) = Тип("СправочникСсылка.ТехническиеПроекты")
		Или ТипЗнч(ПроверяемыйОбъект) = Тип("СправочникСсылка.Идеи")
		Или ТипЗнч(ПроверяемыйОбъект) = Тип("СправочникСсылка.ЗадачиПроцесса") Тогда
		
		Возврат ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ПроверяемыйОбъект, "Публикуется");
		
	ИначеЕсли ТипЗнч(ПроверяемыйОбъект) = Тип("СправочникОбъект.ТехническиеПроекты")
		Или ТипЗнч(ПроверяемыйОбъект) = Тип("СправочникОбъект.Идеи")
		Или ТипЗнч(ПроверяемыйОбъект) = Тип("СправочникОбъект.ЗадачиПроцесса") Тогда
		
		Возврат ПроверяемыйОбъект.Публикуется;
		
	ИначеЕсли ТипЗнч(ПроверяемыйОбъект) = Тип("СправочникСсылка.Файлы") Тогда
		
		ДанныеФайла = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(ПроверяемыйОбъект, "Публикуется, ВладелецФайла");
		
		Если ДанныеФайла.Публикуется Тогда
			// Проверка владельца файла.
			Возврат СтатусПубликацииДляОбъекта(ДанныеФайла.ВладелецФайла);
		Иначе
			Возврат Ложь;
		КонецЕсли;
		
	ИначеЕсли ТипЗнч(ПроверяемыйОбъект) = Тип("СправочникОбъект.Файлы") Тогда
		
		Если ПроверяемыйОбъект.Публикуется Тогда
			// Проверка владельца файла.
			Возврат СтатусПубликацииДляОбъекта(ПроверяемыйОбъект.ВладелецФайла);
		Иначе
			Возврат Ложь;
		КонецЕсли;
		
	ИначеЕсли ТипЗнч(ПроверяемыйОбъект) = Тип("СправочникСсылка.ВерсииФайлов") Тогда
		
		Возврат СтатусПубликацииДляОбъекта(ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ПроверяемыйОбъект, "Владелец"));
		
	ИначеЕсли ТипЗнч(ПроверяемыйОбъект) = Тип("СправочникОбъект.ВерсииФайлов") Тогда
		
		Возврат СтатусПубликацииДляОбъекта(ПроверяемыйОбъект.Владелец);
		
	КонецЕсли;
	
	Возврат Истина;
	
КонецФункции

// Выполняет регистрацию файлов для объектов, которые содержат присоединенные файлы.
// Необходима, если у объекта изменился признак публикации - возможно следует зарегистрировать файлы.
//  Объект - СправочникСсылка.Файлы, СправочникСсылка.ВерсииФайлов - выгружаемый объект
//  Получатели - Массив - Узлы-получатели
//  ЭтоФайл - Булево - тип объекта СправочникСсылка.Файлы 
Процедура ЗарегистрироватьКОбменуПрисоединенныеФайлы(Объект, Получатели) Экспорт
	
	// Не публикуемый объект не имеет смысла обрабатывать.
	Если Не СтатусПубликацииДляОбъекта(Объект) Тогда
		Возврат;
	КонецЕсли;
	
	ОбъектСсылка = Объект.Ссылка;
	УзлыДляРегистрации = УзлыФильтрПоПубликацииДляСсылки(ОбъектСсылка, Получатели);
	Если УзлыДляРегистрации = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	// Выбираем принадлежащие объекту файлы.
	// Сразу отсекаем не публикуемые файлы - регистрировать их не имеет смысла.
	Запрос = Новый Запрос("ВЫБРАТЬ
		|	Ссылка
		|ИЗ Справочник.Файлы
		|ГДЕ ВладелецФайла = &ОбъектСсылка И Публикуется");
	Запрос.УстановитьПараметр("ОбъектСсылка", Объект.Ссылка);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		ПланыОбмена.ЗарегистрироватьИзменения(УзлыДляРегистрации, Выборка.Ссылка);
		ЗарегистрироватьКОбменуСведенияОФайлах(Выборка.Ссылка, УзлыДляРегистрации, Истина);
	КонецЦикла;
	
КонецПроцедуры

// Выполняет регистрацию данных, связанных с выгружаемыми файлами / версиями файлов.
// Параметры:
//  Объект - СправочникСсылка.Файлы, СправочникСсылка.ВерсииФайлов - выгружаемый объект
//  Получатели - Массив - Узлы-получатели
//  ЭтоФайл - Булево - тип объекта СправочникСсылка.Файлы 
Процедура ЗарегистрироватьКОбменуСведенияОФайлах(Объект, Получатели, ЭтоФайл) Экспорт
	ОбъектСсылка = Объект.Ссылка;
	ВладелецФайла = ?(ЭтоФайл, 
					Объект.ВладелецФайла, Объект.Владелец.ВладелецФайла);
	УзлыДляРегистрации = УзлыФильтрПоПубликацииДляСсылки(ВладелецФайла, Получатели);
	Если УзлыДляРегистрации = Неопределено Тогда
		Возврат;
	КонецЕсли;
	// Возможно поменялся признак публикации у файла. Следует принудительно зарегистрировать РС НаличиеФайлов.
	НаборЗаписейНаличиеФайлов = РегистрыСведений.НаличиеФайлов.СоздатьНаборЗаписей();
	НаборЗаписейНаличиеФайлов.Отбор.ОбъектСФайлами.Установить(ВладелецФайла);
	ПланыОбмена.ЗарегистрироватьИзменения(УзлыДляРегистрации, НаборЗаписейНаличиеФайлов);
	
	// Возможно поменялся признак публикации у файла. Следует принудительно зарегистрировать текущую версию файла.
	Если ЭтоФайл 
		И ЗначениеЗаполнено(Объект.ТекущаяВерсия) Тогда
		ПланыОбмена.ЗарегистрироватьИзменения(УзлыДляРегистрации, Объект.ТекущаяВерсия);
	КонецЕсли;
КонецПроцедуры

// Формирует текст и параметры запроса для регистрации Задач процесса и связанных с ним регистров сведений.
// Параметры:
//  Предмет - связанный с выгружаемым объектом предмет (техпроект, задача процесса и т.п.).
//  Отказ - Булево - признак отказа от регистрации.
//  ИспользоватьКэш - Булево - см. параметры обработчика ПередОбработкой в ПРО
//  ТекстЗапроса - Строка - см. параметры обработчика ПередОбработкой в ПРО
//  ПараметрыЗапроса - Структура - см. параметры обработчика ПередОбработкой в ПРО
Процедура ОбработатьРегистрациюЗадачиПроцесса(Предмет, Отказ, ИспользоватьКэш, ТекстЗапроса, ПараметрыЗапроса) Экспорт
	Если Не ЗначениеЗаполнено(Предмет) Тогда
		Отказ = Истина;
	ИначеЕсли Не ОбщегоНазначения.СсылкаСуществует(Предмет) Тогда
		Отказ = Истина;
	Иначе
		ПараметрыДляОбработки = ПараметрыДляОбработкиПредметаПроцесса(Предмет);
		Если ПараметрыДляОбработки.Отказ Тогда
			Отказ = Истина;
		Иначе
			ИспользоватьКэш = Ложь;
			ТекстЗапроса = ОбменДаннымиПовтИспСППР.СформироватьЗапросУзловДляОбъекта(ПараметрыДляОбработки.ТипЗначенияОбъекта);
			Для Каждого ТекПараметр Из ПараметрыДляОбработки.ПараметрыЗапроса Цикл
				ПараметрыЗапроса.Вставить(ТекПараметр.Ключ, ТекПараметр.Значение);
			КонецЦикла;
		КонецЕсли;
	КонецЕсли;
	Если Отказ Тогда 
		Возврат;
	КонецЕсли;
	// Корректировка текста запроса: "навешивание" условия по выгрузке задач.
	ТекстЗапроса = "ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	РИБСОтборамиПроекты.Ссылка
	|ИЗ ПланОбмена.РИБСОтборами.Проекты КАК РИБСОтборамиПроекты
	|ГДЕ РИБСОтборамиПроекты.СинхронизироватьЗадачи
	|	И РИБСОтборамиПроекты.Ссылка В ( " + ТекстЗапроса + ")
	|	И (НЕ РИБСОтборамиПроекты.ТолькоПубликуемыеЗадачи
	|		ИЛИ &СвойствоОбъекта_ЗадачаПубликуется)
	|	И РИБСОтборамиПроекты.Проект = &СвойствоОбъекта_Проект"; 
	ПараметрыЗапроса.Вставить("Проект", ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Предмет, "Владелец"));

КонецПроцедуры

Функция ПараметрыДляОбработкиПредметаПроцесса(ПредметПроцессаСсылка)
	ПараметрыДляОбработки = Новый Структура("Отказ, ТипЗначенияОбъекта, ПараметрыЗапроса", Ложь, "", Новый Структура());
	МассивТипов = Новый Массив();
	МассивТипов.Добавить(Тип("СправочникСсылка.Процессы"));
	МассивТипов.Добавить(Тип("СправочникСсылка.ПрофилиПользователей"));
	МассивТипов.Добавить(Тип("СправочникСсылка.ОбъектыМетаданных"));
	МассивТипов.Добавить(Тип("СправочникСсылка.ТехническиеПроекты"));
	МассивТипов.Добавить(Тип("СправочникСсылка.Ошибки"));
	МассивТипов.Добавить(Тип("СправочникСсылка.СборкиВерсии"));
	МассивТипов.Добавить(Тип("СправочникСсылка.ФункцииСистемы"));

	Если МассивТипов.Найти(ТипЗнч(ПредметПроцессаСсылка)) = Неопределено Тогда
		// Этот объект не мигрирует в РИБ.
		ПараметрыДляОбработки.Отказ = Истина;
	ИначеЕсли ТипЗнч(ПредметПроцессаСсылка) = Тип("СправочникСсылка.ТехническиеПроекты") Тогда
		ПараметрыДляОбработки.ТипЗначенияОбъекта = "СправочникОбъект.ТехническиеПроекты";
		РеквизитыДляПараметров = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(ПредметПроцессаСсылка, "Владелец, Публикуется");
		ПараметрыДляОбработки.ПараметрыЗапроса.Вставить("Ссылка", РеквизитыДляПараметров.Владелец);
		ПараметрыДляОбработки.ПараметрыЗапроса.Вставить("Публикуется", РеквизитыДляПараметров.Публикуется);
		ПараметрыДляОбработки.ПараметрыЗапроса.Вставить("МассивРазделов", ОбменДаннымиПовтИспСППР.МассивРазделовПроектаИзСсылки(ПредметПроцессаСсылка));
	ИначеЕсли ТипЗнч(ПредметПроцессаСсылка) = Тип("СправочникСсылка.Ошибки") Тогда
		ПараметрыДляОбработки.ТипЗначенияОбъекта = "СправочникОбъект.Ошибки";
		РеквизитыДляПараметров = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(ПредметПроцессаСсылка, "Владелец, СтатусПубликации");
		ПараметрыДляОбработки.ПараметрыЗапроса.Вставить("Ссылка", РеквизитыДляПараметров.Владелец);
		ПараметрыДляОбработки.ПараметрыЗапроса.Вставить("Публикуется", (РеквизитыДляПараметров.СтатусПубликации = Перечисления.СтатусыПубликацииОшибок.Публикуется));
		ПараметрыДляОбработки.ПараметрыЗапроса.Вставить("МассивРазделов", ОбменДаннымиПовтИспСППР.МассивРазделовПроектаИзСсылки(ПредметПроцессаСсылка));
	Иначе
		ПараметрыДляОбработки.ТипЗначенияОбъекта = "СправочникОбъект." + ПредметПроцессаСсылка.Метаданные().Имя;
		ПараметрыДляОбработки.ПараметрыЗапроса = Новый Структура();
		ПараметрыДляОбработки.ПараметрыЗапроса.Вставить("Ссылка", ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ПредметПроцессаСсылка, "Владелец"));
	КонецЕсли;
	Возврат ПараметрыДляОбработки;
КонецФункции

Функция УзлыФильтрПоПубликацииДляСсылки(ОбъектСсылка, ФильтрУзлы) Экспорт
	ТипОбъекта = ТипЗнч(ОбъектСсылка);
	Если ТипОбъекта = Тип("СправочникСсылка.Идеи")
		Или ТипОбъекта = Тип("СправочникСсылка.Ошибки")
		Или ТипОбъекта = Тип("СправочникСсылка.ТехническиеПроекты")
		Или ТипОбъекта = Тип("СправочникСсылка.Регламенты") Тогда
		ПроектВладелец = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ОбъектСсылка, "Владелец");
		ИмяРеквизитаТолькоПубликуемые = "";
		Если ТипОбъекта = Тип("СправочникСсылка.Идеи") Тогда
			ИмяРеквизитаТолькоПубликуемые = "ТолькоПубликуемыеИдеи";
		ИначеЕсли ТипОбъекта = Тип("СправочникСсылка.Ошибки") Тогда
			ИмяРеквизитаТолькоПубликуемые = "ТолькоПубликуемыеОшибки";
		ИначеЕсли ТипОбъекта = Тип("СправочникСсылка.ТехническиеПроекты") Тогда
			ИмяРеквизитаТолькоПубликуемые = "ТолькоПубликуемыеТехническиеПроекты";
		ИначеЕсли ТипОбъекта = Тип("СправочникСсылка.Регламенты") Тогда
			ИмяРеквизитаТолькоПубликуемые = "ТолькоПубликуемыеРегламенты"; 
		КонецЕсли;
		Запрос = Новый Запрос;
		Запрос.Текст = "ВЫБРАТЬ
		|	Ссылка КАК Узел
		|ИЗ ПланОбмена.РИБСОтборами.Проекты
		|ГДЕ Проект = &Проект И Ссылка В (&Узлы)
		|	И " + ИмяРеквизитаТолькоПубликуемые + " = ИСТИНА";
		Запрос.УстановитьПараметр("Узлы", ФильтрУзлы);
		Запрос.УстановитьПараметр("Проект", ПроектВладелец);
		Результат = Запрос.Выполнить();
		Если Результат.Пустой() Тогда
			Возврат Неопределено;
		КонецЕсли;
		Возврат Результат.Выгрузить().ВыгрузитьКолонку("Узел");
	КонецЕсли;
	Возврат Неопределено;
КонецФункции

Процедура ПослеОбработкиРегистраСостоянийЗадач(Получатели) Экспорт
	ПараметрыСеансаСинхронизацииДанных = Новый Соответствие;
	УстановитьПривилегированныйРежим(Истина);
	Попытка
		ТекущийПараметрСеанса = ПараметрыСеанса.ПараметрыСеансаСинхронизацииДанных.Получить();
	Исключение
		ТекущийПараметрСеанса = Неопределено;
	КонецПопытки;
	УстановитьПривилегированныйРежим(Ложь);
	
	Если ТипЗнч(ТекущийПараметрСеанса) = Тип("Соответствие") Тогда
		ПараметрОтключенаРегистрация = ТекущийПараметрСеанса.Получить("ОтключитьРегистрациюСостоянийЗадач");
		Если ПараметрОтключенаРегистрация = Неопределено Тогда
			Возврат;
		КонецЕсли;
		ПолучателиКУдалению = Новый Массив;
		Для Каждого УзелИФлаг Из ПараметрОтключенаРегистрация Цикл
			Если УзелИФлаг.Значение = Истина Тогда
				ПолучателиКУдалению.Добавить(УзелИФлаг.Ключ);
			КонецЕсли;
		КонецЦикла;
		Для Каждого УзелКУдалению Из ПолучателиКУдалению Цикл
			ИндексВМассиве = Получатели.Найти(УзелКУдалению);
			Если ИндексВМассиве <> Неопределено Тогда
				Получатели.Удалить(ИндексВМассиве);
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
КонецПроцедуры
#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Возвращает сокращенное строковое представление коллекции значений
// 
// Параметры:
//  Коллекция 						- массив или список значений.
//  МаксимальноеКоличествоЭлементов - число, максимальное количество элементов включаемое в представление.
//
// Возвращаемое значение:
//  Строка.
//
Функция СокращенноеПредставлениеКоллекцииЗначений(Коллекция, МаксимальноеКоличествоЭлементов = 2) Экспорт
	
	СтрокаПредставления = "";
	
	КоличествоЗначений			 = Коллекция.Количество();
	КоличествоВыводимыхЭлементов = Мин(КоличествоЗначений, МаксимальноеКоличествоЭлементов);
	
	Если КоличествоВыводимыхЭлементов = 0 Тогда
		
		Возврат "";
		
	Иначе
		
		Для НомерЗначения = 1 По КоличествоВыводимыхЭлементов Цикл
			
			СтрокаПредставления = СтрокаПредставления + Коллекция.Получить(НомерЗначения - 1) + ", ";	
			
		КонецЦикла;
		
		СтрокаПредставления = Лев(СтрокаПредставления, СтрДлина(СтрокаПредставления) - 2);
		Если КоличествоЗначений > КоличествоВыводимыхЭлементов Тогда
			СтрокаПредставления = СтрокаПредставления + ", ... ";
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат СтрокаПредставления;
	
КонецФункции

// Возвращает признак доступности плана обмена в базовой версии
Функция ДоступностьПланаОбменаВБазовойВерсии(ИмяПланаОбмена,СообщатьПользователю = Истина)
	
	КоличествоУзловПланаОбмена = 2;
	СписокДоступныхПлановОбмена = ОбменДаннымиПовтИсп.ПланыОбменаБСП();
	
	Если СписокДоступныхПлановОбмена.Найти(ИмяПланаОбмена) <> Неопределено
		И ОбменДаннымиСобытия.ВсеУзлыПланаОбмена(ИмяПланаОбмена).Количество() < КоличествоУзловПланаОбмена Тогда
		Возврат Истина;
	Иначе
		
		Если СообщатьПользователю тогда
			Сообщение = Новый СообщениеПользователю;
			Сообщение.Текст = НСтр("ru='Используются ограничения базовой версии. Выбранный план обмена создать невозможно.'");
			Сообщение.Сообщить();
		КонецЕсли;
		
		Возврат Ложь;
		
	КонецЕсли;
	
КонецФункции

// Возвращает массив доступных для изменения в подчиненном узле констант
Функция НастройкиДоступныеДляИзмененияВПодчиненномУзле()
	
	МассивНастроек = Новый Массив;
	Возврат МассивНастроек;
	
КонецФункции

#Область ОбработчикиОбновленияИнформационнойБазы

// Добавляет в список процедуры-обработчики обновления данных ИБ
// для всех поддерживаемых версий библиотеки или конфигурации.
// Вызывается перед началом обновления данных ИБ для построения плана обновления.
//
// Параметры:
//  Обработчики - ТаблицаЗначений - описание полей 
//                                  см. в процедуре ОбновлениеИнформационнойБазы.НоваяТаблицаОбработчиковОбновления
//
// Пример добавления процедуры-обработчика в список:
//  Обработчик = Обработчики.Добавить();
//  Обработчик.Версия              = "1.0.0.0";
//  Обработчик.Процедура           = "ОбновлениеИБ.ПерейтиНаВерсию_1_0_0_0";
//  Обработчик.МонопольныйРежим    = Ложь;
//  Обработчик.Опциональный        = Истина;
// 
Процедура ПриДобавленииОбработчиковОбновления(Обработчики) Экспорт
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти