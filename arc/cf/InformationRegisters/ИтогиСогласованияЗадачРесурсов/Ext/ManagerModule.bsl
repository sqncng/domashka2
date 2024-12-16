﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДанныеСогласованияПоЗадаче

Процедура ПересчитатьСогласованиеРесурсовВсехЗадач(ПересчитыватьПроцентВыполнения = Ложь) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ЗадачиПроцесса.Предмет КАК Предмет
	|ИЗ
	|	Справочник.ЗадачиПроцесса КАК ЗадачиПроцесса";
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		РассчитатьСогласованиеРесурсовЗадачПоПредмету(Выборка.Предмет, ПересчитыватьПроцентВыполнения);
	КонецЦикла;
	
КонецПроцедуры

Процедура РассчитатьСогласованиеРесурсовЗадачПоПредмету(Предмет, ПересчитыватьИтогиПоДочерним = Ложь) Экспорт
	
	Запрос = Новый Запрос;
	
	Запрос.Текст = "ВЫБРАТЬ
	|	ЗадачиПроцесса.Ссылка
	|ИЗ
	|	Справочник.ЗадачиПроцесса КАК ЗадачиПроцесса
	|ГДЕ
	|	ЗадачиПроцесса.Предмет = &Предмет";
	
	Запрос.УстановитьПараметр("Предмет", Предмет);
	
	МассивРассчитываемыхЗадач = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
	РассчитатьСогласованиеРесурсовМассиваЗадачПроцессов(МассивРассчитываемыхЗадач, Предмет);
	
КонецПроцедуры

