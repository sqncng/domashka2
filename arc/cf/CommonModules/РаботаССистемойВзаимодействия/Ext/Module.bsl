﻿////////////////////////////////////////////////////////////////////////////////
// Общие процедуры для работы с системой взаимодействия
// 
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Выполняет добавление сообщения системы взаимодействия в контексте указанного объекта.
//
// Параметры:
//  СсылкаНаОбъект - Любая ссылка
//  ПользовательПолучательСообщения - СправочникСсылка.Пользователи, Массив - пользователь (или массив пользователей), которому адресовано сообщение
//  ПользовательАвторСообщения - СправочникСсылка.Пользователипользователь-отправитель сообщения
//  ЗаголовокОбсуждения - Строка - заголовок для обсуждения, в рамках которого будет выполнено добавление сообщения
//  ТекстСообщения - Строка - текст добавляемого сообщения.
//  Действия - СписокЗначений - список действий, допустимых в сообщении
//
Процедура ДобавитьСообщениеПоОбъекту(СсылкаНаОбъект, ПользовательПолучательСообщения, ПользовательАвторСообщения, ЗаголовокОбсуждения, ТекстСообщения, Действия = Неопределено) Экспорт
	
	ИдентификаторАвтораСообщения = ПользовательДляСистемыВзаимодействия(ПользовательАвторСообщения);
	
	Если ИдентификаторАвтораСообщения = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ИдентификаторыАдресатовСообщения = Новый Массив;
	
	Если ТипЗнч(ПользовательПолучательСообщения) = Тип("СправочникСсылка.Пользователи") Тогда
		
		ИдентификаторАдресатаСообщения = ПользовательДляСистемыВзаимодействия(ПользовательПолучательСообщения);
		
		Если ИдентификаторАдресатаСообщения = Неопределено Тогда
			Возврат;
		КонецЕсли;
		
		ИдентификаторыАдресатовСообщения.Добавить(ИдентификаторАдресатаСообщения);
		
	ИначеЕсли ТипЗнч(ПользовательПолучательСообщения) = Тип("Массив") Тогда
		
		Для Каждого Пользователь из ПользовательПолучательСообщения Цикл
			
			ИдентификаторАдресатаСообщения = ПользовательДляСистемыВзаимодействия(Пользователь);
			
			Если ИдентификаторАдресатаСообщения = Неопределено Тогда
				Возврат;
			КонецЕсли;
			
			ИдентификаторыАдресатовСообщения.Добавить(ИдентификаторАдресатаСообщения);
			
		КонецЦикла;
		
	КонецЕсли;
	
	Если ИдентификаторыАдресатовСообщения.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ИдентификаторОбсуждения = ДобавитьКонтекстноеОбсуждение(СсылкаНаОбъект, ЗаголовокОбсуждения);
	
	ДобавитьСообщениеОбсуждения(ИдентификаторОбсуждения, ТекстСообщения,
	                            ИдентификаторыАдресатовСообщения, ИдентификаторАвтораСообщения, Действия);
	
КонецПроцедуры

// Выполняет добавление сообщения системы взаимодействия в контексте указанного объекта.
//
// Параметры:
//  СсылкаНаОбъект - Любая ссылка
//  ПользовательПолучательСообщения - СправочникСсылка.Пользователи - пользователь, которому адресовано сообщение
//  ПользовательАвторСообщения - СправочникСсылка.Пользователи - пользователь-отправитель сообщения
//  ТекстСообщения - Строка - текст добавляемого сообщения.
//  Действия - СписокЗначений - список действий, допустимых в сообщении.
//
Процедура ДобавитьНеконтекстноеСообщение(ПользовательПолучательСообщения, ПользовательАвторСообщения, ТекстСообщения, Действия) Экспорт
	
	ИдентификаторАдресатаСообщения = ПользовательДляСистемыВзаимодействия(ПользовательПолучательСообщения);
	ИдентификаторАвтораСообщения = ПользовательДляСистемыВзаимодействия(ПользовательАвторСообщения);
	
	Если ИдентификаторАдресатаСообщения = Неопределено
		ИЛИ ИдентификаторАвтораСообщения = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	УчастникиОбсуждения = Новый Массив;
	УчастникиОбсуждения.Добавить(ИдентификаторАдресатаСообщения);
	УчастникиОбсуждения.Добавить(ИдентификаторАвтораСообщения);
	
	ИдентификаторОбсуждения = ДобавитьНеконтекстноеОбсуждение(УчастникиОбсуждения);
	
	ИдентификаторыПолучателей = Новый Массив;
	ИдентификаторыПолучателей.Добавить(ИдентификаторАдресатаСообщения);
	
	ДобавитьСообщениеОбсуждения(ИдентификаторОбсуждения, ТекстСообщения,
	                            ИдентификаторыПолучателей, ИдентификаторАвтораСообщения, Действия);
	
