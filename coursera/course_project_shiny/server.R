#read data
brandsTable <- data.frame(read.csv("data/brands.csv"))
modelsTable <- read.csv("data/models.csv")
carsTable <- read.csv("data/cars.csv", sep=";")

#convert columns type
carsTable <- transform(carsTable, 
                        brand = as.character(brand), 
                        brands_id = as.integer(brands_id),
                        model = as.character(model), 
                        models_id = as.character(models_id), 
                        market_price = as.integer(market_price), 
                        year = as.integer(year)
                       )

#make data for selectInput "brands"
list_brands_id <- brandsTable[,"brands_id"]
list_brands_id <- c(0, list_brands_id)
list_brands_title <- as.character(brandsTable[,"brand"])
list_brands_title <- c("...", list_brands_title)
list_brands <- data.frame(list_brands_id, list_brands_title)


shinyServer(
    function(input, output) {
        
        #selectInput "brands" for UI
        choicesBrands = setNames(list_brands$list_brands_id, list_brands$list_brands_title)
        output$brandControls <- renderUI({
            selectInput("brands", "Choose a brand:", choicesBrands)
        })
        
        #reactivity for count of cars to view
        countCars <- reactive({
            input$countCars
        })

        #selectInput "models" for UI
        output$modelControls <- renderUI({
            #make data for selectInput "models" by input$brands
            list_models_by_brands_id <- modelsTable[modelsTable$brands_id == input$brands, ]
            list_models_id <- list_models_by_brands_id[,"models_id"]
            list_models_id <- c(0, list_models_id)
            list_models_title <- as.character(list_models_by_brands_id[,"model"])
            list_models_title <- c("...", list_models_title)
            list_models <- data.frame(list_models_id, list_models_title)
            choicesModels = setNames(list_models$list_models_id, list_models$list_models_title)
            selectInput("models", "Choose a model:", choicesModels)
        })

        #outputUI for list of cars
        output$carsControls <- renderUI({
            tableOutput("carsList")
            
        })

        #output list of cars
        output$carsList <- renderTable({
            if (!is.null(input$brands) & !is.null(input$models)) { 
                if (input$brands > 0 & input$models > 0) {
                    
                    #filtered cars and selection only information columns
                    cars = data.frame(carsTable[
                        carsTable$models_id == input$models &
                            carsTable$market_price >= input$market_price[1] &
                            carsTable$market_price <= input$market_price[2] &
                            carsTable$year >= input$year[1] &
                            carsTable$year <= input$year[2], 
                        c("brand", "model", "market_price", "year")])
                    #total count of cars by selection
                    total = nrow(cars)
                    
                    #reactivity for calc count of pages
                    countPages <- reactive({
                        ceiling(total / countCars())
                    })
                    output$total <- renderText({
                        paste("Total: ", total, "Count pages: ", countPages())
                    })
                    
                    #reactivity for get number page
                    numberPage <- reactive({
                        if (is.null(input$pages)) {
                            1
                        } else {
                            if (input$pages > countPages()) {
                                countPages()
                            } else {
                                input$pages
                            }
                        }
                    })
                    
                    #reactivity for get start and finish position of cars for view
                    rangePosition <- reactive({
                        start = (numberPage() - 1) * input$countCars + 1
                        if (numberPage() * input$countCars > total) {
                            finish = total
                        } else {
                            finish = numberPage() * input$countCars
                        }
                        
                        c("start" = start, "finish" = finish)
                    })
                    
                    #numericInput for select page of car's list
                    output$pageControls <- renderUI({
                        numericInput("pages", "Number of page:", numberPage(), min = 1, max = countPages())
                    })
                    
                    #rename columns for good showing
                    names(cars) <- c("brand" = "Brand", "model" = "Model", "market_price" = "Market price", "year" = "Year")
                    #row names for cars set NULL = row names get started from 1
                    rownames(cars) <- NULL
                    #and return list of cars
                    head(cars[rangePosition()["start"]:rangePosition()["finish"],], n = countCars())
                    
                }
            }
        })

    }
)