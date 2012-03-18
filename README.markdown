Esercizio - estrarre un report da un file di accessi di Apache
==============================================================

Si vuole scrivere un programma batch che legge in input un file di accessi di Apache e produce in output un report.

Il nostro input è un file di questo tipo: 

    192.168.20.192 - - [29/Jul/2011:14:19:48 +0200] "GET / HTTP/1.1" 200 11870
    192.168.20.192 - - [29/Jul/2011:14:19:49 +0200] "GET /tomcat.png HTTP/1.1" 304 -
    192.168.20.192 - - [29/Jul/2011:14:20:39 +0200] "POST /phoenix-0.0/phoenixServlet HTTP/1.1" 200 264
    192.168.20.192 - - [29/Jul/2011:14:21:23 +0200] "GET /phoenix-0.0/tranpipe-demo/demo.html HTTP/1.1" 304 -
    192.168.20.191 - - [29/Jul/2011:15:48:04 +0200] "POST /phoenix-0.0/phoenixServlet HTTP/1.1" 200 263
    192.168.100.184 - - [01/Aug/2011:13:20:49 +0200] "GET /manager/status?XML=true HTTP/1.1" 401 2486

Il nostro obiettivo è estrarre un report di questa forma

    data        risultati-2xx  risultati-3xx risultati-4xx risultati-5xx
    29/Jul/2011 1223           23            456           12
    30/Jul/2011 1212           24            11            123


