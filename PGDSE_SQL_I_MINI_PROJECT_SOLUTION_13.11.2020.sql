#1.	Show the percentage of wins of each bidder in the order of highest to lowest percentage.
SELECT 
    ibd.bidder_id,
    (COUNT(ibd.bid_status) / ibp.no_of_bids * 100) AS Winning_Percentage
FROM
    ipl_bidding_details AS ibd
        JOIN
    ipl_bidder_points AS ibp ON ibd.BIDDER_ID = ibp.BIDDER_ID
WHERE
    ibd.BID_STATUS LIKE '%won%'
GROUP BY ibd.BIDDER_ID
ORDER BY winning_percentage DESC;
#----------------------------------------------------------------------------------
#2.	Display the number of matches conducted at each stadium with stadium name, city from the database.
SELECT 
    ips.stadium_id,
    ips.stadium_name,
    ips.city,
    COUNT(ims.match_id) AS No_Match_Conducted,
    ims.STATUS
FROM
    ipl_stadium AS ips
        JOIN
    ipl_match_schedule AS ims ON ips.STADIUM_ID = ims.STADIUM_ID
GROUP BY ips.STADIUM_ID
HAVING ims.status LIKE '%completed%'; 
#----------------------------------------------------------------------------------
#3.	In a given stadium, what is the percentage of wins by a team which has won the toss?

SELECT 
    ips.stadium_id,
    ips.STADIUM_NAME,
    im.TOSS_WINNER,
    im.MATCH_WINNER,
    (COUNT(im.toss_winner) / it.total_matches) * 100 AS winning_percentage
FROM
    ipl_match AS im
        JOIN
    ipl_match_schedule AS ims ON im.MATCH_ID = ims.MATCH_ID
        JOIN
    ipl_tournament AS it ON it.TOURNMT_ID = ims.TOURNMT_ID
        JOIN
    ipl_stadium AS ips ON ims.STADIUM_ID = ips.STADIUM_ID
WHERE
    im.TOSS_WINNER = im.MATCH_WINNER
GROUP BY ips.STADIUM_NAME
ORDER BY winning_percentage DESC;
#----------------------------------------------------------------------------------
#4.	Show the total bids along with bid team and team name.
SELECT 
    ibd.bid_team, COUNT(ibd.bidder_id) Total_bid, it.team_name
FROM
    ipl_bidding_details AS ibd
        JOIN
    ipl_team AS it ON ibd.BID_TEAM = it.TEAM_ID
GROUP BY it.TEAM_NAME;
#----------------------------------------------------------------------------------
#5.	Show the team id who won the match as per the win details.
SELECT 
    win_details,
    CASE
        WHEN match_winner = 1 THEN team_id1
        WHEN match_winner = 2 THEN team_id2
        ELSE 'tie'
    END AS 'Winning_Team_ID'
FROM
    ipl_match;
#----------------------------------------------------------------------------------
#6.	Display total matches played, total matches won and total matches lost by team along with its team name.
SELECT 
    it.team_id,
    it.team_name,
    SUM(ita.matches_played) AS Total_match_Played,
    SUM(ita.matches_won) AS Total_Match_Won,
    SUM(ita.matches_lost) AS Total_Match_Lost
FROM
    ipl_team AS it
        JOIN
    ipl_team_standings AS ita ON it.TEAM_ID = ita.TEAM_ID
GROUP BY it.TEAM_ID , it.TEAM_NAME
ORDER BY total_match_won DESC;
#----------------------------------------------------------------------------------
#7.	Display the bowlers for Mumbai Indians team.
SELECT 
    ip.player_id, ip.player_name, it.team_name, itp.player_role
FROM
    ipl_team AS it
        JOIN
    ipl_team_players AS itp ON it.TEAM_ID = itp.TEAM_ID
        JOIN
    ipl_player AS ip ON ip.PLAYER_ID = itp.PLAYER_ID
WHERE
    it.TEAM_NAME LIKE '%Mumbai%'
        AND itp.PLAYER_ROLE LIKE '%Bowler%';
#----------------------------------------------------------------------------------
#8.	How many all-rounders are there in each team, Display the teams with more than 4 all-rounder in descending order.
SELECT 
    it.team_id,
    it.team_name,
    itp.player_role,
    COUNT(itp.PLAYER_ROLE) AS Player_Role
FROM
    ipl_team AS it
        JOIN
    ipl_team_players AS itp ON it.TEAM_ID = itp.TEAM_ID
WHERE
    itp.PLAYER_ROLE LIKE '%All%'
GROUP BY it.TEAM_NAME
HAVING COUNT(itp.PLAYER_ROLE LIKE '%All%') > 4
ORDER BY player_role DESC;
#----------------------------------------------------------------------------------