Процедура РассчитатьСогласованиеРесурсовМассиваЗадачПроцессов(МассивРассчитываемыхЗадач, Предмет) Экспорт
	
	Если МассивРассчитываемыхЗадач.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	СписокСогласуемыхРесурсов = Неопределено;
	Если ЗначениеЗаполнено(Предмет) Тогда
		ДанныеШаблона = ЗадачиПроцессов.ДанныеШаблонаПоПредмету(Предмет);
		Если ЗначениеЗаполнено(ДанныеШаблона.ШаблонПроцесса) Тогда
			СписокСогласуемыхРесурсов = ДанныеШаблона.ВидыСогласуемыхРесурсов;
		Иначе
			СписокСогласуемыхРесурсов = ЗадачиПроцессовПовтИсп.ИспользуемыеВИБВидыСогласуемыхРесурсов();
		КонецЕсли;
	Иначе 
		СписокСогласуемыхРесурсов = ЗадачиПроцессовПовтИсп.ИспользуемыеВИБВидыСогласуемыхРесурсов();
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = "
	|ВЫБРАТЬ
	|	ВидыСогласуемыхРесурсов.Ссылка КАК ВидРесурса,
	|	ЗадачиПроцесса.Ссылка КАК Задача,
	|	ВЫБОР
	|		КОГДА ЗадачиПроцесса.ПометкаУдаления
	|				ИЛИ ЗадачиПроцесса.Статус = ЗНАЧЕНИЕ(Перечисление.СтатусыЗадачПроцессов.Отменена)
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ КАК НеУчитывается
	|ПОМЕСТИТЬ ЗадачиРесурсы
	|ИЗ
	|	Справочник.ВидыСогласуемыхРесурсов КАК ВидыСогласуемыхРесурсов,
	|	Справочник.ЗадачиПроцесса КАК ЗадачиПроцесса
	|ГДЕ
	|	ЗадачиПроцесса.Ссылка В(&МассивРассчитываемыхЗадач)
	|	И ВидыСогласуемыхРесурсов.Ссылка В(&СписокСогласуемыхРесурсов)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ЗадачиРесурсы.Задача КАК Задача,
	|	ЗадачиРесурсы.ВидРесурса КАК ВидРесурса,
	|	СУММА(ВЫБОР
	|			КОГДА ЗадачиРесурсы.НеУчитывается
	|				ТОГДА 0
	|			КОГДА ПротоколСогласованияРесурсов.СтатусСогласования = ЗНАЧЕНИЕ(Перечисление.СтатусыСогласованияРесурса.КСогласованию)
	|				ТОГДА ЕСТЬNULL(ПротоколСогласованияРесурсов.Количество, 0)
	|			ИНАЧЕ 0
	|		КОНЕЦ) КАК Запланировано,
	|	СУММА(ВЫБОР
	|			КОГДА ЗадачиРесурсы.НеУчитывается
	|				ТОГДА 0
	|			КОГДА ПротоколСогласованияРесурсов.СтатусСогласования = ЗНАЧЕНИЕ(Перечисление.СтатусыСогласованияРесурса.Согласовано)
	|				ТОГДА ЕСТЬNULL(ПротоколСогласованияРесурсов.Количество, 0)
	|			ИНАЧЕ 0
	|		КОНЕЦ) КАК Согласовано
	|ПОМЕСТИТЬ ДанныеРасчитываемыхЗадач
	|ИЗ
	|	ЗадачиРесурсы КАК ЗадачиРесурсы
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ПротоколСогласованияРесурсов КАК ПротоколСогласованияРесурсов
	|		ПО (ПротоколСогласованияРесурсов.Задача = ЗадачиРесурсы.Задача)
	|			И (ПротоколСогласованияРесурсов.ВидРесурса = ЗадачиРесурсы.ВидРесурса)
	|
	|СГРУППИРОВАТЬ ПО
	|	ЗадачиРесурсы.Задача,
	|	ЗадачиРесурсы.ВидРесурса
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ДанныеРасчитываемыхЗадач.Задача                                              КАК ЗадачаПроцесса,
	|	ДанныеРасчитываемыхЗадач.ВидРесурса                                          КАК ВидРесурса,
	|	ДанныеРасчитываемыхЗадач.Запланировано                                       КАК Запланировано,
	|	ДанныеРасчитываемыхЗадач.Согласовано                                         КАК Согласовано,
	|	ЕСТЬNULL(ИтогиСогласованияЗадачРесурсов.ЗапланированоВДочерних, 0)           КАК ЗапланированоВДочерних,
	|	ЕСТЬNULL(ИтогиСогласованияЗадачРесурсов.СогласованоВДочерних, 0)             КАК СогласованоВДочерних,
	|	ЕСТЬNULL(ИтогиСогласованияЗадачРесурсов.ВыполненоСогласованоВДочерних, 0)    КАК ВыполненоСогласованоВДочерних,
	|	ЕСТЬNULL(ИтогиСогласованияЗадачРесурсов.ВыполненоНаСогласованииВДочерних, 0) КАК ВыполненоНаСогласованииВДочерних
	|ИЗ
	|	ДанныеРасчитываемыхЗадач КАК ДанныеРасчитываемыхЗадач
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ИтогиСогласованияЗадачРесурсов КАК ИтогиСогласованияЗадачРесурсов
	|		ПО ДанныеРасчитываемыхЗадач.Задача = ИтогиСогласованияЗадачРесурсов.ЗадачаПроцесса
	|			И ДанныеРасчитываемыхЗадач.ВидРесурса = ИтогиСогласованияЗадачРесурсов.ВидРесурса";
	
	Запрос.УстановитьПараметр("СписокСогласуемыхРесурсов", СписокСогласуемыхРесурсов);
	Запрос.УстановитьПараметр("МассивРассчитываемыхЗадач", МассивРассчитываемыхЗадач);
	
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	
	Пока Выборка.Следующий() Цикл
	
		ВыполнитьЗаписьВРегистр(Выборка);
	
	КонецЦикла;
	
КонецПроцедуры

Процедура ОчиститьДанныеСогласованияМассиваЗадач(МассивЗадач) Экспорт

	Для Каждого ЗадачаПроцесса Из МассивЗадач Цикл
		
		Если Не ЗначениеЗаполнено(ЗадачаПроцесса)
			Или Не ТипЗнч(ЗадачаПроцесса) = Тип("СправочникСсылка.ЗадачиПроцесса") Тогда
			
			Продолжить;
			
		КонецЕсли;
		
		НаборЗаписей = РегистрыСведений.ИтогиСогласованияЗадачРесурсов.СоздатьНаборЗаписей();
		НаборЗаписей.Отбор.ЗадачаПроцесса.Установить(ЗадачаПроцесса);
		НаборЗаписей.Записать();
		
	КонецЦикла;

КонецПроцедуры

#КонецОбласти

#Область ИтогиПоДочернимЗадачам

Процедура ПересчитатьВсеИтогиПоДочернимЗадачам() Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ЗадачиПроцесса.Предмет КАК Предмет
	|ИЗ
	|	Справочник.ЗадачиПроцесса КАК ЗадачиПроцесса";
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		РассчитатьИтогиПоДочернимЗадачамПоПредмету(Выборка.Предмет);
	КонецЦикла;
	
