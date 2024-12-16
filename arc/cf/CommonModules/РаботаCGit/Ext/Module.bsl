﻿#Область ПрограммныйИнтерфейс

// Возвращает гиперссылку для перехода в браузере
//
// Параметры:
//  Ветка - СправочникСсылка.Ветки
// 
// Возвращаемое значение:
//  Строка
//
Функция ПерейтиККоммитамВетки(Ветка) Экспорт
	Проект = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ветка, "Владелец");
	ДанныеПодключения = Тестирование.ДанныеПодключенияПроектаКGitСерверу(Проект);
	ВеткаИмя = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ветка, "Имя");
	
	Гиперссылка = СтрШаблон("https://%1/%2/-/commits/%3",
		ЗаменитьСимволыВГиперссылке(ДанныеПодключения.РедактированиеСценариевВGitАдресСервера),
		ЗаменитьСимволыВГиперссылке(ДанныеПодключения.РедактированиеСценариевВGitИмяПроекта),
		ЗаменитьСимволыВГиперссылке(ВеткаИмя));
		
	Возврат Гиперссылка;	
		
КонецФункции	

// Возвращает гиперссылки для перехода в браузере
//
// Параметры:
//  Исходник - Строка
//  Ветка - СправочникСсылка.Ветки
//  Тип - Строка
// 
// Возвращаемое значение:
//  Массив
//
Функция ИзмененыеФайлыДляПереходаККоммитамПоМетаданному(Исходник, Ветка, Тип) Экспорт
	Результат = Новый Массив;
	
	МассивСтрок = СтрРазделить(Исходник, Символы.ПС);
	Для Сч = 0 По МассивСтрок.Количество() - 1 Цикл
		ТекСтрока = МассивСтрок[Сч];
		Если Лев(ТекСтрока, 3) = "---" Тогда
			Если Найти(ТекСтрока, "/dev/null") > 0 И Сч < (МассивСтрок.Количество() - 1) Тогда
				ТекСтрока = МассивСтрок[Сч+1];
			КонецЕсли;	
			ТекСтрока = СокрЛП(Сред(ТекСтрока, 4));
			Если Лев(ТекСтрока, 2) = "a/" ИЛИ Лев(ТекСтрока, 2) = "b/" Тогда
				ТекСтрока = Сред(ТекСтрока, 3);
			КонецЕсли;
			ДанныеФайла = Новый Структура;
			ДанныеФайла.Вставить("ИмяФайла", ТекСтрока);
			ХешированиеДанных = Новый ХешированиеДанных(ХешФункция.SHA1);
			ХешированиеДанных.Добавить(ТекСтрока);
			ДанныеФайла.Вставить("ХешСумма", НРег(СтрЗаменить(ХешированиеДанных.ХешСумма, " ", "")));
			
			Проект = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ветка, "Владелец");
			ПриемникИмя = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ветка, "Приемник.Имя");
			ВеткаИмя = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ветка, "Имя");
			ДанныеПодключения = Тестирование.ДанныеПодключенияПроектаКGitСерверу(Проект);
			
			Гиперссылка = СтрШаблон("https://%1/%2/-/%5/%3/%4",
				ЗаменитьСимволыВГиперссылке(ДанныеПодключения.РедактированиеСценариевВGitАдресСервера),
				ЗаменитьСимволыВГиперссылке(ДанныеПодключения.РедактированиеСценариевВGitИмяПроекта),
				ЗаменитьСимволыВГиперссылке(ВеткаИмя),
				ТекСтрока,
				Тип);
			ДанныеФайла.Вставить("Гиперссылка", Гиперссылка);
			
			Результат.Добавить(ДанныеФайла);
		КонецЕсли;			
	КонецЦикла;	
	
	Возврат Результат;
	
КонецФункции	

