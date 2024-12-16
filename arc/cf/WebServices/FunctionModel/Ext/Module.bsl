﻿#Область ПрограммныйИнтерфейс

Функция GetListOfProjects()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	Проекты.Ссылка,
	|	Проекты.Наименование
	|ИЗ
	|	Справочник.Проекты КАК Проекты
	|ГДЕ
	|	НЕ Проекты.ПометкаУдаления";
	
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Выборка = Результат.Выбрать();
	
	ТипСпискаПроектов = ФабрикаXDTO.Тип("http://www.1c.ru/SPPR/FunctionModel", "ListOfProjects");
	ТипДанныхПроекта = ФабрикаXDTO.Тип("http://www.1c.ru/SPPR/FunctionModel", "Project");
	
	СписокПроектов = ФабрикаXDTO.Создать(ТипСпискаПроектов);
	Пока Выборка.Следующий() Цикл
		ДанныеПроекта = ФабрикаXDTO.Создать(ТипДанныхПроекта);
		ДанныеПроекта.ID = Выборка.Ссылка.УникальныйИдентификатор();
		ДанныеПроекта.Name = Выборка.Наименование;
		
		СписокПроектов.Project.Добавить(ДанныеПроекта);
	КонецЦикла;
	
	Возврат СписокПроектов;
	
КонецФункции

Функция GetListOfFunctions(Project)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	Функции.Ссылка,
	|	Функции.Родитель,
	|	Функции.Наименование,
	|	Функции.ХранилищеОписания
	|ИЗ
	|	Справочник.Проекты КАК Проекты
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ФункцииСистемы КАК Функции
	|		ПО Проекты.Ссылка = Функции.Владелец
	|			И (НЕ Функции.ПометкаУдаления)
	|ГДЕ
	|	Проекты.Наименование = &Проект
	|
	|УПОРЯДОЧИТЬ ПО
	|	Функции.ПолныйКод";
	
	Запрос.УстановитьПараметр("Проект", Project);
	
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Выборка = Результат.Выбрать();
	
	ТипСпискаФункций = ФабрикаXDTO.Тип("http://www.1c.ru/SPPR/FunctionModel", "ListOfFunctions");
	
	СписокФункций = ФабрикаXDTO.Создать(ТипСпискаФункций);
	Пока Выборка.Следующий() Цикл
		ОписаниеФункции = ИнтеграцияФункциональнойМодели.ОписаниеФункции(Выборка);
		СписокФункций.FunctionDescription.Добавить(ОписаниеФункции);
	КонецЦикла;
	
	Возврат СписокФункций;
	
КонецФункции

Функция GetListOfPerformers(Project)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ПрофилиПользователей.Ссылка,
	|	ПрофилиПользователей.Родитель,
	|	ПрофилиПользователей.ЭтоГруппа,
	|	ПрофилиПользователей.Наименование,
	|	ПрофилиПользователей.ХранилищеОписания
	|ИЗ
	|	Справочник.Проекты КАК Проекты
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ПрофилиПользователей КАК ПрофилиПользователей
	|		ПО Проекты.Ссылка = ПрофилиПользователей.Владелец
	|			И (НЕ ПрофилиПользователей.ПометкаУдаления)
	|ГДЕ
	|	Проекты.Наименование = &Проект
	|
	|УПОРЯДОЧИТЬ ПО
	|	ПрофилиПользователей.Наименование";
	
	Запрос.УстановитьПараметр("Проект", Project);
	
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Выборка = Результат.Выбрать();
	
	ТипДанныхСписокОбъектов = ФабрикаXDTO.Тип("http://www.1c.ru/SPPR/FunctionModel", "ListOfPerformers");
	СписокПрофилей = ФабрикаXDTO.Создать(ТипДанныхСписокОбъектов);
	Пока Выборка.Следующий() Цикл
		
		ОписаниеПрофиля = КраткоеОписаниеПрофиля(Выборка);
		СписокПрофилей.PerformerDescription.Добавить(ОписаниеПрофиля);
	
	КонецЦикла;
	
	Возврат СписокПрофилей;
	
КонецФункции

