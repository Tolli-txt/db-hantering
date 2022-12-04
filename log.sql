CREATE TABLE Kvarter(id varchar(20) NOT NULL,
	kommun varchar(100),
	trakt varchar(100),
	block_nr int,
	enhet int,
	PRIMARY KEY (id)
);


CREATE TABLE Adress(id varchar(150) NOT NULL,
	kvarter_id varchar(20),
	gatunamn varchar(100),
	gatunummer int,
	PRIMARY KEY (id),
	FOREIGN KEY (kvarter_id) REFERENCES Kvarter(id)
);


CREATE TABLE Lägenhetshus(id varchar(20) NOT NULL,
	adress_id varchar(150) NOT NULL,
	ordnings_namn varchar(100),
	PRIMARY KEY (id),
	FOREIGN KEY (adress_id) REFERENCES Adress(id),
	CONSTRAINT unique_id UNIQUE (ordnings_namn)
);


CREATE TABLE Våningsplan(id varchar(100) NOT NULL,
	lägenhetshus_id varchar(20) NOT NULL,
	plan_nr varchar(50),
	PRIMARY KEY (id),
	FOREIGN KEY (lägenhetshus_id) REFERENCES Lägenhetshus(id),
	CONSTRAINT unique_plan_nr UNIQUE (plan_nr)
);


CREATE TABLE Lägenhet(id varchar(30) NOT NULL,
	våning_id varchar(100) NOT NULL,
	lgh_nr varchar(30),
	antal_rum int,
	area_kvm int,
	PRIMARY KEY (id),
	FOREIGN KEY (våning_id) REFERENCES Våningsplan(id),
	CONSTRAINT unique_lgh_nr UNIQUE (lgh_nr)
);


CREATE TABLE Avtal(id varchar(20) NOT NULL,
	lgh_id varchar(30) NOT NULL,
	månadshyra money,
	start_datum date,
	slut_datum date,
	årshyra money,
	PRIMARY KEY (id),
	FOREIGN KEY (lgh_id) REFERENCES Lägenhet(id)
);


CREATE TABLE Person(id varchar(30) NOT NULL,
	first_name varchar(100),
	last_name varchar(100),
	email varchar(100),
	telefon_nr varchar(30),
	avtal_id varchar(20),
	PRIMARY KEY (id),
	FOREIGN KEY (avtal_id) REFERENCES Avtal(id),
);

-- Time to add avtal_id to table Lägenhet + make it FK
ALTER TABLE Lägenhet
	ADD avtal_id varchar(20);
	
ALTER TABLE Lägenhet
	ADD FOREIGN KEY(avtal_id) REFERENCES Avtal(id);

-- Time to insert values into columns

INSERT INTO Kvarter (id, kommun, trakt, block_nr, enhet)
VALUES ('BJRN-1', 'Vallentuna', 'Björnen', 12, 10);

INSERT INTO Adress(id, kvarter_id, gatunamn, gatunummer)
VALUES ('BJRN-ADRESS-1', 'BJRN-1', 'Rosenlundsgatan', 10)

INSERT INTO Lägenhetshus(id, adress_id, ordnings_namn)
VALUES ('BJRN-HUS-1', 'BJRN-ADRESS-1', 'Björnen, Hus Trästocken')

INSERT INTO Våningsplan(id, lägenhetshus_id, plan_nr)
VALUES ('Trästocken-Vån-1', 'BJRN-HUS-1', 'Trästocken, plan #1')

--

INSERT INTO Lägenhet(id, våning_id, lgh_nr, antal_rum, area_kvm)
VALUES ('TRÄ-1101', 'Trästocken-Vån-1', 'TRÄ-LGH 1101', 3, 80);

INSERT INTO Lägenhet(id, våning_id, lgh_nr, antal_rum, area_kvm)
VALUES ('TRÄ-1102', 'Trästocken-Vån-1', 'TRÄ-LGH 1102', 2, 65);

