﻿#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	Если ЗначениеЗаполнено(ПараметрКоманды) Тогда
		
		ПараметрыФормы = Новый Структура("Ссылка", ПараметрКоманды);
		ОткрытьФорму("ОбщаяФорма.ИнформацияДляХранилища",
		             ПараметрыФормы,
					 ПараметрыВыполненияКоманды.Источник,
					 ПараметрКоманды,
					 ,
					 ,
					 ,
					 Неопределено);

	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти