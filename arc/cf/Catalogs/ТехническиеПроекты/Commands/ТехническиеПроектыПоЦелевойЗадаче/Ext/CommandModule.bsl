﻿
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	СтруктураОтбора = Новый Структура("ЦелеваяЗадача", ПараметрКоманды);
	
	ПараметрыФормы = Новый Структура("Отбор", СтруктураОтбора);
	ОткрытьФорму("Справочник.ТехническиеПроекты.Форма.СписокТехническихПроектов",
					ПараметрыФормы,
					ПараметрыВыполненияКоманды.Источник,
					ПараметрыВыполненияКоманды.Уникальность,
					ПараметрыВыполненияКоманды.Окно,
					ПараметрыВыполненияКоманды.НавигационнаяСсылка);
					
КонецПроцедуры
