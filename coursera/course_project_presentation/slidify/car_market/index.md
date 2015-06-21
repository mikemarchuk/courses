---
title       : Car Market Shiny Application
subtitle    : Course Project
author      : Mike Marchuk
job         : Developing Data Products, Coursera
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## General description

My shiny application is a simple example of selection of car on the market. Of course, it does not reflect the real situation in the market and does not represent all possible lineup of cars.

Shiny application consists of two files - <span class="bold">server.R</span> and <span class="bold">ui.R</span>. 

File <span class="bold italic">ui.R</span> intended to describe the user interface through which the user interacts with the application.
File <span class="bold italic">server.R</span> actually implements the logic of the application and loads the required data (once).

--- .functionality

## Functionality

To display a list of cars must select the brand and model. Brands and models related: model list is filled with the chosen brand.
<p class="name_elem">Range of market price</p>
Limits the market price of the car. Properties: minimum value = 100,000, maximum value = 1,000,000, step = 20,000. Default values: 100,000 and 1,000,000.
<p class="name_elem">Range of years</p>
Limits on car production year. Properties: minimum value = 2013, maximum value = 2015, step = 1. Default values: 2013 and 2015.
<p class="name_elem">Number of cars to view</p>
Used to change the number of cars that appear in the list. Properties: minimum value = 5, maximum value = 20. Default value: 15.
<p class="name_elem">Number of page</p>
Used to navigate through the pages. NOTE: Will be displayed after the model selection.
<p class="name_elem">Other information</p>
Above the list output the total number of cars and the number of pages.

---

## Example, part 1

The following shows a text description of the request to the server:

- brand: Chevrolet
- model: AVEO
- market price range: 100,000 - 1,000,000
- year of production: 2010 - 2012
- numbers of cars to view: 10
- numbers of page: 5

and...

--- &twocol_with_width

## Example, part 2

*** =left width:50%

so it will look like on form:

![image](assets/img/example.png)

*** =right width:50%

and the result is that the server returns:


```
##        Brand Model Market price Year
## 41 CHEVROLET  AVEO       200000 2012
## 42 CHEVROLET  AVEO       195000 2012
## 43 CHEVROLET  AVEO       180000 2012
## 44 CHEVROLET  AVEO       180000 2012
## 45 CHEVROLET  AVEO       180000 2012
## 46 CHEVROLET  AVEO       180000 2012
## 47 CHEVROLET  AVEO       170000 2012
## 48 CHEVROLET  AVEO       170000 2012
## 49 CHEVROLET  AVEO       170000 2011
## 50 CHEVROLET  AVEO       165000 2012
```

and some total values:


```
## [1] "Total:  229 Count pages:  23"
```

---

## P.S.

Presentation created within the course project at class "Developing Data Products".