// Возвращает гиперссылки для перехода в браузере
//
// Параметры:
//  Ветка - СправочникСсылка.Ветки
//  Исходник - Строка
// 
// Возвращаемое значение:
//  Массив
//
Функция ПерейтиКСравнениюСВеткойПриемникомСервер(Ветка, Исходник) Экспорт
	ДанныеОткрытогоЗапросаНаСлияние = ДанныеОткрытогоЗапросаНаСлияние(Ветка);
	Если ДанныеОткрытогоЗапросаНаСлияние = Неопределено Тогда
		ИзмененыеФайлы = ИзмененыеФайлыДляПереходаКСравнениюВеток(
			Исходник, Ветка);
	Иначе	
		ИзмененыеФайлы = ИзмененыеФайлыДляПереходаКСравнениюВетокЧерезЗапросНаСлияние(
			Исходник, Ветка);
	КонецЕсли;
	
	Возврат ИзмененыеФайлы;
		
КонецФункции	

// Возвращает гиперссылки для перехода в браузере
//
// Параметры:
//  Ветка - СправочникСсылка.Ветки
//  ОбъектМетаданных - СправочникСсылка.ОбъектыМетаданных
//  ПодчиненныйОбъект - Строка
// 
// Возвращаемое значение:
//  Строка
//
Функция ГиперссылкаИзмененияСПредыдущегоСогласованияПоВсемОбъектам(Ветка, ОбъектМетаданных, ПодчиненныйОбъект) Экспорт
	Проект = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ветка, "Владелец");
	ДанныеПодключения = Тестирование.ДанныеПодключенияПроектаКGitСерверу(Проект);
	ВеткаИмя = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ветка, "Имя");
	
	ДанныеПредыдущегоСогласования = ДанныеПредыдущегоСогласования(Ветка, ОбъектМетаданных, ПодчиненныйОбъект);
	Если НЕ ЗначениеЗаполнено(ДанныеПредыдущегоСогласования.КоммитСогласования) Тогда
		Возврат Неопределено;
	КонецЕсли;	
	
	Гиперссылка = СтрШаблон("https://%1/%2/-/compare/%3...%4",
		ЗаменитьСимволыВГиперссылке(ДанныеПодключения.РедактированиеСценариевВGitАдресСервера),
		ЗаменитьСимволыВГиперссылке(ДанныеПодключения.РедактированиеСценариевВGitИмяПроекта),
		ЗаменитьСимволыВГиперссылке(ДанныеПредыдущегоСогласования.КоммитСогласования),
		ЗаменитьСимволыВГиперссылке(ВеткаИмя));
	
	Возврат Гиперссылка;	
КонецФункции	

// Возвращает гиперссылки для перехода в браузере
//
// Параметры:
//  Ветка - СправочникСсылка.Ветки
//  ОбъектМетаданных - СправочникСсылка.ОбъектыМетаданных
//  ПодчиненныйОбъект - Строка
// 
// Возвращаемое значение:
//  Строка
//
Функция ИзмененыеФайлыДляПереходаКСравнениюВеткиПриемникаСПредыдущимКоммитомСогласования(Исходник, Ветка, ОбъектМетаданных, ПодчиненныйОбъект) Экспорт
	ДанныеПредыдущегоСогласования = ДанныеПредыдущегоСогласования(Ветка, ОбъектМетаданных, ПодчиненныйОбъект);
	Если НЕ ЗначениеЗаполнено(ДанныеПредыдущегоСогласования.КоммитСогласования) Тогда
		Возврат Неопределено;
	КонецЕсли;	
	
	Результат = Новый Массив;
	
	МассивСтрок = СтрРазделить(Исходник, Символы.ПС);
	Для Каждого ТекСтрока Из МассивСтрок Цикл
		Если Лев(ТекСтрока, 3) = "---" Тогда
			ТекСтрока = СокрЛП(Сред(ТекСтрока, 4));
			Если Лев(ТекСтрока, 2) = "a/" Тогда
				ТекСтрока = Сред(ТекСтрока, 3);
			КонецЕсли;
			ДанныеФайла = Новый Структура;
			ДанныеФайла.Вставить("ИмяФайла", ТекСтрока);
			ХешированиеДанных = Новый ХешированиеДанных(ХешФункция.SHA1);
			ХешированиеДанных.Добавить(ТекСтрока);
			ДанныеФайла.Вставить("ХешСумма", НРег(СтрЗаменить(ХешированиеДанных.ХешСумма, " ", "")));
			
			Проект = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ветка, "Владелец");
			ПриемникИмя = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ветка, "Приемник.Имя");
			ВеткаИмя = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ветка, "Имя");
			ДанныеПодключения = Тестирование.ДанныеПодключенияПроектаКGitСерверу(Проект);
			
			Гиперссылка = СтрШаблон("https://%1/%2/-/compare/%3...%4#%5",
				ЗаменитьСимволыВГиперссылке(ДанныеПодключения.РедактированиеСценариевВGitАдресСервера),
				ЗаменитьСимволыВГиперссылке(ДанныеПодключения.РедактированиеСценариевВGitИмяПроекта),
				ЗаменитьСимволыВГиперссылке(ПриемникИмя),
				ЗаменитьСимволыВГиперссылке(ДанныеПредыдущегоСогласования.КоммитСогласования),
				ДанныеФайла.ХешСумма);
				
			ДанныеФайла.Вставить("Гиперссылка", Гиперссылка);
			
			Результат.Добавить(ДанныеФайла);
		КонецЕсли;			
	КонецЦикла;	
	
	Возврат Результат;