INSERT INTO Lägenhet(id, våning_id, lgh_nr, antal_rum, area_kvm)
VALUES ('TRÄ-1103', 'Trästocken-Vån-1', 'TRÄ-LGH 1103', 4, 85);

INSERT INTO Lägenhet(id, våning_id, lgh_nr, antal_rum, area_kvm)
VALUES ('TRÄ-1104', 'Trästocken-Vån-1', 'TRÄ-LGH 1104', 2, 65);

-- Skapar avtal 1
INSERT INTO Avtal(id, lgh_id, månadshyra, start_datum, slut_datum, årshyra)
VALUES ('Avtal-TRÄ-1101', 'TRÄ-1101', 7000, '2022-06-25', '2025-12-25', 84000)

INSERT INTO Avtal(id, lgh_id, månadshyra, start_datum, slut_datum, årshyra)
VALUES ('Avtal-TRÄ-1102', 'TRÄ-1102', 5600, '2029-09-03', '2023-08-25', 67200)

INSERT INTO Avtal(id, lgh_id, månadshyra, start_datum, slut_datum, årshyra)
VALUES ('Avtal-TRÄ-1103', 'TRÄ-1103', 7300, '2022-06-25', '2025-06-25', 87600)

INSERT INTO Avtal(id, lgh_id, månadshyra, start_datum, slut_datum, årshyra)
VALUES ('Avtal-TRÄ-1104', 'TRÄ-1104', 5600, '2022-06-25', '2025-06-25', 67200)

-- Lägger till avtal till respektive lägenhet
UPDATE Lägenhet 
SET avtal_id = 'Avtal-TRÄ-1101'
WHERE id = 'TRÄ-1101';

UPDATE Lägenhet 
SET avtal_id = 'Avtal-TRÄ-1102'
WHERE id = 'TRÄ-1102';

UPDATE Lägenhet 
SET avtal_id = 'Avtal-TRÄ-1103'
WHERE id = 'TRÄ-1103';

UPDATE Lägenhet 
SET avtal_id = 'Avtal-TRÄ-1104'
WHERE id = 'TRÄ-1104';

-- 
INSERT INTO Person(id, first_name, last_name, email, telefon_nr, avtal_id)
VALUES ('19820416-5692', 'John', 'Alfredsson', 'john.a@gmail.com', '070 453 6783', 'Avtal-TRÄ-1101')

INSERT INTO Person(id, first_name, last_name, email, telefon_nr, avtal_id)
VALUES ('19851107-3674', 'Jessica', 'Göransson', 'j.goransson@gmail.com', '070 478-9321', 'Avtal-TRÄ-1101')

INSERT INTO Person(id, first_name, last_name, email, telefon_nr, avtal_id)
VALUES ('19900103-4583', 'Martin', 'Andersson', 'marand@gmail.com', '073 354 6782', 'Avtal-TRÄ-1102')

INSERT INTO Person(id, first_name, last_name, email, telefon_nr, avtal_id)
VALUES ('19650222-5783', 'Klas', 'Nordstörm', 'klas@hotmail.com', '070 563 4532', 'Avtal-TRÄ-1103')

INSERT INTO Person(id, first_name, last_name, email, telefon_nr, avtal_id)
VALUES ('19690222-5783', 'Carina', 'Nordstörm', 'carina-nordstorm@hotmail.com', '073 234 5998', 'Avtal-TRÄ-1104')

INSERT INTO Person(id, first_name, last_name, email, telefon_nr, avtal_id)
VALUES ('19720428-5647', 'Karl', 'Bergendahl', 'kalle-b@hotmail.com', '073 543 4332', 'Avtal-TRÄ-1104')

INSERT INTO Person(id, first_name, last_name, email, telefon_nr, avtal_id)
VALUES ('19820920-4568', 'Amanda', 'Bergendahl', 'amanda.bergendahl@hotmail.com', '073 678 5763', 'Avtal-TRÄ-1104')

--

INSERT INTO Våningsplan(id, lägenhetshus_id, plan_nr)
VALUES ('Trästocken-Vån-2', 'BJRN-HUS-1', 'Trästocken, plan #2')

