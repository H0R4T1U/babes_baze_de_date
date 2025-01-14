USE Practic

create table Artisti(
    idArtist INT PRIMARY KEY,
    Nume varchar(50),
    Prenume varchar(50),
    Gen varchar(50),
    AnulNasterii Int,

)
create TABLE Mobilier(
    idMobilier int PRIMARY KEY,
    Denumire varchar(50),
    An DATE,
    Valoare INT,
    idArtist INT FOREIGN KEY REFERENCES Artisti(idArtist),

)
create TABLE Colectionari(
    idColectionar INT PRIMARY KEY,
    Nume varchar(50),
    Prenume varchar(50),
    Varsta INT,
    Piese INT,
)
create TABLE Muzee(
    idMuzeu INT PRIMARY KEY,
    Denumire varchar(50),
    AnDatare DATE,
    Oras varchar(50),
    Judet varchar(50),
    Tara varchar(50),
)
create TABLE Expozitie(
    idArtist INT FOREIGN KEY REFERENCES Artisti(idArtist),
    idMuzeu INT FOREIGN KEY REFERENCES Muzee(idMuzeu),
    DataExpozitie DATE,
    Pret INT,
)

INSERT INTO Artisti(idArtist,Nume,Prenume,Gen,AnulNasterii) VALUES 
    (1,'Davinci','Leonardo','Masculin',1400),
    (2,'Van Gogh','Vincent','Masculin',1800),
    (3,'Ionescu','Ana','Feminin',1996);

INSERT INTO Mobilier(idMobilier,Denumire,An,Valoare,idArtist) VALUES 
    (1,'Mona Lisa','2024-01-23',3500,1),
    (2,'Noaptea Instelata','2023-07-15',500,2),
    (3,'Scaun','2021-09-5',6500,3);

INSERT INTO Colectionari(idColectionar,Nume,Prenume,Varsta,Piese) VALUES 
    (1,'Banciu','Horatiu',20,0),
    (2,'Popescu','Ion',45,2),
    (3,'Istoc','Maria',35,1);

INSERT INTO Muzee(idMuzeu,Denumire,AnDatare,Oras,Judet,Tara) VALUES 
    (1,'Muzeul de arta Bucuresti','1870-01-01','Bucuresti','Ilfov','Romania'),
    (2,'Muzeul de arta Cluj','1700-04-20','Cluj-Napoca','Cluj','Romania'),
    (3,'Muzeul de arta Iasi','1875-05-25','Iasi','Iasi','Romania');

INSERT INTO Expozitie(idArtist,idMuzeu,DataExpozitie,Pret) VALUES 
    (1,1,'2025-01-18',40),
    (2,2,'2025-02-25',45),
    (3,3,'2025-03-05',35);