КонецПроцедуры

// Получает и возвращает имееющиеся сообщения по объекту.
//
// Параметры:
//  ПользовательПолучательСообщения - СправочникСсылка.Пользователи - пользователь, которому адресовано сообщение
//  ПользовательАвторСообщения - СправочникСсылка.Пользователи - пользователь-отправитель сообщения
//  ЗаголовокОбсуждения - Строка - заголовок для обсуждения, в рамках которого будет выполнено добавление сообщения
//  ДатаНачала - Дата - дата, начиная с которой выбираются сообщения.
//
// Возвращаемое значение:
//  Сообщения - Массив - найденные сообщения.
//
Функция СообщенияПоОбъекту(СсылкаНаОбъект, ПользовательПолучательСообщения, ПользовательАвторСообщения, ЗаголовокОбсуждения, ДатаНачала) Экспорт
	
	НайденныеСообщения = Новый Массив;
	
	ИдентификаторАдресатаСообщения = ПользовательДляСистемыВзаимодействия(ПользовательПолучательСообщения);
	ИдентификаторАвтораСообщения = ПользовательДляСистемыВзаимодействия(ПользовательАвторСообщения);
	
	НавигационнаяСсылкаПредмета = ПолучитьНавигационнуюСсылку(СсылкаНаОбъект);
	
	Если НЕ ЗначениеЗаполнено(ИдентификаторАдресатаСообщения)
		ИЛИ НЕ ЗначениеЗаполнено(ИдентификаторАвтораСообщения) Тогда
		Возврат НайденныеСообщения;
	КонецЕсли;
	
	КонтекстОбсуждения = Новый КонтекстОбсужденияСистемыВзаимодействия(НавигационнаяСсылкаПредмета);
	
	ОтборОбсуждений = Новый ОтборОбсужденийСистемыВзаимодействия;
	
	ОтборОбсуждений.Групповое = Истина;
	ОтборОбсуждений.КонтекстноеОбсуждение = Истина;
	ОтборОбсуждений.КонтекстОбсуждения = КонтекстОбсуждения;
	ОтборОбсуждений.Отображаемое = Истина;
	ОтборОбсуждений.НаправлениеСортировки = НаправлениеСортировки.Возр;
	ОтборОбсуждений.ДатаНачала = ДатаНачала;
	ОтборОбсуждений.ТекущийПользовательЯвляетсяУчастником = Ложь;
	
	ОтобранныеОбсуждения = СистемаВзаимодействия.ПолучитьОбсуждения(ОтборОбсуждений);
	
	Для Каждого Обсуждение из ОтобранныеОбсуждения Цикл
		Если Обсуждение.Заголовок = ЗаголовокОбсуждения Тогда
			
			ОтборСообщений = Новый ОтборСообщенийСистемыВзаимодействия;
			ОтборСообщений.Обсуждение = Обсуждение.Идентификатор;
			
			Сообщения = СистемаВзаимодействия.ПолучитьСообщения(ОтборСообщений);
			
			Для Каждого Сообщение из Сообщения Цикл
				Если Сообщение.Дата > ДатаНачала И Сообщение.Автор = ИдентификаторАвтораСообщения
					И Сообщение.Получатели.Содержит(ИдентификаторАдресатаСообщения) Тогда
					НайденныеСообщения.Добавить(Сообщение);
				КонецЕсли;
			КонецЦикла;
			
		КонецЕсли;
	КонецЦикла;
	
	Возврат НайденныеСообщения;
	
КонецФункции

// Добавляет контекстное обсуждение в рамках указанного объекта.
//
// Параметры:
//  СсылкаНаОбъект - Любая ссылка
//  ЗаголовокОбсуждения - Строка - заголовок для добавляемого обсуждения.
//
Функция ДобавитьКонтекстноеОбсуждение(СсылкаНаОбъект, ЗаголовокОбсуждения) Экспорт
	
	НавигационнаяСсылкаПредмета = ПолучитьНавигационнуюСсылку(СсылкаНаОбъект);
	
	КонтекстОбсуждения = Новый КонтекстОбсужденияСистемыВзаимодействия(НавигационнаяСсылкаПредмета);
	
	Обсуждение = СистемаВзаимодействия.СоздатьОбсуждение();
	
	Обсуждение.Групповое = Истина;
	Обсуждение.КонтекстОбсуждения = КонтекстОбсуждения;
	Обсуждение.Отображаемое = Истина;
	
	Обсуждение.Заголовок = ЗаголовокОбсуждения;
	
	Обсуждение.Записать();
	
	Возврат Обсуждение.Идентификатор;
	
