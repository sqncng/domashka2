﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Приемник = Параметры.Приемник;
	Источник = Параметры.Источник;
	ПравилоИспользования = Параметры.ПравилоИспользования;
	
	Проект = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Приемник, "Владелец");
	
	ДоступноПравоИзменения = УправлениеДоступомСППР.РольДоступнаПоПроекту("ДобавлениеИзменениеОбъектовМетаданных", Проект);
	
	Если НЕ ДоступноПравоИзменения Тогда
		ТолькоПросмотр = Истина;
	Иначе
		УстановитьДоступностьПравилаИспользования();
	КонецЕсли;
	
	Если Источник = Неопределено Тогда
		УстановитьТипИсточника(Приемник, Источник);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ИсточникПриИзменении(Элемент)
	
	УстановитьДоступностьПравилаИспользования();;
	
КонецПроцедуры

&НаКлиенте
Процедура ИсточникОчистка(Элемент, СтандартнаяОбработка)
	
    УстановитьТипИсточника(Приемник, Источник);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОК(Команда)
	
	ОбработатьИзменениеДанных();
	Оповестить("ИзменениеИнформацииОбИспользованииИсточника", Приемник);
	
	Закрыть();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьДоступностьПравилаИспользования()
	
	Элементы.ПравилоИспользования.Доступность = ЗначениеЗаполнено(Источник) И ДоступноПравоИзменения;
	
КонецПроцедуры

&НаСервере
Процедура ОбработатьИзменениеДанных()
	
	РегистрыСведений.ИспользованиеОбъектов.ЗаписатьИнформациюОбИспользованииОбъектаПриемником(Приемник,
	                                                                                          Источник,
																							  ПравилоИспользования);

КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьТипИсточника(Приемник, Источник)
	
	Типы = Новый Массив;
	Типы.Добавить(ТипЗнч(Приемник));
	
	ОписаниеТипов = Новый ОписаниеТипов(Типы);
	Значение = ОписаниеТипов.ПривестиЗначение(Неопределено);
	
	Источник = Значение;
	
КонецПроцедуры

#КонецОбласти