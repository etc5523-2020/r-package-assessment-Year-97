library(shiny)
library(ggplot2)
library(plotly)
library(coronavirus)
library(tidyverse)
library(DT)
library(kableExtra)
library(shinythemes)

corona_daily <- coronavirus %>% 
  select(date, country, type, cases) %>% 
  group_by(type, date) %>%
  summarise(total_cases = sum(cases)) %>%
  pivot_wider(names_from = type, values_from = total_cases) %>%
  arrange(date) %>%
  mutate(totalconfirmed = cumsum(confirmed),
         totalrecovered = cumsum(recovered),
         totaldeath = cumsum(death))

corona_top <- coronavirus %>% 
  select(date, country, type, cases) %>% 
  group_by(type, country) %>%
  summarise(total_cases = sum(cases)) %>%
  pivot_wider(names_from = type, values_from = total_cases) %>% 
  arrange(-confirmed) %>% 
  head(10)

corona_country <- coronavirus %>% 
  select(date, country, type, cases) %>% 
  filter(country %in% c("US", "India", "Brazil", "Russia", "Peru", "Colombia", "Mexico", "South Africa", "Spain", "Argentina")) %>% 
  filter(type == "confirmed")


ui <- fluidPage(
  theme = shinytheme("readable"),
  titlePanel("COVID-19"),
  
  tabsetPanel(type = "tabs",
              
              tabPanel("Daily Situation", fluid = TRUE,
                       mainPanel(dataTableOutput("eachday"),
                                 p("The first tab section shows daily situation. Here I use",
                                   span("DT package to create an interactive table.", style = "color:blue"),
                                   "When people use the app, they can easily get the information they need by searching in the interactive table. For example, if you want to know",
                                   strong("which day has the highest confirmed cases or deaths,"),
                                   "you just need to click on the corresponding column to sort in descending order. If you want to know",
                                   span(" the situation of a specific day, ", style = "color:red"),
                                   "you just need to enter the corresponding date in the Search Box to know that information easily."))
              ),
              
              tabPanel("Global Trend", fluid = TRUE,
                       mainPanel(plotlyOutput("lineplot", height = 800, width = 1200),
                                 p("In the Global Trend section, I used a line figure with filling color which is using in my blog entry before to",
                                   span("show the change trend of confirmed cases, deaths and recovered cases with the advance of time.", style = "color:blue"),
                                   "Also I have improved that figure again to make it much more attractive. When you move the mouse to the points in the above interactive plot, you can know the daily confirmed cases, deaths and recovered cases easily. It can be concluded that until the end of March, the confirmed cases in the world",
                                   span("did not exceed 300,000,", style = "color:blue"),
                                   "which indicates that at the beginning of the epidemic, the transmission speed was very slow, which is probably due to",
                                   strong("the perfect control of the epidemic by the country with the first outbreak of COVID-19.")),
                                 br(),
                                 p("Then in April, confirmed cases began to soar rapidly due to other countries' people's contempt for the epidemic and the frequent flow between the countries.",
                                   span("The speed of new confirmed cases reached to the highest in May, and there is no downward trend until now.", style = "color:red"),
                                   "It shows that in the outbreak period, the protection awareness of each country is very weak. Also, they",
                                   strong("have a high degree of confidence in their own epidemic prevention policies,"),
                                   "but they did not worked, so that until now they can not contain the development of the epidemic. "),
                                 br(),
                                 p("As for deaths and recover cases, The recovered rate was also relatively low at the beginning, but it began to", 
                                   span("rise rapidly in the middle of May,"),
                                   "which showed that various countries began to pay attention to the epidemic situation, and the whole world began to unite to fight against the attack of the epidemic.",
                                   strong("Fortunately, the mortality rate of patients with COVID-19 is not high,"),
                                   "and the growth of the mortality rate has not significantly accelerated and remained stable."))
                                   
                       ),

              tabPanel("Top_10 Comparison", fluid = TRUE,
                       sidebarLayout(
                         sidebarPanel(selectInput("country", "Which country do you choose?", 
                                                  choices = c(corona_country$country), 
                                                  selected = "Argentina")
                         ),
                         mainPanel(
                           plotOutput("plot", height = 800, width = 800),
                           p("In Top_10 Comparison section, users can select a country in the selection box, and then the figure will ",
                             span("show the daily growth trend of confirmed cases corresponding to that chosen country,", style = "color:blue"),
                             "which is quite simple to use."),
                           br(),
                           p("And from those figures, we can see that there is a small problem in Spain and Colombia data. There are",
                             span("three negative numbers shown in confirmed cases", style = "color:blue"),
                             "which are not consistent with common sense.",
                             strong("It should be the fault of the author who made the coronavirus package.")),
                           br(),
                           p("After removing this part of the data, we can find that most of the new cases in the ten countries have shown a downward trend,", 
                             span("but the new confirmed cases in India have been increasing.", style = "color:red"),
                             "This sends a very dangerous signal. Because India is known to have the second largest population in the world, but its average national income is quite low.",
                             strong("The high growth rate of confirmed cases may cause a huge gap in India's medical resources."),
                             "Whether it can be controlled or not depends on the measures taken by the Indian government.")
                         )
                       )
              ),
              
              tabPanel("Country", fluid = TRUE,
                       sidebarLayout(
                         sidebarPanel(Inputselect("country", "Which country do you choose",
                                                   c(corona_table$country)), 
                                      p("In the Country section, I use",
                                        span("kableExtra package to make a different table.", style = "color:blue"),
                                        "It lists all the countries on record, and I've listed them in descending order of confirmed cases. There is",
                                        span("a selection box next to the table.", style = "color:red"),
                                        "Originally, the table will only show the specific situation of the corresponding country. However, after thinking for a long time, ",
                                        strong("the relationship between the two can not be established,"),
                                        "so it has no effect on the table content. I hope it can be improved in the future.")
                                      
                         ),
                         mainPanel(htmlOutput("table")))
                       ),
              

              tabPanel("About",  
                       mainPanel(strong("The creator of this app is Chengzhi Ye. "),
                                 br(),
                                 p("This app has two purposes. First, I selected",
                                   span("the top ten countries with the largest number of confirmed cases", style = "color:blue"),
                                   "in the world, and then identified their overall changes from January to October in the form of a line chart."),
                                 p("In this way, people can clearly understand the overall changes among the ten countries by",
                                   strong("selecting different countries in the selection box"),
                                   ", and meanwhile, we can learn the",
                                   span("epidemic prevention efficiency of each country and the situation of the second outbreak through comparison.")),
                                 p("Secondly, I have combined the overall situation of each country and obtained the global trend of confirmed cases. Also, I used", 
                                 code("plotly package"),
                                 "to make figure interactive. People can", 
                                 strong("click on different points"),
                                 "to search for the new confirmed cases every day, and they can also judge the severity of the epidemic from the different trend of the line chart."))
  ),
           tabPanel("Citation",
                    mainPanel(p("1. Chang, W., Cheng, J., Allaire, J. J., Xie, Y., & McPherson, J. (2015). Package ‘shiny’. See http://citeseerx. ist. psu. edu/viewdoc/download."),
                              p("2. Wickham, H., Chang, W., & Wickham, M. H. (2016). Package ‘ggplot2’. Create Elegant Data Visualisations Using the Grammar of Graphics. Version, 2(1), 1-189."),
                              p("3. C. Sievert. Interactive Web-Based Data Visualization with R, plotly, and shiny. Chapman and Hall/CRC Florida, 2020."),
                              p("4. Rami Krispin and Jarrett Byrnes (2020). coronavirus: The 2019 Novel Coronavirus COVID-19 (2019-nCoV) Dataset. R package version 0.3.0.9000. https://github.com/RamiKrispin/coronavirus"),
                              p("5. Wickham, H., & Wickham, M. H. (2017). Package tidyverse. Easily Install and Load the ‘Tidyverse."),
                              p("6. Yihui Xie, Joe Cheng and Xianying Tan (2020). DT: A Wrapper of the JavaScript Library 'DataTables'. R package version 0.15. https://CRAN.R-project.org/package=DT"),
                              p("7. Hao Zhu (2019). kableExtra: Construct Complex Table with 'kable' and Pipe Syntax. R package version 1.1.0. https://CRAN.R-project.org/package=kableExtra"),
                              p("8. Winston Chang (2018). shinythemes: Themes for Shiny. R package version 1.1.2. https://CRAN.R-project.org/package=shinythemes")))
  )
)



