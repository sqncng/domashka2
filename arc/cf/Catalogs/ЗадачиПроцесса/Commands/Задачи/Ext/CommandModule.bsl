﻿
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ПараметрыФормы = Новый Структура("Предмет", ПараметрКоманды);
	ОткрытьФорму("Справочник.ЗадачиПроцесса.Форма.ФормаСпискаПараметрическая",
	             ПараметрыФормы,
	             ПараметрыВыполненияКоманды.Источник,
	             ПараметрыВыполненияКоманды.Уникальность,
	             ПараметрыВыполненияКоманды.Окно,
	             ПараметрыВыполненияКоманды.НавигационнаяСсылка);
	
КонецПроцедуры
