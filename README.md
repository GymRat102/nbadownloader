
<!-- README.md is generated from README.Rmd. Please edit that file -->

# nbadownloader

<!-- badges: start -->
<!-- badges: end -->

This R package, nbadownloader, is a utility package that helps you
download nba data from stat.nba.com easily.

## Installation

You can install the released version of nbadownloader from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("nbadownloader")
```

There’s no version of nbadownloader on CRAN. You can install the
development version from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("GymRat102/nbadownloader")
```

## Example

This is a basic example which shows you how to fetch Luka Doncic’s shot
data in 2019-20 season and return a dataframe in your R environment:

``` r
library(nbadownloader)

## 1629029 is Luka's playerId, which you need to look up on stat.nba.com by your own at this stage.
Luka_shotdata_201920 <- get_shotdata("2019-20", "1629029") 
```

The returned dataframe is like this:

``` r
> glimpse(Luka_shotdata_201920)

Rows: 1,255
Columns: 24
$ GRID_TYPE           <chr> "Shot Chart Detail", "Shot Chart Detail", "Shot Chart Detail", "Shot Chart Detail", "Shot Chart Detail", "S…
$ GAME_ID             <chr> "0021900009", "0021900009", "0021900009", "0021900009", "0021900009", "0021900009", "0021900009", "00219000…
$ GAME_EVENT_ID       <chr> "9", "14", "35", "61", "95", "248", "260", "291", "319", "335", "342", "364", "375", "395", "441", "444", "…
$ PLAYER_ID           <chr> "1629029", "1629029", "1629029", "1629029", "1629029", "1629029", "1629029", "1629029", "1629029", "1629029…
$ PLAYER_NAME         <chr> "Luka Doncic", "Luka Doncic", "Luka Doncic", "Luka Doncic", "Luka Doncic", "Luka Doncic", "Luka Doncic", "L…
$ TEAM_ID             <chr> "1610612742", "1610612742", "1610612742", "1610612742", "1610612742", "1610612742", "1610612742", "16106127…
$ TEAM_NAME           <chr> "Dallas Mavericks", "Dallas Mavericks", "Dallas Mavericks", "Dallas Mavericks", "Dallas Mavericks", "Dallas…
$ PERIOD              <chr> "1", "1", "1", "1", "1", "2", "2", "2", "2", "2", "2", "3", "3", "3", "3", "3", "3", "3", "4", "1", "1", "1…
$ MINUTES_REMAINING   <chr> "11", "11", "9", "6", "4", "6", "5", "3", "1", "0", "0", "11", "10", "9", "5", "4", "3", "1", "1", "10", "6…
$ SECONDS_REMAINING   <chr> "37", "12", "11", "51", "35", "24", "32", "16", "38", "32", "2", "1", "4", "8", "7", "35", "26", "35", "0",…
$ EVENT_TYPE          <chr> "Made Shot", "Missed Shot", "Missed Shot", "Missed Shot", "Made Shot", "Made Shot", "Made Shot", "Missed Sh…
$ ACTION_TYPE         <chr> "Driving Finger Roll Layup Shot", "Running Finger Roll Layup Shot", "Jump Shot", "Turnaround Fadeaway Bank …
$ SHOT_TYPE           <chr> "2PT Field Goal", "2PT Field Goal", "3PT Field Goal", "2PT Field Goal", "2PT Field Goal", "3PT Field Goal",…
$ SHOT_ZONE_BASIC     <chr> "Restricted Area", "Restricted Area", "Above the Break 3", "In The Paint (Non-RA)", "In The Paint (Non-RA)"…
$ SHOT_ZONE_AREA      <chr> "Center(C)", "Center(C)", "Right Side Center(RC)", "Left Side(L)", "Center(C)", "Left Side Center(LC)", "Ri…
$ SHOT_ZONE_RANGE     <chr> "Less Than 8 ft.", "Less Than 8 ft.", "24+ ft.", "8-16 ft.", "Less Than 8 ft.", "24+ ft.", "24+ ft.", "24+ …
$ SHOT_DISTANCE       <chr> "1", "1", "24", "9", "4", "25", "25", "26", "0", "2", "0", "24", "1", "26", "6", "25", "1", "27", "27", "2"…
$ LOC_X               <dbl> -16, -11, 97, -68, 42, -174, 84, 41, 0, -12, 6, -70, 13, 24, 3, -152, -14, -136, 79, 8, 2, 24, 30, 19, 104,…
$ LOC_Y               <dbl> 7, 10, 228, 73, 8, 180, 243, 265, -6, 23, 6, 235, 10, 262, 61, 201, 5, 235, 263, 28, 315, 14, 153, 5, 226, …
$ SHOT_ATTEMPTED_FLAG <chr> "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1…
$ SHOT_MADE_FLAG      <chr> "1", "0", "0", "0", "1", "1", "1", "0", "1", "1", "1", "1", "1", "0", "1", "1", "1", "0", "0", "0", "0", "1…
$ GAME_DATE           <chr> "20191023", "20191023", "20191023", "20191023", "20191023", "20191023", "20191023", "20191023", "20191023",…
$ HTM                 <chr> "DAL", "DAL", "DAL", "DAL", "DAL", "DAL", "DAL", "DAL", "DAL", "DAL", "DAL", "DAL", "DAL", "DAL", "DAL", "D…
$ VTM                 <chr> "WAS", "WAS", "WAS", "WAS", "WAS", "WAS", "WAS", "WAS", "WAS", "WAS", "WAS", "WAS", "WAS", "WAS", "WAS", "W…
```

The dataframe includes tons of information about every shot, especially
x, y coordinates. You can draw a super simple shot chart with the help
of ggplot2:

``` r
Luka_shotdata_201920$LOC_X <- as.numeric(as.character(Luka_shotdata_201920$LOC_X))
Luka_shotdata_201920$LOC_Y <- as.numeric(as.character(Luka_shotdata_201920$LOC_Y))

Luka_shotdata_201920 %>% 
  ggplot(aes(x = LOC_X, y = LOC_Y)) + 
  geom_point() +
  coord_equal()
```

<img src="https://i.imgur.com/dg11bIr.png" width="100%" />

