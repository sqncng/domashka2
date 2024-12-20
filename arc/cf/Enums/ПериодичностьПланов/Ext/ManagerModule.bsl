﻿#Область ПрограммныйИнтерфейс

// Проверяет план, на предмет соответствия настройкам вида плана
//
// Параметры:
//  ПараметрыПроверки  - см. ПараметрыПроверкиПериодичностиПлана
//
// Возвращаемое значение:
//   Булево
//
Функция ПланСоответствуетПериодичностиПлана(ПараметрыПроверки) Экспорт
	
	Если ПараметрыПроверки.ДатаНачалаНастроек > ПараметрыПроверки.ДатаНачалаПлана Тогда
		Возврат Ложь;
	КонецЕсли;
	
	ДатаНачалаОчередногоПериода = ПараметрыПроверки.ДатаНачалаНастроек;
	
	Пока ПараметрыПроверки.ДатаНачалаПлана >= ДатаНачалаОчередногоПериода Цикл
		
		ДатаОкончанияОчередногоПериода = КонецПериодаПланирования(ДатаНачалаОчередногоПериода, 
		                                                          ПараметрыПроверки.ПериодичностьНастроек, 
		                                                          ПараметрыПроверки.КоличествоПериодовНастроек);
		
		Если ПараметрыПроверки.ДатаНачалаПлана = ДатаНачалаОчередногоПериода 
			И ПараметрыПроверки.ДатаОкончанияПлана = ДатаОкончанияОчередногоПериода Тогда
			
			Возврат Истина;
			
		ИначеЕсли ПараметрыПроверки.ДатаНачалаПлана <= ДатаОкончанияОчередногоПериода Тогда
			
			Возврат Ложь;
			
		КонецЕсли;
		
		ДатаНачалаОчередногоПериода = НачалоСледующегоПериодаПланирования(ДатаНачалаОчередногоПериода,
		                                                                  ПараметрыПроверки.ПериодичностьНастроек, 
		                                                                  ПараметрыПроверки.КоличествоПериодовНастроек);
		
	КонецЦикла;
	
КонецФункции

// Конструктор для параметров проверки периодичности плана
//
// Возвращаемое значение:
//   Структура - содержит:
//     * ДатаНачалаНастроек         - Дата
//     * ПериодичностьНастроек      - ПеречислениеСсылка.ПериодичностьПланов
//     * КоличествоПериодовНастроек - Число
//     * ДатаНачалаПлана            - Дата
//     * ДатаОкончанияПлана         - Дата
//
Функция ПараметрыПроверкиПериодичностиПлана() Экспорт
	
	ПараметрыПроверки = Новый Структура;
	ПараметрыПроверки.Вставить("ДатаНачалаНастроек",         Дата(1, 1, 1));
	ПараметрыПроверки.Вставить("ПериодичностьНастроек",      Перечисления.ПериодичностьПланов.ПустаяСсылка());
	ПараметрыПроверки.Вставить("КоличествоПериодовНастроек", 0);
	ПараметрыПроверки.Вставить("ДатаНачалаПлана",            0);
	ПараметрыПроверки.Вставить("ДатаОкончанияПлана",         0);
	
	Возврат ПараметрыПроверки;
	
КонецФункции

