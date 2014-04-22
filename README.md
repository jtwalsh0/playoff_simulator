Playoff Simulator
==================

This script uses simulation to estimate the probability of one team beating another in a playoff series and to plot the results.  The user can choose the following inputs: 

 1.  `series.format` is a vector of As and Bs to define [the format of the playoff series](en.wikipedia.org/wiki/Playoff_format).  The default is 2-2-1-1-1 ("A", "A", "B", "B", "A", "B", "A"), but user can define a series with any odd-numbered length.  For example, a 2-3-2 format would be ("A", "A", "B", "B", "B", "A", "A"), a 2-1 format would be ("A", "A", "B"), and a 0-5 (all games at team B's ice) would be ("B", "B", "B", "B", "B").
 2.  `teamA.name` is the name of the team with home-ice advantage (that is, the 7th game is played there)
 3.  `teamB.name` is the name of the team without home-ice advantage
 4.  `p.teamA` is the probability that team A beats team B on neutral ice
 5.  `p.home.ice` is the increased probability that team A beats team B on team A's ice and the probability that team B beats team A on team B's ice.  The default is 0.04, which was the single-game home-ice advantage in 2013 ([citation](http://www.sportingcharts.com/nhl/stats/team-home-and-away-winning-percentages/2013/)).
 6.  `how.many.wins.teamA.has` enables the user to simulate from the middle of a series; that is, team A starts with 0, 1, 2, 3, or 4 wins
 7.  `how.many.wins.teamB.has` enables the user to simulate from the middle of a series; that is, team B starts with 0, 1, 2, 3, or 4 wins
 8.  `n.simulations` is the number of series we would like to simulate for each `p.teamA`.  The more simulations we use, the more precise our estimates will be but the longer the estimate takes to finish.

The script plots the results.  Here is a plot for the 2014 Boston-Detroit series before game 1 assuming Boston would win 62% of its games against Detroit on neutral ice (I derived this number from the Vegas odds) and a home-ice advantage of 4%.  I used 10,000 simulations:

![Boston-Detroit series](https://raw.githubusercontent.com/jtwalsh0/home_ice_advantage/master/Boston-Detroit%20series%20before%20game%201.png)
