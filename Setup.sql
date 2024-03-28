Create TABLE Location(
    Location_id int PRIMARY KEY NOT NULL,
    Locationname VARCHAR(255) NOT NULL
);

Create TABLE Results(
    Results_id int PRIMARY KEY NOT NULL,
    Score int NOT NULL DEFAULT 0,
    Prizemoney MONEY NOT NULL
);

Create TABLE Participant(
    Participant_id int PRIMARY KEY NOT NULL,
    firstname VARCHAR(32) NOT NULL,
    lastname VARCHAR(32) NOT NULL,
    email VARCHAR(64) NOT NULL,
    address VARCHAR(128) NOT NULL
)

Create TABLE Teams(
    Teams_id int PRIMARY KEY NOT NULL,
    Participant_id int NOT NULL,
    teamname VARCHAR(255) NOT NULL UNIQUE,
    quantity int NOT NULL CHECK (quantity>0),
    FOREIGN KEY (Participant_id) REFERENCES Participant (Participant_id)
);

Create TABLE Competition(
    Competition_id int PRIMARY KEY NOT NULL,
    Location_id int NOT NULL,
    Teams_id int NOT NULL,
    Results_id int NOT NULL,
    date TIMESTAMP NOT NULL,
    FOREIGN KEY (Location_id) REFERENCES Location (Location_id),
    FOREIGN KEY (Teams_id) REFERENCES Teams (Teams_id),
    FOREIGN KEY (Results_id) REFERENCES Results (Results_id)
);

Create TABLE Sport(
    Cybersport_id int PRIMARY KEY NOT NULL,
    Competition_id int NOT NULL,
    Cybersportname VARCHAR(128) NOT NULL,
    FOREIGN KEY (Competition_id) REFERENCES Competition (Competition_id)
);