КонецПроцедуры

Процедура РассчитатьИтогиПоДочернимЗадачамПоПредмету(Предмет) Экспорт

	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ 
	|	ЗадачиПроцесса.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.ЗадачиПроцесса КАК ЗадачиПроцесса
	|ГДЕ
	|	ЗадачиПроцесса.Предмет = &Предмет
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////1
	|ВЫБРАТЬ
	|	ЗадачиПроцесса.Ссылка КАК Ссылка
	|ИЗ
	|	РегистрСведений.ИерархияЗадачПроцесса КАК ИерархияЗадачПроцесса
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ЗадачиПроцесса КАК ЗадачиПроцесса
	|		ПО ИерархияЗадачПроцесса.ЗадачаПроцесса = ЗадачиПроцесса.Ссылка
	|			И ИерархияЗадачПроцесса.Родитель = ЗадачиПроцесса.Ссылка
	|			И (ИерархияЗадачПроцесса.Уровень = 0)
	|			И (ЗадачиПроцесса.Предмет = &Предмет)";
	
	Запрос.УстановитьПараметр("Предмет", Предмет);
	
	Результат = Запрос.ВыполнитьПакет();
	
	МассивЗадачДляЗаписи = Результат[0].Выгрузить().ВыгрузитьКолонку("Ссылка");
	МассивРассчитываемыхЗадач = Результат[1].Выгрузить().ВыгрузитьКолонку("Ссылка");
	
	РассчитатьИтогиПоДочернимДляМассиваЗадач(МассивРассчитываемыхЗадач, МассивЗадачДляЗаписи);
	
КонецПроцедуры

Процедура РассчитатьИтогиПоДочернимДляМассиваЗадач(МассивРассчитываемыхЗадач, МассивЗадачДляЗаписи) Экспорт
	
	Если МассивРассчитываемыхЗадач.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = "
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ИтогиСогласованияЗадачРесурсов.ВидРесурса КАК ВидРесурса
	|ИЗ
	|	РегистрСведений.ИтогиСогласованияЗадачРесурсов КАК ИтогиСогласованияЗадачРесурсов
	|ГДЕ
	|	ИтогиСогласованияЗадачРесурсов.ЗадачаПроцесса В(&МассивЗадачДляЗаписи)";
	
	Запрос.УстановитьПараметр("МассивЗадачДляЗаписи", МассивЗадачДляЗаписи);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
	
		РассчитатьИтогиПоДочернимДляМассиваЗадачПоВидуРесурса(МассивРассчитываемыхЗадач, МассивЗадачДляЗаписи, Выборка.ВидРесурса);
	
	КонецЦикла;
	
КонецПроцедуры

