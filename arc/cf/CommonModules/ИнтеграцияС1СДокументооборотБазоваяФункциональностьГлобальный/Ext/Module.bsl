﻿////////////////////////////////////////////////////////////////////////////////
// Подсистема "Интеграция с 1С:Документооборотом"
// Модуль ИнтеграцияС1СДокументооборотБазоваяФункциональностьКлиент: глобальный, клиент
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

// Выполняется при истечении времени жизни токена доступа к веб-сервису 1С:Документооборот.
//
Процедура ПриИстеченииВремениЖизниТокенаДоступа() Экспорт
	
	ИнтеграцияС1СДокументооборотБазоваяФункциональностьВызовСервера.СброситьКэшПодключенияКДО();
	
КонецПроцедуры

#КонецОбласти
