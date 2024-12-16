﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Определяет префикс кодов и номеров объектов информационной базы по умолчанию.
//
// Параметры:
//	Префикс - Строка, 2 - префикс кодов и номеров объектов информационной базы по умолчанию.
//
Процедура ПриОпределенииПрефиксаИнформационнойБазыПоУмолчанию(Префикс) Экспорт
	
	Префикс = "00";
	
КонецПроцедуры

// Определяет список планов обмена, которые используют функционал подсистемы обмена данными.
//
// Параметры:
// ПланыОбменаПодсистемы - Массив - Массив планов обмена конфигурации,
//  которые используют функционал подсистемы обмена данными.
//  Элементами массива являются объекты метаданных планов обмена.
//
// Пример тела процедуры:
//
// ПланыОбменаПодсистемы.Добавить(Метаданные.ПланыОбмена.ОбменБезИспользованияПравилКонвертации);
// ПланыОбменаПодсистемы.Добавить(Метаданные.ПланыОбмена.ОбменСБиблиотекойСтандартныхПодсистем);
// ПланыОбменаПодсистемы.Добавить(Метаданные.ПланыОбмена.РаспределеннаяИнформационнаяБаза);
//
Процедура ПолучитьПланыОбмена(ПланыОбменаПодсистемы) Экспорт
	
	ОбменДаннымиСППР.СписокПлановОбмена(ПланыОбменаПодсистемы);
	
КонецПроцедуры

// Обработчик при выгрузке данных.
// Используется для переопределения стандартной обработки выгрузки данных.
// В данном обработчике должна быть реализована логика выгрузки данных:
// выборка данных для выгрузки, сериализация данных в файл сообщения или сериализация данных в поток.
// После выполнения обработчика выгруженные данные будут отправлены получателю подсистемой обмена данными.
// Формат сообщения для выгрузки может быть произвольным.
// В случае ошибок при отправке данных следует прерывать выполнение обработчика
// методом ВызватьИсключение с описанием ошибки.
//
// Параметры:
//
//  СтандартнаяОбработка - Булево - в данный параметр передается признак выполнения стандартной (системной) обработки
//                                 события.
//   Если в теле процедуры-обработчика установить данному параметру значение Ложь, стандартная
//   обработка события производиться не будет. Отказ от стандартной обработки не отменяет действие.
//   Значение по умолчанию - Истина.
//
//  Получатель - ПланОбменаСсылка - узел плана обмена, для которого выполняется выгрузка данных.
//
//  ИмяФайлаСообщения - Строка - имя файла, в который необходимо выполнить выгрузку данных.
//   Если этот параметр заполнен, то система ожидает,
//   что данные будут выгружены в файл. После выгрузки система выполнит отправку данных из этого файла.
//   Если параметр пустой, то система ожидает, что данные будут выгружены в параметр ДанныеСообщения.
//
//  ДанныеСообщения - Произвольный - если параметр ИмяФайлаСообщения пустой,
//   то система ожидает, что данные будут выгружены в этот параметр.
//
//  КоличествоЭлементовВТранзакции - Число - определяет максимальное число элементов данных,
//   которые помещаются в сообщение в рамках одной транзакции базы данных.
//   При необходимости в обработчике следует реализовать логику
//   установки транзакционных блокировок на выгружаемые данные.
//   Значение параметра задается в настройках подсистемы обмена данными.
//
//  ИмяСобытияЖурналаРегистрации - Строка - имя события журнала регистрации текущего сеанса обмена данными.
//   Используется для записи в журнал регистрации данных (ошибок, предупреждений, информации) с заданным именем события.
//   Соответствует параметру ИмяСобытия метода глобального контекста ЗаписьЖурналаРегистрации.
//
//  КоличествоОтправленныхОбъектов - Число - счетчик отправленных объектов.
//   Используется для определения количества отправленных объектов
//   для последующей фиксации в протоколе обмена.
//
Процедура ПриВыгрузкеДанных(СтандартнаяОбработка,
								Получатель,
								ИмяФайлаСообщения,
								ДанныеСообщения,
								КоличествоЭлементовВТранзакции,
								ИмяСобытияЖурналаРегистрации,
								КоличествоОтправленныхОбъектов) Экспорт
	
КонецПроцедуры