КонецФункции	

// Возвращает гиперссылки для перехода в браузере
//
// Параметры:
//  Ветка - СправочникСсылка.Ветки
//  ОбъектМетаданных - СправочникСсылка.ОбъектыМетаданных
//  ПодчиненныйОбъект - Строка
// 
// Возвращаемое значение:
//  Массив
//
Функция ИзмененыеФайлыДляПереходаКИзменениямСПоследнегоСогласования(Исходник, Ветка, ОбъектМетаданных, ПодчиненныйОбъект) Экспорт
	ДанныеПредыдущегоСогласования = ДанныеПредыдущегоСогласования(Ветка, ОбъектМетаданных, ПодчиненныйОбъект);
	Если НЕ ЗначениеЗаполнено(ДанныеПредыдущегоСогласования.КоммитСогласования) Тогда
		Возврат Неопределено;
	КонецЕсли;	
	
	Результат = Новый Массив;
	
	МассивСтрок = СтрРазделить(Исходник, Символы.ПС);
	Для Каждого ТекСтрока Из МассивСтрок Цикл
		Если Лев(ТекСтрока, 3) = "---" Тогда
			ТекСтрока = СокрЛП(Сред(ТекСтрока, 4));
			Если Лев(ТекСтрока, 2) = "a/" Тогда
				ТекСтрока = Сред(ТекСтрока, 3);
			КонецЕсли;
			ДанныеФайла = Новый Структура;
			ДанныеФайла.Вставить("ИмяФайла", ТекСтрока);
			ХешированиеДанных = Новый ХешированиеДанных(ХешФункция.SHA1);
			ХешированиеДанных.Добавить(ТекСтрока);
			ДанныеФайла.Вставить("ХешСумма", НРег(СтрЗаменить(ХешированиеДанных.ХешСумма, " ", "")));
			ДанныеФайла.Вставить("КоммитСогласования", ДанныеПредыдущегоСогласования.КоммитСогласования);
			
			Проект = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ветка, "Владелец");
			ПриемникИмя = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ветка, "Приемник.Имя");
			ВеткаИмя = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ветка, "Имя");
			ДанныеПодключения = Тестирование.ДанныеПодключенияПроектаКGitСерверу(Проект);
			
			Гиперссылка = СтрШаблон("https://%1/%2/-/compare/%3...%4#%5",
				ЗаменитьСимволыВГиперссылке(ДанныеПодключения.РедактированиеСценариевВGitАдресСервера),
				ЗаменитьСимволыВГиперссылке(ДанныеПодключения.РедактированиеСценариевВGitИмяПроекта),
				ЗаменитьСимволыВГиперссылке(ДанныеПредыдущегоСогласования.КоммитСогласования),
				ЗаменитьСимволыВГиперссылке(ВеткаИмя),
				ДанныеФайла.ХешСумма);
				
			ДанныеФайла.Вставить("Гиперссылка", Гиперссылка);
			
			Результат.Добавить(ДанныеФайла);
		КонецЕсли;			
	КонецЦикла;	
	
	Возврат Результат;
