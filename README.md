In diesem Projekt können mehrere SPARQL-Queries miteinander verglichen werden. Dies wird automatisiert mit den Berlin SPARQL-Benchmark ausgeführt. Nach der Ausführung werden dann die verschiedenen Laufzeiten der einzelnen Queries gespeichert und es werden die berechneten Queries per Second Metriken für jede Query gespeichert. Hierdurch wird ein Vergleich von verschiedenen Queries stark erleichtert. Im Folgenden eine Step-By-Step-Anleitung für die Ausführung des Projektes gegen einen Triple-Store.
1: Einen Triple-Store starten. 
   Für die Messergebnisse in diesem Projekt wurde mit docker und stain/jena-fuseki gearbeitet. 
   1.1: Docker installieren
   1.2: docker pull stain/jena-fuseki
   1.3: Den Fuseki server starten: 
        docker run -p 3030:3030 --name fuseki -e JAVA_OPTS='-Xmx4G' -e JVM_ARGS=-Xmx4G -e         ADMIN_PASSWORD=123 stain/jena-fuseki
        Hier wird der Fuseki-Server mit dem Containernamen "fuseki" gestartet und hat eine Heap-Space Größe von 4 GB.
   1.4: Über http://localhost:3030 Daten in ein Datenset laden. Für das Projekt wurden Daten mithilfe des BSBM erstellt. 

2: Queries in den Ordner "queries" speichern. Hierbei muss es für jede Query 2-3 Dateien geben. 
  In der ersten Datei, kommt die Query mit evtl. Variablen, welche aus der randomWerte.txt Datei gelesen werden können.
  In die zweite Datei kommt die Auflösung der Variablen 
  In die dritte Datei kommt die Query ohne Variablen. Diese wird aber nur für die statische Optimierung der Queries genutzt.
3: Das runQueries.bat Skript ausführen: 
  runQueries.bat -name ZurordnungQueriesNummer.txt -endpoint http://localhost:3030/DATENSETNAME/query -dir DIRNAME -query queries
  Die verschiedenen Optionen des Skriptes können mit dem Kommando runQueries.bat -help zurückgegeben werden.
