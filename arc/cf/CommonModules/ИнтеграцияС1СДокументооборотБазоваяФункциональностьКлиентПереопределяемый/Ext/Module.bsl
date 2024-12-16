﻿////////////////////////////////////////////////////////////////////////////////
// Подсистема "Интеграция с 1С:Документооборотом"
// Модуль ИнтеграцияС1СДокументооборотБазоваяФункциональностьКлиентПереопределяемый: клиент
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Вызывается из форм согласуемых объектов. Предназначена для вывода листа согласования в случаях,
// когда добавление команды в подменю печати невозможно или нежелательно, а также для внедрения в конфигурации
// без подсистемы БСП УправлениеПечатью.
//
// Параметры:
//   ПредметСогласования - ЛюбаяСсылка - согласуемый объект.
//   ВладелецФормы - ФормаКлиентскогоПриложения - необязательный, форма-источник команды.
//
Процедура ВыполнитьКомандуПечатиЛистаСогласования(ПредметСогласования, ВладелецФормы = Неопределено) Экспорт
	
	
	
КонецПроцедуры

// Вызывается из форм обработки, соответствующих процессам, документам и задачам ДО. Предназначена для обработки
// команд, добавленных программно при вызове процедуры ДополнительнаяОбработкаФормы<...> переопределяемого модуля.
//
// Параметры:
//   Команда - КомандаФормы - вызванная пользователем команда.
//   ЭтаФорма - ФормаКлиентскогоПриложения - форма обработки, откуда вызвана команда.
//
Процедура ВыполнитьПрограммноДобавленнуюКоманду(Команда, ЭтаФорма) Экспорт
	
	
	
КонецПроцедуры

// Вызывается перед выполнением команды ОткрытьПанель обработки ПанельАдминистрированияБИД.
// Позволяет переопределить форму НастройкаИнтеграцииC1СДокументооборотом.
//
// Параметры:
//   ПараметрыВыполненияКоманды - Произвольный - Параметры выполнения команды ОткрытьПанель.
//   СтандартнаяОбработка - Булево - неявно возвращаемое значение, признак того, что стандартная
//     форма НастройкаИнтеграцииC1СДокументооборотом открыта не будет.
//
// Пример:
//	СтандартнаяОбработка = Ложь;
//	ОткрытьФорму(
//		"Обработка.ПанельАдминистрированияБИД.Форма.НастройкаИнтеграцииC1СДокументооборотомПереопределяемый",
//		Новый Структура,
//		ПараметрыВыполненияКоманды.Источник,
//		"Обработка.ПанельАдминистрированияБИД.Форма.НастройкаИнтеграцииC1СДокументооборотомПереопределяемый"
//			+ ?(ПараметрыВыполненияКоманды.Окно = Неопределено, ".ОтдельноеОкно", ""),
//		ПараметрыВыполненияКоманды.Окно);
//
Процедура ОткрытьПанельАдминистрированияБИД(ПараметрыВыполненияКоманды, СтандартнаяОбработка) Экспорт
	
	
	
КонецПроцедуры

// Вызывается перед созданием бизнес-процесса и позволяет отказаться от запуска.
//
// Параметры:
//   Предмет - ЛюбаяСсылка - ссылка на объект интегрируемой системы, или
//           - Структура - описание объекта ДО, со свойствами:
//               ID - Строка - идентификатор;
//               type - Строка - тип;
//               name - Строка - наименование предмета.
//   Отказ - Булево - при установке в Истина процесс запущен не будет.
//
// Пример:
//	Если ТипЗнч(Предмет) = Тип("ДокументСсылка._ДемоЗаказПокупателя") Тогда
//		ТекстСообщения = "";
//		Если Не ПродажиВызовСервера.ЗаказЗаполненКорректно(Предмет, ТекстСообщения) Тогда
//			Отказ = Истина;
//			ПоказатьПредупреждение(, ТекстСообщения);
//		КонецЕсли;
//	КонецЕсли;
//
Процедура ПередСозданиемБизнесПроцесса(Предмет, Отказ) Экспорт
	
	
	
КонецПроцедуры

