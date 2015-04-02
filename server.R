shinyServer(function(input, output) {

  output$main_plot <- renderPlot({

    source("home-ice advantage.R")

    plot_series_results(plot_function_series.format           = input$series_format,
                        plot_function_teamA.name              = input$teamA, 
                        plot_function_teamB.name              = input$teamB,
                        plot_function_p.teamA                 = input$p_teamA, 
                        plot_function_p.home.ice              = input$p_homeice, 
                        plot_function_how.many.wins.teamA.has = input$teamA_wins, 
                        plot_function_how.many.wins.teamB.has = input$teamB_wins, 
                        plot_function_n.simulations           = input$n_simulations)


  })
})