-- 

INSERT INTO Lägenhet(id, våning_id, lgh_nr, antal_rum, area_kvm)
VALUES ('TRÄ-1201', 'Trästocken-Vån-2', 'TRÄ-LGH 1201', 2, 60);

INSERT INTO Lägenhet(id, våning_id, lgh_nr, antal_rum, area_kvm)
VALUES ('TRÄ-1202', 'Trästocken-Vån-2', 'TRÄ-LGH 1202', 1, 50);

INSERT INTO Lägenhet(id, våning_id, lgh_nr, antal_rum, area_kvm)
VALUES ('TRÄ-1203', 'Trästocken-Vån-2', 'TRÄ-LGH 1203', 5, 80);

INSERT INTO Lägenhet(id, våning_id, lgh_nr, antal_rum, area_kvm)
VALUES ('TRÄ-1204', 'Trästocken-Vån-2', 'TRÄ-LGH 1204', 2, 90);

--

INSERT INTO Avtal(id, lgh_id, månadshyra, start_datum, slut_datum, årshyra)
VALUES ('Avtal-TRÄ-1201', 'TRÄ-1201', 5500, '2019-11-25', '2025-12-25', 66000)

INSERT INTO Avtal(id, lgh_id, månadshyra, start_datum, slut_datum, årshyra)
VALUES ('Avtal-TRÄ-1202', 'TRÄ-1202', 4500, '2022-11-25', '2023-08-25', 54000)

INSERT INTO Avtal(id, lgh_id, månadshyra, start_datum, slut_datum, årshyra)
VALUES ('Avtal-TRÄ-1203', 'TRÄ-1203', 7000, '2022-11-25', '2025-12-25', 84000)

INSERT INTO Avtal(id, lgh_id, månadshyra, start_datum, slut_datum, årshyra)
VALUES ('Avtal-TRÄ-1204', 'TRÄ-1204', 8000, '2022-11-25', '2025-12-25', 96000)

--

UPDATE Lägenhet 
SET avtal_id = 'Avtal-TRÄ-1201'
WHERE id = 'TRÄ-1201';

UPDATE Lägenhet 
SET avtal_id = 'Avtal-TRÄ-1202'
WHERE id = 'TRÄ-1202';

UPDATE Lägenhet 
SET avtal_id = 'Avtal-TRÄ-1203'
WHERE id = 'TRÄ-1203';

UPDATE Lägenhet 
SET avtal_id = 'Avtal-TRÄ-1204'
WHERE id = 'TRÄ-1204';

--

INSERT INTO Person(id, first_name, last_name, email, telefon_nr, avtal_id)
VALUES ('19920416-7892', 'Jens', 'Ekdahl', 'jeek@gmail.com', '070 689 9223', 'Avtal-TRÄ-1201')

INSERT INTO Person(id, first_name, last_name, email, telefon_nr, avtal_id)
VALUES ('19920120-8821', 'Sofie', 'Ekdahl', 'sofie.ek@gmail.com', '070 878 8823', 'Avtal-TRÄ-1201')

INSERT INTO Person(id, first_name, last_name, email, telefon_nr, avtal_id)
VALUES ('19940323-4563', 'Sebastian', 'Sörensson', 'sebbe@gmail.com', '073 456 3821', 'Avtal-TRÄ-1202')

INSERT INTO Person(id, first_name, last_name, email, telefon_nr, avtal_id)
VALUES ('19850222-8782', 'Amelia', 'Ström', 'amelia@hotmail.com', '075 568 6932', 'Avtal-TRÄ-1203')

INSERT INTO Person(id, first_name, last_name, email, telefon_nr, avtal_id)
VALUES ('19830222-9281', 'Ian', 'Berglund', 'ian-berg@hotmail.com', '070 768 8798', 'Avtal-TRÄ-1203')