// Обработчик при загрузке данных.
// Используется для переопределения стандартной обработки загрузки данных.
// В данном обработчике должна быть реализована логика загрузки данных:
// необходимые проверки перед загрузкой данных, сериализация данных из файла сообщения или сериализация данных из
// потока.
// Формат сообщения для загрузки может быть произвольным.
// В случае ошибок при получении данных следует прерывать выполнение обработчика
// методом ВызватьИсключение с описанием ошибки.
//
// Параметры:
//
//  СтандартнаяОбработка - Булево - в данный параметр передается признак выполнения
//   стандартной (системной) обработки события.
//   Если в теле процедуры-обработчика установить данному параметру значение Ложь,
//   стандартная обработка события производиться не будет.
//   Отказ от стандартной обработки не отменяет действие.
//   Значение по умолчанию: Истина.
//
//  Отправитель - ПланОбменаСсылка - узел плана обмена, для которого выполняется загрузка данных.
//
//  ИмяФайлаСообщения - Строка - имя файла, из которого требуется выполнить загрузку данных.
//   Если параметр не заполнен, то данные для загрузки передаются через параметр ДанныеСообщения.
//
//  ДанныеСообщения - Произвольный - параметр содержит данные, которые необходимо загрузить.
//   Если параметр ИмяФайлаСообщения пустой,
//   то данные для загрузки передаются через этот параметр.
//
//  КоличествоЭлементовВТранзакции - Число - определяет максимальное число элементов данных,
//   которые читаются из сообщения и записываются в базу данных в рамках одной транзакции.
//   При необходимости в обработчике следует реализовать логику записи данных в транзакции.
//   Значение параметра задается в настройках подсистемы обмена данными.
//
//  ИмяСобытияЖурналаРегистрации - Строка - имя события журнала регистрации текущего сеанса обмена данными.
//   Используется для записи в журнал регистрации данных (ошибок, предупреждений, информации) с заданным именем события.
//   Соответствует параметру ИмяСобытия метода глобального контекста ЗаписьЖурналаРегистрации.
//
//  КоличествоПолученныхОбъектов - Число -счетчик полученных объектов.
//   Используется для определения количества загруженных объектов
//   для последующей фиксации в протоколе обмена.
//
Процедура ПриЗагрузкеДанных(СтандартнаяОбработка,
								Отправитель,
								ИмяФайлаСообщения,
								ДанныеСообщения,
								КоличествоЭлементовВТранзакции,
								ИмяСобытияЖурналаРегистрации,
								КоличествоПолученныхОбъектов) Экспорт
	
КонецПроцедуры

// Обработчик регистрации изменений для начальной выгрузки данных.
// Используется для переопределения стандартной обработки регистрации изменений.
// При стандартной обработке будут зарегистрированы изменения всех данных из состава плана обмена.
// Если для плана обмена предусмотрены фильтры ограничения миграции данных,
// то использование этого обработчика позволит повысить производительность начальной выгрузки данных.
// В обработчике следует реализовать регистрацию изменений с учетом фильтров ограничения миграции данных.
// Если для плана обмена используются ограничения миграции по дате или по дате и организациям,
// то можно воспользоваться универсальной процедурой
// ОбменДаннымиСервер.ЗарегистрироватьДанныеПоДатеНачалаВыгрузкиИОрганизациям.
// Обработчик используется только для универсального обмена данными с использованием правил обмена
// и для универсального обмена данными без правил обмена и не используется для обменов в РИБ.
// Использование обработчика позволяет повысить производительность
// начальной выгрузки данных в среднем в 2-4 раза.
//
// Параметры:
//
//   Получатель - ПланОбменаСсылка - узел плана обмена, в который требуется выгрузить данные.
//   СтандартнаяОбработка - Булево - в данный параметр передается признак выполнения стандартной
//                          (системной) обработки события.
//                          Если в теле процедуры-обработчика установить данному параметру значение Ложь,
//                          стандартная обработка события производиться не будет.
//                          Отказ от стандартной обработки не отменяет действие.
//                          Значение по умолчанию - Истина.
//   Отбор - Массив из ОбъектМетаданных
//         - ОбъектМетаданных - определяет отбор по объектам метаданных,
//           для которых следует выполнить регистрацию изменений.
//
Процедура РегистрацияИзмененийНачальнойВыгрузкиДанных(Знач Получатель, СтандартнаяОбработка, Отбор) Экспорт
	
	
	
КонецПроцедуры

