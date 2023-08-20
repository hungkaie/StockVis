# About this repo "StockVis"
I follow the tutorial of [RShiny](https://shiny.posit.co/r/getstarted/shiny-basics/lesson7/) to practice sharing StockVis RShiny App on Github.
I hereby indicate that the original source of this code comes from [this link](https://shiny.posit.co/r/getstarted/shiny-basics/lesson6/), a RShiny tutorial.

# Usage
Use R to run the following:
```R=
# install.packages("shiny")
library(shiny)
runGitHub("StockVis", "hungkaie")
```

This App helps you visualize stock price data easily. You can 
1. Select stock by its symbol, which can be found in https://finance.yahoo.com/lookup/
2. Select the date range you want.
3. Select whether to modify the data according to inflation.
4. Select the plotting scale.
