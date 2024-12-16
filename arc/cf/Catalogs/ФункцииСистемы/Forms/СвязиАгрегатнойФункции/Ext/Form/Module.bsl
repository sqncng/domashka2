﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если ТипЗнч(Параметры.Связи) = Тип("Соответствие") Тогда
		
		Для Каждого ЭлементСоответствия из Параметры.Связи Цикл
			
			СтрокаАгрегатаИлиДочерней = СвязиФункции.ПолучитьЭлементы().Добавить();
			СтрокаАгрегатаИлиДочерней.Функция  = ЭлементСоответствия.Ключ;
			
			ПодчиненныеСтроки = СтрокаАгрегатаИлиДочерней.ПолучитьЭлементы();
			
			Если ТипЗнч(ЭлементСоответствия.Значение) = Тип("Массив") Тогда
				// Это конечные связи дочерней функции
				Для Каждого СвойстваСвязи из ЭлементСоответствия.Значение Цикл
					ПодчиненнаяСтрока = ПодчиненныеСтроки.Добавить();
					ПодчиненнаяСтрока.Функция = СвойстваСвязи.Ссылка;
				КонецЦикла;
				
			ИначеЕсли ТипЗнч(ЭлементСоответствия.Значение) = Тип("Соответствие") Тогда
				// Это дочерние функции, связанные с агрегатом
				Для Каждого ЭлементСоответствияДочерней из ЭлементСоответствия.Значение Цикл
					
					ПодчиненнаяСтрока = ПодчиненныеСтроки.Добавить();
					ПодчиненнаяСтрока.Функция = ЭлементСоответствияДочерней.Ключ;
					
					СтрокиСвязей = ПодчиненнаяСтрока.ПолучитьЭлементы();
					
					Если ТипЗнч(ЭлементСоответствияДочерней.Значение) = Тип("Массив") Тогда
						// Это конечные связи дочерней функции
						Для Каждого СвойстваСвязи из ЭлементСоответствияДочерней.Значение Цикл
							СтрокаСвязи = СтрокиСвязей.Добавить();
							СтрокаСвязи.Функция = СвойстваСвязи.Ссылка;
						КонецЦикла;
						
					КонецЕсли;
					
				КонецЦикла;
				
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СвязиФункцииВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтрокаДерева = СвязиФункции.НайтиПоИдентификатору(ВыбраннаяСтрока);
	
	Если СтрокаДерева <> Неопределено Тогда
		ПоказатьЗначение(, СтрокаДерева.Функция);
	КонецЕсли;
	
КонецПроцедуры