// Определяет даты начала и окончания планов попадающих в заданный период
//
// Параметры:
//  ПараметрыПолучения  - Структура - см. НовыйПараметрыПолученияДанныхПлановПоПериоду
//
// Возвращаемое значение:
//   Структура - содержит:
//     * НачалоПериодаПланов - Дата - 
//     * КонецПериодаПланов  - Дата - 
//
Функция ДатаНачалаИОкончанияПлановПопадающихВПериод(ПараметрыПолучения) Экспорт
	
	Результат = Новый Структура;
	Результат.Вставить("НачалоПериодаПланов", Неопределено);
	Результат.Вставить("КонецПериодаПланов", Неопределено);
	
	НастройкиПланирования = ПараметрыПолучения.НастройкиПланирования;
	
	Если ПараметрыПолучения.ДатаОкончания = Неопределено Тогда
		ДатаОкончания = РезультатИзмененияДатыНаПериодичность(ПараметрыПолучения.ДатаНачала, 
		                                                      НастройкиПланирования.Периодичность,
		                                                      НастройкиПланирования.КоличествоПериодов * ПараметрыПолучения.КоличествоПериодов,
		                                                      "Вперед");
	Иначе
		ДатаОкончания = ПараметрыПолучения.ДатаОкончания;
	КонецЕсли;
		
	Если ПараметрыПолучения.ДатаНачала < НастройкиПланирования.НачалоДействия Тогда
		
		Результат.НачалоПериодаПланов = НастройкиПланирования.НачалоДействия;
		
	Иначе
		
		ТекущаяДатаНачалаПериода = НастройкиПланирования.НачалоДействия;
		
		Пока Истина Цикл
			
			НоваяДатаНачалаПериода = РезультатИзмененияДатыНаПериодичность(ТекущаяДатаНачалаПериода,
			                                                               НастройкиПланирования.Периодичность, 
			                                                               НастройкиПланирования.КоличествоПериодов, 
			                                                               "Вперед");
			
			Если НоваяДатаНачалаПериода > ПараметрыПолучения.ДатаНачала Тогда
				
				Результат.НачалоПериодаПланов = ТекущаяДатаНачалаПериода;
				Прервать;
				
			ИначеЕсли НоваяДатаНачалаПериода = ПараметрыПолучения.ДатаНачала Тогда
				
				Результат.НачалоПериодаПланов = НоваяДатаНачалаПериода; 
				Прервать;
				
			Иначе
				ТекущаяДатаНачалаПериода = НоваяДатаНачалаПериода;
			КонецЕсли;
		
		КонецЦикла
		
	КонецЕсли;
	
	Если ДатаОкончания < Результат.НачалоПериодаПланов Тогда
		ДатаНачалаПоследнегоПериода = Результат.НачалоПериодаПланов;
	Иначе
		
		ДатаНачалаПоследнегоПериода      = Результат.НачалоПериодаПланов;
		НоваяДатаНачалаПоследнегоПериода = ДатаНачалаПоследнегоПериода;
		
		Пока Истина Цикл
			
			НоваяДатаНачалаПоследнегоПериода = РезультатИзмененияДатыНаПериодичность(ДатаНачалаПоследнегоПериода, 
			                                                                         НастройкиПланирования.Периодичность,
			                                                                         НастройкиПланирования.КоличествоПериодов,
			                                                                         "Вперед");
			
			Если НоваяДатаНачалаПоследнегоПериода > ДатаОкончания Тогда
				Прервать;
			ИначеЕсли НоваяДатаНачалаПоследнегоПериода = ДатаОкончания Тогда
				ДатаНачалаПоследнегоПериода = НоваяДатаНачалаПоследнегоПериода; 
				Прервать;
			Иначе
				ДатаНачалаПоследнегоПериода = НоваяДатаНачалаПоследнегоПериода;
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЕсли;
	
	ДатаНачалаСледующегоПериода = РезультатИзмененияДатыНаПериодичность(ДатаНачалаПоследнегоПериода, 
	                                                                    НастройкиПланирования.Периодичность,
	                                                                    НастройкиПланирования.КоличествоПериодов,
	                                                                    "Вперед");
	
	Результат.КонецПериодаПланов = ДатаНачалаСледующегоПериода - 86400;
	
	Возврат Результат;
	
КонецФункции

