:: Windows batch file that launches Shiny app 'XGapminder'

@ECHO OFF

cd "C:/Users/MK/Documents/pCloud_Sync_offline/Code_Examples/Shiny/Apps/"
"C:/Program Files/R/R-3.6.2/bin/x64/R.exe" -e "shiny::runApp('XDataExplore', launch.browser = TRUE)"

PAUSE