// Обработчик при коллизии изменений данных.
// Событие возникает при получении данных, если в текущей информационной базе изменен тот же объект,
// что получен из сообщения обмена и эти объекты различаются.
// Используется для переопределения стандартной обработки коллизий изменений данных.
// Стандартная обработка коллизий предполагает получение изменений от главного узла
// и игнорирование изменений, полученных от подчиненного узла.
// В данном обработчике должен быть переопределен параметр ПолучениеЭлемента,
// если требуется изменить поведение по умолчанию.
// В данном обработчике можно задать поведение системы при возникновении коллизии изменений данных в разрезе данных,
// в разрезе свойств данных, в разрезе отправителей или для всей информационной базы в целом, или для всех данных в
// целом.
// Обработчик вызывается как в обмене в распределенной информационной базе (РИБ),
// так и во всех остальных обменах, в том числе в обменах по правилам обмена.
//
// Параметры:
//  ЭлементДанных - Произвольный - элемент данных, прочитанный из сообщения обмена данными.
//                  Элементами данных могут быть КонстантаМенеджерЗначения.<Имя константы>,
//                  объекты базы данных (кроме объекта "Удаление объекта"), наборы записей регистров,
//                  последовательностей или перерасчетов.
//
//  ПолучениеЭлемента - ПолучениеЭлементаДанных - определяет, будет ли прочитанный элемент данных записан в базу данных
//                                               или нет в случае коллизии.
//   При вызове обработчика параметр имеет значение Авто, что означает действия по умолчанию
//   (принимать от главного, игнорировать от подчиненного).
//   Значение данного параметра может быть переопределено в обработчике.
//
//  Отправитель - ПланОбменаСсылка - узел плана обмена, от имени которого выполняется получение данных.
//
//  ПолучениеОтГлавного - Булево -  в распределенной информационной базе обозначает признак получения данных от главного
//                                узла.
//   Истина - выполняется получение данных от главного узла, Ложь - от подчиненного.
//   В обменах по правилам обмена принимает значение Истина - если в правилах обмена приоритет объекта
//   при коллизии установлен в значение "Выше" (значение по умолчанию) или не указан;
//   Ложь - если в правилах обмена приоритет объекта при коллизии установлен в значение "Ниже" или "Совпадает".
//   Во всех остальных типах обмена данными параметр принимает значение Истина.
//
Процедура ПриКоллизииИзмененийДанных(Знач ЭлементДанных, ПолучениеЭлемента, Знач Отправитель, Знач ПолучениеОтГлавного) Экспорт
	
	
	
КонецПроцедуры

// Обработчик начальной настройки ИБ после создания узла РИБ.
// Вызывается в момент первого запуска подчиненного узла РИБ (в том числе АРМ).
//
Процедура ПриНастройкеПодчиненногоУзлаРИБ() Экспорт
	
КонецПроцедуры

// Получает доступные для использования версии универсального формата EnterpriseData.
//
// Параметры:
//   ВерсииФормата - Соответствие - соответствие номера версии формата,
//                   общему модулю, в котором находятся обработчики выгрузки/загрузки для данной версии.
//
// Пример:
//   ВерсииФормата.Вставить("1.2", <ИмяОбщегоМодуляСПравиламиКонвертации>);
//
Процедура ПриПолученииДоступныхВерсийФормата(ВерсииФормата) Экспорт
	
	
	
КонецПроцедуры

// Получает доступные для использования расширения универсального формата EnterpriseData.
//
// Параметры:
//   РасширенияФормата - Соответствие из КлючИЗначение:
//     * Ключ - Строка - URI пространства имен схемы расширения формата.
//     * Значение - Строка - номер расширяемой версии формата.
//
Процедура ПриПолученииДоступныхРасширенийФормата(РасширенияФормата) Экспорт
	
КонецПроцедуры

// Вызывается в событии ПриЗаписи константы ЭтоАвтономноеРабочееМесто.
// Позволяет переопределить стандартную обработку при измении значения.
//
// Параметры:
//   ПредыдущееЗначение - Булево - значение константы ЭтоАвтономноеРабочееМесто до изменения.
//   НовоеТекущее - Булево - записываемое значение константы ЭтоАвтономноеРабочееМесто до изменения.
//   СтандартнаяОбработка - Булево - отключение стандартного поведения системы при записи константы 
//                                   (значение по-умолчанию Истина).
//
Процедура ПриИзмененииОпцииАвтономногоРежимаРаботы(ПредыдущееЗначение, НовоеТекущее, СтандартнаяОбработка) Экспорт
	
	
	
КонецПроцедуры

#КонецОбласти
