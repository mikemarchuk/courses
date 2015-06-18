shinyUI(
    pageWithSidebar(
        headerPanel("Coursera project. Car market."),
        sidebarPanel(
            uiOutput("brandControls"),
            uiOutput("modelControls"),
            uiOutput("marketPriceControls"),
            sliderInput("market_price", "Range of market price: ", min = 100000, max = 1000000, value = c(100000, 1000000), step = 20000),
            sliderInput("year", "Range of years: ", min = 2003, max = 2015, value = c(2003, 2015), sep = ""),
            numericInput("countCars", "Number of cars to view:", 15, min = 5, max = 20),
            uiOutput("pageControls")
        ),
        mainPanel(
            tabsetPanel(
                tabPanel("Main",
                         h3("List of cars"),
                         verbatimTextOutput("total"),
                         uiOutput("carsControls")
                         ),
                tabPanel("Documentation",
                         h3("General description"),
                         helpText("This shiny application is a simple example of selection of car on the market."),
                         h3("Functionality"),
                         helpText("To display a list of cars must select the brand and model. Brands and models related: model list is filled with the chosen brand"),
                         h5("Range of market price"),
                         helpText("Limits the market price of the car. 
                                  Properties: minimum value = 100,000, maximum value = 1,000,000, step = 20,000.
                                  Default values: 100,000 and 1,000,000."),
                         h5("Range of years"),
                         helpText("Limits on car production year. 
                                  Properties: minimum value = 2013, maximum value = 2015, step = 1.
                                  Default values: 2013 and 2015."),
                         h5("Number of cars to view"),
                         helpText("Used to change the number of cars that appear in the list.
                                  Properties: minimum value = 5, maximum value = 20.
                                  Default value: 15"),
                         h5("Number of page"),
                         helpText("Used to navigate through the pages"),
                         helpText("NOTE: Will be displayed after the model selection"),
                         h5("Other information"),
                         helpText("Above the list output the total number of cars and the number of pages."),
                         h5("P.S."),
                         helpText("Sorry for my English.")
                         )
            )
        )
    )
)