server <- function(input, output, session) {
  
  
  output$eachday <- renderDataTable(datatable(corona_daily, options = list(
    lengthMenu = list(c(5, 15, -1), c('5', '15', 'All')),
    pageLength = 15, columnDefs = list(list(className = 'dt-center', targets = 2:6))
  )))
  
  output$lineplot <- renderPlotly({
    g <- plot_ly(corona_daily, 
                 x = ~ date, 
                 y = ~ totalconfirmed,
                 name = 'Confirmed',
                 fillcolor = 'purple',
                 type = 'scatter',
                 mode = 'none',
                 stackgroup = 'one') %>% 
      add_trace(y = ~totalrecovered, 
                name = 'Recovered', 
                fillcolor = 'lightgreen') %>%
      add_trace(y = ~ totaldeath, 
                name = "Death",
                fillcolor = 'black') %>%
      layout(title = "Distribution of Covid19 Cases Worldwide",
             legend = list(x = 0.1, y = 0.9),
             yaxis = list(title = "Number of Cases"),
             xaxis = list(title = "Date"),
             hovermode = "compare")
    
    ggplotly(g)
  })
  
  
  output$plot <- renderPlot({
    ggplot(corona_country, aes(x = date, y = cases)) +
      geom_line(data = filter(corona_country, country == input$country)) +
      ggtitle("Top 10 Countries with Most Confirmed Cases") +
      theme_light() +
      labs(x = "Time", y = "Counts", title = input$country)
  })
  
  output$table <- renderText({
    Easykable(15)
  })


    
}

shinyApp(ui, server)