КонецФункции	

// Возвращает гиперссылку для перехода в браузере
//
// Параметры:
//  ВеткаИмя - Строка - имя ветки
//  Проект - СправочникСсылка.Проекты
// 
// Возвращаемое значение:
//  Строка
//
Функция ПерейтиКВетке(ВеткаИмя, Проект) Экспорт
	ДанныеПодключения = Тестирование.ДанныеПодключенияПроектаКGitСерверу(Проект);
	
	Гиперссылка = СтрШаблон("https://%1/%2/-/tree/%3",
		ЗаменитьСимволыВГиперссылке(ДанныеПодключения.РедактированиеСценариевВGitАдресСервера),
		ЗаменитьСимволыВГиперссылке(ДанныеПодключения.РедактированиеСценариевВGitИмяПроекта),
		ЗаменитьСимволыВГиперссылке(ВеткаИмя));
		
	Гиперссылка = СтрЗаменить(Гиперссылка, "%2F", "/");
		
	Возврат Гиперссылка;
		
КонецФункции	

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ЗаменитьСимволыВГиперссылке(Знач Стр)
	Возврат СтрЗаменить(Тестирование.ЭкранироватьСпецсимволыWeb(Стр), "%2F", "/");
КонецФункции

Функция ИзмененыеФайлыДляПереходаКСравнениюВеток(Исходник, Ветка)
	Результат = Новый Массив;
	
	МассивСтрок = СтрРазделить(Исходник, Символы.ПС);
	Для Каждого ТекСтрока Из МассивСтрок Цикл
		Если Лев(ТекСтрока, 3) = "---" Тогда
			ТекСтрока = СокрЛП(Сред(ТекСтрока, 4));
			Если Лев(ТекСтрока, 2) = "a/" Тогда
				ТекСтрока = Сред(ТекСтрока, 3);
			КонецЕсли;
			ДанныеФайла = Новый Структура;
			ДанныеФайла.Вставить("ИмяФайла", ТекСтрока);
			ХешированиеДанных = Новый ХешированиеДанных(ХешФункция.SHA1);
			ХешированиеДанных.Добавить(ТекСтрока);
			ДанныеФайла.Вставить("ХешСумма", НРег(СтрЗаменить(ХешированиеДанных.ХешСумма, " ", "")));
			
			Проект = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ветка, "Владелец");
			ПриемникИмя = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ветка, "Приемник.Имя");
			ВеткаИмя = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ветка, "Имя");
			ДанныеПодключения = Тестирование.ДанныеПодключенияПроектаКGitСерверу(Проект);
			
			Гиперссылка = СтрШаблон("https://%1/%2/-/compare/%3...%4#%5",
				ЗаменитьСимволыВГиперссылке(ДанныеПодключения.РедактированиеСценариевВGitАдресСервера),
				ЗаменитьСимволыВГиперссылке(ДанныеПодключения.РедактированиеСценариевВGitИмяПроекта),
				ЗаменитьСимволыВГиперссылке(ПриемникИмя),
				ЗаменитьСимволыВГиперссылке(ВеткаИмя),
				ДанныеФайла.ХешСумма);
				
			ДанныеФайла.Вставить("Гиперссылка", Гиперссылка);
			
			Результат.Добавить(ДанныеФайла);
		КонецЕсли;			
	КонецЦикла;	
	
	Возврат Результат;
	
КонецФункции

