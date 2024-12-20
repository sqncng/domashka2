﻿#Область ПрограммныйИнтерфейс

// Выполняет инициализацию редактора
//
// Параметры:
//  Редактор - Поле HTML документа
//  ДанныеРедактора - Структура, в которую будут возвращены служебные данные редактора
//
Процедура ИнициализироватьРедактор(Редактор, ДанныеРедактора) Экспорт
	
	Представление = Редактор.Document.defaultView;
	GherkinProvider = Представление.VanessaGherkinProvider;
	GherkinProvider.setSuggestWidgetWidth("90%");
	
	Если ПараметрыПриложения["КлючевыеСловаGherkin"] = Неопределено Тогда
		ПараметрыПриложения.Вставить("КлючевыеСловаGherkin", ПолучитьКлючевыеСловаGherkin());
	КонецЕсли;	
	GherkinProvider.setKeywords(ПараметрыПриложения["КлючевыеСловаGherkin"]);
	
	Если ПараметрыПриложения["СоответствиеСловУсловныхОператоров"] = Неопределено Тогда
		ПараметрыПриложения.Вставить("СоответствиеСловУсловныхОператоров", ЗаписатьОбъектJSON(УстановитьСоответствиеСловУсловныхОператоров()));
	КонецЕсли;	
	GherkinProvider.setKeypairs(ПараметрыПриложения["СоответствиеСловУсловныхОператоров"]);
	
	Если ПараметрыПриложения["КлючевыеСловаИсключенийGherkin"] = Неопределено Тогда
		ПараметрыПриложения.Вставить("КлючевыеСловаИсключенийGherkin", ЗаписатьОбъектJSON(КлючевыеСловаИсключенийGherkin()));
	КонецЕсли;	
	GherkinProvider.setMetatags(ПараметрыПриложения["КлючевыеСловаИсключенийGherkin"]);
	
	Если ПараметрыПриложения["СписокКомандРедактора"] = Неопределено Тогда
		ПараметрыПриложения.Вставить("СписокКомандРедактора", ЗаписатьОбъектJSON(СписокКомандРедактора()));
	КонецЕсли;	
	GherkinProvider.setErrorLinks(ПараметрыПриложения["СписокКомандРедактора"]);
	
	Если ПараметрыПриложения["СписокШаговРедактор"] = Неопределено Тогда
		ПараметрыПриложения.Вставить("СписокШаговРедактор", ЗаписатьОбъектJSON(СписокШаговРедактор("ru")));
	КонецЕсли;	
	GherkinProvider.setStepList(ПараметрыПриложения["СписокШаговРедактор"]);
	
	GherkinProvider.setSPPR(Истина);
	GherkinProvider.setDirectives(ЗаписатьОбъектJSON(ДирективыПрепроцессора()));
	
	Если ТипЗнч(ДанныеРедактора) <> Тип("Структура") Тогда
		ДанныеРедактора = Новый Структура;
	КонецЕсли;	
	ЗакладкиРедактора = Представление.createVanessaTabs();
	
	ДанныеРедактора.Вставить("ЗакладкиРедактора", ЗакладкиРедактора);
	ДанныеРедактора.Вставить("GherkinProvider", GherkinProvider);

КонецПроцедуры

