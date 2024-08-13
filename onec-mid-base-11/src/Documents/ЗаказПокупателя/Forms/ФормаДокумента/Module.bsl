
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// ++Красова Задача №2 , 30.06.2024 
	ГруппаПересчетСуммы = Элементы.Добавить("ПересчетСуммы", Тип("ГруппаФормы"), Элементы.ГруппаШапкаЛево);
	ГруппаПересчетСуммы.Вид = ВидГруппыФормы.ОбычнаяГруппа;
	ГруппаПересчетСуммы.Заголовок = "Пересчет суммы"; 
	ГруппаПересчетСуммы.ОтображатьЗаголовок = Ложь;
	ГруппаПересчетСуммы.Отображение = ОтображениеОбычнойГруппы.Нет; 
	
	ЭлементСогласованнаяСкидка = Элементы.Добавить("Д_СогласованнаяСкидка", Тип("ПолеФормы"), ГруппаПересчетСуммы);
	ЭлементСогласованнаяСкидка.Вид = ВидПоляФормы.ПолеВвода;
	ЭлементСогласованнаяСкидка.ПутьКДанным = "Объект.Д_СогласованнаяСкидка";
	ЭлементСогласованнаяСкидка.УстановитьДействие("ПриИзменении", "ПриИзмененииСогласованнаяСкидка"); 
	
	КомандаПересчитатьТаблицу = Команды.Добавить("ПересчитатьТаблицу");
	КомандаПересчитатьТаблицу.Заголовок = "Пересчитать таблицу";
	КомандаПересчитатьТаблицу.Действие = "ПересчитатьТаблицу"; 
	
	КнопкаПересчитатьТаблицу = Элементы.Добавить("ПересчитатьТаблицу", Тип("КнопкаФормы"), ГруппаПересчетСуммы);
	КнопкаПересчитатьТаблицу.Вид = ВидКнопкиФормы.ОбычнаяКнопка;
	КнопкаПересчитатьТаблицу.ИмяКоманды = "ПересчитатьТаблицу";
	КнопкаПересчитатьТаблицу.Картинка = БиблиотекаКартинок.Перечитать;
	КнопкаПересчитатьТаблицу.Отображение = ОтображениеКнопки.КартинкаИТекст;
	// --
	
КонецПроцедуры

&НаКлиенте
Асинх Процедура ПриИзмененииСогласованнаяСкидка()	
	// ++Красова Задача №1 , 30.06.2024 

	ТекстВопроса = "Изменен процент скидки. Пересчитать таблицы товаров и услуг?"; 
	ВариантыОтвета = Новый СписокЗначений;
	ВариантыОтвета.Добавить(1, "Да");
	ВариантыОтвета.Добавить(2, "Нет");
	
	Если ЗначениеЗаполнено(Объект.Товары) Или ЗначениеЗаполнено(Объект.Услуги) Тогда 
		
		ОтветПользователя = Ждать ВопросАсинх(ТекстВопроса,ВариантыОтвета); 
		
		Если ОтветПользователя = 1 Тогда
			
			ПересчитатьТаблицуЗаказа(); 	
			
		ИначеЕсли ОтветПользователя = 2 Тогда 		
			
			Возврат;
			
		КонецЕсли;
		
	КонецЕсли
	// --  
КонецПроцедуры

&НаКлиенте
Процедура ПересчитатьТаблицу(Команда)
	 // ++Красова Задача №1 , 30.06.2024 

	 ПересчитатьТаблицуЗаказа();
	 // --  
КонецПроцедуры

&НаКлиенте
Процедура ПересчитатьТаблицуЗаказа()
  // ++Красова Задача №1 , 30.06.2024 

  Для Каждого Строка Из Объект.Товары Цикл 
	  
	  РассчитатьСуммуСтроки(Строка);

	КонецЦикла; 
	Для Каждого Строка Из Объект.Услуги Цикл 
		
		РассчитатьСуммуСтроки(Строка);
		
	КонецЦикла
  // --  
КонецПроцедуры 

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
    ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТовары

&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыПриИзменении(Элемент)
	РассчитатьСуммуДокумента();
КонецПроцедуры

&НаКлиенте
Процедура ТоварыСкидкаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыУслуги

&НаКлиенте
Процедура УслугиКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиСкидкаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиПриИзменении(Элемент)
	РассчитатьСуммуДокумента();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура РассчитатьСуммуСтроки(ТекущиеДанные)
	
	// ++Красова Задача №1,3 , 30.06.2024
	
	ИтоговаяСкидка = ТекущиеДанные.Скидка + Объект.Д_СогласованнаяСкидка;
	
	Если ИтоговаяСкидка > 100 Тогда
		Стр = СтрШаблон("Превышено максимальное значение суммы скидок(%1%%) в номенклатуре: ""%2""", 100, ТекущиеДанные.Номенклатура); 
		Сообщить(Стр);
	КонецЕсли; 
	
	Если ИтоговаяСкидка > 100 Тогда
		ИтоговаяСкидка = 100
	КонецЕсли;
	
	ТекущиеДанные.Сумма = ТекущиеДанные.Количество * (ТекущиеДанные.Цена - ТекущиеДанные.Цена * ИтоговаяСкидка / 100); 
	// --
	
КонецПроцедуры

&НаКлиенте
Процедура РассчитатьСуммуДокумента()
	
	Объект.СуммаДокумента = Объект.Товары.Итог("Сумма") + Объект.Услуги.Итог("Сумма");
	
КонецПроцедуры

#Область ПодключаемыеКоманды

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
    ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
    ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
    ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#КонецОбласти