INSERT INTO Person(id, first_name, last_name, email, telefon_nr, avtal_id)
VALUES ('19780428-9891', 'Robert', 'Norberg', 'robnor@hotmail.com', '073 788 9787', 'Avtal-TRÄ-1204')

INSERT INTO Person(id, first_name, last_name, email, telefon_nr, avtal_id)
VALUES ('19820920-5674', 'Clara', 'Norberg', 'clara.norberg@hotmail.com', '073 763 6782', 'Avtal-TRÄ-1204')

-- KVARTER 1, HUS 1 = KLAR
-- TIME FOR NUMBA 2

INSERT INTO Kvarter (id, kommun, trakt, block_nr, enhet)
VALUES ('SKTN-1', 'Vallentuna', 'Skatan', 9, 3);

INSERT INTO Adress(id, kvarter_id, gatunamn, gatunummer)
VALUES ('SKTN-ADRESS-1', 'SKTN-1', 'Polhemsvägen', 42)

INSERT INTO Lägenhetshus(id, adress_id, ordnings_namn)
VALUES ('SKTN-HUS-1', 'SKTN-ADRESS-1', 'Skatan, Hus Fågelholken')

--

INSERT INTO Våningsplan(id, lägenhetshus_id, plan_nr)
VALUES ('Fågelholken-Vån-1', 'SKTN-HUS-1', 'Fågelholken, plan #1')

INSERT INTO Våningsplan(id, lägenhetshus_id, plan_nr)
VALUES ('Fågelholken-Vån-2', 'SKTN-HUS-1', 'Fågelholken, plan #2')

--

INSERT INTO Lägenhet(id, våning_id, lgh_nr, antal_rum, area_kvm)
VALUES ('FGL-1101', 'Fågelholken-Vån-1', 'FGL-LGH 1101', 2, 60);

INSERT INTO Lägenhet(id, våning_id, lgh_nr, antal_rum, area_kvm)
VALUES ('FGL-1102', 'Fågelholken-Vån-1', 'FGL-LGH 1102', 2, 75);

INSERT INTO Lägenhet(id, våning_id, lgh_nr, antal_rum, area_kvm)
VALUES ('FGL-1103', 'Fågelholken-Vån-1', 'FGL-LGH 1103', 2, 75);

INSERT INTO Lägenhet(id, våning_id, lgh_nr, antal_rum, area_kvm)
VALUES ('FGL-1104', 'Fågelholken-Vån-1', 'FGL-LGH 1104', 1, 60);

-- 

INSERT INTO Avtal(id, lgh_id, månadshyra, start_datum, slut_datum, årshyra)
VALUES ('Avtal-FGL-1101', 'FGL-1101', 5500, '2022-06-25', '2025-12-25', 66000)

INSERT INTO Avtal(id, lgh_id, månadshyra, start_datum, slut_datum, årshyra)
VALUES ('Avtal-FGL-1102', 'FGL-1102', 6800, '2022-03-20', '2024-01-25', 81600)

INSERT INTO Avtal(id, lgh_id, månadshyra, start_datum, slut_datum, årshyra)
VALUES ('Avtal-FGL-1103', 'FGL-1103', 6800, '2022-06-25', '2025-12-25', 81600)

INSERT INTO Avtal(id, lgh_id, månadshyra, start_datum, slut_datum, årshyra)
VALUES ('Avtal-FGL-1104', 'FGL-1104', 5500, '2022-06-25', '2025-12-25', 66000)

--

UPDATE Lägenhet 
SET avtal_id = 'Avtal-FGL-1101'
WHERE id = 'FGL-1101';

UPDATE Lägenhet 
SET avtal_id = 'Avtal-FGL-1102'
WHERE id = 'FGL-1102';

UPDATE Lägenhet 
SET avtal_id = 'Avtal-FGL-1103'
WHERE id = 'FGL-1103';

UPDATE Lägenhet 
SET avtal_id = 'Avtal-FGL-1104'
WHERE id = 'FGL-1104';

--

