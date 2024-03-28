CREATE VIEW Participants_with_Location AS
SELECT p.Participant_id, p.firstname, p.lastname, p.email, p.address, l.Locationname
FROM Participant p
JOIN Teams t ON p.Participant_id = t.Participant_id
JOIN Competition c ON t.Teams_id = c.Teams_id
JOIN Location l ON c.Location_id = l.Location_id;

CREATE VIEW High_Score_Participants AS
SELECT p.Participant_id, p.firstname, p.lastname, p.email, p.address, r.Score
FROM Participant p
JOIN Teams t ON p.Participant_id = t.Participant_id
JOIN Competition c ON t.Teams_id = c.Teams_id
JOIN Results r ON c.Results_id = r.Results_id
WHERE r.Score > 100; 

CREATE VIEW Teams_in_Location AS
SELECT t.Teams_id, t.teamname, l.Locationname
FROM Teams t
JOIN Competition c ON t.Teams_id = c.Teams_id
JOIN Location l ON c.Location_id = l.Location_id;

CREATE VIEW Cybersport_Competition_Results AS
SELECT s.Cybersport_id, s.Cybersportname, c.date, r.Score, r.Prizemoney
FROM Sport s
JOIN Competition c ON s.Competition_id = c.Competition_id
JOIN Results r ON c.Results_id = r.Results_id;

CREATE VIEW TeamAverageScores AS
SELECT
    t.Teams_id,
    t.teamname,
    AVG(r.Score) AS AverageScore
FROM
    Teams t
INNER JOIN Competition c ON t.Teams_id = c.Teams_id
INNER JOIN Results r ON c.Results_id = r.Results_id
GROUP BY
    t.Teams_id, t.teamname;

CREATE VIEW CompetitionAverageScore AS
SELECT 
    c.Competition_id,
    AVG(r.Score) AS AverageScore
FROM 
    Competition c
JOIN Results r ON c.Results_id = r.Results_id
GROUP BY 
    c.Competition_id;

    CREATE VIEW CompetitionTeamCount AS
SELECT 
    Competition_id,
    COUNT(Teams_id) AS TeamCount
FROM 
    Competition
GROUP BY 
    Competition_id;

    CREATE VIEW LocationTeamCount AS
SELECT 
    l.Location_id,
    l.Locationname,
    COUNT(c.Teams_id) AS TeamCount
FROM 
    Location l
LEFT JOIN Competition c ON l.Location_id = c.Location_id
GROUP BY 
    l.Location_id, l.Locationname;

    CREATE VIEW LocationParticipantCount AS
SELECT 
    l.Location_id,
    l.Locationname,
    COUNT(DISTINCT t.Participant_id) AS ParticipantCount
FROM 
    Location l
LEFT JOIN Competition c ON l.Location_id = c.Location_id
LEFT JOIN Teams t ON c.Teams_id = t.Teams_id
GROUP BY 
    l.Location_id, l.Locationname;

CREATE VIEW ParticipantPrizeMoneyTotal AS
SELECT 
    p.Participant_id,
    p.firstname,
    p.lastname,
    p.email,
    p.address,
    SUM(r.Prizemoney) AS TotalPrizeMoney
FROM 
    Participant p
JOIN Teams t ON p.Participant_id = t.Participant_id
JOIN Competition c ON t.Teams_id = c.Teams_id
JOIN Results r ON c.Results_id = r.Results_id
GROUP BY 
    p.Participant_id, p.firstname, p.lastname, p.email, p.address;

   CREATE VIEW CompetitionAverageScore AS
SELECT 
    c.Competition_id,
    AVG(r.Score) AS AverageScore
FROM 
    Competition c
JOIN Results r ON c.Results_id = r.Results_id
GROUP BY 
    c.Competition_id;