#' Function to save shot data into csv file, default in your working directory
#' @param season a character string
#' @param playerId a character string
#' @param path a character string
#' @import httr jsonlite readr
#' @export
download_shotdata <- function(season, playerId, path = getwd()){
  headers = c(
    `Connection` = 'keep-alive',
    `Accept` = 'application/json, text/plain, */*',
    `x-nba-stats-token` = 'true',
    `X-NewRelic-ID` = 'VQECWF5UChAHUlNTBwgBVw==',
    `User-Agent` = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.87 Safari/537.36',
    `x-nba-stats-origin` = 'stats',
    `Sec-Fetch-Site` = 'same-origin',
    `Sec-Fetch-Mode` = 'cors',
    `Referer` = 'https://stats.nba.com/players/leaguedashplayerbiostats/',
    `Accept-Encoding` = 'gzip, deflate, br',
    `Accept-Language` = 'en-US,en;q=0.9'
  )

  url1 <- "https://stats.nba.com/stats/shotchartdetail?AheadBehind=&CFID=33&CFPARAMS="
  url2 <- "&ClutchTime=&Conference=&ContextFilter=&ContextMeasure=FGA&DateFrom=&DateTo=&Division=&EndPeriod=10&EndRange=28800&GROUP_ID=&GameEventID=&GameID=&GameSegment=&GroupID=&GroupMode=&GroupQuantity=5&LastNGames=0&LeagueID=00&Location=&Month=0&OnOff=&OpponentTeamID=0&Outcome=&PORound=0&Period=0&PlayerID="
  url3 <- "&PlayerID1=&PlayerID2=&PlayerID3=&PlayerID4=&PlayerID5=&PlayerPosition=&PointDiff=&Position=&RangeType=0&RookieYear=&Season="
  url4 <- "&SeasonSegment=&SeasonType=Regular+Season&ShotClockRange=&StartPeriod=1&StartRange=0&StarterBench=&TeamID=0&VsConference=&VsDivision=&VsPlayerID1=&VsPlayerID2=&VsPlayerID3=&VsPlayerID4=&VsPlayerID5=&VsTeamID="

  url <- paste0(url1, season, url2, playerId, url3, season, url4)
  res <- httr::GET(url = url, httr::add_headers(.headers=headers))
  json_resp <- jsonlite::fromJSON(httr::content(res, "text"))
  df <- data.frame(json_resp$resultSets$rowSet[1])
  colnames(df) <- json_resp[["resultSets"]][["headers"]][[1]]

  file <- paste0(path, "/data.csv")
  readr::write_csv(df, file)
}
