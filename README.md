Playoff Simulator
==================

This script uses simulation to estimate the probability of one team beating another in a playoff series and to plot the results.  The user can choose the following inputs: 
 1.  `teamA.name` is the name of the first team.  By default, this should be the team with home-ice advantage (that is, the team who plays at home in the last game of the series).
 2.  `teamB.name` is the name of the other team.
 3.  `series.format` is a vector of As and Bs to define [the format of the playoff series](en.wikipedia.org/wiki/Playoff_format).  An "A" means that game is played on A's home ice, and a "B" means that game is played on B's home ice.  The default is 2-2-1-1-1 ("A", "A", "B", "B", "A", "B", "A"), but user can define a series with any odd-numbered length.  For example, a 2-3-2 format would be ("A", "A", "B", "B", "B", "A", "A"), a 2-1 format would be ("A", "A", "B"), and a 0-5 (all games at team B's ice) would be ("B", "B", "B", "B", "B").
 4.  `p.teamA` is the probability that team A beats team B on neutral ice.
 5.  `p.home.ice` is the increased probability that team A beats team B on team A's ice and the probability that team B beats team A on team B's ice.  The default is 0.04, which was the single-game home-ice advantage in 2013 ([citation](http://www.sportingcharts.com/nhl/stats/team-home-and-away-winning-percentages/2013/)).
 6.  `how.many.wins.teamA.has` enables the user to simulate from the middle of a series; for example, team A could start a seven-game series with 0, 1, 2, 3, or 4 wins.
 7.  `how.many.wins.teamB.has` enables the user to simulate from the middle of a series; for example, team B could start a seven-game series with 0, 1, 2, 3, or 4 wins.
 8.  `n.simulations` is the number of series we would like to simulate.  The more simulations we use, the more precise our estimates will be.  However, each simulation adds the same amount of processing time but less precision than the simulation before it, so we do not gain much by doing lots of simulations.  I have found that 10,000 simulations is more than enough for the typical seven-game forecast.

The script also includes a function that uses the Vegas moneyline to calculate the probability that one team beats another on neutral ice.  It takes the following arguments:
 1.  `teamA.moneyline` is the moneyline for the team with home-ice advantage (or either team, if the game is being played on neutral ice).
 2.  `teamB.moneyline` is the moneyline for the team without home-ice advantage.
 3.  `home.ice.advantage` is the assumed percentage-point increase that team A wins the game.  The default is .04, which I get [here](http://www.sportingcharts.com/nhl/stats/team-home-and-away-winning-percentages/2013/).
 

The script plots the results.  Here is a plot for the 2014 Boston-Detroit series before game 1 assuming Boston would win 62% of its games against Detroit on neutral ice (I derived this number from the Vegas odds) and a home-ice advantage of 4%.  I used 10,000 simulations:

![Boston-Detroit series](https://raw.githubusercontent.com/jtwalsh0/home_ice_advantage/master/Boston-Detroit%20series%20before%20game%201.png)