// Выполняет установку списка шагов редактора с учетом подсценариев
//
// Параметры:
//  Редактор - Поле HTML документа
//  Подсценарии - данные подсценариев
//
Процедура УстановитьСписокШагов(Редактор, Подсценарии) Экспорт
	
	Если ПараметрыПриложения["СписокШаговРедактор"] = Неопределено Тогда
		ПараметрыПриложения.Вставить("СписокШаговРедактор", ЗаписатьОбъектJSON(СписокШаговРедактор("ru")));
	КонецЕсли;  
	
	Данные = ПрочитатьОбъектJSON(ПараметрыПриложения["СписокШаговРедактор"]);
	
	НадоПолучатьДанныеЗапросом = Истина;
	ПодсценарииДляПолученияДанных = Новый Массив;
	Для Каждого Элем Из Подсценарии Цикл
		Если ТипЗнч(Элем.Шаблон) = Тип("Строка") Тогда
			НадоПолучатьДанныеЗапросом = Ложь;
		КонецЕсли;	
		ПодсценарииДляПолученияДанных.Добавить(Элем.Шаблон);
	КонецЦикла;
	
	Если ПодсценарииДляПолученияДанных.Количество() > 0 Тогда
		Если НадоПолучатьДанныеЗапросом Тогда
			ИменаПодсценариев = РедакторСценариевВызовСервера.ИменаПодсценариев(ПодсценарииДляПолученияДанных);
		Иначе	
			ИменаПодсценариев = ПодсценарииДляПолученияДанных;
		КонецЕсли;	
		Для Каждого ТекИмя Из ИменаПодсценариев Цикл
			ДанныеПодсценария = Новый Структура;
			ДанныеПодсценария.Вставить("filterText", ТекИмя);
			ДанныеПодсценария.Вставить("insertText", "Дано " + ТекИмя);
			ДанныеПодсценария.Вставить("sortText", "");
			ДанныеПодсценария.Вставить("documentation", "");
			ДанныеПодсценария.Вставить("kind", 17);
			ДанныеПодсценария.Вставить("section", "");
			Данные.Добавить(ДанныеПодсценария);
		КонецЦикла;
		
		Представление = Редактор.Document.defaultView;
		GherkinProvider = Представление.VanessaGherkinProvider;
		GherkinProvider.setStepList(ЗаписатьОбъектJSON(Данные));
	КонецЕсли;	
	
КонецПроцедуры

// Выполняет выравнивание значений таблицы сценария
//
// Параметры:
//  МассивСтрокТаблицы - Массив
//
Процедура ФорматироватьТаблицуСценария(МассивСтрокТаблицы) Экспорт
	
	МассивПараметров = ОпределитьПараметрыВСтрокеПримера(МассивСтрокТаблицы[0]);
	КолПараметров = МассивПараметров.Количество();
	МассивДлин = Новый Массив;
	Для каждого Элем Из МассивПараметров Цикл
		МассивДлин.Добавить(0);
	КонецЦикла;
	
	Для каждого СтрТзн Из МассивСтрокТаблицы Цикл
		МассивПараметров = ОпределитьПараметрыВСтрокеПримера(СтрТзн);
		
		Для Сч1 = 0 По МассивДлин.Количество() - 1 Цикл
			ДлинаСтроки = СтрДлина(СокрЛП(МассивПараметров.Получить(Сч1)));
			Если ДлинаСтроки > МассивДлин[Сч1] Тогда
				МассивДлин[Сч1] = ДлинаСтроки;
			КонецЕсли;	 
		КонецЦикла;
	КонецЦикла;
	
	Для Сч2 = 0 По (МассивСтрокТаблицы.Количество() - 1) Цикл
		СтрТзн = МассивСтрокТаблицы[Сч2];
		МассивПараметров = ОпределитьПараметрыВСтрокеПримера(СтрТзн);
		СтрПараметров = "| ";
		Для Сч1 = 0 По МассивДлин.Количество() - 1 Цикл
			Зн = СокрЛП(МассивПараметров[Сч1]);
			Пока СтрДлина(Зн) < МассивДлин[Сч1] Цикл
				Зн = Зн + " ";
			КонецЦикла;
			СтрПараметров = СтрПараметров + Зн + " | ";
		КонецЦикла;
		
		СтрПараметров = СокрЛП(СтрПараметров);
		
		МассивСтрокТаблицы[Сч2] = СтрПараметров;
	КонецЦикла;

КонецПроцедуры

// Преобразует данные в строку Json
//
// Параметры:
//  ДанныеJSON - Произвольные данные, которые могут быть сериализованы в формат Json
//
Функция ЗаписатьОбъектJSON(ДанныеJSON) Экспорт
	#Если НЕ ВебКлиент Тогда

	ЗаписьJSON = Новый ЗаписьJSON;
	ЗаписьJSON.УстановитьСтроку();
	ЗаписатьJSON(ЗаписьJSON, ДанныеJSON);
	Возврат ЗаписьJSON.Закрыть();
	
	#КонецЕсли
КонецФункции

