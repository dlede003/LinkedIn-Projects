Yankees <- read_excel("C:/Users/danie/Documents/YankeesWLRecords.xlsx", sheet = "Stats")
Ranks <- read_excel("C:/Users/danie/Documents/YankeesWLRecords.xlsx",sheet = "Ranks") 

ui <- dashboardPage(
  dashboardHeader(title = "Yankees 2023 Season (As of 07/21/23)"),
  dashboardSidebar(width = 400,
                   sidebarMenu(
                     menuItem("Introduction", tabName = "intro", icon = icon("info")),
                     menuItem(" Wins By Year (Since 1994)", tabName = "wins", icon = icon("chart-line")),
                     menuItem(" Yankees AL East History By Year (Since 1994)", tabName = "al_east", icon = icon("chart-bar")),
                     menuItem(" Yankees Offense By Year (Since 1994)", tabName = "offense", icon = icon("baseball-bat-ball")),
                     menuItem(" Yankees Batting Ranks (By Year)", tabName = "batting_ranks", icon = icon("chart-column")),
                     menuItem(" Yankees Pitching & Defensive Ranks (By Year)", tabName = "def_pit_ranks", icon = icon("mitten"))
                   )
  ),
  dashboardBody(
    tabItems(
      tabItem("intro",
              h2("Introduction"),
              p("Welcome to the Yankees 2023 Season Shiny Dashboard!"),
              p("This dashboard provides various visualizations and insights into the New York Yankees' (underwhelming) performance during the 2023 season."),
              p("The data used in this dashboard is sourced from Baseball-Reference.com and contains information on the Yankees' regular-season performance for each year since 1994."),
              p("You can explore the team's wins, AL East division history, offense statistics, batting ranks, pitching ranks, and defensive ranks using the menu options."),
              p("Enjoy exploring the data and Go Yankees!"),
              p("Data Source: https://www.baseball-reference.com/teams/NYY/index.shtml"),
              p("Note: the 2020 season was not included in this project, as it was only a 60 game season due to COVID")
      ),
      tabItem("wins",
              box(highchartOutput("Wins_Per_Season"), width = 10),
              box(plotlyOutput("Pyth_WL_Chart"), width = 10)
      ),
      tabItem("al_east",
              box(plotlyOutput("AL_East_History_Chart"), width = 6),
              box(plotlyOutput("AL_East_Pie_Chart"), width = 6)
      ),
      tabItem("offense",
              box(plotlyOutput("OBP_OPS_SLG_Chart"), width = 10),
              box(highchartOutput("Run_Differential_Chart"), width = 10)
      ),        
      tabItem("batting_ranks",
              box(plotlyOutput("Batting_Ranks_Chart"),  width = 10),
              box(plotlyOutput("Batting_Ranks_Chart2"), width = 10),
              box(plotlyOutput("Batting_Ranks_Chart3"), width = 10)
      ),
      tabItem("def_pit_ranks",
              box(plotlyOutput("Pitching_Ranks_Chart"),  width = 10),
              box(plotlyOutput("Defensive_Ranks_Chart"),   width = 10)
              
      )
    )
  )
)