Процедура РассчитатьИтогиПоДочернимДляМассиваЗадачПоВидуРесурса(МассивРассчитываемыхЗадач, МассивЗадачДляЗаписи, ВидРесурса) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = "
	|ВЫБРАТЬ РАЗЛИЧНЫЕ РАЗРЕШЕННЫЕ
	|	ЗадачиПроцесса.Ссылка                                                        КАК ЗадачаПроцесса,
	|	ЗадачиПроцесса.Статус                                                        КАК Статус,
	|	&ВидРесурса                                                                  КАК ВидРесурса,
	|	ЕстьNULL(ИтогиСогласованияЗадачРесурсов.Запланировано, 0)                    КАК Запланировано,
	|	ЕстьNULL(ИтогиСогласованияЗадачРесурсов.Согласовано, 0)                      КАК Согласовано,
	|	ЕстьNULL(ИтогиСогласованияЗадачРесурсов.ЗапланированоВДочерних, 0)           КАК ТекущееЗапланированоВДочерних,
	|	ЕстьNULL(ИтогиСогласованияЗадачРесурсов.СогласованоВДочерних, 0)             КАК ТекущееСогласованоВДочерних,
	|	ЕстьNULL(ИтогиСогласованияЗадачРесурсов.ВыполненоСогласованоВДочерних, 0)    КАК ТекущееВыполненоСогласованоВДочерних,
	|	ЕстьNULL(ИтогиСогласованияЗадачРесурсов.ВыполненоНаСогласованииВДочерних, 0) КАК ТекущееВыполненоНаСогласованииВДочерних
	|ИЗ
	|	Справочник.ЗадачиПроцесса КАК ЗадачиПроцесса
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.ИерархияЗадачПроцесса КАК ИерархияЗадачПроцесса
	|		ПО ИерархияЗадачПроцесса.ЗадачаПроцесса = ЗадачиПроцесса.Ссылка
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ИтогиСогласованияЗадачРесурсов КАК ИтогиСогласованияЗадачРесурсов
	|		ПО (ИтогиСогласованияЗадачРесурсов.ЗадачаПроцесса = ЗадачиПроцесса.Ссылка)
	|			И ИтогиСогласованияЗадачРесурсов.ВидРесурса = &ВидРесурса
	|ГДЕ
	|	ИерархияЗадачПроцесса.Родитель В(&МассивРассчитываемыхЗадач)
	|
	|УПОРЯДОЧИТЬ ПО
	|	ЗадачаПроцесса ИЕРАРХИЯ";
	
	Запрос.УстановитьПараметр("МассивРассчитываемыхЗадач", МассивРассчитываемыхЗадач);
	Запрос.УстановитьПараметр("ВидРесурса",                ВидРесурса);
	
	ДеревоЗадач = Запрос.Выполнить().Выгрузить(ОбходРезультатаЗапроса.ПоГруппировкамСИерархией);
	ДеревоЗадач.Колонки.Добавить("ЗапланированоВДочерних",           ОбщегоНазначения.ОписаниеТипаЧисло(15, 3));
	ДеревоЗадач.Колонки.Добавить("СогласованоВДочерних",             ОбщегоНазначения.ОписаниеТипаЧисло(15, 3));
	ДеревоЗадач.Колонки.Добавить("ВыполненоСогласованоВДочерних",    ОбщегоНазначения.ОписаниеТипаЧисло(15, 3));
	ДеревоЗадач.Колонки.Добавить("ВыполненоНаСогласованииВДочерних", ОбщегоНазначения.ОписаниеТипаЧисло(15, 3));
	
	Для Каждого СтрокаДерева Из ДеревоЗадач.Строки Цикл 
	
		РассчитатьИтогиПоДочернимДляСтрокиДерева(СтрокаДерева, МассивРассчитываемыхЗадач, МассивЗадачДляЗаписи);
	
	КонецЦикла;
	
КонецПроцедуры

Процедура РассчитатьИтогиПоДочернимДляСтрокиДерева(СтрокаДерева, МассивРассчитываемыхЗадач, МассивЗадачДляЗаписи)
	
	Для Каждого ПодчиненнаяСтрока Из СтрокаДерева.Строки Цикл
		
		РассчитатьИтогиПоДочернимДляСтрокиДерева(ПодчиненнаяСтрока, МассивРассчитываемыхЗадач, МассивЗадачДляЗаписи);
		
		СтрокаДерева.ЗапланированоВДочерних = СтрокаДерева.ЗапланированоВДочерних + ПодчиненнаяСтрока.ЗапланированоВДочерних + ПодчиненнаяСтрока.Запланировано;
		СтрокаДерева.СогласованоВДочерних   = СтрокаДерева.СогласованоВДочерних + ПодчиненнаяСтрока.СогласованоВДочерних + ПодчиненнаяСтрока.Согласовано;
		
		Если ПодчиненнаяСтрока.Статус = Перечисления.СтатусыЗадачПроцессов.Выполнена Тогда
			СтрокаДерева.ВыполненоСогласованоВДочерних    = СтрокаДерева.ВыполненоСогласованоВДочерних + ПодчиненнаяСтрока.Согласовано + ПодчиненнаяСтрока.ВыполненоСогласованоВДочерних;
			СтрокаДерева.ВыполненоНаСогласованииВДочерних = СтрокаДерева.ВыполненоНаСогласованииВДочерних + (ПодчиненнаяСтрока.Запланировано - ПодчиненнаяСтрока.Согласовано) + ПодчиненнаяСтрока.ВыполненоНаСогласованииВДочерних;
		Иначе
			СтрокаДерева.ВыполненоСогласованоВДочерних    = СтрокаДерева.ВыполненоСогласованоВДочерних + ПодчиненнаяСтрока.ВыполненоСогласованоВДочерних;
			СтрокаДерева.ВыполненоНаСогласованииВДочерних = СтрокаДерева.ВыполненоНаСогласованииВДочерних + ПодчиненнаяСтрока.ВыполненоНаСогласованииВДочерних;
		КонецЕсли;
		
	КонецЦикла;
	
	Если МассивЗадачДляЗаписи.Найти(СтрокаДерева.ЗадачаПроцесса) <> Неопределено Тогда
		
		Если СтрокаДерева.ЗапланированоВДочерних              <> СтрокаДерева.ТекущееЗапланированоВДочерних
			Или СтрокаДерева.СогласованоВДочерних             <> СтрокаДерева.ТекущееСогласованоВДочерних
			Или СтрокаДерева.ВыполненоСогласованоВДочерних    <> СтрокаДерева.ТекущееВыполненоСогласованоВДочерних 
			Или СтрокаДерева.ВыполненоНаСогласованииВДочерних <> СтрокаДерева.ТекущееВыполненоНаСогласованииВДочерних Тогда
			
			ВыполнитьЗаписьВРегистр(СтрокаДерева);
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ЗаписьВРегистр

Процедура ВыполнитьЗаписьВРегистр(Данные) Экспорт

	Если Не ЗначениеЗаполнено(Данные.ВидРесурса)
		Или Не ЗначениеЗаполнено(Данные.ЗадачаПроцесса) Тогда
		Возврат
	КонецЕсли;
	
	НаборЗаписей = РегистрыСведений.ИтогиСогласованияЗадачРесурсов.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.ЗадачаПроцесса.Установить(Данные.ЗадачаПроцесса);
	НаборЗаписей.Отбор.ВидРесурса.Установить(Данные.ВидРесурса);
	
	Если Данные.Согласовано                       = 0 
		И Данные.ЗапланированоВДочерних           = 0 
		И Данные.СогласованоВДочерних             = 0 
		И Данные.ВыполненоСогласованоВДочерних    = 0
		И Данные.ВыполненоНаСогласованииВДочерних = 0
		И Данные.Запланировано                    = 0 Тогда
		
		НаборЗаписей.Записать();
		
	Иначе
		
		ЗаписьНабора = НаборЗаписей.Добавить();
		ЗаполнитьЗначенияСвойств(ЗаписьНабора, Данные);
		НаборЗаписей.Записать();
		
	КонецЕсли;

КонецПроцедуры

Процедура УдалитьЗаписиПоПредмету(Предмет) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = "
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ИтогиСогласованияЗадачРесурсов.ЗадачаПроцесса КАК ЗадачаПроцесса
	|ИЗ
	|	РегистрСведений.ИтогиСогласованияЗадачРесурсов КАК ИтогиСогласованияЗадачРесурсов
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ЗадачиПроцесса КАК ЗадачиПроцесса
	|		ПО ИтогиСогласованияЗадачРесурсов.ЗадачаПроцесса = ЗадачиПроцесса.Ссылка
	|ГДЕ
	|	ЗадачиПроцесса.Предмет = &Предмет";
	
	Запрос.УстановитьПараметр("Предмет", Предмет);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		УдалитьЗаписиПоЗадаче(Выборка.ЗадачаПроцесса);
	КонецЦикла;
	
КонецПроцедуры

Процедура УдалитьЗаписиПоЗадаче(ЗадачаПроцесса) Экспорт
	
	НаборЗаписей = РегистрыСведений.ИтогиСогласованияЗадачРесурсов.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.ЗадачаПроцесса.Установить(ЗадачаПроцесса);
	НаборЗаписей.Записать();
	
КонецПроцедуры

#КонецОбласти

Процедура РассчитатьВсеИтогиДляЗадачи(ЗадачаДляРасчета, СогласуемыйРесурс) Экспорт
	
	МассивЗадачДляРасчета = Новый Массив;
	МассивЗадачДляРасчета.Добавить(ЗадачаДляРасчета); 
	
	РассчитатьВсеИтогиПоМассивуЗадач(МассивЗадачДляРасчета, СогласуемыйРесурс, Неопределено);
	
КонецПроцедуры