Функция GetInterfaceDescription(Project, Interface)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	Подсистемы.Ссылка КАК Ссылка,
	|	Подсистемы.Наименование КАК Представление
	|ПОМЕСТИТЬ Подсистема
	|ИЗ
	|	Справочник.Проекты КАК Проекты
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.Подсистемы КАК Подсистемы
	|		ПО (Подсистемы.Наименование = &Подсистема)
	|ГДЕ
	|	Проекты.Наименование = &Проект
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	Подсистема.Представление
	|ИЗ
	|	Подсистема КАК Подсистема
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	СпрФункции.Ссылка,
	|	СпрФункции.Родитель,
	|	СпрФункции.Наименование КАК Представление
	|ИЗ
	|	Справочник.Подсистемы КАК Подсистемы
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ФункцииСистемы КАК СпрФункции
	|		ПО (СпрФункции.Подсистема = Подсистемы.Ссылка)
	|			И (НЕ СпрФункции.ПометкаУдаления)
	|ГДЕ
	|	НЕ Подсистемы.ПометкаУдаления
	|	И Подсистемы.Ссылка В ИЕРАРХИИ
	|			(ВЫБРАТЬ
	|				Подсистема.Ссылка
	|			ИЗ
	|				Подсистема)
	|
	|УПОРЯДОЧИТЬ ПО
	|	Представление
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	Функции.Ссылка,
	|	Функции.Родитель,
	|	Функции.Наименование КАК Представление
	|ИЗ
	|	Справочник.Проекты КАК Проекты
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ФункцииСистемы КАК Функции
	|		ПО Проекты.Ссылка = Функции.Владелец
	|			И (НЕ Функции.ПометкаУдаления)
	|ГДЕ
	|	Проекты.Наименование = &Проект";
	
	Запрос.УстановитьПараметр("Проект", Project);
	Запрос.УстановитьПараметр("Подсистема", Interface);
	
	Результат = Запрос.ВыполнитьПакет();
	
	ОписаниеРазделаИнтерфейса = ИнтеграцияФункциональнойМодели.СформироватьОписаниеРазделаИнтерфейса(Результат);
	
	Возврат ОписаниеРазделаИнтерфейса;
	
КонецФункции