// Преобразует  строку Json в данные
//
// Параметры:
//  ДанныеJSON - Строка с произвольными данными, которые могут быть десериализованы из формата Json
//  ПрочитатьВСоответствие - Булево
//
Функция ПрочитатьОбъектJSON(ДанныеJSON, ПрочитатьВСоответствие = Ложь) Экспорт
	#Если НЕ ВебКлиент Тогда

	ЧтениеJSON = New ЧтениеJSON;
	ЧтениеJSON.УстановитьСтроку(ДанныеJSON);
	Значение = ПрочитатьJSON(ЧтениеJSON, ПрочитатьВСоответствие);
	ЧтениеJSON.Закрыть();
	Возврат Значение;
	
	#КонецЕсли
КонецФункции	 

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ПолучитьКлючевыеСловаGherkin() 
	
	ДвоичныеДанные = РедакторСценариевВызовСервера.ПолучитьКлючевыеСловаGherkin();
	Поток = ДвоичныеДанные.ОткрытьПотокДляЧтения();
	ЧтениеТекста = Новый ЧтениеТекста(Поток, КодировкаТекста.UTF8);
	ДанныеJSON = ЧтениеТекста.Прочитать();
	ЧтениеТекста.Закрыть(); 
	
	Возврат ДанныеJSON;
	
КонецФункции	

Функция УстановитьСоответствиеСловУсловныхОператоров()
	
	УсловныеОператоры = Новый Соответствие;

	МассивСлов = Новый Массив;
	МассивСлов.Добавить("then");
	УсловныеОператоры.Вставить("if", МассивСлов);
	УсловныеОператоры.Вставить("elseif", МассивСлов);

	МассивСлов = Новый Массив;
	МассивСлов.Добавить("Тогда");
	УсловныеОператоры.Вставить("Если", МассивСлов);
	УсловныеОператоры.Вставить("ИначеЕсли", МассивСлов);
	
	Возврат УсловныеОператоры;
	
КонецФункции

Функция КлючевыеСловаИсключенийGherkin()
	СоответствиеТаблицПереводов = СоздатьСоответствиеТаблицПереводов();
	
	МассивСлов = Новый Массив;
	
	Для Каждого Элем Из СоответствиеТаблицПереводов Цикл
		Для Каждого КлючевыеСлова Из Элем.Значение Цикл
			Для Каждого КлючевоеСлово Из КлючевыеСлова.Значение Цикл
				Если КлючевоеСлово.Значение.Тип = "except"
					ИЛИ КлючевоеСлово.Значение.Тип = "try"
					ИЛИ КлючевоеСлово.Значение.Тип = "if"
					ИЛИ КлючевоеСлово.Значение.Тип = "elseif"
					ИЛИ КлючевоеСлово.Значение.Тип = "else"
					ИЛИ КлючевоеСлово.Значение.Тип = "endif"
					ИЛИ КлючевоеСлово.Значение.Тип = "endtry"
					ИЛИ КлючевоеСлово.Значение.Тип = "cycle"
					ИЛИ КлючевоеСлово.Значение.Тип = "endcycle"
					Тогда
					МассивСлов.Добавить(КлючевоеСлово.Значение.Слово);
				КонецЕсли;	 
			КонецЦикла;	 
		КонецЦикла;	 
	КонецЦикла;	 
	
	Возврат МассивСлов; 
КонецФункции	 

Функция СоздатьСоответствиеТаблицПереводов()
	Соответствие = Новый Соответствие;
	Соответствие.Вставить("ru", СоздатьТаблицуКлючевыхСлов_ru());
	Соответствие.Вставить("en", СоздатьТаблицуКлючевыхСлов_en());
	
	Возврат Соответствие; 
КонецФункции

Функция СоздатьТаблицуКлючевыхСлов_ru()
	Тзн = СоздатьТаблицуКлючевыхСлов();
	
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"и","and");
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"когда","when");
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"тогда","then");
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"затем","then");
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"дано","given");
	
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"функция","feature");
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"функционал","feature");
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"функциональность","feature");
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"свойство","feature");
	
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"предыстория","background");
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"контекст","background");
	
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"сценарий","scenario");
	
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"структура сценария","scenario_outline");
	
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"примеры","examples");
	
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"допустим","given");
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"пусть","given");
	
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"цикл","cycle");
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"конеццикла","endcycle");
	
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"если","if");
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"конецесли","endif");
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"иначеесли","elseif");
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"иначе","else");
	
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"попытка","try");
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"исключение","except");
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"конецпопытки","endtry");
	
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"то","then");

	
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"к тому же","and");
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"также","and");
	
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"но","but");
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"а","but");
	
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"импорт","import");
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"подключить","import");
	
	
	Возврат Новый Структура("ТаблицаКлючевыхСлов",Тзн);
