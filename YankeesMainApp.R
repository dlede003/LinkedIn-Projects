library("shiny")
library("shinydashboard")
library("rsconnect")
 



# Source server and UI code

source("ui.R")
source("server.R")

# Run the Shiny app

shinyApp(ui = ui, server = server)