// Вычисляет изменение даты на периодичность 
//
// Параметры:
//  ДатаПланирования   - Дата - дата, которую предполагается изменить.
//  Периодичность      - ПеречислениеСсылка.ПериодичностьПланов - периодичность.
//  КоличествоПериодов - Число - количество периодов, на которое требуется изменить дату.
//  Направление        - Строка - "Вперед" или "Назад".
//
// Возвращаемое значение:
//   Дата   - результат изменения даты на периодичность
//
Функция РезультатИзмененияДатыНаПериодичность(ДатаПланирования, Периодичность, КоличествоПериодов, Направление) Экспорт
	
	НоваяДатаПланирования = ДатаПланирования;
	
	Если Направление = "Вперед" Тогда
		
		Если Периодичность = Перечисления.ПериодичностьПланов.День Тогда
			
			НоваяДатаПланирования = НоваяДатаПланирования + 86400 * КоличествоПериодов;
			
		ИначеЕсли Периодичность = Перечисления.ПериодичностьПланов.Неделя Тогда
			
			НоваяДатаПланирования = НачалоДня(НоваяДатаПланирования + 86400 * КоличествоПериодов * 7);
			
		ИначеЕсли Периодичность = Перечисления.ПериодичностьПланов.Месяц Тогда
			
			НоваяДатаПланирования = НачалоДня(ДобавитьМесяц(НоваяДатаПланирования, КоличествоПериодов));
			
		ИначеЕсли Периодичность = Перечисления.ПериодичностьПланов.Квартал Тогда
			
			НоваяДатаПланирования = НачалоДня(ДобавитьМесяц(НоваяДатаПланирования, 3 * КоличествоПериодов));
			
		ИначеЕсли Периодичность = Перечисления.ПериодичностьПланов.Год Тогда
			
			НоваяДатаПланирования = НачалоДня(ДобавитьМесяц(НоваяДатаПланирования, 12 * КоличествоПериодов));
			
		КонецЕсли;
		
	Иначе
		
		Если Периодичность = Перечисления.ПериодичностьПланов.День Тогда
			
			НоваяДатаПланирования = НоваяДатаПланирования - 86400 * КоличествоПериодов;
			
		ИначеЕсли Периодичность = Перечисления.ПериодичностьПланов.Неделя Тогда
			
			НоваяДатаПланирования = НачалоДня(НоваяДатаПланирования - 86400 * КоличествоПериодов * 7);
			
		ИначеЕсли Периодичность = Перечисления.ПериодичностьПланов.Месяц Тогда
			
			НоваяДатаПланирования = НачалоДня(ДобавитьМесяц(НоваяДатаПланирования, - КоличествоПериодов));
			
		ИначеЕсли Периодичность = Перечисления.ПериодичностьПланов.Квартал Тогда
			
			НоваяДатаПланирования = НачалоДня(ДобавитьМесяц(НоваяДатаПланирования, -3 * КоличествоПериодов));
			
		ИначеЕсли Периодичность = Перечисления.ПериодичностьПланов.Год Тогда
			
			НоваяДатаПланирования = НачалоДня(ДобавитьМесяц(НоваяДатаПланирования, -12 * КоличествоПериодов));
			
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат НоваяДатаПланирования;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыФункции

Функция НачалоСледующегоПериодаПланирования(ДатаНачалаТекущегоПериода, Периодичность, КоличествоПериодов)
	
	Если Периодичность = Перечисления.ПериодичностьПланов.День Тогда
		
		ДатаНачалаСледующегоПериода = ДатаНачалаТекущегоПериода + 86400 * КоличествоПериодов;
		
	ИначеЕсли Периодичность = Перечисления.ПериодичностьПланов.Неделя Тогда
		
		ДатаНачалаСледующегоПериода = НачалоДня(ДатаНачалаТекущегоПериода + 86400 * КоличествоПериодов * 7);
		
		
	ИначеЕсли Периодичность = Перечисления.ПериодичностьПланов.Месяц Тогда
		
		ДатаНачалаСледующегоПериода = НачалоДня(ДобавитьМесяц(ДатаНачалаТекущегоПериода, КоличествоПериодов));
		
	ИначеЕсли Периодичность = Перечисления.ПериодичностьПланов.Квартал Тогда
		
		ДатаНачалаСледующегоПериода = НачалоДня(ДобавитьМесяц(ДатаНачалаТекущегоПериода, 3 * КоличествоПериодов));
		
	ИначеЕсли Периодичность = Перечисления.ПериодичностьПланов.Год Тогда
		
		ДатаНачалаСледующегоПериода = НачалоДня(ДобавитьМесяц(ДатаНачалаТекущегоПериода, 12 * КоличествоПериодов));
		
	КонецЕсли;
	
	Возврат ДатаНачалаСледующегоПериода;
	
КонецФункции

Функция КонецПериодаПланирования(ДатаНачала, Периодичность, КоличествоПериодов)
	
	Возврат НачалоДня(НачалоСледующегоПериодаПланирования(ДатаНачала, Периодичность, КоличествоПериодов) - 2);
	
КонецФункции

#КонецОбласти


