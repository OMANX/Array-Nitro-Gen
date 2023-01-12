@echo off
rem Check if Python is installed
where python >nul 2>&1
if %errorlevel% neq 0 (
    rem Show an error message if Python is not installed
    msg * "Error: Python is not installed"
    exit /b
)

rem Installing required packages
pip install -r requirements.txt 2>error.txt

rem Check if proxy.exe exists in the bin folder
if exist "bin\proxy.exe" (
    rem Open proxy.exe 
    start bin\proxy.exe
) else (
    rem Show an error message if proxy.exe not found
    echo Error: proxy.exe not found in bin folder >> error.txt
    msg * "Error: proxy.exe not found in bin folder"
    exit /b
)

rem Running the script
python bin\main.py 2>error.txt

rem Check if main.py exists in the bin folder
if exist "bin\main.py" (
    rem Open main.py on top of every process
    start /BELOWNORMAL "main.py" python bin\main.py
) else (
    rem Show an error message if main.py not found
    echo Error: main.py not found in bin folder >> error.txt
    msg * "Error: main.py not found in bin folder"
    exit /b
)

rem Check if there are errors in the error log
for /f "delims=" %%i in (error.txt) do (
    set "error=%%i"
)
if defined error (
    rem Show the error message
    msg * "Error Occured. Please Read error.txt"
) else (
    rem Show a message if the script finished successfully
    msg * "Script finished successfully"
)
rem Close the batch file
exit
