createdb group11
psql group11 

CREATE TABLE electric_vehicles (
Municipality VARCHAR(50) NOT NULL, 
County VARCHAR(50) NOT NULL, 
Year VARCHAR(4) NOT NULL, 
Total_personal_vehicles VARCHAR(15) NOT NULL, 
Number_of_EVs VARCHAR(10) NOT NULL, 
Percent_of_EVs VARCHAR(10) NOT NULL, 
PRIMARY KEY(Municipality, County, Year)
);

\copy electric_vehicles FROM '/home/lion/cab-project-11/Datasets/Revised_Electric_Vehicle_Ownership_Data.csv' WITH (FORMAT CSV, HEADER true, DELIMITER ',');

CREATE TABLE solar_installations (
Municipality VARCHAR(50) NOT NULL, 
County VARCHAR(50) NOT NULL, 
Year VARCHAR(4) NOT NULL, 
Commercial VARCHAR(10), 
Residential VARCHAR(10),
Other VARCHAR(10), 
Total_num_installations VARCHAR(15) NOT NULL, 
Total_size_of_system VARCHAR(15) NOT NULL, 
PRIMARY KEY(Municipality, County, Year)
);

\copy solar_installations FROM '/home/lion/cab-project-11/Datasets/Revised_Version of Solar_Installation_Data.csv' WITH (FORMAT CSV, HEADER true, DELIMITER ',');

CREATE TABLE municipality_data (
County VARCHAR(50) NOT NULL, 
Municipality VARCHAR(50) NOT NULL, 
PRIMARY KEY(Municipality, County)
);

\copy municipality_data FROM '/home/lion/cab-project-11/Datasets/Revised_Municipalities_of_New_Jersey.csv' WITH (FORMAT CSV, HEADER true, DELIMITER ',');

CREATE TABLE energy_data (
Municipality VARCHAR(50) NOT NULL, 
County VARCHAR(50) NOT NULL, 
Year VARCHAR(4) NOT NULL,
Residential_electricity VARCHAR(20),
Commercial_electricity VARCHAR(20),
Industrial_electricity VARCHAR(20),
Street_lighting_electricity VARCHAR(20),
Total_electricity VARCHAR(20),
Utility VARCHAR(10),
Residential_NaturalGas VARCHAR(20),
Commercial_Natural_Gas VARCHAR(20),
Industrial_Natural_Gas VARCHAR(20),
Street_Lighting_Natural_Gas VARCHAR(20),
Total_Natural_Gas VARCHAR(20),
PRIMARY KEY(Municipality, County, Year)
);

\copy energy_data FROM '/home/lion/cab-project-11/Datasets/Revised_Energy_Data.csv' WITH (FORMAT CSV, HEADER true, DELIMITER ',');





