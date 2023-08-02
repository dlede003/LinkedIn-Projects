library("shinydashboard")
library("highcharter")
library("plotly")
library("viridisLite")
library("viridis")
library("tidyr")
library("fontawesome")


ui <- dashboardPage(
  dashboardHeader(title = "Yankees 2023 Season (As of 07/21/23)"),
  dashboardSidebar(width = 400,
                   sidebarMenu(
                     menuItem("Introduction", tabName = "intro", icon = icon("info")),
                     menuItem(" Wins By Year (Since 1994)", tabName = "wins", icon = icon("chart-line")),
                     menuItem(" Yankees AL East History By Year (Since 1994)", tabName = "al_east", icon = icon("chart-bar")),
                     menuItem(" Yankees Offense By Year (Since 1994)", tabName = "offense", icon = icon("baseball-bat-ball")),
                     menuItem(" Yankees Batting Ranks (By Year)", tabName = "batting_ranks", icon = icon("chart-column")),
                     menuItem(" Yankees Pitching & Defensive Ranks (By Year)", tabName = "def_pit_ranks", icon = icon("mitten")),
                     menuItem("Findings", tabName = "findings", icon = icon("magnifying-glass"))
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
      ),
      tabItem("findings",
              h2("Wins By Year (Since 1994)"),
              p("Based on the current Pythagorean W-L%, the New York Yankees are projected to have a winning percentage of approximately 50% in the 2023 season, which would result in an 81-81 record. The last time the Yankees recorded 81 wins or fewer was back in 1995 when they achieved only 79 wins; however, this was due to the strike, which resulted in a shortened season of 144 games played. Considering the 1994 season was also shortened (112-117 games) due to the strike, there is a possibility that the 2023 season could be regarded as the Yankees' worst season since the inception of the 5-team AL East in 1994."),p("Moreover, if the season were to conclude today, the New York Yankees would encounter their most significant disparity in W-L% compared to recent years. For instance, if the Yankees were to finish the 2023 season with a 50-51 W-L%, it would represent a 10% decrease from last season's 61 W-L% performance. This 10% drop would be the most substantial decline since 1999 when they experienced a similar decrease of approximately 10% compared to their outstanding 1998 season.
In 1998, the Yankees achieved remarkable success, winning 114 games (the second-highest in AL history and the third-highest in MLB history) and achieving a staggering 70 W-L% record. As a result, the 10% decrease in W-L% in 1999 was primarily due to the extraordinary number of wins achieved in the previous year, making it exceedingly challenging to replicate such an exceptional performance in consecutive seasons.
"),
              h2("Yankees AL East History By Year (Since 1994)"),
              p("Since 1994, the New York Yankees have demonstrated their dominance by securing the 1st place in the AL East an impressive 16 times out of 28 seasons. Equally surprising is the fact that in all these 28 seasons, they have never finished in last place (5th) since the start of the 5-team AL East (1994). However, the current season has been a stark contrast, as the Yankees currently find themselves in 5th place in the AL East, underscoring the team's struggles and disappointing performance this year. "),
              
              h2("Yankees Offense By Year (Since 1994)"),
              p("Observing the graph, it becomes evident that the Yankees' SLG% and OPS% have shown relatively consistent trends since 1994. However, in 2023, there has been an approximate 5% decline in OPS% compared to the previous year, primarily due to a 2-2.5% decrease in both SLG% and OBP%.
This decline in offensive performance can be attributed to the underperformance of key players such as Giancarlo Stanton and Anthony Rizzo during the 2023 season. Stanton's batting average currently stands at .198, and his high strikeout rate has impacted the team's SLG% and OPS%. Similarly, Rizzo's increased strikeout rate compared to the previous season has resulted in a significant 10% reduction in both his SLG% and OPS% for the 2023 season.
"),p("As of the current season (2023), the New York Yankees' run differential (RD) stands at 8. This marks a notable contrast from the previous season (2022), where they had a remarkable run differential of 240, which was their highest since their 114-win performance in 1998. The difference of 232 in RD between the two seasons is the most significant margin observed since 1994-1995.
"),p("Furthermore, the current RD of 8 is the lowest the Yankees have experienced in a season since 2016, when they recorded an RD of -22. When a team's run differential hovers close to zero or falls into negative territory, it indicates that they are barely outscoring or are being outscored by their opponents. This factor can significantly influence the number of games a team wins throughout a season, highlighting the importance of run differential in assessing a team's overall performance.
"),
              h2("Yankees Batting Ranks (By Year)"),
              p("When compared to the rest of the AL teams the Yankees offense currently ranks (out of AL 15 teams): 
•	9th,11th and 10th in SLG, OBP and OPS respectively
•	10th in Runs Per Game (R/G)
•	10th in Base on Balls (Walks) (BB)
•	14th in Batting Average (BA)
•	14th in Hits (H)
•	15th (Last) in At Bats (AB)
When compared to last season, the biggest drops in rank occurred in: 
•	OBP (2nd to 10th)
•	SLG (2nd to 9th)
•	OPS (2nd to 10th)
•	R/G (1st to 10th) 
•	BB (1st to 10th)"), 
p("From the observed decreases in rank, it can be inferred that the New York Yankees, who were among the best offenses in the AL last year, have experienced a significant decline in offensive performance this year, possibly making them one of the weakest offenses in the league. The data suggests that the Yankees are encountering difficulties in getting on base, be it through hits, walks, or extra-base hits, resulting in a lower run-scoring output compared to other AL teams.

Because of these struggles, the team has accumulated fewer At-Bats (ABs) throughout the season, contributing to their last place ranking in ABs among both the AL and MLB. Additionally, they are 14th position in Batting Average (BA) only the 30-77 Oakland A's have a lower BA in the AL.
"),
p("However, despite these challenges, the Yankees rank 3rd in the AL in Home Runs, which is a primary reason why their values for SLG, OBP, and OPS are not in last place. The high number of home runs suggests that the team heavily relies on this power-hitting aspect to score most of their runs, while they seem to struggle in finding other effective means to get on base and bring runs across the plate.
"),
              h2("Yankees Pitching & Defensive Ranks (By Year)"),
              p("In the 2023 season, the New York Yankees' pitching statistics place them in mid-ranking positions among AL teams in crucial categories such as Earned Run Average (ERA) (7th), Runs Allowed Per Game (RA/G) (7th) and Walks and Hits Per Inning Pitched (WHIP) (6th). However, these values have all experienced a decline compared to the previous season when the Yankees ranked an impressive 2nd in each of these categories. This marks the most significant difference in these pitching categories observed since 1994.

"),p("When examining their defensive ranks, the Yankees currently stand at 12th in Errors (E), 12th in Fielding Percentage (Fld%), and 14th in Double Plays Turned (DP). This contrasts with last year's performance when they ranked 2nd in Fld% and 3rd in Errors, highlighting potential defensive issues this season. Once again, comparing this year's defensive performance to the previous year's, these differences represent the highest since 1994.
"),p("
However, it's worth noting that when analyzing the trend over the years, excluding 2022, the Yankees haven't consistently ranked at the top in these defensive categories. In fact, the values have been steadily decreasing in general, indicating ongoing challenges in maintaining a strong defensive presence over time. 
"),
h2("Conclusion"),
p("In conclusion, the data and analysis presented in the Yankees 2023 Season Dashboard reveal significant challenges faced by the New York Yankees in the current season. The team's projected winning percentage of approximately 50% indicates a potential 81-81 record, the lowest since 1995, considering the impact of strikes on previous seasons. The offensive decline, with notable drops in SLG, OBP, and OPS, suggests the Yankees are struggling to get on base and score runs compared to other AL teams.

"),p("Furthermore, the significant disparities in W-L% compared to recent years and the decreased performance in pitching and defense highlight the team's struggles in multiple aspects of the game. Despite ranking 3rd in the AL in Home Runs, the reliance on power-hitting alone may not be sustainable for consistent success.

"),p("As a dedicated baseball enthusiast, I will continue to explore and analyze the data to identify patterns and potential areas for improvement. The insights from this dashboard offer valuable information to understand the Yankees' performance in the 2023 season and help shape future strategies for the team. Let's keep the baseball spirit alive as we dive deeper into the world of sports analytics and cheer on our beloved New York Yankees!")
              
              
      )
    )
  )
)