# iperf<BR>
Тестирование ширины канала сетевых соединений между серверами группы серверов. Позволяет определить соответствие пропускной способности сетевых интерфейсов. Рекомендуется перед развёртыванием кластеров.

## Тест на сетевых интерфейсах 10G lan.<BR>
Пример нормального канала (9.42 Gbits/sec) и пример канала со сбоями (111 Mbits/sec).

<pre><code>[user1@pg-1 ~]$ iperf3 -c 192.168.235.52 -i 1 -t 20 -P 4
Connecting to host 192.168.235.52, port 5201
[  4] local 192.168.235.55 port 47160 connected to 192.168.235.52 port 5201
[  6] local 192.168.235.55 port 47162 connected to 192.168.235.52 port 5201
[  8] local 192.168.235.55 port 47164 connected to 192.168.235.52 port 5201
[ 10] local 192.168.235.55 port 47166 connected to 192.168.235.52 port 5201
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bandwidth       Retr
[  4]   0.00-20.00  sec  3.66 GBytes  1.57 Gbits/sec    0             sender
[  4]   0.00-20.00  sec  3.65 GBytes  1.57 Gbits/sec                  receiver
[  6]   0.00-20.00  sec  3.66 GBytes  1.57 Gbits/sec    0             sender
[  6]   0.00-20.00  sec  3.65 GBytes  1.57 Gbits/sec                  receiver
[  8]   0.00-20.00  sec  3.66 GBytes  1.57 Gbits/sec    0             sender
[  8]   0.00-20.00  sec  3.65 GBytes  1.57 Gbits/sec                  receiver
[ 10]   0.00-20.00  sec  11.0 GBytes  4.71 Gbits/sec    0             sender
[ 10]   0.00-20.00  sec  11.0 GBytes  4.71 Gbits/sec                  receiver
[SUM]   0.00-20.00  sec  21.9 GBytes  9.42 Gbits/sec    0             sender
[SUM]   0.00-20.00  sec  21.9 GBytes  9.42 Gbits/sec                  receiver
iperf Done.


[user1@pg-2 ~]$ iperf3 -c 192.168.235.52 -i 1 -t 20 -P 4
Connecting to host 192.168.235.52, port 5201
[  4] local 192.168.235.56 port 33842 connected to 192.168.235.52 port 5201
[  6] local 192.168.235.56 port 33844 connected to 192.168.235.52 port 5201
[  8] local 192.168.235.56 port 33846 connected to 192.168.235.52 port 5201
[ 10] local 192.168.235.56 port 33848 connected to 192.168.235.52 port 5201
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bandwidth       Retr
[  4]   0.00-20.00  sec  79.4 MBytes  33.3 Mbits/sec  2085             sender
[  4]   0.00-20.00  sec  79.2 MBytes  33.2 Mbits/sec                  receiver
[  6]   0.00-20.00  sec  64.4 MBytes  27.0 Mbits/sec  1388             sender
[  6]   0.00-20.00  sec  63.9 MBytes  26.8 Mbits/sec                  receiver
[  8]   0.00-20.00  sec  59.1 MBytes  24.8 Mbits/sec  1448             sender
[  8]   0.00-20.00  sec  58.8 MBytes  24.7 Mbits/sec                  receiver
[ 10]   0.00-20.00  sec  62.6 MBytes  26.2 Mbits/sec  1331             sender
[ 10]   0.00-20.00  sec  62.4 MBytes  26.2 Mbits/sec                  receiver
[SUM]   0.00-20.00  sec   266 MBytes   111 Mbits/sec  6252             sender
[SUM]   0.00-20.00  sec   264 MBytes   111 Mbits/sec                  receiver
iperf Done.
</code></pre>

## Немного подсчётов.

При наличии 2-х - 3-х серверов можно протестировать вручную.<BR>
При большем количестве вспоминаем формулу числа размещений (т.к. прядок важен):

https://www.matburo.ru/tvart_sub.php?p=calc_A
![alt text](cnk1.png)

# P.S.<BR>
https://vuzlit.com/2250166/postanovka_zadachi<BR>
Недостатки протокола TCP

https://ru.wikipedia.org/wiki/Медленный_старт<BR>
Медленный старт — часть стратегии управления окном перегрузки (англ. congestion window), в TCP. Медленный старт используется совместно с другими алгоритмами для того чтобы избежать отправки большего количества данных, чем сеть способна передать. Алгоритм определяется RFC 5681.

https://habr.com/ru/company/webo/blog/327050/<BR>
Медленный старт мало влияет на скачивание крупных файлов или потокового видео...

https://habr.com/post/147747/<BR>
Повышаем скорость и качество работы сети, страдающей потерей пакетов.