INSERT INTO Person(id, first_name, last_name, email, telefon_nr, avtal_id)
VALUES ('19960303-7838', 'Chris', 'Hjalmarsson', 'chrishjal@gmail.com', '070 897 8372', 'Avtal-FGL-1101')

INSERT INTO Person(id, first_name, last_name, email, telefon_nr, avtal_id)
VALUES ('19940523-7672', 'Alexis', 'Ilmachuk', 'alx.ilm@hotmail.com', '070 243 6531', 'Avtal-FGL-1102')

INSERT INTO Person(id, first_name, last_name, email, telefon_nr, avtal_id)
VALUES ('19860315-5627', 'Viktor', 'Holmberg', 'vikholm@gmail.com', '070 786 7531', 'Avtal-FGL-1103')

INSERT INTO Person(id, first_name, last_name, email, telefon_nr, avtal_id)
VALUES ('19740511-6784', 'Johanna', 'Strand', 'johanna.strand@gmail.com', '070 743 5672', 'Avtal-FGL-1104')

--

CREATE TABLE Archived_avtal(id varchar(20) NOT NULL,
	lgh_id varchar(30) NOT NULL,
	månadshyra money,
	start_datum date,
	slut_datum date,
	årshyra money
);

-- tar Avtal-FGL-1001 och skickar in det in i arkiverade avtal tabellen
INSERT INTO Archived_avtal 
SELECT * FROM Avtal 
WHERE id = 'Avtal-FGL-1101';


-- Tar bort gammalt avtal från hyresgäst & lägenheten
UPDATE Person
SET avtal_id = NULL
WHERE id = '19960303-7838';

UPDATE Lägenhet
SET avtal_id = NULL
WHERE lgh_nr = 'FGL-LGH 1101';

DELETE FROM Avtal WHERE id = 'Avtal-FGL-1101';

-- Nytt avtal med nytt startdatum, månadshyra, och årshyra
INSERT INTO Avtal(id, lgh_id, månadshyra, start_datum, slut_datum, årshyra)
VALUES ('Avtal-FGL-1101', 'FGL-1101', 5800, '2022-12-02', '2025-12-25', 69600)

UPDATE Person
SET avtal_id = 'Avtal-FGL-1101'
WHERE id = '19960303-7838';

UPDATE Lägenhet
SET avtal_id = 'Avtal-FGL-1101'
WHERE lgh_nr = 'FGL-LGH 1101';

-- ******************************************
-- ******************************************

INSERT INTO Adress(id, kvarter_id, gatunamn, gatunummer)
VALUES ('BJRN-ADRESS-2', 'BJRN-1', 'Rosenlundsgatan', 10)

INSERT INTO Lägenhetshus(id, adress_id, ordnings_namn)
VALUES ('BJRN-HUS-2', 'BJRN-ADRESS-2', 'Björnen, Hus Barrskogen')

INSERT INTO Våningsplan(id, lägenhetshus_id, plan_nr)
VALUES ('Barrskogen-Vån-1', 'BJRN-HUS-2', 'Barrskogen, plan #1')

--

INSERT INTO Lägenhet(id, våning_id, lgh_nr, antal_rum, area_kvm)
VALUES ('BRR-1101', 'Barrskogen-Vån-1', 'BRR-LGH 1101', 3, 80);

INSERT INTO Lägenhet(id, våning_id, lgh_nr, antal_rum, area_kvm)
VALUES ('BRR-1102', 'Barrskogen-Vån-1', 'BRR-LGH 1102', 2, 65);

INSERT INTO Lägenhet(id, våning_id, lgh_nr, antal_rum, area_kvm)
VALUES ('BRR-1103', 'Barrskogen-Vån-1', 'BRR-LGH 1103', 4, 85);

INSERT INTO Lägenhet(id, våning_id, lgh_nr, antal_rum, area_kvm)
VALUES ('BRR-1104', 'Barrskogen-Vån-1', 'BRR-LGH 1104', 2, 65);

