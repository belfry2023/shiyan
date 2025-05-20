@echo off
setlocal enabledelayedexpansion

for /r %%a in (eg????.exe) do (
    set "filename=%%~na"
    set "num_str=!filename:~2,4!"
    echo !num_str! | findstr /r "^[0-1][0-7][0-9][0-9]$" >nul && (
        set /a num=1!num_str! - 10000
        if !num! lss 700 (
            start "" "%%a"
        )
    )
)

endlocal