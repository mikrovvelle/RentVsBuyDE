library(shiny)

# pageWithSidebar(headerPanel, sidebarPanel, mainPanel)

shinyUI(
  fluidPage(
    headerPanel("Buying vs. Renting")
    ,sidebarPanel(h3("Costs"),
                  h4("Living constraints"),
                  numericInput('years', 'Years at fixed rate', 10, min = 1, max = 50, step = 1),
                  
                  h4("Purchase costs"),
                  numericInput('price', "Purchase Price of home", 500000, max = 10000000, min = 0, step = 1e4),
                  numericInput('maintenance', "Estimated yearly maintenance", 5000, min = 0, max = 1e5, step = 1e3),

                  h4("Finance terms"),
                  numericInput('downpayment', "Down Payment", 25000, min = 0, max = 1e6, step = 1000),
                  sliderInput('ir1', "Interest rate", value = 3, min = 0, max = 19, step = 0.01),
                  sliderInput('tg1', "Yearly pay-down ('Tilgung', %)", value = 0.5, min = 0.25, max = 4, step = 0.25),
                  sliderInput('appreciation', "Estimated appreciation (%/yr)", value = 1.5, min = -10, max = 15, step = 0.1),

                  h4("Rent terms"),
                  numericInput('rent', 'Monthly Rent', 1500, min = 0, max = 10000, step = 10),
                  numericInput('payin', 'Monthly market investment', value = 100, min = 0, max = 10000, step = 50),
                  numericInput('market', 'Expected annual market return (%)', 4, min = -10, max = 20, step = 0.1),
                  sliderInput('rentHike', 'Expected annual rent hike (%)', value = 1, min = 0, max = 8, step = 0.5),

                  hr(),
                  h4("Additional purchasing costs"),
                  sliderInput('realtorRate', "Realtor's fee (%)", value = 5.69, max = 20, min = 0, step = 0.01),
                  sliderInput('notarRate', "Notar rate (%)", value = 1.5, max = 3, min = 0, step = 0.1),
                  sliderInput('txTax', "Transaction tax (%)", value = 6, max = 8, min = 3, step = 0.1),
                  sliderInput('propTax', "Property tax (%/yr)", value = 1.4, min = 0, max = 10, step = 0.01),
                  sliderInput('inflation', 'Expected annual inflation (%)', value = 1.5, min = -5, max = 15, step = 0.1)

                  )
    ,mainPanel("Compare financial outcomes of renting vs. buying in Germany.
      Adjust the figures to show realistic fincancial scenarios, and compare the outcomes in the tables below.",
              h3("Purchase scenario"),
              h4("Average Monthly Payment (purchasing)"),
                verbatimTextOutput("buyAvgMPayment"),
              h4("Final Balance (purchasing)"),
                tableOutput("buyTable"),

              hr(),
              h3("Rent scenario"),
              h4("Average Monthly Payment (renting)"),
                verbatimTextOutput("rentAvgMPayment"),
              h4("Final Balance (renting)"),
                tableOutput("rentTable"),
              h4("Total invested"),
                verbatimTextOutput("totalInvested")
                )))
              