-- Skapar avtal 1
INSERT INTO Avtal(id, lgh_id, månadshyra, start_datum, slut_datum, årshyra)
VALUES ('Avtal-BRR-1101', 'BRR-1101', 7000, '2022-06-25', '2025-12-25', 84000)

INSERT INTO Avtal(id, lgh_id, månadshyra, start_datum, slut_datum, årshyra)
VALUES ('Avtal-BRR-1102', 'BRR-1102', 5600, '2019-09-03', '2023-08-25', 67200)

INSERT INTO Avtal(id, lgh_id, månadshyra, start_datum, slut_datum, årshyra)
VALUES ('Avtal-BRR-1103', 'BRR-1103', 7300, '2022-06-25', '2025-06-25', 87600)

INSERT INTO Avtal(id, lgh_id, månadshyra, start_datum, slut_datum, årshyra)
VALUES ('Avtal-BRR-1104', 'BRR-1104', 5600, '2022-06-25', '2025-06-25', 67200)

--

UPDATE Lägenhet 
SET avtal_id = 'Avtal-BRR-1101'
WHERE id = 'BRR-1101';

UPDATE Lägenhet 
SET avtal_id = 'Avtal-BRR-1102'
WHERE id = 'BRR-1102';

UPDATE Lägenhet 
SET avtal_id = 'Avtal-BRR-1103'
WHERE id = 'BRR-1103';

UPDATE Lägenhet 
SET avtal_id = 'Avtal-BRR-1104'
WHERE id = 'BRR-1104';

--

INSERT INTO Person(id, first_name, last_name, email, telefon_nr, avtal_id)
VALUES ('19820416-8091', 'Johan', 'Kristoffersson', 'johkris@gmail.com', '070 689 7821', 'Avtal-BRR-1101')

INSERT INTO Person(id, first_name, last_name, email, telefon_nr, avtal_id)
VALUES ('19730405-6892', 'Frida', 'Johansson', 'frida@gmail.com', '070 651 4324', 'Avtal-BRR-1102')

INSERT INTO Person(id, first_name, last_name, email, telefon_nr, avtal_id)
VALUES ('19760923-5689', 'Isabella', 'Ståhl', 'isastahl@gmail.com', '070 782 3289', 'Avtal-BRR-1103')

INSERT INTO Person(id, first_name, last_name, email, telefon_nr, avtal_id)
VALUES ('19820115-4921', 'Urban', 'Axelsson', 'urban@gmail.com', '073 392 2389', 'Avtal-BRR-1104')

--

INSERT INTO Våningsplan(id, lägenhetshus_id, plan_nr)
VALUES ('Barrskogen-Vån-2', 'BJRN-HUS-2', 'Barrskogen, plan #2')

INSERT INTO Lägenhet(id, våning_id, lgh_nr, antal_rum, area_kvm)
VALUES ('BRR-1201', 'Barrskogen-Vån-2', 'BRR-LGH 1201', 5, 100);

INSERT INTO Lägenhet(id, våning_id, lgh_nr, antal_rum, area_kvm)
VALUES ('BRR-1202', 'Barrskogen-Vån-2', 'BRR-LGH 1202', 5, 100);

INSERT INTO Avtal(id, lgh_id, månadshyra, start_datum, slut_datum, årshyra)
VALUES ('Avtal-BRR-1201', 'BRR-1201', 9500, '2022-06-25', '2025-12-25', 11400)

INSERT INTO Avtal(id, lgh_id, månadshyra, start_datum, slut_datum, årshyra)
VALUES ('Avtal-BRR-1202', 'BRR-1202', 9500, '2022-06-25', '2025-12-25', 11400)

--

UPDATE Lägenhet 
SET avtal_id = 'Avtal-BRR-1201'
WHERE id = 'BRR-1201';

UPDATE Lägenhet 
SET avtal_id = 'Avtal-BRR-1202'
WHERE id = 'BRR-1202';

--

INSERT INTO Person(id, first_name, last_name, email, telefon_nr, avtal_id)
VALUES ('19720420-8921', 'Benny', 'Persson', 'benny.p@gmail.com', '070 782 2781', 'Avtal-BRR-1201')

