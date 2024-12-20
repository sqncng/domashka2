﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область ПрограммныйИнтерфейс

Процедура ОбновитьГиперссылкиСправки(ТекстСправки, ГиперссылкиДляСправки, ГиперссылкаПоУмолчанию = Неопределено, УдалятьЛишние = Истина) Экспорт
	
	// Замечание. Правильность расстановки тэгов (т.е. "висящие", не имеющие пары) не контролируется,
	// так как, скорее всего, будут пропущены браузером.
	МассивТекстовГиперссылок = Новый Массив;
	
	ОстатокТекстаСправки = ТекстСправки;
	
	// Воспользуемся тем, что поиск подстроки выполняется сначала текста
	ПозицияОткрывающегоТэга = Найти(ОстатокТекстаСправки, "<A>");
	
	ТекстыГиперссылокВРег = ГиперссылкиДляСправки.Выгрузить(, "ТекстГиперссылки");
	Для Каждого Строка ИЗ ТекстыГиперссылокВРег Цикл
		Строка.ТекстГиперссылки = ВРег(Строка.ТекстГиперссылки);
	КонецЦикла;

	Пока ПозицияОткрывающегоТэга > 0 Цикл
		
		ОстатокТекстаСправки = Сред(ОстатокТекстаСправки, ПозицияОткрывающегоТэга + 3);
		
		ПозицияЗакрывающегоТэга = Найти(ОстатокТекстаСправки, "</A>");
				
		Если ПозицияЗакрывающегоТэга > 0 Тогда
			
			ТекстГиперссылки = СокрЛП(Сред(ОстатокТекстаСправки, 1, ПозицияЗакрывающегоТэга - 1));
			ТекстГиперссылкиВРег = ВРег(СокрЛП(Сред(ОстатокТекстаСправки, 1, ПозицияЗакрывающегоТэга - 1)));
			
			Если Найти(ТекстГиперссылкиВРег, "<A>") = 0 Тогда
				
				СтруктураПоиска = Новый Структура("ТекстГиперссылки", ТекстГиперссылкиВРег);
				СписокСтрок = ТекстыГиперссылокВРег.НайтиСтроки(СтруктураПоиска);
				
				Если СписокСтрок.Количество() = 0 Тогда
					
					НоваяСтрока = ГиперссылкиДляСправки.Добавить();
					НоваяСтрока.ТекстГиперссылки = ТекстГиперссылки;
					НоваяСтрока.Гиперссылка = ГиперссылкаПоУмолчанию;
					
				ИначеЕсли НЕ УдалятьЛишние Тогда
					
					Для Каждого СтрокаТЧ ИЗ ГиперссылкиДляСправки Цикл
						Если ВРег(СтрокаТЧ.ТекстГиперссылки) = ТекстГиперссылкиВРег Тогда
							СтрокаТЧ.ОтсутствуетВСправке = Ложь;
						КонецЕсли;
					КонецЦикла;
					
				КонецЕсли;
				
				Если МассивТекстовГиперссылок.Найти(ТекстГиперссылкиВРег) = Неопределено Тогда
					МассивТекстовГиперссылок.Добавить(ТекстГиперссылкиВРег);
				КонецЕсли;
				
				ОстатокТекстаСправки = Сред(ОстатокТекстаСправки, ПозицияЗакрывающегоТэга + 4);
			КонецЕсли;
		КонецЕсли;
		
		ПозицияОткрывающегоТэга = Найти(ОстатокТекстаСправки, "<A>");
	КонецЦикла;
		
	// Удаление лишних текстов гиперссылок из табличной части
	КоличествоГиперссылок = ГиперссылкиДляСправки.Количество();
	Если КоличествоГиперссылок > 0 Тогда
		Для ОбратныйИндекс = 1 По КоличествоГиперссылок Цикл
			СтрокаТЧ = ГиперссылкиДляСправки[КоличествоГиперссылок - ОбратныйИндекс];
			Если МассивТекстовГиперссылок.Найти(ВРег(СтрокаТЧ.ТекстГиперссылки)) = Неопределено Тогда
				Если УдалятьЛишние Тогда
					ГиперссылкиДляСправки.Удалить(СтрокаТЧ);
				Иначе
					СтрокаТЧ.ОтсутствуетВСправке = Истина;
				КонецЕсли; 
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбновитьКартинкиСправки(ТекстСправки, КартинкиДляСправки, УдалятьЛишние = Истина, СправкаКартинка = Ложь) Экспорт
	
	МассивНазванийКартинок = Новый Массив;
	
	ОстатокТекстаСправки = ТекстСправки;
	
	ПозицияОткрывающегоТэга = Найти(ОстатокТекстаСправки, "<IMG>");
	
	НазванияКартинокВРег = КартинкиДляСправки.Выгрузить(, "НазваниеКартинки");
	Для Каждого Строка ИЗ НазванияКартинокВРег Цикл
		Строка.НазваниеКартинки = ВРег(Строка.НазваниеКартинки);
	КонецЦикла;

	Пока ПозицияОткрывающегоТэга > 0 Цикл
		
		ОстатокТекстаСправки = Сред(ОстатокТекстаСправки, ПозицияОткрывающегоТэга + 5);
		
		ПозицияЗакрывающегоТэга = Найти(ОстатокТекстаСправки, "</IMG>");
		
		Если ПозицияЗакрывающегоТэга > 0 Тогда
			НазваниеКартинки = ВРег(СокрЛП(Сред(ОстатокТекстаСправки, 1, ПозицияЗакрывающегоТэга - 1)));
			
			Если Найти(НазваниеКартинки, "<IMG>") = 0 Тогда
				
				СтруктураПоиска = Новый Структура("НазваниеКартинки", НазваниеКартинки);
				СписокСтрок = НазванияКартинокВРег.НайтиСтроки(СтруктураПоиска);
				Если СписокСтрок.Количество() > 0 И НЕ УдалятьЛишние Тогда
					Для Каждого СтрокаТЧ ИЗ КартинкиДляСправки Цикл
						Если ВРег(СтрокаТЧ.НазваниеКартинки) = НазваниеКартинки Тогда
							СтрокаТЧ.ОтсутствуетВСправке = Ложь;
						КонецЕсли;
					КонецЦикла;
				КонецЕсли;
								
				Если МассивНазванийКартинок.Найти(НазваниеКартинки) = Неопределено Тогда
					МассивНазванийКартинок.Добавить(НазваниеКартинки);
				КонецЕсли;
				
				ОстатокТекстаСправки = Сред(ОстатокТекстаСправки, ПозицияЗакрывающегоТэга + 6);
			КонецЕсли;
		КонецЕсли;
		
		ПозицияОткрывающегоТэга = Найти(ОстатокТекстаСправки, "<IMG>");
	КонецЦикла;
		
	// Удаление лишних картинок из табличной части
	КоличествоКартинок = КартинкиДляСправки.Количество();
	Если СправкаКартинка Тогда
		Если КоличествоКартинок > 1 Тогда
			Для ОбратныйИндекс = 1 По КоличествоКартинок - 1 Цикл
				КартинкиДляСправки.Удалить(КартинкиДляСправки[КоличествоКартинок - ОбратныйИндекс]);
			КонецЦикла;
		КонецЕсли;
	Иначе
		Если КоличествоКартинок > 0 Тогда
			Для ОбратныйИндекс = 1 По КоличествоКартинок Цикл
				СтрокаТЧ = КартинкиДляСправки[КоличествоКартинок - ОбратныйИндекс];
				Если МассивНазванийКартинок.Найти(ВРег(СтрокаТЧ.НазваниеКартинки)) = Неопределено Тогда
					Если УдалятьЛишние Тогда
						КартинкиДляСправки.Удалить(СтрокаТЧ);
					Иначе
						СтрокаТЧ.ОтсутствуетВСправке = Истина;
					КонецЕсли; 
				КонецЕсли;
			КонецЦикла;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ВЫБОР КОГДА ТипЗначения(Владелец) = Тип(Справочник.ОбъектыМетаданных) ИЛИ ТипЗначения(Владелец) = Тип(Справочник.Подсистемы) ТОГДА ЗначениеРазрешено(Владелец.Владелец)
	|	КОГДА ТипЗначения(Владелец) = Тип(Справочник.ФормыОбъектовМетаданных) ТОГДА ЗначениеРазрешено(ВЫРАЗИТЬ(Владелец КАК Справочник.ФормыОбъектовМетаданных).Владелец.Владелец)
	|	ИНАЧЕ Владелец <> Неопределено КОНЕЦ ";

КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#КонецЕсли