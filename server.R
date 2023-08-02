library("shiny")
library("dplyr")
library("readxl")
library("highcharter")
library("plotly")

#setwd("C:/Users/danie/Documents/YankeesProject")

Yankees <- read_excel("C:/Users/danie/Documents/YankeesProject/YankeesWLRecords.xlsx", sheet = "Stats")
Ranks <- read_excel("C:/Users/danie/Documents/YankeesProject/YankeesWLRecords.xlsx",sheet = "Ranks") 

server <- function(input, output) {
  output$Wins_Per_Season <- renderHighchart({
    
    filteredYankees<-Yankees%>%filter(Year >= 1994 & Year <= 2022 & Year!=2020)  
    
    filteredYankees%>%arrange(Year)%>%
      hchart('line',hcaes(x=as.factor(Year),y=W),color="darkblue")%>%
      hc_add_theme(hc_theme_bloom())%>%
      hc_xAxis(title = list(text = "Year"),tickInterval = 5)%>%
      hc_yAxis(title = list(text = "Wins"))%>%
      hc_tooltip(pointFormat='<b> Total Wins {point.y} <b>')%>%
      hc_title(text='Yankees Regular Season Wins (By Year)',style=list(fontSize='25px',fontWeight='bold'))%>%
      hc_subtitle(text='Since 1994',style=list(fontSize='16px'))%>%
      hc_credits(enabled=TRUE,text='Data Source: https://www.baseball-reference.com/teams/NYY/index.shtml')
  })
  
  output$Pyth_WL_Chart <- renderPlotly({
    filteredYankees2 <- Yankees %>% arrange(Year) %>% filter(Year >= 1994 & Year <= 2023 & Year != 2020)
    filteredYankees2$Year <- as.numeric(as.character(filteredYankees2$Year))
    
    hover_text_pyth <- paste("Year: %{x}", "<br>", "Pyth W-L%: %{y}", "<br>")
    hover_text_wl <- paste("Year: %{x}", "<br>", "W-L%: %{y}", "<br>")
    
    pythwl <- plot_ly(data = filteredYankees2, type = "scatter", mode = "lines+markers") %>%
      add_trace(x = ~Year, y = ~`pythW-L%`, name = "Pyth W-L%", line = list(color = "red"), marker = list(color = "red"),
                hovertemplate = hover_text_pyth) %>%
      add_trace(x = ~Year, y = ~`W-L%`, name = "W-L%", line = list(color = "black"), marker = list(color = "black"),
                hovertemplate = hover_text_wl) %>%
      layout(title = "Yankees W-L%, Pyth W-L% (By Year)",
             xaxis = list(title = "Year"),
             yaxis = list(title = "Win %"),
             showlegend = TRUE,
             legend = list(x = 0.95, y = 0.95),
             hovermode = "closest",
             margin = list(b = 120))
    
    pythwl
  })
  
  output$AL_East_History_Chart <- renderPlotly({
    filteredYankees <- Yankees %>% filter(Year >= 1994 & Year <= 2022 & Year != 2020) 
    aggregated_data <- aggregate(Year ~ Finish...22, data = filteredYankees, FUN = length)
    
    color_palette <- viridisLite::viridis(n = length(unique(aggregated_data$Finish...22)), option = "mako")
    finish_order <- c("1st", "2nd", "3rd", "4th", "5th")
    # Convert Finish...22 to a factor to preserve the order
    aggregated_data$Finish...22 <- factor(aggregated_data$Finish...22, levels = finish_order)
    
    # Create a plotly bar chart with adjustable bar width and a legend
    plot_ly(data = aggregated_data, type = "bar",
            x = ~Finish...22, y = ~Year, marker = list(color = color_palette),
            name = ~Finish...22) %>%
      layout(title = 'Yankees AL East Finish by Amount (Since 1994)',
             xaxis = list(title = "Yankees AL East End of Season Finish"),
             yaxis = list(title = "Amount (Since 1994)"),
             bargap = 0.2,  # Adjust this value to control the spacing between the bars
             bargroupgap = 0.1)  # Adjust this value to control the spacing between bar groups
  })
  
  output$AL_East_Pie_Chart <- renderPlotly({
    filteredYankees <- Yankees %>% filter(Year >= 1994 & Year <= 2022 & Year != 2020)
    pie_data <- filteredYankees %>%
      group_by(Finish...22) %>%
      summarise(count = n()) %>%
      ungroup()
    
    yankees_colors <- c("navy", "royalblue","grey", "black", "red")
    # Create the pie chart
    plot_ly(data = pie_data, type = "pie", labels = ~Finish...22, values = ~count, 
            textinfo = "label+percent", 
            insidetextfont = list(size = 14), 
            marker = list(colors = yankees_colors),
            hoverinfo = "text",
            texttemplate = "%{label}: %{percent}") %>%
      layout(title = "Yankees AL East Finish Distribution (1994-2022)",
             showlegend = TRUE)
  })
  
  output$OBP_OPS_SLG_Chart <- renderPlotly({
    
    filteredYankees2<-Yankees%>%arrange(Yankees$Year)%>%filter(Year >= 1994 & Year <= 2023 & Year!=2020)
    
    filteredYankees2$Year <- as.numeric(as.character(filteredYankees2$Year))
    
    hover_text_obp <- paste("Year: %{x}", "<br>",
                            "OBP: %{y}", "<br>")
    hover_text_slg <- paste("Year: %{x}", "<br>",
                            "SLG: %{y}", "<br>")
    hover_text_ops <- paste("Year: %{x}", "<br>",
                            "OPS: %{y}", "<br>")
    
    obpslgops <- plot_ly(data = filteredYankees2, type = "scatter", mode = "lines+markers") %>%
      add_trace(x = ~Year, y = ~`OBP`, name = "OBP%", line = list(color= "grey"),marker=list(color="grey"),
                hovertemplate = hover_text_obp) %>%
      add_trace(x = ~Year, y = ~`SLG`, name = "SLG%", line = list(color = "royalblue"),marker = list(color = "royalblue"),
                hovertemplate = hover_text_slg) %>%
      add_trace(x = ~Year, y = ~`OPS`, name = "OPS%", line = list(color = "navy"),marker = list(color = "navy"),
                hovertemplate = hover_text_ops) %>%
      layout(title = "Yankees OBP SLG & OPS (By Year)",
             xaxis = list(title = "Year"),
             yaxis = list(title = "%"),
             showlegend = TRUE,
             legend = list(x = 0.95, y = .95),
             hovermode = "closest",
             margin = list(b = 120))
    
    obpslgops
  })
  output$Run_Differential_Chart <- renderHighchart({
    
    filteredYankees2 <- Yankees %>% arrange(Year) %>% filter(Year >= 1994 & Year <= 2023 & Year != 2020)
    
    filteredYankees2$Year <- as.numeric(as.character(filteredYankees2$Year))
    
    rundiff <- filteredYankees2 %>%
      mutate(RD = R...13 - RA...14) %>%
      hchart('line', hcaes(x = as.factor(Year), y = RD), color = "darkblue") %>%
      hc_add_theme(hc_theme_bloom()) %>%
      hc_xAxis(title = list(text = "Year"), tickInterval = 5) %>%
      hc_yAxis(title = list(text = "Run Differential")) %>%
      hc_tooltip(pointFormat = '<b> Run Differential {point.y} </b>') %>%
      hc_title(text = 'Yankees Regular Season Run Differential (By Year)', style = list(fontSize = '25px', fontWeight = 'bold')) %>%
      hc_subtitle(text = 'Since 1994', style = list(fontSize = '16px')) %>%
      hc_credits(enabled = TRUE, text = 'Data Source: https://www.baseball-reference.com/teams/NYY/index.shtml')
    
    rundiff
  })
  output$Batting_Ranks_Chart <- renderPlotly({
    
    filteredRanks <- Ranks %>% arrange(Year) %>% filter(Year >= 1994 & Year <= 2023 & Year != 2020)
    graph <- plot_ly() %>%
      add_trace(data = filteredRanks, x = ~Year, y = ~OBP, name = "OBP Rank", type = "scatter", mode = "lines+markers", line = list(color = "navy"), marker = list(color = "navy")) %>%
      add_trace(data = filteredRanks, x = ~Year, y = ~SLG, name = "SLG Rank", type = "scatter", mode = "lines+markers", line = list(color = "blue"), marker = list(color = "blue")) %>%
      add_trace(data = filteredRanks, x = ~Year, y = ~OPS, name = "OPS Rank", type = "scatter", mode = "lines+markers", line = list(color = "gray"), marker = list(color = "gray")) %>%
      layout(title = "Yankees' Ranks for OBP, SLG, and OPS By Year (Since 1994)",
             xaxis = list(title = "Year"),
             yaxis = list(title = "Rank", autorange = "reversed"))  # Reverse the Y-axis
    
    graph
  })
  output$Batting_Ranks_Chart2 <- renderPlotly({
    filteredRanks<-Ranks%>%arrange(Ranks$Year)%>%filter(Year >= 1994 & Year <= 2023 & Year!=2020)
    battinggraph <- plot_ly() %>%
      add_trace(data = filteredRanks, x = ~Year, y = ~`R/G`, name = "R/G Rank", type = "scatter", mode = "lines+markers", line = list(color = "navy"),marker=list(color="navy")) %>%
      add_trace(data = filteredRanks, x = ~Year, y = ~AB, name = "AB Rank", type = "scatter", mode = "lines+markers", line = list(color = "blue"),marker=list(color="blue")) %>%
      add_trace(data = filteredRanks, x = ~Year, y = ~`H...10`, name = "H Rank", type = "scatter", mode = "lines+markers", line = list(color = "gray"),marker=list(color="gray")) %>%
      layout(title = "Yankees' AL Batting Ranks By Year (Since 1994)",
             xaxis = list(title = "Year"),
             yaxis = list(title = "Rank", autorange = "reversed"))
    battinggraph
  })
  output$Batting_Ranks_Chart3<-renderPlotly({
    filteredRanks<-Ranks%>%arrange(Ranks$Year)%>%filter(Year >= 1994 & Year <= 2023 & Year!=2020)
    
    addbattinggraph <- plot_ly() %>%
      add_trace(data = filteredRanks, x = ~Year, y = ~`BB...16`, name = "BB Rank", type = "scatter", mode = "lines+markers", line = list(color = "navy"),marker=list(color="navy")) %>%
      add_trace(data = filteredRanks, x = ~Year, y = ~`SO...17`, name = "SO Rank", type = "scatter", mode = "lines+markers", line = list(color = "blue"),marker=list(color="blue")) %>%
      add_trace(data = filteredRanks, x = ~Year, y = ~BA, name = "BA Rank", type = "scatter", mode = "lines+markers", line = list(color = "gray"),marker=list(color="gray")) %>%
      layout(title = "Yankees AL (Add.) Batting Ranks By Year (Since 1994)",
             xaxis = list(title = "Year"),
             yaxis = list(title = "Rank", autorange = "reversed"))
    addbattinggraph
  })
  output$Defensive_Ranks_Chart<-renderPlotly({
    filteredRanks<-Ranks%>%arrange(Ranks$Year)%>%filter(Year >= 1994 & Year <= 2023 & Year!=2020)
    defgraph <- plot_ly() %>%
      add_trace(data = filteredRanks, x = ~Year, y = ~`E...22`, name = "Err. Rank", type = "scatter", mode = "lines+markers", line = list(color = "navy"),marker=list(color="navy")) %>%
      add_trace(data = filteredRanks, x = ~Year, y = ~`DP...23`, name = "DP Rank", type = "scatter", mode = "lines+markers", line = list(color = "blue"),marker=list(color="blue")) %>%
      add_trace(data = filteredRanks, x = ~Year, y = ~`Fld%...24`, name = "Fld% Rank", type = "scatter", mode = "lines+markers", line = list(color = "gray"),marker=list(color="gray")) %>%
      layout(title = "Yankees AL Defensive Ranks By Year (Since 1994)",
             xaxis = list(title = "Year"),
             yaxis = list(title = "Rank", autorange = "reversed"))
    defgraph
  })
  output$Pitching_Ranks_Chart<-renderPlotly({
    filteredRanks<-Ranks%>%arrange(Ranks$Year)%>%filter(Year >= 1994 & Year <= 2023 & Year!=2020)
    pitgraph <- plot_ly() %>%
      add_trace(data = filteredRanks, x = ~Year, y = ~`RA/G`, name = "RA/G Rank", type = "scatter", mode = "lines+markers", line = list(color = "navy"),marker=list(color="navy")) %>%
      add_trace(data = filteredRanks, x = ~Year, y = ~ERA, name = "ERA Rank", type = "scatter", mode = "lines+markers", line = list(color = "blue"),marker=list(color="blue")) %>%
      add_trace(data = filteredRanks, x = ~Year, y = ~WHIP, name = "WHIP Rank", type = "scatter", mode = "lines+markers", line = list(color = "gray"),marker=list(color="gray")) %>%
      layout(title = "Yankees AL Pitching Ranks By Year (Since 1994)",
             xaxis = list(title = "Year"),
             yaxis = list(title = "Rank", autorange = "reversed"))
    pitgraph
  })
  
  
  
}
