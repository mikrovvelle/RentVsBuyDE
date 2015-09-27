library(shiny)

# pageWithSidebar(headerPanel, sidebarPanel, mainPanel)

shinyUI(
  fluidPage(
    headerPanel("Buying vs. Renting")
    
     
     
    ,sidebarPanel(h3("Costs"),
                  h4("Scenario duration"),
                  numericInput('years', 'Years at fixed rate', 10, min = 1, max = 50, step = 1),
                  
                  h4("Purchase costs"),
                  numericInput('price', "Purchase Price of home", 500000, max = 10000000, min = 0, step = 1e4),
                  numericInput('maintenance', "Estimated yearly maintenance", 5000, min = 0, max = 1e5, step = 1e3),
                  numericInput('downpayment', "Down Payment", 25000, min = 0, max = 1e6, step = 1000),
                  sliderInput('ir1', "Interest rate", value = 3, min = 0, max = 19, step = 0.01),
                  sliderInput('tg1', "Yearly pay-down ('Tilgung', %)", value = 0.5, min = 0.25, max = 4, step = 0.25),
                  sliderInput('appreciation', "Estimated appreciation (%/yr)", value = 1.5, min = -10, max = 15, step = 0.1),

                  h4("Rent terms"),
                  numericInput('rent', 'Monthly Rent', 1500, min = 0, max = 10000, step = 10),
                  numericInput('payin', 'Monthly market investment', value = 100, min = 0, max = 10000, step = 50),
                  sliderInput('market', 'Expected annual market return (%)', 3, min = -10, max = 20, step = 0.1),
                  sliderInput('rentHike', 'Expected annual rent hike (%)', value = 1, min = 0, max = 8, step = 0.5),

                  hr(),
                  h4("Additional purchasing costs"),
                  sliderInput('realtorRate', "Realtor's fee (%)", value = 5.95, max = 20, min = 0, step = 0.01),
                  sliderInput('notarRate', "Notar rate (%)", value = 1.5, max = 3, min = 0, step = 0.1),
                  sliderInput('txTax', "Transaction tax (%)", value = 6, max = 8, min = 3, step = 0.1),
                  sliderInput('propTax', "Property tax (%/yr)", value = 1.4, min = 0, max = 10, step = 0.01),
                  sliderInput('inflation', 'Expected annual inflation (%)', value = 1.5, min = -5, max = 15, step = 0.1)
                  )

    ,mainPanel(
      p("Compare financial outcomes of renting vs. buying in Germany."),
      p("Adjust the figures to show realistic fincancial scenarios, and compare the outcomes in the results tables."),
      tabsetPanel(
        tabPanel("Results",
        
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
                )
      ,tabPanel("Help",
        p("Is it worth it to own your own home? Although"),

        tabsetPanel(
          tabPanel("Variables",
          h4("Years at fixed rate"), p("The scenario compares the two financial outcomes after the same period of time.
            German loans are usually 5, 10 or 15 years in duration."),

          h3("Purchase terms"),
          h4("Purchase price"), p("This is the official price of the home.
            Additional costs like realtor premiums, closing costs (German 'Notar' fees), and taxes are adjustable in the
            sliders further down the sidebar panel."),
          h4("Estimated yearly maintenance"), p("This is an estimate of recurring costs that go into owning the home.
            This could include communal fees, repair efforts, insurance, etc."),
          h4("Interest rate, Yearly pay-down"), p("German loans often don't pay-off completely within their duration.
            Instead, they include a 'pay-down' ('Tilgung'), which reduces the principle owed by a certain percent each year."),
            p("For example, a typical Tilgung of 2%, would result in 20% of the principle being paid off after 10 years."),
          h4("Estimated appreciation"), p("This is your estimate of how much the price of the real estate will increase each year.
            This doesn't have to be positive—sometimes real estate prices go down."),
          h3("Additional purchase terms (further down)"),
            p("German real estate purchases include significant transaction costs. These costs are usually fixed and unavoidable.
              The sliders at the bottom of the sidebar have their default values set to the typical rates."),
          h4("Realtor's fee"), p("Usually the buyer pays the realtor a premium of 5.95%, enforced by a contract with the seller."),
          h4("Notar rate"), p("Every major property transaction must be cleared by a designated 'Notar'.
            The cost for this service is a non-negotiable 3% of the property's value, split between buyer and seller."),
          h4("Transaction tax"), p("This is a one-time tax, that varies by state. It usually runs at 3-7% of the property's value."),
          h4("Property tax"), p("This is a yearly tax to the property owner based on its value.
            (Terms for these taxes vary substationally in different areas)"),

          h3("Rent terms"),
          h4("Rent"), p("No surprises here. This is what you would pay a landlord each month to live in your apartment.
            Entry-level price for a major German city is about 1200 EUR."),
          h4("Monthly market investment"), p("Since you're not sinking your money into your home, you should probably be 
            investing that money somewhere else. This is your monthly contribution to an alternative investment,
             like the stock market."),
          h4("Expected annual market return"), p("This is your estimate of how well your alternative investment will perform,
            in % per year.")
          )
        )
        )
      ))))
              