КонецФункции

// Добавляет неконтекстное обсуждение.
//
// Параметры:
//  УчастникиОбсуждения - Массив - идентификаторы участников обсуждения.
//
Функция ДобавитьНеконтекстноеОбсуждение(УчастникиОбсуждения) Экспорт
	
	Обсуждение = СистемаВзаимодействия.СоздатьОбсуждение();
	
	Обсуждение.Групповое = Ложь;
	Обсуждение.Отображаемое = Истина;
	
	Для Каждого ИдентификаторУчастника из УчастникиОбсуждения Цикл
		Обсуждение.Участники.Добавить(ИдентификаторУчастника);
	КонецЦикла;
	
	Обсуждение.Записать();
	
	Возврат Обсуждение.Идентификатор;
	
КонецФункции

// Добавляет новое сообщение в рамках указанного обсуждения.
//
// Параметры:
//  ИдентификаторОбсуждения - ИдентификаторОбсужденияСистемыВзаимодействия - идентификатор обсуждения,
//                            в рамках которого добавляется сообщения
//  ТекстСообщения - Строка - текст добавляемого сообщения
//  ИдентификаторыПолучателей - КоллекцияИдентификаторовПользователейСистемыВзаимодействия  - идентификаторы получателей
//  ИдентификаторАвтора - ИдентификаторПользователяСистемыВзаимодействия - идентификатор автора ссобщения.
//
Процедура ДобавитьСообщениеОбсуждения(ИдентификаторОбсуждения, ТекстСообщения, ИдентификаторыПолучателей, ИдентификаторАвтора, Действия = Неопределено) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	СообщениеОбсуждения = СистемаВЗаимодействия.СоздатьСообщение(ИдентификаторОбсуждения);
	
	Для Каждого ИдентификаторПолучателя из ИдентификаторыПолучателей Цикл
		СообщениеОбсуждения.Получатели.Добавить(ИдентификаторПолучателя);
	КонецЦикла;
	
	СообщениеОбсуждения.Текст = ТекстСообщения;
	СообщениеОбсуждения.Автор = ИдентификаторАвтора;
	
	Если ТипЗнч(Действия) = Тип("СписокЗначений") Тогда
		Для Каждого ЭлементСписка из Действия Цикл
			СообщениеОбсуждения.Действия.Добавить(ЭлементСписка.Значение, ЭлементСписка.Представление);
		КонецЦикла;
	КонецЕсли;
	
	СообщениеОбсуждения.Записать();
	
КонецПроцедуры

// Возвращает идентификатор пользователя по указанному пользователю.
//
// Параметры:
//  Пользователь - СправочникСсылка.Пользователи - пользователь, для которого требуется получить идентификатор
//
// Возвращаемое значение:
//  Идентификатор - ИдентификаторПользователяСистемыВзаимодействия - идентификатор для указанного пользователя.
//
Функция ПользовательДляСистемыВзаимодействия(Пользователь) Экспорт
	
	ИдентификаторПользователяИБ = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Пользователь, "ИдентификаторПользователяИБ");
	
	Попытка
		 ИдентификаторПользователя= СистемаВзаимодействия.ПолучитьИдентификаторПользователя(ИдентификаторПользователяИБ);
	 Исключение
		 ИдентификаторПользователя = Неопределено;
		 
		 ИмяСобытия = НСтр("ru ='Получение пользователя системы взаимодействия'");
		 
		 ТекстКомментария = НСтр("ru = 'Не удалось получить пользователя системы взаимодействия для пользователя %Пользователь%'");
		 ТекстКомментария = СтрЗаменить(ТекстКомментария, "%Пользователь%", Пользователь);
		 
		 ЗаписьЖурналаРегистрации(ИмяСобытия, УровеньЖурналаРегистрации.Предупреждение,,, ТекстКомментария);
				
	КонецПопытки;
	
	Возврат ИдентификаторПользователя;
	
КонецФункции

#КонецОбласти