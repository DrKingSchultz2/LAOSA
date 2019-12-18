@echo off

set dirT=QueryTestRun
set name=ZuordnungQueriesNummer.txt
set queri=queries



:Loop
echo %1
if "%1"=="" GOTO Continue 
if "%1"=="-help" (
	echo "runQueries.bat (name) (endpoint)"
	echo "name = The file-path of the file ZuordnungQueriesNummer built like: NameOfQuery	ConinuousNumberOfQueries	GroupNumberForQueries"
	echo "where NameOfQuery is a name for the query for you to recognize. ConinuousNumberOfQueries is a unique number for each query as saved in your queries folder. GroupNumberForQueries defines how the queries are stored, so all GroupNumberForQueries with number 1 are stored in one folder, ..."
	echo "endpoint = The Sparql endpoint of your TripleStore"
	echo "The bsbm-Benchmark must be installed in the Benc/* folder"
	SHIFT 
	GOTO End
)
if "%1"=="-name" (
	set name=%2
	SHIFT
	SHIFT 
	GOTO Loop
)
if "%1"=="-dir" (
	set dirT=%2
	SHIFT
	SHIFT
	GOTO Loop
)
if "%1"=="-query" (
	set queri=%2
	SHIFT
	SHIFT
	GOTO Loop
)
SHIFT 
GOTO Loop

:Continue

mkdir %dirT%

FOR /F "tokens=1,3,4" %%i in (%name%) do (
echo %%j
mkdir "%dirT%/Query%%k" 
qparse --explain --query %queri%/query%%jValued.txt > %dirT%/Query%%k/optQuery%%i.txt

)
:End
	