Функция ИзмененыеФайлыДляПереходаКСравнениюВетокЧерезЗапросНаСлияние(Исходник, Ветка)
	
	ДанныеОткрытогоЗапросаНаСлияние = ДанныеОткрытогоЗапросаНаСлияние(Ветка);
	
	Результат = Новый Массив;
	
	МассивСтрок = СтрРазделить(Исходник, Символы.ПС);
	Для Каждого ТекСтрока Из МассивСтрок Цикл
		Если Лев(ТекСтрока, 3) = "---" Тогда
			ТекСтрока = СокрЛП(Сред(ТекСтрока, 4));
			Если Лев(ТекСтрока, 2) = "a/" Тогда
				ТекСтрока = Сред(ТекСтрока, 3);
			КонецЕсли;
			ДанныеФайла = Новый Структура;
			ДанныеФайла.Вставить("ИмяФайла", ТекСтрока);
			ХешированиеДанных = Новый ХешированиеДанных(ХешФункция.SHA1);
			ХешированиеДанных.Добавить(ТекСтрока);
			ДанныеФайла.Вставить("ХешСумма", НРег(СтрЗаменить(ХешированиеДанных.ХешСумма, " ", "")));
			
			Проект = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ветка, "Владелец");
			ПриемникИмя = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ветка, "Приемник.Имя");
			ВеткаИмя = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ветка, "Имя");
			ДанныеПодключения = Тестирование.ДанныеПодключенияПроектаКGitСерверу(Проект);
			
			Гиперссылка = СтрШаблон("https://%1/%2/-/merge_requests/%3/diffs#diff-content-%4",
				ЗаменитьСимволыВГиперссылке(ДанныеПодключения.РедактированиеСценариевВGitАдресСервера),
				ЗаменитьСимволыВГиперссылке(ДанныеПодключения.РедактированиеСценариевВGitИмяПроекта),
				ЗаменитьСимволыВГиперссылке(XMLСтрока(ДанныеОткрытогоЗапросаНаСлияние.iid)),
				ДанныеФайла.ХешСумма);
				
			ДанныеФайла.Вставить("Гиперссылка", Гиперссылка);
			
			Результат.Добавить(ДанныеФайла);
		КонецЕсли;			
	КонецЦикла;	
	
	Возврат Результат;
	
КонецФункции

Функция ДанныеОткрытогоЗапросаНаСлияние(Ветка)
	Данные = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Ветка,"Владелец,Имя,Приемник.Имя");
	Возврат ТестированиеЗапускТестирования.ДанныеОткрытогоЗапросаНаСлияниеПоВетке(Данные.Владелец, Данные.Имя, Данные.ПриемникИмя);
КонецФункции	

Функция ДанныеПредыдущегоСогласования(Ветка, ОбъектМетаданных, ПодчиненныйОбъект)
	
	Результат = Новый Структура;
	Результат.Вставить("КоммитСогласования", Неопределено);
	Результат.Вставить("ПредыдущийСтатусСогласования", Неопределено);
	Результат.Вставить("ПредыдущееПодробноеОписаниеИзменений", Неопределено);
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ИзмененияВВетках.КоммитСогласования КАК КоммитСогласования,
		|	ИзмененияВВетках.ПредыдущийСтатусСогласования КАК ПредыдущийСтатусСогласования,
		|	ИзмененияВВетках.ПредыдущееПодробноеОписаниеИзменений КАК ПредыдущееПодробноеОписаниеИзменений
		|ИЗ
		|	РегистрСведений.ИзмененияВВетках КАК ИзмененияВВетках
		|ГДЕ
		|	ИзмененияВВетках.Ветка = &Ветка
		|	И ИзмененияВВетках.ОбъектМетаданных = &ОбъектМетаданных
		|	И ИзмененияВВетках.ПодчиненныйОбъект = &ПодчиненныйОбъект";
	
	Запрос.УстановитьПараметр("Ветка", Ветка);
	Запрос.УстановитьПараметр("ОбъектМетаданных", ОбъектМетаданных);
	Запрос.УстановитьПараметр("ПодчиненныйОбъект", ПодчиненныйОбъект);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		ЗаполнитьЗначенияСвойств(Результат, ВыборкаДетальныеЗаписи);
	КонецЦикла;
	
	Возврат Результат;

КонецФункции	

#КонецОбласти