Функция GetFormDescription(Project, Metadata, FormName, Title)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	//0
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ОбъектыМетаданных.Ссылка КАК Ссылка,
	|	ВЫБОР
	|		КОГДА ОбъектыМетаданных.ПредставлениеСписка <> """"
	|			ТОГДА ОбъектыМетаданных.ПредставлениеСписка
	|		ИНАЧЕ ОбъектыМетаданных.Синоним
	|	КОНЕЦ КАК Представление,
	|	ЕСТЬNULL(ОбъектыМетаданных.Родитель.ПредставлениеВидаОбъектаМетаданныхВЕдЧисле, """") КАК ВидОбъекта
	|ПОМЕСТИТЬ ВТ_ОбъектыМетаданных
	|ИЗ
	|	Справочник.Проекты КАК Проекты
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ОбъектыМетаданных КАК ОбъектыМетаданных
	|		ПО (ОбъектыМетаданных.Владелец = Проекты.Ссылка)
	|			И (ОбъектыМетаданных.Наименование = &ИмяОбъектаМетаданных)
	|ГДЕ
	|	Проекты.Наименование = &Проект
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ВТ_ОбъектыМетаданных.Ссылка КАК ОбъектМетаданных,
	|	ФормыОМ.Ссылка КАК Ссылка,
	|	ФормыОМ.Синоним КАК Представление
	|ПОМЕСТИТЬ ВТ_ФормаОбъектаМетаданных
	|ИЗ
	|	ВТ_ОбъектыМетаданных КАК ВТ_ОбъектыМетаданных
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ФормыОбъектовМетаданных КАК ФормыОМ
	|		ПО (ФормыОМ.Владелец = ВТ_ОбъектыМетаданных.Ссылка)
	|			И (ФормыОМ.Наименование = &ИмяФормы
	|				ИЛИ &ИмяФормы = """")
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	ОбъектМетаданных
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	Функции.Ссылка КАК Ссылка,
	|	Функции.Наименование КАК Представление
	|ИЗ
	|	Справочник.Проекты КАК Проекты
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ФункцииСистемы КАК Функции
	|		ПО Проекты.Ссылка = Функции.Владелец
	|			И (НЕ Функции.ПометкаУдаления)
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ФункцииСистемы.ИсходящиеОбъектыМетаданных КАК ФункцииИсходящиеОМ
	|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТ_ОбъектыМетаданных КАК ВТ_ОбъектыМетаданных
	|			ПО (ВТ_ОбъектыМетаданных.Ссылка = ФункцииИсходящиеОМ.ОбъектМетаданных)
	|		ПО (ФункцииИсходящиеОМ.Ссылка = Функции.Ссылка)
	|ГДЕ
	|	Проекты.Наименование = &Проект
	|
	|ОБЪЕДИНИТЬ
	|
	|ВЫБРАТЬ
	|	Функции.Ссылка КАК Ссылка,
	|	Функции.Наименование КАК Представление
	|ИЗ
	|	Справочник.Проекты КАК Проекты
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ФункцииСистемы КАК Функции
	|		ПО Проекты.Ссылка = Функции.Владелец
	|			И (НЕ Функции.ПометкаУдаления)
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ФункцииСистемы.ОтчетыСервисныеОбъекты КАК ФункцииОтчетыСервисныеОбъекты
	|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТ_ОбъектыМетаданных КАК ВТ_ОбъектыМетаданных
	|			ПО (ВТ_ОбъектыМетаданных.Ссылка = ФункцииОтчетыСервисныеОбъекты.ОбъектМетаданных)
	|		ПО (ФункцииОтчетыСервисныеОбъекты.Ссылка = Функции.Ссылка)
	|ГДЕ
	|	Проекты.Наименование = &Проект
	|
	|УПОРЯДОЧИТЬ ПО
	|	Представление
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВТ_ОбъектыМетаданных.Представление КАК Представление,
	|	ВТ_ОбъектыМетаданных.ВидОбъекта КАК ВидОбъекта
	|ИЗ
	|	ВТ_ОбъектыМетаданных КАК ВТ_ОбъектыМетаданных
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВТ_ФормаОбъектаМетаданных.Представление КАК Представление
	|ИЗ
	|	ВТ_ФормаОбъектаМетаданных КАК ВТ_ФормаОбъектаМетаданных";
	
	ИмяФормы = СтрЗаменить(FormName, ".Форма.", ".");
	Запрос.УстановитьПараметр("Проект", Project);
	Запрос.УстановитьПараметр("ИмяФормы", ИмяФормы);
	Запрос.УстановитьПараметр("ИмяОбъектаМетаданных", Metadata);
	
	Результат = Запрос.ВыполнитьПакет();
	
	ОписаниеФормы = ИнтеграцияФункциональнойМодели.СформироватьОписаниеФормы(Результат, Title);
	
	Возврат ОписаниеФормы;
	
КонецФункции

Функция GetFunction(ID)
	
	ДанныеФункции = ИнтеграцияФункциональнойМодели.ДанныеФункции(Справочники.ФункцииСистемы.ПолучитьСсылку(ID));
	
	Возврат ДанныеФункции;
	
КонецФункции

Функция GetPerformerDescription(ID)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ПрофилиПользователей.Ссылка КАК Ссылка,
	|	ПрофилиПользователей.Родитель КАК Родитель,
	|	ПрофилиПользователей.ЭтоГруппа КАК ЭтоГруппа,
	|	ПрофилиПользователей.Наименование КАК Представление,
	|	ПрофилиПользователей.ХранилищеОписания КАК ХранилищеОписания
	|ИЗ
	|	Справочник.ПрофилиПользователей КАК ПрофилиПользователей
	|ГДЕ
	|	ПрофилиПользователей.Ссылка = &Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	Функции.Ссылка КАК Ссылка,
	|	Функции.Родитель КАК Родитель,
	|	Функции.Наименование КАК Представление,
	|	Функции.ХранилищеОписания КАК ХранилищеОписания,
	|	НайденныеФункции.ТипСсылки КАК ТипСсылки
	|ИЗ
	|	(ВЫБРАТЬ РАЗЛИЧНЫЕ
	|		ФункцииСистемыИсполнители.Ссылка КАК Ссылка,
	|		"""" КАК ТипСсылки
	|	ИЗ
	|		Справочник.ФункцииСистемы.Исполнители КАК ФункцииСистемыИсполнители
	|	ГДЕ
	|		ФункцииСистемыИсполнители.Исполнитель = &Ссылка
	|		И НЕ ФункцииСистемыИсполнители.Ссылка.ПометкаУдаления) КАК НайденныеФункции
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ФункцииСистемы КАК Функции
	|		ПО (Функции.Ссылка = НайденныеФункции.Ссылка)
	|
	|УПОРЯДОЧИТЬ ПО
	|	Представление";	
	
	Запрос.УстановитьПараметр("Ссылка", Справочники.ПрофилиПользователей.ПолучитьСсылку(ID));
	
	Результат = Запрос.ВыполнитьПакет();
		
	ОписаниеПрофиля = ИнтеграцияФункциональнойМодели.СформироватьОписаниеПрофиля(Результат);
	
	Возврат ОписаниеПрофиля;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция КраткоеОписаниеПрофиля(Выборка)

	ТипДанныхОписаниеПрофиля = ФабрикаXDTO.Тип("http://www.1c.ru/SPPR/FunctionModel", "PerformerDescription");

	ОписаниеПрофиля = ФабрикаXDTO.Создать(ТипДанныхОписаниеПрофиля);
	ОписаниеПрофиля.ID = Выборка.Ссылка.УникальныйИдентификатор(); 
	ОписаниеПрофиля.ID_Parent = Выборка.Родитель.УникальныйИдентификатор(); 
	ОписаниеПрофиля.Name = Выборка.Наименование; 
	ОписаниеПрофиля.Description = Выборка.ХранилищеОписания; 
	ОписаниеПрофиля.IsFolder = Выборка.ЭтоГруппа; 
	
	Возврат ОписаниеПрофиля;
	
КонецФункции
 
#КонецОбласти
