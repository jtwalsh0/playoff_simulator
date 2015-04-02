#################################
##                             ##
##      HOME-ICE SIMULATOR     ##
##                             ##
##         Joestradamus        ##
##     http://joestradam.us    ##
## https://github.com/jtwalsh0 ##
##        April 19, 2014       ##
##                             ##
#################################


## This script uses simulation to estimate the probability of one team beating
## another in a playoff series and to plot the results.  The user can choose the
## following inputs: 
##   - series format.  The user creates a character vector that lists the location of
##     each game.  The default is a 2-2-1-1-1 format: c("A", "A", "B", "B", "A", "B", "A").
##   - teamA.name is the name of the team with home-ice advantage (7th game played there)
##   - teamB.name is the name of the team without home-ice advantage
##   - p.teamA is the probability that team A beats team B on neutral ice
##   - p.home.ice is the increased probability that team A beats team B on team A's
##     ice and the probability that team B beats team A on team B's ice.  The 
##     default is 0.04, which was the single-game home-ice advantage in 2013 (see
##     http://www.sportingcharts.com/nhl/stats/team-home-and-away-winning-percentages/2013/).
##   - how.many.wins.teamA.has enables the user to simulate from the middle of a series, 
##     e.g. team A starts with 0, 1, 2, 3, or 4 wins.
##   - how.many.wins.teamB.has enables the user to simulate from the middle of a series, 
##     e.g. team B starts with 0, 1, 2, 3, or 4 wins.
##   - n.simulations is the number of series we would like to simulate for each p.teamA.
##     The more simulations we use, the more precise our estimates will be but the
##     longer the estimate takes to finish.
##
## The script creates a barplot of the results.


# Set the seed for replicability
set.seed(12345)


# Create a function that takes the probability of team A winning a game on neutral ice, how much 
# more likely home teams are to winning than if they were playing on neutral ice, and the number
# of simulations we want for each set of p.teamA as inputs.
function.probability.of.winning.series <- function(series.format=c("A", "A", "B", "B", "A", "B", "A"),
                                                   p.teamA=.5, 
                                                   p.home.ice=.04, 
                                                   how.many.wins.teamA.has=0,
                                                   how.many.wins.teamB.has=0,
                                                   n.simulations=10000){

  
  # How many games could there be in the series?  Five and seven are most 
  # common the major North American sports; seven is the default here.
  max.series.length <- length(series.format)

  # Playoff series should have an odd number of games.  Stop the script if 
  # max.series.length is even.
  if(max.series.length %% 2 == 0)  stop("The series should have an odd number of games.")

  # How many games does it take to win the series?
  min.series.length <- ceiling(max.series.length/2)

  
  # Matrix to store how many games each team won in a simulated series.
  # Each team starts with zero wins.
  series.results <- matrix(0, nrow=n.simulations, ncol=2)
    colnames( series.results ) <- c("TeamA", "TeamB")
  
    # We can simulate from the current state of the series, e.g. 0 games to 0, 1 game to 0,
    # 3 games to 1, 1 game to 3.
    series.results[,1] <- how.many.wins.teamA.has
    series.results[,2] <- how.many.wins.teamB.has
  
    # Neither team can start with more wins than it takes to win the series.
    # Stop the script if they do.
    if(how.many.wins.teamA.has > min.series.length)  stop("Team A cannot start with more wins than it takes to win the series.")
    if(how.many.wins.teamB.has > min.series.length)  stop("Team B cannot start with more wins than it takes to win the series.")
      
  # At the extremes (e.g. probability of sharks winning is .01 and home-ice
  # advantage is .03), the probabilities can top 1 or drop below 0.  Fix that.
  with.home.ice <- p.teamA + p.home.ice
    if( with.home.ice < 0 )  with.home.ice <- 0
    if( with.home.ice > 1 )  with.home.ice <- 1
  without.home.ice <- p.teamA - p.home.ice
    if( without.home.ice < 0 )  without.home.ice <- 0
    if( without.home.ice > 1 )  without.home.ice <- 1
    

  for(i in 1:n.simulations){
  
    # Cycle until a team wins four games
    while( (series.results[i,1] < min.series.length)  &  (series.results[i,2] < min.series.length) ){
  
      # Which game is about to be played?
      game.about.to.be.played <- sum(series.results[i,]) + 1
      
      # Figure out whether team A has home ice advantage, then simulate the game
      if(series.format[ game.about.to.be.played ] == 'A'){
        teamA.wins.the.game <- rbinom(n=1, size=1, prob=with.home.ice)
        if( teamA.wins.the.game == 1 ) series.results[i,1] <- series.results[i,1] + 1  else  series.results[i,2] <- series.results[i,2] + 1
      } else{
        teamA.wins.the.game <- rbinom(n=1, size=1, prob=without.home.ice)
        if( teamA.wins.the.game == 1 ) series.results[i,1] <- series.results[i,1] + 1  else  series.results[i,2] <- series.results[i,2] + 1
      }
        
    }
  
  }

  
  # Possible series outcomes
  possible.series.outcomes <- c( paste(min.series.length, 0:(min.series.length-1), sep="-"),
                                 paste((min.series.length-1):0, min.series.length, sep="-"))
  
  
  # Create a vector to save the estimates that we plan to return
  return_vector <- rep(NA, max.series.length+1)
    names(return_vector) <- possible.series.outcomes
  
  
  for(i in 1:length(return_vector)){
    
    teamA.wins.in.this.possible.series.outcome <- as.numeric( strsplit( names(return_vector[i]), "-")[[1]][1] )
    teamB.wins.in.this.possible.series.outcome <- as.numeric( strsplit( names(return_vector[i]), "-")[[1]][2] )
      
    return_vector[i] <- mean( series.results[,1]==teamA.wins.in.this.possible.series.outcome & 
                              series.results[,2]==teamB.wins.in.this.possible.series.outcome )

  }

  
  # Return the estimates
  return(return_vector)
  

}