INSERT INTO Person(id, first_name, last_name, email, telefon_nr, avtal_id)
VALUES ('19730525-6892', 'Karl', 'Johan', 'karl.johan@gmail.com', '070 892 8912', 'Avtal-BRR-1202')

-- *******************************************

INSERT INTO Adress(id, kvarter_id, gatunamn, gatunummer)
VALUES ('SKTN-ADRESS-2', 'SKTN-1', 'Polhemsvägen', 45)

INSERT INTO Lägenhetshus(id, adress_id, ordnings_namn)
VALUES ('SKTN-HUS-2', 'SKTN-ADRESS-2', 'Skatan, Hus Fröet')

--

INSERT INTO Våningsplan(id, lägenhetshus_id, plan_nr)
VALUES ('Fröet-Vån-1', 'SKTN-HUS-2', 'Fröet, plan #1')

INSERT INTO Våningsplan(id, lägenhetshus_id, plan_nr)
VALUES ('Fröet-Vån-2', 'SKTN-HUS-2', 'Fröet, plan #2')

--

INSERT INTO Lägenhet(id, våning_id, lgh_nr, antal_rum, area_kvm)
VALUES ('FRÖ-1101', 'Fröet-Vån-1', 'FRÖ-LGH 1101', 3, 80);

INSERT INTO Lägenhet(id, våning_id, lgh_nr, antal_rum, area_kvm)
VALUES ('FRÖ-1102', 'Fröet-Vån-1', 'FRÖ-LGH 1102', 3, 80);

INSERT INTO Lägenhet(id, våning_id, lgh_nr, antal_rum, area_kvm)
VALUES ('FRÖ-1201', 'Fröet-Vån-2', 'FRÖ-LGH 1201', 3, 80);

INSERT INTO Lägenhet(id, våning_id, lgh_nr, antal_rum, area_kvm)
VALUES ('FRÖ-1202', 'Fröet-Vån-2', 'FRÖ-LGH 1202', 3, 80);

--

INSERT INTO Avtal(id, lgh_id, månadshyra, start_datum, slut_datum, årshyra)
VALUES ('Avtal-FRÖ-1101', 'FRÖ-1101', 7000, '2022-06-25', '2025-12-25', 84000)

INSERT INTO Avtal(id, lgh_id, månadshyra, start_datum, slut_datum, årshyra)
VALUES ('Avtal-FRÖ-1102', 'FRÖ-1102', 7000, '2022-06-25', '2025-12-25', 84000)

INSERT INTO Avtal(id, lgh_id, månadshyra, start_datum, slut_datum, årshyra)
VALUES ('Avtal-FRÖ-1201', 'FRÖ-1201', 7000, '2022-06-25', '2025-12-25', 84000)

INSERT INTO Avtal(id, lgh_id, månadshyra, start_datum, slut_datum, årshyra)
VALUES ('Avtal-FRÖ-1202', 'FRÖ-1202', 7000, '2022-06-25', '2025-12-25', 84000)

--

UPDATE Lägenhet 
SET avtal_id = 'Avtal-FRÖ-1101'
WHERE id = 'FRÖ-1101';

UPDATE Lägenhet 
SET avtal_id = 'Avtal-FRÖ-1102'
WHERE id = 'FRÖ-1102';

UPDATE Lägenhet 
SET avtal_id = 'Avtal-FRÖ-1201'
WHERE id = 'FRÖ-1201';

UPDATE Lägenhet 
SET avtal_id = 'Avtal-FRÖ-1202'
WHERE id = 'FRÖ-1202';

--

INSERT INTO Person(id, first_name, last_name, email, telefon_nr, avtal_id)
VALUES ('19821016-8912', 'Oskar', 'Fredriksson', 'osfre@gmail.com', '070 787 8782', 'Avtal-FRÖ-1101')

