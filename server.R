shinyServer(function(input, output) {

  output$main_plot <- renderPlot({

    source("playoff_simulation.R")

    series.format = gsub(' ', '', input$series_format)
    series.format = strsplit(series.format, ',')[[1]]

    home_ice_swing = input$p_homeice / 2

    plot_series_results(plot_function_series.format           = series.format,
                        plot_function_teamA.name              = input$teamA, 
                        plot_function_teamB.name              = input$teamB,
                        plot_function_p.teamA                 = input$p_teamA, 
                        plot_function_p.home.ice              = home_ice_swing, 
                        plot_function_how.many.wins.teamA.has = input$teamA_wins, 
                        plot_function_how.many.wins.teamB.has = input$teamB_wins, 
                        plot_function_n.simulations           = input$n_simulations)

  })
})