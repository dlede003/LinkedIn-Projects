library("shiny")
library("shinydashboard")
library("rsconnect")
 

#rsconnect::setAccountInfo(name='daniel-ledesma-46',
                          #token='2FD6DE6C0B95B9880BF32CC6BDBE3DBB',
                          #secret='Ud97zPYjmx/BpYVASWRaoubppfj7+4xDZ1UBSKeS')


# Source server and UI code

source("ui.R")
source("server.R")

# Run the Shiny app

shinyApp(ui = ui, server = server)