Процедура РассчитатьВсеИтогиПоМассивуЗадач(МассивЗадачДляРасчета, СогласуемыйРесурс, Предмет) Экспорт
	
	ДанныеПоРодителям = ЗадачиПроцессов.ЗадачиСРодителямиПоМассивуЗадач(МассивЗадачДляРасчета);
	
	РассчитатьСогласованиеРесурсовМассиваЗадачПроцессов(МассивЗадачДляРасчета, Предмет);
	
	Если СогласуемыйРесурс = Неопределено Тогда
		
		ИспользуемыеВидыРесурсов = ЗадачиПроцессовПовтИсп.ИспользуемыеВИБВидыСогласуемыхРесурсов();
		
		Для Каждого ИспользуемыВидРесурса Из ИспользуемыеВидыРесурсов Цикл
		
			РассчитатьИтогиПоДочернимДляМассиваЗадачПоВидуРесурса(ДанныеПоРодителям.ЗадачиВерхнегоУровня, 
			                                                      ДанныеПоРодителям.МассивРодительскихЗадач,
			                                                      ИспользуемыВидРесурса);
		
		КонецЦикла;
		
	Иначе
		
		РассчитатьИтогиПоДочернимДляМассиваЗадачПоВидуРесурса(ДанныеПоРодителям.ЗадачиВерхнегоУровня, 
		                                                      ДанныеПоРодителям.МассивРодительскихЗадач,
		                                                      СогласуемыйРесурс);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура РассчитатьВсеИтогиПоПредмету(Предмет, СогласуемыйРесурс) Экспорт
	
	Запрос = Новый Запрос;
	
	Запрос.Текст = "ВЫБРАТЬ
	|	ЗадачиПроцесса.Ссылка
	|ИЗ
	|	Справочник.ЗадачиПроцесса КАК ЗадачиПроцесса
	|ГДЕ
	|	ЗадачиПроцесса.Предмет = &Предмет";
	
	Запрос.УстановитьПараметр("Предмет", Предмет);
	
	МассивРассчитываемыхЗадач = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
	
	РассчитатьВсеИтогиПоМассивуЗадач(МассивРассчитываемыхЗадач, СогласуемыйРесурс, Предмет);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ПредставлениеИтогов

Функция ПредставлениеХодаВыполненияПоПредмету(Предмет) Экспорт
	
	ПредставлениеХодаВыполнения = "";
	
	Запрос = Новый Запрос;
	Запрос.Текст = "
	|ВЫБРАТЬ
	|	СУММА(ИтогиСогласованияЗадачРесурсов.Запланировано + ИтогиСогласованияЗадачРесурсов.ЗапланированоВДочерних) КАК Запланировано,
	|	СУММА(ВЫБОР
	|			КОГДА ЗадачиПроцесса.Статус = ЗНАЧЕНИЕ(Перечисление.СтатусыЗадачПроцессов.Выполнена)
	|				ТОГДА ИтогиСогласованияЗадачРесурсов.Запланировано
	|			ИНАЧЕ 0
	|		КОНЕЦ + ИтогиСогласованияЗадачРесурсов.ВыполненоСогласованоВДочерних + ИтогиСогласованияЗадачРесурсов.ВыполненоНаСогласованииВДочерних) КАК Выполнено
	|ИЗ
	|	РегистрСведений.ИтогиСогласованияЗадачРесурсов КАК ИтогиСогласованияЗадачРесурсов
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ЗадачиПроцесса КАК ЗадачиПроцесса
	|		ПО ИтогиСогласованияЗадачРесурсов.ЗадачаПроцесса = ЗадачиПроцесса.Ссылка
	|			И (ЗадачиПроцесса.Предмет = &Предмет)
	|			И (ЗадачиПроцесса.Родитель = ЗНАЧЕНИЕ(Справочник.ЗадачиПроцесса.ПустаяСсылка))
	|			И (НЕ ЗадачиПроцесса.ПометкаУдаления)
	|			И (НЕ ИтогиСогласованияЗадачРесурсов.ЗадачаПроцесса.Статус = ЗНАЧЕНИЕ(Перечисление.СтатусыЗадачПроцессов.Отменена))";
	
	Запрос.УстановитьПараметр("Предмет", Предмет);
	
	Результат = Запрос.Выполнить();
	
	Если Результат.Пустой() Тогда
		Возврат ПредставлениеХодаВыполнения;
	КонецЕсли;
	
	Выборка = Результат.Выбрать();
	
	Если Выборка.Следующий() Тогда
		
		ПроцентВыполнения = 0;
		
		Если Выборка.Запланировано = 0 Тогда
			Возврат ПредставлениеХодаВыполнения;
		КонецЕсли;
		
		Если  Выборка.Выполнено <> 0 Тогда
			
			ПроцентВыполнения =  Окр(100 * (Выборка.Выполнено / Выборка.Запланировано), 0, РежимОкругления.Окр15как20);
			
		КонецЕсли;
		
		Возврат "";  
	
	КонецЕсли;
	
	Возврат ПредставлениеХодаВыполнения;
	
КонецФункции

#КонецОбласти


#КонецОбласти

#КонецЕсли