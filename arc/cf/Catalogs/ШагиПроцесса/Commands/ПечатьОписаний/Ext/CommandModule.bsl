﻿
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ТекстВопроса = НСтр("ru='Будут распечатаны описания выбранных объектов'");
	
	Структура = Новый Структура("ПараметрКоманды", ПараметрКоманды);
	ОписаниеОповещения = Новый ОписаниеОповещения("ОбработкаКомандыЗавершение", ЭтотОбъект, Структура);
	ПоказатьВопрос(ОписаниеОповещения, ТекстВопроса, РежимДиалогаВопрос.ОКОтмена, , КодВозвратаДиалога.ОК);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаКомандыЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт
    
    ПараметрКоманды = ДополнительныеПараметры.ПараметрКоманды;
    
    Ответ = РезультатВопроса;
    
    Если Ответ <> КодВозвратаДиалога.ОК Тогда
        Возврат;
    КонецЕсли;
    
    ПечатныеФормы = ОписаниеОбъектов.СформироватьПечатныеФормы("Справочник.ШагиПроцесса", ПараметрКоманды);
    ОбщегоНазначенияСППРКлиент.НапечататьОписанияСхемы(ПечатныеФормы);
    
КонецПроцедуры