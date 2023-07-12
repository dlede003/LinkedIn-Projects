# LinkedIn-Projects


In this folder you will find various short projects that I have created using data from publicly available websites!

One of my passions is writing about and analyzing baseball data! I am a New York Yankees fan, if you were curious!

    "JudgevsOhtani".rmd is an R Markdown file comparing some basic stats between Aaaron Judge's AL record 62 HR season (2022) and comparing it with Shohei Ohtani's current 2023 season totals, up until the All-Star break.

    In order for the data to read correctly in R, I took the following steps:
      1.) downloaded the appropriate data in XLS format from baseball-reference.com
      2.) then I created two seperate sheets in the a blank XLS
      3.) I added by month season totals for both players (sheet="ByMonth") and then added a new column "Batter" into the XLS which then seperate the rows with a unique identifier for each player 
      4.) then I created another sheet ("ByHalf") where it shows first and second half data for both players and added the same "Batter" column to uniquely identify the appropriate batter; *note:Shohei Ohtani does not have second half stats available because at the point of creating this, the MLB season is at the All Star break*
      
