library(shiny)

source("irTools.r")

shinyServer(
  function(input, output) {
    output$inputValue <- renderPrint({input$id1})
    output$downPaymentAbs <- renderPrint(input$downPaymentPct1 * input$nominalPrice / 100)
    
    buyReport <- reactive({
      getBuyReport(
        price = input$price,
        years = input$years,
        downpayment = input$downpayment,
        appreciation = 0.01 * input$appreciation,
        tilgung = 0.01 * input$tg1,
        ir = 0.01 * input$ir1,
        realtorRate = 0.01 * input$realtorRate,
        notarRate = 0.01 * input$notarRate,
        txTaxRate = 0.01 * input$txTax,
        propTaxRate = 0.01 * input$propTax,
        maintenanceCost = input$maintenance,
        inflationRate = 0.01 * input$inflation
        )})

    rentReport <- reactive({
      getRentReport(
        input$rent,
        input$years,
        0.01*input$rentHike,
        0.01*input$market,
        input$payin
        )})

    # buy key figures
    output$debug <- renderPrint({buyReport()})
    output$totalCost <- renderText({buyReport()$totalCost})
    output$endValue <- renderText({buyReport()$endValue})
    output$buyAvgMPayment <- renderText({sum(buyReport()$payments)/(12*input$years)})
    output$buyCashEarned <- renderText({buyReport()$cashEarned})
    output$buyPctEarned <- renderText({buyReport()$percentEarned})
    output$buyAnnualEarning <- renderText({buyReport()$annualEarning})
    output$buyTable <- renderTable({
      data.frame(
        Total.Spent = buyReport()$totalCost
        ,Total.Value = buyReport()$endValue
        ,Net.Gain = buyReport()$cashEarned
        ,Percent.Earned = buyReport()$percentEarned
        ,Annual.Earning = buyReport()$annualEarning
        )
    })


    # rent key figures
    output$rentAvgMPayment <- renderText({
      (rentReport()$totalRentPaid + rentReport()$marketSpending) / (12*input$years)
    })
    output$totalInvested <- renderText({rentReport()$marketSpending})
    output$totalRentSpending <- renderText({
      rentReport()$totalRentPaid + rentReport()$marketSpending
    })

    output$rentCashEarned <- renderText({rentReport()$cashEarned})
    output$rentPctEarned <- renderText({rentReport()$percentEarned})
    output$rentAnnualEarning <- renderText({rentReport()$annualEarning})
    output$rentTable <- renderTable({
      data.frame(
        Total.Spent = rentReport()$totalCost
        ,Total.Value = rentReport()$totalMktEarnings
        ,Net.Gain = rentReport()$cashEarned
        ,Percent.Earned = rentReport()$percentEarned
        ,Annual.Earning = rentReport()$annualEarning
        )
    })
  }
  )
