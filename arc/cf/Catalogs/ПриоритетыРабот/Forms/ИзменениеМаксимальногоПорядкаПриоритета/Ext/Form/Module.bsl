﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ПравоИзменения = ПравоДоступа("Изменение", Метаданные.Константы.МаксимальныйПорядокПриоритетаРаботы);
	
	МаксимальныйПорядокПриоритетаРаботы = Константы.МаксимальныйПорядокПриоритетаРаботы.Получить();
	МаксимальныйИспользуемыйПорядок = Справочники.ПриоритетыРабот.МаксимальныйИспользуемыйПриоритет();
	
	Элементы.МаксимальныйУровеньПриоритетаРаботы.МинимальноеЗначение = МинимальныйДоступныйПорядокПриоритета(МаксимальныйИспользуемыйПорядок);
	СформироватьПояснение();
	
	Если Не ПравоИзменения Тогда
		ТолькоПросмотр = Истина;
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы


#КонецОбласти

#Область Прочее

&НаСервере
Процедура СформироватьПояснение()

	Если МаксимальныйИспользуемыйПорядок = 0 Тогда
		ТекстТекущийМаксимальныйУровень = 
			СтроковыеФункции.ФорматированнаяСтрока(
				НСтр("ru='<span style=""color: ЗаблокированныйРеквизитЦвет"">Ни один приоритет не используется.</span>'"));
		ТекстМожетеИзменить = 
			СтроковыеФункции.ФорматированнаяСтрока(
				НСтр("ru='<span style=""color: ЗаблокированныйРеквизитЦвет"">Вы можете указать любое значение, больше чем 1.</span>'"));
	Иначе
		ТекстТекущийМаксимальныйУровень = 
			СтроковыеФункции.ФорматированнаяСтрока(
				НСтр("ru='<span style=""color: ЗаблокированныйРеквизитЦвет"">Максимальный порядок уже используемых приоритетов - %1.</span>'"),
				Строка(МаксимальныйИспользуемыйПорядок));
		ТекстМожетеИзменить = 
			СтроковыеФункции.ФорматированнаяСтрока(
				НСтр("ru='<span style=""color: ЗаблокированныйРеквизитЦвет"">Вы можете указать любое значение, не менее чем %1.</span>'"),
				Строка(МинимальныйДоступныйПорядокПриоритета(МаксимальныйИспользуемыйПорядок)));
	КонецЕсли;
	
	Если ПравоИзменения Тогда
		
		ТекстПояснения = Новый ФорматированнаяСтрока(ТекстТекущийМаксимальныйУровень, ТекстМожетеИзменить);
		
	Иначе
		
		ТекстПояснения = ТекстТекущийМаксимальныйУровень;
		
	КонецЕсли;
	
	Элементы.ДекорацияТекущийМаксимальнойИспользуемыйПорядок.Заголовок = ТекстПояснения;

КонецПроцедуры

&НаКлиенте
Процедура Записать(Команда)
	
	ОчиститьСообщения();
	
	Если Модифицированность Тогда
		
		РезультатПроверкиИзменений = РезультатПроверкиИзменений();
		Если Не РезультатПроверкиИзменений.ИзмененияКорректны Тогда
			
			ОбщегоНазначенияКлиент.СообщитьПользователю(РезультатПроверкиИзменений.ТекстОшибки,,,"МаксимальныйУровеньПриоритетаРаботы");
			Возврат;
			
		Иначе
			
			Закрыть(Истина)
			
		КонецЕсли;
		
	Иначе
		
		Закрыть();
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция РезультатПроверкиИзменений()
	
	Результат = Новый Структура;
	Результат.Вставить("ИзмененияКорректны", Истина);
	Результат.Вставить("ТекстОшибки",        "");
	
	МаксимальныйИспользуемыйПорядок = Справочники.ПриоритетыРабот.МаксимальныйИспользуемыйПриоритет();
	
	Если МаксимальныйПорядокПриоритетаРаботы < МинимальныйДоступныйПорядокПриоритета(МаксимальныйИспользуемыйПорядок) Тогда
		СформироватьПояснение();
		Результат.ИзмененияКорректны = Ложь;
		Результат.ТекстОшибки = СтрШаблон(НСтр("ru = 'Изменение не выполнено, новый порядок приоритета, не может быть меньше чем %1.'"), 
		                                  МинимальныйДоступныйПорядокПриоритета(МаксимальныйИспользуемыйПорядок));
	КонецЕсли;
	
	Если Результат.ИзмененияКорректны Тогда
		Константы.МаксимальныйПорядокПриоритетаРаботы.Установить(МаксимальныйПорядокПриоритетаРаботы);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция МинимальныйДоступныйПорядокПриоритета(МаксимальныйИспользуемыйПорядок)

	Возврат Макс(Мин(МаксимальныйИспользуемыйПорядок, 2), 2);

КонецФункции


#КонецОбласти

