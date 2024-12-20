﻿
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ)
	
	ДополнительныеСвойства.Вставить("ДанныеПередЗаписью", ДанныеПередЗаписью());
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ДанныеПередЗаписью = ДополнительныеСвойства.ДанныеПередЗаписью;
	
	Если Не ДанныеПередЗаписью.ПриоритетПоУмолчанию 
		И ПриоритетПоУмолчанию Тогда
		
		СнятьПризнакОсновнойУДругихПриоритетовЕслиНеобходимо();
		Справочники.ПриоритетыРабот.УстановитьПриоритетПоУмолчаниюВФоне(Владелец, Истина);

		
	ИначеЕсли Не ДанныеПередЗаписью.ПометкаУдаления 
		И ПометкаУдаления Тогда
		
		Справочники.ПриоритетыРабот.УстановитьПриоритетПоУмолчаниюВФоне(Владелец, Истина);
			
	ИначеЕсли ДанныеПередЗаписью.ПометкаУдаления 
		И Не ПометкаУдаления Тогда
		
		Справочники.ПриоритетыРабот.УстановитьПриоритетПоУмолчаниюВФоне(Владелец, Истина);
		
	ИначеЕсли ДанныеПередЗаписью.Порядок <> Порядок Тогда
		
		РегистрыСведений.ОчередиРаботСотрудников.СформироватьОчередьРаботСотрудников(
			РегистрыСведений.ОчередиРаботСотрудников.НовыйПараметрыФормированияОчередиСотрудников());
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	
	Порядок = 0;
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	ДанныеДоступныхЗначенийПорядка = Справочники.ПриоритетыРабот.ДоступныеДляПроектаЗначенияПорядкаПриоритета(Владелец, Ссылка);
	
	Если ДанныеДоступныхЗначенийПорядка.ДоступныеЗначения.Найти(Порядок) = Неопределено Тогда
		
		ТекстСообщения = НСтр("ru = 'Недопустимое значение порядка.'") + " " + ДанныеДоступныхЗначенийПорядка.Представление;
		ОбщегоНазначения.СообщитьПользователю(ТекстСообщения, Ссылка, "Порядок",,Отказ);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура СнятьПризнакОсновнойУДругихПриоритетовЕслиНеобходимо()

	Если ПриоритетПоУмолчанию Тогда
		
		Запрос = Новый Запрос;
		Запрос.Текст = "
		|ВЫБРАТЬ
		|	ПриоритетыРабот.Ссылка       КАК Ссылка,
		|	ПриоритетыРабот.Наименование КАК Наименование
		|ИЗ
		|	Справочник.ПриоритетыРабот КАК ПриоритетыРабот
		|ГДЕ
		|	ПриоритетыРабот.Ссылка <> &Ссылка
		|	И ПриоритетыРабот.ПриоритетПоУмолчанию
		|	И ПриоритетыРабот.Владелец = &Проект";
		
		Запрос.УстановитьПараметр("Ссылка", Ссылка);
		Запрос.УстановитьПараметр("Проект", Владелец);
		
		Результат = Запрос.Выполнить();
		
		Если Результат.Пустой() Тогда
			Возврат;
		КонецЕсли;
		
		Выборка = Результат.Выбрать();
		
		Пока Выборка.Следующий() Цикл
		
			Попытка
				ЗаблокироватьДанныеДляРедактирования(Выборка.Ссылка);
			Исключение
				ТекстОшибки = СтрШаблон(НСтр("ru='Не удалось заблокировать приоритет ""%1"" для снятия признака ""Приоритет по умолчанию"". %2'"), 
				                        Выборка.Наименование,
				                        КраткоеПредставлениеОшибки(ИнформацияОбОшибке()));
				                        ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстОшибки, Выборка.Ссылка);
				Отказ = Истина;
				Возврат;
			КонецПопытки;
			
			СправочникОбъект = Выборка.Ссылка.ПолучитьОбъект();
			СправочникОбъект.ПриоритетПоУмолчанию = Ложь;
			
			Попытка
				СправочникОбъект.Записать();
			Исключение
				ТекстОшибки = СтрШаблон(НСтр("ru='Не удалось записать приоритет ""%1"" для снятия признака ""Приоритет по умолчанию"". %2'"), 
				                        СправочникОбъект.Наименование, 
				                        КраткоеПредставлениеОшибки(ИнформацияОбОшибке()));
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстОшибки, СправочникОбъект.Ссылка);
				Отказ = Истина;
				Возврат;
			КонецПопытки;
		
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

Функция ДанныеПередЗаписью() 
	
	ДанныеПередЗаписью = Новый Структура;
	ДанныеПередЗаписью.Вставить("ПометкаУдаления",      Ложь);
	ДанныеПередЗаписью.Вставить("ПриоритетПоУмолчанию", Ложь);
	ДанныеПередЗаписью.Вставить("Порядок",              0);
	
	Запрос = Новый Запрос;
	Запрос.Текст = "
	|ВЫБРАТЬ
	|	ПриоритетыРабот.ПометкаУдаления      КАК ПометкаУдаления,
	|	ПриоритетыРабот.ПриоритетПоУмолчанию КАК ПриоритетПоУмолчанию,
	|	ПриоритетыРабот.Порядок              КАК Порядок
	|ИЗ
	|	Справочник.ПриоритетыРабот КАК ПриоритетыРабот
	|ГДЕ
	|	ПриоритетыРабот.Ссылка = &Ссылка";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Выборка.Следующий() Тогда
	
		ДанныеПередЗаписью.ПометкаУдаления      = Выборка.ПометкаУдаления;
		ДанныеПередЗаписью.ПриоритетПоУмолчанию = Выборка.ПриоритетПоУмолчанию;
		ДанныеПередЗаписью.Порядок              = Выборка.Порядок;
	
	КонецЕсли;
	
	Возврат ДанныеПередЗаписью;
	
КонецФункции

#КонецОбласти

#КонецЕсли