// Вызывается при изменении состояния согласования в ДО. Предназначен для изменения формы
// согласуемого объекта, если доработка самого модуля формы нежелательна.
//
// Параметры:
//   ПредметСогласования - ЛюбаяСсылка - согласуемый объект.
//   Источник - ФормаКлиентскогоПриложения - форма-источник вызова.
//   Состояние - ПеречислениеСсылка.СостоянияСогласованияВДокументообороте.
//   ВызовИзФормыОбъекта - Булево - Истина, если изменение состояния вызвано пользователем из формы объекта.
//
Процедура ПриИзмененииСостоянияСогласования(ПредметСогласования, Источник, Состояние, ВызовИзФормыОбъекта) Экспорт
	
	
	
КонецПроцедуры

// Возвращает сохраненный ранее признак состоявшегося показа окна авторизации.
//
// Параметры:
//   АвторизацияПредложена - Булево - неявно возвращаемое значение,
//     Истина, если авторизация была предложена в этом сеансе, и Ложь в противном случае.
//
Процедура ПриОпределенииПредложенияАвторизации(АвторизацияПредложена) Экспорт
	
	
	
КонецПроцедуры

// Позволяет переопределить разложение полного имени файла на составляющие.
//
// Параметры:
//   СтруктураИмениФайла - Структура:
//     * ПолноеИмя - Строка - Содержит полный путь к файлу, т.е. полностью соответствует входному
//         параметру ПолноеИмяФайла.
//     * Путь - Строка - Содержит путь к каталогу, в котором лежит файл.
//     * Имя - Строка - Содержит имя файла с расширением, без пути к файлу.
//     * Расширение - Строка - Содержит расширение файла.
//     * ИмяБезРасширения - Строка - Содержит имя файла без расширения и без пути к файлу.
//
Процедура ПриРазложенииПолногоИмениФайла(СтруктураИмениФайла) Экспорт
	
	
	
КонецПроцедуры

// Вызывается при сохранении массива пользовательских настроек МассивСтруктур.
//
// Параметры:
//   МассивСтруктур - Массив - массив структур с полями "Объект", "Настройка", "Значение".
//   НужноОбновитьПовторноИспользуемыеЗначения - Булево - требуется обновить повторно используемые значения.
//   СтандартнаяОбработка - Булево - неявно возвращаемое значение, признак того, что стандартная
//     обработка вызываться не будет.
//
Процедура ПриСохраненииНастроекПользователя(МассивСтруктур, НужноОбновитьПовторноИспользуемыеЗначения,
		СтандартнаяОбработка) Экспорт
	
	
	
КонецПроцедуры

// Запоминает факт показа окна авторизации, чтобы больше не беспокоить пользователя в пределах сеанса.
//
Процедура ПриСохраненииПредложенияАвторизации() Экспорт
	
	
	
КонецПроцедуры

// Устанавливает отбор при выборе объекта ДО, связанного с объектом ИС.
//
// Параметры:
//   СвязываемыйОбъект - ЛюбаяСсылка - объект ИС, связываемый с объектом ДО.
//   ТипОбъектаДокументооборота - Строка - тип выбираемого объекта ДО.
//   Отбор - Структура, Неопределено - неявно возвращаемое значение, отбор, накладываемый перед
//     предъявлением пользователю.
//
// Пример:
//	Если ТипЗнч(СвязываемыйОбъект) = Тип("СправочникСсылка.Контрагенты")
//			И ТипОбъектаДокументооборота = "DMCorrespondent" Тогда
//		ЗначенияРеквизитов = ОбщегоНазначенияУТВызовСервера.ЗначенияРеквизитовОбъекта(
//			СвязываемыйОбъект, "Наименование, ИНН, КПП");
//		Если ЗначениеЗаполнено(ЗначенияРеквизитов.ИНН) Тогда
//			Отбор = Новый Структура;
//			Отбор.Вставить("inn", ЗначенияРеквизитов.ИНН);
//			Отбор.Вставить("kpp", ЗначенияРеквизитов.КПП);
//		ИначеЕсли ЗначениеЗаполнено(ЗначенияРеквизитов.Наименование) Тогда
//			Отбор = Новый Структура;
//			Отбор.Вставить("name", ЗначенияРеквизитов.Наименование);
//		КонецЕсли;
//	КонецЕсли;
//
Процедура ПриУстановкеОтбораПриВыбореСвязанногоОбъекта(СвязываемыйОбъект, ТипОбъектаДокументооборота, Отбор) Экспорт
	
	
	
КонецПроцедуры

#КонецОбласти