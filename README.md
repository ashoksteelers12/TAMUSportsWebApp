# TAMUSportsWebApp

Personal Project

This App contains football and basketball information on Texas A&M University from their most recent season. To update to the next season, the python code must be run again to collect new data and refresh the webpage. As of now, the information on the web app is until the 2019 sports year. 

The data was collected through the sportsreference library in Python on Jupyter Notebook. The data was transferred into csv files. The csv files were read in R. The app was created using shiny, as well as the plots. 

How App Functions?

To access either the basketball or football information/statistics, press either football or basketball. To access roster, schedule, or stats, click the button for it at the top after clicking the specified sport (basketball/football). Can change between both sports by clicking on the other then one of the three top buttons based on what one wants to see. The roster section contains specified stats for each player on the roster. Scroll down to find the different stats in a drop-down menu to compare each player with. The football roster contains the stats of the most recent (in this case 2019) season. The basketball roster contains stats from all seasons the player has played uptill the most current. This was how the Python sportsreference library gathered the information for each, which differed. But both is uptill or for the most recent season. The schedule section contains the most recent schedule for both teams. If the schedule is still old, that means the app is not updated yet and still requires the Jupyter Notebook file to run again and will have to republish the app. The stats section has a table of the important and main stats and plots them in a bar plot. 

The link to the webpage is below...

https://ashoksteelers12.shinyapps.io/TAMUSports/