КонецФункции

Функция СоздатьТаблицуКлючевыхСлов_en()
	Тзн = СоздатьТаблицуКлючевыхСлов();
	
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"feature","feature");
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"Functionality","feature");
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"Business Need","feature");
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"Ability","feature");
	
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"background","background");
	
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"scenario outline","scenario_outline");
	
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"scenario","scenario",Ложь);
	
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"examples","examples");
	
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"given","given");
	
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"when","when");
	
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"then","then");

	ДобавитьКлючевоеСловоВТаблицу(Тзн,"and","and");
	
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"but","but");
	
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"if","if");
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"elseif","elseif");
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"else","else");
	
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"try","try");
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"except","except");
	
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"import","import");
	ДобавитьКлючевоеСловоВТаблицу(Тзн,"using","import");
	
	Возврат Новый Структура("ТаблицаКлючевыхСлов",Тзн);
КонецФункции

Функция СоздатьТаблицуКлючевыхСлов()
	Тзн = Новый Соответствие;
	Возврат Тзн;
КонецФункции	

Процедура ДобавитьКлючевоеСловоВТаблицу(Тзн,Слово,Тип,Уникально = Истина)
	
	Данные = Новый Структура;
	Данные.Вставить("Слово",НРег(Слово));
	Данные.Вставить("Тип",Тип);
	Данные.Вставить("Уникально",Уникально);
	
	Тзн.Вставить(НРег(Слово),Данные);
	
КонецПроцедуры

Функция СписокКомандРедактора()
	Команды = Новый Массив;
	
	Возврат Команды;
КонецФункции

Функция СписокШаговРедактор(Язык)
	ДанныеИзСправочника = РедакторСценариевВызовСервера.ДанныеШагов(Язык);
	
	Возврат ДанныеИзСправочника;
	
КонецФункции	

Функция ДирективыПрепроцессора()
	
	Соответствие = Новый Соответствие;
	Соответствие.Вставить("if", СтрРазделить("Если,If", ","));
	Соответствие.Вставить("else", СтрРазделить("ИначеЕсли,Иначе,ElseIf,Else", ","));
	Соответствие.Вставить("endif", СтрРазделить("КонецЕсли,EndIf", ","));
	Возврат Соответствие;

КонецФункции	

Функция ОпределитьПараметрыВСтрокеПримера(Знач Стр)
	Массив = Новый Массив;

	Стр = СтрЗаменить(Стр, "\|", "~ЭкранированиеВертикальнойЧерты~");
	
	Стр = СокрЛП(Стр);
	Если Лев(Стр, 1) <> "|" Тогда
		Возврат Массив;
	КонецЕсли;	 
	
	Если Прав(Стр, 1) <> "|" Тогда
		Возврат Массив;
	КонецЕсли;	 
	
	Стр = Сред(Стр, 2);
	Стр = Сред(Стр, 1, СтрДлина(Стр) - 1);
	// убрали символы |
	
	Массив = СтрРазделить(Стр, "|");
	Если Массив.Количество() = 0 Тогда
		Массив.Добавить(Стр);
	КонецЕсли;	
	
	Для Ккк = 0 По Массив.Количество() - 1 Цикл
		Массив[Ккк] = СокрЛП(Массив[Ккк]);
		Массив[Ккк] = СтрЗаменить(Массив[Ккк], "~ЭкранированиеВертикальнойЧерты~", "\|");
	КонецЦикла;
	
	Спс = Новый СписокЗначений;
	Для каждого Элем Из Массив Цикл
		Спс.Добавить(Элем);
	КонецЦикла;
	
	Возврат  Спс;
КонецФункции

#КонецОбласти