## Plot relative frequency of series outcomes (sweeps, 4 games to 1, 3 games to 4, etc.)
plot_series_results <- function(plot_function_series.format           = c("A", "A", "B", "B", "A", "B", "A"),
                                plot_function_teamA.name              = "teamA", 
                                plot_function_teamB.name              = "teamB",
                                plot_function_p.teamA                 = .5, 
                                plot_function_p.home.ice              = .04, 
                                plot_function_how.many.wins.teamA.has = 0, 
                                plot_function_how.many.wins.teamB.has = 0, 
                                plot_function_n.simulations           = 10000){
  
  # Call the simulation function
  simulated_results <- function.probability.of.winning.series(series.format           = plot_function_series.format,
                                                              p.teamA                 = plot_function_p.teamA,
                                                              p.home.ice              = plot_function_p.home.ice, 
                                                              how.many.wins.teamA.has = plot_function_how.many.wins.teamA.has, 
                                                              how.many.wins.teamB.has = plot_function_how.many.wins.teamB.has, 
                                                              n.simulations           = plot_function_n.simulations)
  
  pr.teamA.wins.series <- round( sum(simulated_results[1:4]), 2)
  # Barplot the simulated results
  barplot(simulated_results,
          ylim=c(0,.25),  # Standardize size of y axis for easy comparison across multiple plots
          names.arg = names(simulated_results),
          main=paste(plot_function_teamA.name, "-", plot_function_teamB.name, "Series: Forecasted Before Game",
                     plot_function_how.many.wins.teamA.has + plot_function_how.many.wins.teamB.has + 1),
          sub=paste("Pr(" , plot_function_teamA.name, " wins the series) = ", pr.teamA.wins.series, sep=""),
          xlab=paste(plot_function_teamA.name, "wins -", plot_function_teamB.name, "wins", sep=" "),
          ylab="estimated probability")

}



## Calculate the Vegas implied probability from moneyline odds.  See this post for more:
## http://www.majorwager.com/forums/handicapping-think-tank/143403-moneyline-without-juice.html#post1195868.
## I use the average moneyline
calculate_teamA_Vegas_implied_probability <- function(teamA.moneyline, 
                                                      teamB.moneyline,
                                                      home.ice.advantage=.04){
  
  if(teamA.moneyline < 0)  teamA.win.probability <- -teamA.moneyline/(-teamA.moneyline + 100)  else   teamA.win.probability <- 100/(teamA.moneyline + 100)
  if(teamB.moneyline < 0)  teamB.win.probability <- -teamB.moneyline/(-teamB.moneyline + 100)  else   teamB.win.probability <- 100/(teamB.moneyline + 100)
  
  teamA_implied_probability <- teamA.win.probability / (teamA.win.probability + teamB.win.probability) - home.ice.advantage
  
  return(teamA_implied_probability)
  
}



# Example: Boston-Detroit series before game 3
# png("/Users/User/Desktop/Boston-Detroit before game 3.png",
#     width=7, height=7, units="in", res=200)

#   par(mfrow=c(3,1))

#   # Before game 1
#   plot_series_results(plot_function_series.format=c("A", "A", "B", "B", "A", "B", "A"),
#                       plot_function_teamA.name="Boston", 
#                       plot_function_teamB.name="Detroit", 
#                       plot_function_p.teamA=calculate_teamA_Vegas_implied_probability(teamA.moneyline=-214, 
#                                                                                       teamB.moneyline=172, 
#                                                                                       home.ice.advantage=.04), 
#                       plot_function_p.home.ice=.04, 
#                       plot_function_how.many.wins.teamA.has=0, 
#                       plot_function_how.many.wins.teamB.has=0, 
#                       plot_function_n.simulations=10000)

#   # Before game 2 (Detroit won the first game)
#   plot_series_results(plot_function_series.format=c("A", "A", "B", "B", "A", "B", "A"),
#                       plot_function_teamA.name="Boston", 
#                       plot_function_teamB.name="Detroit", 
#                       plot_function_p.teamA=calculate_teamA_Vegas_implied_probability(teamA.moneyline=-226, 
#                                                                                       teamB.moneyline=186, 
#                                                                                       home.ice.advantage=.04), 
#                       plot_function_p.home.ice=.04, 
#                       plot_function_how.many.wins.teamA.has=0, 
#                       plot_function_how.many.wins.teamB.has=1, 
#                       plot_function_n.simulations=10000)

#   # Before game 3 (Boston won the second game)
#   plot_series_results(plot_function_series.format=c("A", "A", "B", "B", "A", "B", "A"),
#                       plot_function_teamA.name="Boston", 
#                       plot_function_teamB.name="Detroit", 
#                       plot_function_p.teamA=calculate_teamA_Vegas_implied_probability(teamA.moneyline=-226, 
#                                                                                       teamB.moneyline=186, 
#                                                                                       home.ice.advantage=.04), 
#                       plot_function_p.home.ice=.04, 
#                       plot_function_how.many.wins.teamA.has=1, 
#                       plot_function_how.many.wins.teamB.has=1, 
#                       plot_function_n.simulations=10000)

# dev.off()
