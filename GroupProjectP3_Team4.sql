CREATE TABLE Stay
(
    StayID          NUMBER UNIQUE,
    StartTime       TIMESTAMP,
    EndTime         TIMESTAMP,
    PatientID       NUMBER,
    PhysicianID     NUMBER,
    CONSTRAINT Stay_pk PRIMARY KEY (StayID)
);

CREATE TABLE Nurse
(
    NurseID     NUMBER UNIQUE,
    FirstName   VARCHAR(50) NOT NULL,
    LastName    VARCHAR(50) NOT NULL,
    DOB         DATE NOT NULL,
    StayID      NUMBER,
    CONSTRAINT Nurse_pk PRIMARY KEY (NurseId)
);

CREATE TABLE Department
(
    DepartmentID    NUMBER UNIQUE,
    FloorNum        NUMBER,
    DeptName        VARCHAR(50) NOT NULL,
    NurseID         NUMBER,
    PhysicianID     NUMBER,
    CONSTRAINT Department_pk PRIMARY KEY (DepartmentID)
);

CREATE TABLE Physician
(
    PhysicianID        NUMBER UNIQUE,
    FirstName          VARCHAR(50) NOT NULL,
    LastName           VARCHAR(50) NOT NULL,
    DOB                DATE NOT NULL,
    CONSTRAINT Physician_pk PRIMARY KEY (PhysicianID)
);

CREATE TABLE Patient
(
    PatientID           NUMBER UNIQUE,
    FirstName           VARCHAR(50) NOT NULL,
    LastName            VARCHAR(50) NOT NULL,
    DOB                 DATE NOT NULL,
    InsuranceID         NUMBER,
    CONSTRAINT Patient_pk PRIMARY KEY (PatientID)
);

CREATE TABLE Medication 
(
    MedicationID          NUMBER UNIQUE,
    Brand                 VARCHAR(50),
    Description           VARCHAR(100),
    Name                  VARCHAR(50),
    CONSTRAINT Medication_pk PRIMARY KEY (MedicationID)
);

CREATE TABLE Bill
(
    BillID NUMBER UNIQUE,
    FinalCost NUMBER
    CONSTRAINT Bill_pk PRIMARY KEY (BillID)
);

CREATE TABLE Procedure
(
    ProcedureID NUMBER UNIQUE, 
    Name VARCHAR(50),
    Cost NUMBER
    CONSTRAINT Procedure_pk PRIMARY KEY (ProcedureID) 
);

CREATE TABLE Room 
(
    RoomID NUMBER UNIQUE,
    RoomNumber NUMBER, 
    Unavaliable BOOLEAN, 
    CONSTRAINT Room_pk PRIMARY KEY (RoomID)
);


