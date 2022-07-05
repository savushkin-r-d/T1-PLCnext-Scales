# Проект автоматизации процесса взвешивания #

| Тегов | Строк кода | Аппаратов | Агрегатов | Устройств | Узлов | Модулей | IO-Link I/O |
|---|---|---|---|---|---|---|---|
|![](statistics/tags_total.svg) |![](statistics/lines_total.svg) |![](statistics/units_total.svg) |![](statistics/agregates_total.svg) |![](statistics/devices_total.svg) |![](statistics/io_couplers_total.svg) |![](statistics/io_modules_total.svg) |![](statistics/io_link_usage.svg)


## Настройки Bus Coupler для работы с последовательным интерфейсом RS-232

## Содержание
1. [Описание стенда](#описание-стенда)
2. [Установка IP-адреса Bus Coupler](#установка-ip-адреса-bus-coupler)
3. [Подключение к Bus Coupler через StartUp+ и подключение модуля последовательных интерфейсов](#подключение-к-bus-coupler-через-startup-и-подключение-модуля-последовательных-интерфейсов)
4. [Подключение внешнего устройства по интерфейсу RS-232](#подключение-внешнего-устройства-по-интерфейсу-rs-232)
5. [Настройка параметров подключения RS-232](#настройка-параметров-подключения-rs-232)
6. [Чтение данных из внешнего устройства через RS-232](#чтение-данных-из-внешнего-устройства-через-rs-232)
7. [Получение данных из модуля последовательных интерфейсов через ModBus](#получение-данных-из-модуля-последовательных-интерфейсов-через-modbus)

### Описание стенда
___

<p align="center">
<img align="center" src="Images/General_view.jpg">
</p>
<p align="center"> Рисунок 1 - Общий вид стенда </p>

На рисунке 1 показан общий вид стенда, который включает в себя весы (сверху), модуль последовательных интерфейсов *RS UNI XC 1H* (справа), Bus Coupler *AXL F BK ETH NET2* (посередине) и контроллера *AXC F 2152* (слева). 
Блок управления весов соединен с измерительной платформой (черный слева). Черный провод справа осуществляет связь весов и модуля последовательных интерфейсов по интерфейсу RS-232. Модуль последовательных интерфейсов по общей шине соединен с каплером, который в свою очередь соединен с контроллеров кабелем Ethernet. Такой способ подключения позволяет организовать разветвленную систему.

### Установка IP-адреса Bus Coupler 
___
Рассмотрим установку IP-адреса Bus Coupler на примере устройства __AXL F BK ETH NET2__.
Установить IP-адрес устройства возможно следующим образом:
* Требуемый адрес устанавливается поворотными переключателями на корпусе устройства.
* Требуемый адрес устанавливается через специализированное ПО.

На корпусе устройства имеются поворотные переключатели S1 и S2, задающие режим работы.

<p align="center">
<img align="center" src="Images/Bus%20Coupler.jpg">
</p>
<p align="center"> Рисунок 2 - Внешний вид Bus Coupler </p>

Код, соответствующий режиму работы, является суммой S1*10+S2. 

S1    | S2   | Код     | Функция
:---: |:----:|:-------:| :---:
0     | 0    | 00      | Удаленный доступ
0...5 | 1...0| 01...50 |Ручная установка адреса
5...15| 0...9| 51...159| Установка DHCP имени
0     | A    | 0A      | Статический адрес
0     | E    | 0E      | Сброс параметров IP
1     | A    | 1A      | Включить режим PnP
1     | B    | 1B      | Выключить режим PnP
12    | C    | 12C     | Сброс до заводских настроек

Перед установкой новых параметров следует сбросить параметры IP-адреса, выставив переключатели в положения S1 - 0; S2 - E, и перезагрузить устройство. Затем устанавливается необходимый режим, и снова перезагружается устройство. 

Для ручной установки IP-адреса следует:
* Сбросить параметры IP (код на переключателях 0Е). Перезагрузить устройство.
* Установить режим статического IP-адреса (код на переключателях 0А). Перезагрузить устройство.
* Установить требуемый адрес поворотными переключателями. Перезагрузить устройство.

После перезагрузки, устройство использует установленный IP-адрес.
Для автоматической установки IP-адреса следует:
* Сбросить параметры IP (код на переключателях 0Е). Перезагрузить устройство.
* Установить режим удаленного доступа (код на переключателях 00). 
В режиме удаленного доступа, Bus Coupler посылает продолжительные BootP запросы пока не получит действительный IP-адрес. 
* На ПК запустить программу [IPAssign](https://www.phoenixcontact.com/en-us/products/wireless-module-fl-wlan-1101-2702538) (Раздел Downloads - Software). Нажать далее.

<p align="center">
<img align="center" src="Images/IPA_common.jpg">
</p>
<p align="center"> Рисунок 3 - Интерфейс программы IPAssign </p>

* Дождаться появления устройства, выбрать его и нажать далее.

<p align="center">
<img align="center" src="Images/Bus%20Coupler.jpg">
</p>
<p align="center"> Рисунок 4 - Новое устройство обнаружено </p>

* Установить требуемый IP-адрес и нажать далее.

<p align="center">
<img align="center" src="Images/IPA_setIP.jpg">
</p>
<p align="center"> Рисунок 5 - Установка IP-адреса </p>

* Дождаться успешной установки адреса и нажать готово. Перезагрузить устройство.

<p align="center">
<img align="center" src="Images/IPA_done.jpg">
</p>
<p align="center"> Рисунок 6 - Успешная установка IP-адреса </p>

После установки IP-адреса, Bus Coupler работает по адресам xxx.xxx.0.xxx для разъема Ethernet X1 и xxx.xxx.1.xxx для X2.
### Подключение к Bus Coupler через StartUp+ и подключение модуля последовательных интерфейсов
___
Конфигурирование Bus Coupler происходит через программу [StartUp+](https://www.phoenixcontact.com/en-us/products/device-parameterization-startup-2700636) (Раздел Downloads - Software). 
После подключения Bus Coupler к ПК по Ethernet следует убедиться, что ПК находится в нужной подсети. Для этого следует открыть настройки сетей в панели управления пк и в настройках параметров адаптера выбрать неопознанную сеть.

<p align="center">
<img align="center" src="Images/PC_netsetting.jpg">
</p>
<p align="center"> Рисунок 7 - Cетевые подключения </p>

Далее в свойствах сети выбрать пункт *IP версия 4*. Установить параметры, соответствующие Bus Coupler. Обратите внимание на номер подсети: для разъема X1 - xxx.xxx.0.xxx и xxx.xxx.1.xxx для Х2.

<p align="center">
<img align="center" src="Images/PC_netsetting2.jpg">
</p>
<p align="center"> Рисунок 8 - Параметры сетевого подключения для Bus Coupler </p>

- Запускаем программу StartUp+. Нас встречает окно создания нового проекта.

<p align="center">
<img align="center" src="Images/SUP_newpr.jpg">
</p>
<p align="center"> Рисунок 9 - Стартовое окно StartUp+ </p>

- Выбираем пункт *Cоздать новый проект*.
- Далее вы списке выбираем *AXL F BK ETH NET2*.
- В списке выбора способа подключения выбираем *Ethernet TSP/IP*.
- Далее выбираем ручной ввод IP-адреса и указываем IP устройства.

<p align="center">
<img align="center" src="Images/SUP_setip.jpg">
</p>
<p align="center"> Рисунок 10 - Окно установки адреса Bus Coupler </p>

- После всех действий появится окно Topology Scan Wizard для выбора подключенных к Bus Coupler. 

<p align="center">
<img align="center" src="Images/SUP_tp0.jpg">
</p>
<p align="center"> Рисунок 11 - Окно Topology Scan Wizard </p>

- Нажимаем *Продолжить*
- После завершения сканирования в списке появится доступные устройства. Выбираем модуль последовательных интерфейсов *RS UNI XC 1H* и нажимаем продолжить.

<p align="center">
<img align="center" src="Images/SUP_tp.jpg">
</p>
<p align="center"> Рисунок 12 - Результат сканирования доступных модулей </p>

- После всех действий откроется окно окончания настроек подключения. Нажимаем кнопку *Finish*

<p align="center">
<img align="center" src="Images/SUP_fin.jpg">
</p>
<p align="center"> Рисунок 13 - Окно окончания настроек подключения </p>

При успешном подключении в дереве проекта отобразится Bus Coupler и подключенный модуль.

<p align="center">
<img align="center" src="Images/SUP_comp.jpg">
</p>
<p align="center"> Рисунок 14 - Дерево проекта в StartUp+ </p>

### Подключение внешнего устройства по интерфейсу RS-232
___
В качестве внешнего устройства выступают электронные весы ProMAS PM1H-100 4050. Они используют двухпроводное подключение.

<p align="center">
<img align="center" src="Images/RS_sch.jpg">
</p>
<p align="center"> Рисунок 15 - Схема двухпроводного подключения к модулю последовательных интерфейсов </p>

Перемычка включается между контактами DTR(22) и CTS(13).

<p align="center">
<img align="center" src="Images/RS_sch1.jpg">
</p>
<p align="center"> Рисунок 16 - Подключение весов к модулю последовательных интерфейсов </p>

### Настройка параметров подключения RS-232
___
Возвращаемся в программу StartUp+. Выбираем модуль последовательных интерфейсов в дереве проекта и нажимаем на кнопку *Offline parameters* в верхней панели. Открывается окно настроек параметров последовательных интерфейсов. 

<p align="center">
<img align="center" src="Images/SUP_RSUNISET.jpg">
</p>
<p align="center"> Рисунок 17 - Окно настроек параметров последовательных интерфейсов </p>

Выбираем интерфейс RS-232 и протокол XON/XOFF. Было установлено, что весы отправляют вес ввиду набора символов вида *+xxx.xxkg*, где ххх.хх - вес в килограммах. В итоге параметры для связи с весами имеют вид, показанный на рисунке.

После каждого изменения параметров следует произвести процедуру инициализации, иначе считать данные из модуля может быть невозможно. Об этом свидетельствует мигающий зеленым индикатор D на корпусе модуля и Bus Coupler.
Для инициализации модуля переходим на веб-страницу Bus Coupler указав в поисковой строке браузера IP-адрес каплера. Если браузер сообщит об небезопасном соединении, проигнорируйте это. 
В результате откроется веб-страница каплера. 
Переходим в пункт *Configuration - Startup Behaviour*. 

<p align="center">
<img align="center" src="Images/WEB_PNP.jpg">
</p>
<p align="center"> Рисунок 18 - Веб-страница Startup Behaviour </p>

Устанавливаем галочку  *Run in plug and play mode after next restart*, указываем пароль (по умолчанию: private) и нажимаем *Apply and Restart*. После перезагрузки повторить те же действия убрав галочку *Run in plug and play mode after next restart*
### Чтение данных из внешнего устройства через RS-232
___
Кликом правой кнопкой мыши по модулю последовательных интерфейсов открывается список дополнительных параметров модуля. Выбираем **Functions-IO Check**. Открывается окно ввода/вывода модуля, где можно принимать или отправлять данных по интерфейсу.

<p align="center">
<img align="center" src="Images/SUP_IOC.jpg">
</p>
<p align="center"> Рисунок 19 - Выбор окна ввода/вывода модуля последовательных интерфейсов </p>

Буфер приёма-передачи модуля последовательных интерфейсов имеет ёмкость 4 кбайт. Принятые данные сохраняются в буфере в виде очереди и могут быть прочитаны. Для этого в окне ввода/вывода нажимаем кнопку *read*, на верхней панели отобразятся считанные данные. 

<p align="center">
<img align="center" src="Images/SUP_RSRD.jpg">
</p>
<p align="center"> Рисунок 20 - Результат считывания данных из буфера </p>

Если буфер заполнится, модуль начнет сигнализировать об ошибке индикатором E2.
### Получение данных из модуля последовательных интерфейсов через ModBus
___
Для получения данных из модуля прежде всего следует в окне настроек параметров последовательных интерфейсов установить *Data Pach* в режим *Data exchange via process data*.

В качестве программы для связи с модулем по ModBus выступает ModBus Doctor. Все подключенные к Bus Coupler модули получают свой диапазон адресов для записи и считывания. Посмотреть адреса можно в веб-странице каплера в разделе *Information - ModBus I/O Table*.

<p align="center">
<img align="center" src="Images/WEB_MB.jpg">
</p>
<p align="center"> Рисунок 21 - Перечень доступных адресов регистров в Bus Coupler </p>

В нашем случае регистры с адресами 8000-8009 служат для считывания данных, а 9000-9009 для записи команд в модуль последовательных интерфейсов.

Откроем две программы ModBus Doctor для более удобной записи и считывания. Во вкладке *Settings* следует установить адрес каплера, установить параметры подключения по ModBus и нажать кнопку *Conection*. 

<p align="center">
<img align="center" src="Images/MBD_Con.jpg">
</p>
<p align="center"> Рисунок 22 - Подключение к каплеру через ModBus в программе ModBus Doctor </p>

По умолчанию при попытке считать данные из модуля, он вернет уровень заполнения буфера и количество принятых сообщений по последовательному интерфейсу. Для того, чтобы получить сами данные (в нашем случае вес), в регистр по адресу 9000 следует записать число 12288, что соответствует 30h в нулевом байте. Список и формат команд описан в документации на модуль. После записи команды в регистр, при следующих считываниях будут получены данные в виде ASCII символов и некоторые служебные байты.

<p align="center">
<img align="center" src="Images/MBD_rd.jpg">
</p>
<p align="center"> Рисунок 23 - Результат считывания данных из модуля </p>

 В нашем случае в регистрах с 8001 по 8008 записаны символы *+000.73Kg*. Строит учитывать, что байты записаны по стандарту Intel, т.е. сначала идет младший байт, затем старший.