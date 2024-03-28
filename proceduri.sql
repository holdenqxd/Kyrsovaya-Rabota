CREATE PROCEDURE UpdateLocationCascade(
    IN p_Location_id INT,
    IN p_NewLocationName VARCHAR(255)
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Location
    SET Locationname = p_NewLocationName
    WHERE Location_id = p_Location_id;

    UPDATE Competition
    SET Location_id = p_Location_id
    WHERE Location_id = p_Location_id;
END;
$$;

CREATE PROCEDURE UpdateResultsCascade(
    IN p_Results_id INT,
    IN p_NewScore INT,
    IN p_NewPrizeMoney MONEY
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Results
    SET Score = p_NewScore,
        Prizemoney = p_NewPrizeMoney
    WHERE Results_id = p_Results_id;

    UPDATE Competition
    SET Results_id = p_Results_id
    WHERE Results_id = p_Results_id;
END;
$$;

CREATE PROCEDURE UpdateTeamCascade(
    IN p_Teams_id INT,
    IN p_NewTeamName VARCHAR(255),
    IN p_NewQuantity INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Teams
    SET teamname = p_NewTeamName,
        quantity = p_NewQuantity
    WHERE Teams_id = p_Teams_id;

    UPDATE Competition
    SET Teams_id = p_Teams_id
    WHERE Teams_id = p_Teams_id;
END;
$$;

CREATE PROCEDURE DeleteLocationCascade(
    IN p_Location_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM Competition
    WHERE Location_id = p_Location_id;

    DELETE FROM Location
    WHERE Location_id = p_Location_id;
END;
$$;

CREATE PROCEDURE DeleteResultsCascade(
    IN p_Results_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM Competition
    WHERE Results_id = p_Results_id;

    DELETE FROM Results
    WHERE Results_id = p_Results_id;
END;
$$;

CREATE PROCEDURE DeleteTeamCascade(
    IN p_Teams_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM Competition
    WHERE Teams_id = p_Teams_id;

    DELETE FROM Teams
    WHERE Teams_id = p_Teams_id;
END;
$$;

CREATE FUNCTION add_results_on_competition_insert()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Results WHERE Results_id = NEW.Results_id) THEN
        INSERT INTO Results (Results_id, Score, Prizemoney) VALUES (NEW.Results_id, 0, 0.00);
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER add_results_trigger
BEFORE INSERT ON Competition
FOR EACH ROW
EXECUTE FUNCTION add_results_on_competition_insert();

CREATE FUNCTION add_participant_to_team()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Teams WHERE Participant_id = NEW.Participant_id) THEN
        INSERT INTO Teams (Participant_id, teamname, quantity) VALUES (NEW.Participant_id, 'Default Team', 1);
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER add_participant_to_team_trigger
AFTER INSERT ON Participant
FOR EACH ROW
EXECUTE FUNCTION add_participant_to_team();

CREATE FUNCTION check_competition_insert()
RETURNS TRIGGER AS $$
BEGIN
    IF (SELECT COUNT(*) FROM Teams WHERE Teams_id = NEW.Teams_id) > 10 THEN
        RAISE EXCEPTION 'The number of teams for the competition exceeds the limit of 10';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM Location WHERE Location_id = NEW.Location_id) THEN
        RAISE EXCEPTION 'The specified location for the competition does not exist';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_competition_insert_trigger
BEFORE INSERT ON Competition
FOR EACH ROW
EXECUTE FUNCTION check_competition_insert();