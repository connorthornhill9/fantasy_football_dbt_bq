{{
    config(
        materialized='table'
    )
}}

SELECT
  plr.displayName AS tacklerName,
  ply.playDescription,
  tck.tackle,
  tck.assist,
  tck.pff_missedTackle,
  tck.forcedFumble,
  tck.gameId,
  tck.playId,
  gam.gameDate,
  gam.week,
  ply.quarter,
  ply.gameClock,
  ply.down,
  ply.yardlineNumber,
  ply.absoluteYardlineNumber,
  ply.playResult,
  ply.yardsToGo,
  ply.offenseFormation,
  ply.defendersInTheBox,
  ply.ballCarrierDisplayName AS ballCarrierName,
  gam.homeTeamAbbr,
  gam.visitorTeamAbbr
FROM `nfl_games_2024_bdb.tackles` tck 
LEFT JOIN `nfl_games_2024_bdb.plays` ply ON tck.playId = ply.playId AND tck.gameId = ply.gameId
LEFT JOIN `nfl_games_2024_bdb.players` plr ON tck.nflId = plr.nflId
LEFT JOIN `nfl_games_2024_bdb.games` gam ON ply.gameId = gam.gameId
WHERE ply.playNullifiedByPenalty = 'N'
ORDER BY tck.gameId, tck.playId