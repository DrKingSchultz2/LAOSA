echo off

set dirT=QueryTestRun
set name=ZuordnungQueriesNummer.txt
set endpoint=http://localhost:3030/NewVeryBigDataset/query
set queri=queries
set shutdown=1

:Loop
if "%1"=="" GOTO Continue 
if "%1"=="-help" (
	echo "runQueries.bat <options>"
	echo "-name = The file-path of the file ZuordnungQueriesNummer built like: NameOfQuery	ConinuousNumberOfQueries	GroupNumberForQueries"
	echo "where NameOfQuery is a name for the query for you to recognize. ConinuousNumberOfQueries is a unique number for each query as saved in your queries folder. GroupNumberForQueries defines how the queries are stored, so all GroupNumberForQueries with number 1 are stored in one folder, ..."
	echo "-endpoint = The Sparql endpoint of your TripleStore. Standard: http://localhost:3030/NewVeryBigDataset/query"
	echo "-shutdown = Set to 0 if the Computer is to be shutdown after the benchmark is done. Standard: 1"
	echo "-dir = The directory, where the results are to be saved. Standard: QueryTestRun"
	echo "-query = The directory, where the queries are saved. Standard: queries"
	echo "The bsbm-Benchmark must be installed in the Benc/* folder"
	SHIFT 
	GOTO End
)
if "%1"=="-shutdown" (
	echo "will shutdown"
	set shutdown=0
	SHIFT
	GOTO Loop
)
if "%1"=="-endpoint" (
	echo %1
	echo %2
	set endpoint=%2
	SHIFT
	SHIFT 
	GOTO Loop
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

del /Q "%dirT%\GeneralRunMix.xlsx"
FOR /F "tokens=1,3,4" %%i in (%name%) do (
echo %%j
mkdir "%dirT%/Query%%k" 
echo %%j > %queri%/querymix.txt
java -cp Benc/V8/* benchmark.testdriver.TestDriver -w 30 -runs 150 -ucf %queri%/sparql.txt -sepm %dirT%/GeneralRunMix.xlsx -dof %dirT%/Query%%k/%%i.xlsx -o %dirT%/Query%%k/%%i.xml %endpoint%

)
if %shutdown% LSS 1 (
	shutdown /s /t 60
)
:End
	