INSERT INTO Person(id, first_name, last_name, email, telefon_nr, avtal_id)
VALUES ('19731105-8921', 'Samuel', 'Rosenqvist', 'samros@gmail.com', '070 781 2123', 'Avtal-FRÖ-1102')

INSERT INTO Person(id, first_name, last_name, email, telefon_nr, avtal_id)
VALUES ('19761023-8991', 'Arne', 'Eriksson', 'arne.e@gmail.com', '070 123 4321', 'Avtal-FRÖ-1201')

INSERT INTO Person(id, first_name, last_name, email, telefon_nr, avtal_id)
VALUES ('19920615-5661', 'Katarina', 'Lindberg', 'kata.lind@gmail.com', '073 567 8123', 'Avtal-FRÖ-1202')

-- *********************************

ALTER TABLE Lägenhetshus
ADD kvarter_id varchar(20);

ALTER TABLE Lägenhetshus
ADD FOREIGN KEY (kvarter_id) REFERENCES Kvarter(id);

UPDATE Lägenhetshus 
SET kvarter_id = 'BJRN-1'
WHERE id = 'BJRN-HUS-1';

UPDATE Lägenhetshus 
SET kvarter_id = 'BJRN-1'
WHERE id = 'BJRN-HUS-2';

UPDATE Lägenhetshus 
SET kvarter_id = 'SKTN-1'
WHERE id = 'SKTN-HUS-1';

UPDATE Lägenhetshus 
SET kvarter_id = 'SKTN-1'
WHERE id = 'SKTN-HUS-2';

--

ALTER TABLE Lägenhet
ADD lägenhetshus_id varchar(20);

--

UPDATE Lägenhet
SET lägenhetshus_id = 'BJRN-HUS-2'
WHERE våning_id = 'Barrskogen-Vån-1';

UPDATE Lägenhet
SET lägenhetshus_id = 'BJRN-HUS-2'
WHERE våning_id = 'Barrskogen-Vån-2';

UPDATE Lägenhet
SET lägenhetshus_id = 'BJRN-HUS-1'
WHERE våning_id = 'Trästocken-Vån-1';

UPDATE Lägenhet
SET lägenhetshus_id = 'BJRN-HUS-1'
WHERE våning_id = 'Trästocken-Vån-2';

--

-- 4.1
SELECT p.first_name, p.last_name, a.årshyra, l.antal_rum, l.area_kvm 
FROM Person p
LEFT JOIN Avtal a on p.avtal_id = a.id 
LEFT JOIN Lägenhet l on a.lgh_id = l.id  
ORDER BY p.first_name;


-- 4.2
SELECT
    Kvarter.id AS Kvarter_namn,
    COUNT(DISTINCT Lägenhetshus.id) AS antal_hus,
    COUNT(CASE WHEN Lägenhetshus.id = Lägenhet.lägenhetshus_id THEN 1 ELSE 0 END) AS tot_lägenheter,
    SUM(CASE WHEN Lägenhetshus.id = Lägenhet.lägenhetshus_id THEN Lägenhet.area_kvm ELSE 0 END) AS tot_kvm
FROM Kvarter
JOIN Lägenhetshus ON Kvarter.id = Lägenhetshus.kvarter_id
JOIN Lägenhet ON Lägenhetshus.id = Lägenhet.lägenhetshus_id
GROUP BY Kvarter.id

-- 4.3
SELECT
    Kvarter.trakt as TRAKT,
    COUNT(DISTINCT Kvarter.id) AS TRAKT_KVARTER,
    COUNT(Lägenhet.id) AS TRAKT_LÄGENHETER,
    SUM(Lägenhet.area_kvm) AS TRAKT_KVM
FROM
    Kvarter
JOIN Lägenhetshus ON Kvarter.id = Lägenhetshus.kvarter_id
JOIN Lägenhet ON Lägenhetshus.id = Lägenhet.lägenhetshus_id
GROUP BY Kvarter.trakt

-- 4.4
SELECT
    månadshyra AS NästaMånadshyra
FROM
    Avtal
WHERE
    slut_datum IS NULL