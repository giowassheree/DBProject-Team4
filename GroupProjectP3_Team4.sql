DROP TABLE Patient CASCADE CONSTRAINTS;
DROP TABLE Department_proj CASCADE CONSTRAINTS;
DROP TABLE Physician CASCADE CONSTRAINTS;
DROP TABLE Nurse CASCADE CONSTRAINTS;
DROP TABLE Room CASCADE CONSTRAINTS;
DROP TABLE Appointment CASCADE CONSTRAINTS;
DROP TABLE AssignedTo CASCADE CONSTRAINTS;
DROP TABLE Medication CASCADE CONSTRAINTS;
DROP TABLE Prescription CASCADE CONSTRAINTS;
DROP TABLE Includes CASCADE CONSTRAINTS;
DROP TABLE Procedure_proj CASCADE CONSTRAINTS;
DROP TABLE Stay CASCADE CONSTRAINTS;
DROP TABLE PerformedIn CASCADE CONSTRAINTS;
DROP TABLE Bill CASCADE CONSTRAINTS;
DROP SEQUENCE Patient_pk;
DROP SEQUENCE Department_pk;
DROP SEQUENCE Physician_pk;
DROP SEQUENCE Nurse_pk;
DROP SEQUENCE Room_pk;
DROP SEQUENCE Appointment_pk;
DROP SEQUENCE Medication_pk;
DROP SEQUENCE Prescription_pk;
DROP SEQUENCE Procedure_pk;
DROP SEQUENCE Bill_pk;

CREATE TABLE Patient
(
    PatientID           NUMBER GENERATED ALWAYS AS IDENTITY,
    FirstName           VARCHAR(50) NOT NULL,
    LastName            VARCHAR(50) NOT NULL,
    DOB                 DATE NOT NULL,
    InsuranceID         NUMBER,
    CONSTRAINT Patient_pk PRIMARY KEY (PatientID)
);

CREATE TABLE Department_proj
(
    DepartmentID    NUMBER GENERATED ALWAYS AS IDENTITY,
    FloorNum        NUMBER,
    DeptName        VARCHAR(50) NOT NULL,
    NurseID         NUMBER,
    PhysicianID     NUMBER,
    CONSTRAINT Department_pk PRIMARY KEY (DepartmentID)
);

CREATE TABLE Physician
(
    PhysicianID        NUMBER GENERATED ALWAYS AS IDENTITY,
    FirstName          VARCHAR(50) NOT NULL,
    LastName           VARCHAR(50) NOT NULL,
    DOB                DATE NOT NULL,
    DepartmentID       NUMBER NOT NULL,
    CONSTRAINT Physician_pk PRIMARY KEY (PhysicianID),
    CONSTRAINT Physician_department_fk FOREIGN KEY (DepartmentID) REFERENCES Department_proj(DepartmentID)
);

CREATE TABLE Nurse
(
    NurseID      NUMBER GENERATED ALWAYS AS IDENTITY,
    FirstName    VARCHAR(50) NOT NULL,
    LastName     VARCHAR(50) NOT NULL,
    DOB          DATE NOT NULL,
    StayID       NUMBER,
    DepartmentID NUMBER,
    CONSTRAINT Nurse_pk PRIMARY KEY (NurseID),
    CONSTRAINT Nurse_department_fk FOREIGN KEY (DepartmentID) REFERENCES Department_proj(DepartmentID)
);

CREATE TABLE Room 
(
    RoomID NUMBER GENERATED ALWAYS AS IDENTITY,
    RoomNumber NUMBER NOT NULL, 
    Unavaliable NUMBER(1), 
    DepartmentID Number Not NULL,
    CONSTRAINT Room_pk PRIMARY KEY (RoomID),
    CONSTRAINT Room_department_fk FOREIGN KEY (DepartmentID) REFERENCES Department_proj(DepartmentID)
);

CREATE TABLE Appointment
(
    AppointmentID NUMBER GENERATED ALWAYS AS IDENTITY,
    StartTime TIMESTAMP NOT NULL,
    EndTime TIMESTAMP NOT NULL,
    PatientID NUMBER,
    PhysicianID NUMBER,
    CONSTRAINT Appointment_pk PRIMARY KEY (AppointmentID),
    CONSTRAINT Appointment_patient_fk FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    CONSTRAINT Appointment_physician_fk FOREIGN KEY (PhysicianID) REFERENCES Physician(PhysicianID)
);

CREATE TABLE AssignedTo
(
    AppointmentID NUMBER,
    NurseID NUMBER,
    CONSTRAINT Appointment_nurse_pk PRIMARY KEY (AppointmentID, NurseID),
    CONSTRAINT Appointment_nurse_appointment_fk FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID),
    CONSTRAINT Appointment_nurse_nurse_fk FOREIGN KEY (NurseID) REFERENCES Nurse(NurseID)
);

CREATE TABLE Medication 
(
    MedicationID          NUMBER GENERATED ALWAYS AS IDENTITY,
    Brand                 VARCHAR(50),
    Description           VARCHAR(100),
    Name                  VARCHAR(50),
    CONSTRAINT Medication_pk PRIMARY KEY (MedicationID)

);

CREATE TABLE Prescription
(
    PrescriptionID NUMBER GENERATED ALWAYS AS IDENTITY,
    Dose VARCHAR(50) NOT NULL,
    DatePrescribed Date NOT NULL,
    PatientID NUMBER,
    CONSTRAINT Prescription_pk PRIMARY KEY (PrescriptionID),
    CONSTRAINT Prescription_patient_fk FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

CREATE TABLE Includes
(
    PrescriptionID NUMBER,
    MedicationID NUMBER,
    CONSTRAINT PrescriptionMedication_pk PRIMARY KEY (PrescriptionID, MedicationID),
    CONSTRAINT PrescriptionMedication_medication_fk FOREIGN KEY (MedicationID) REFERENCES Medication(MedicationID),
    CONSTRAINT PrescriptionMedication_prescription_fk FOREIGN KEY (PrescriptionID) REFERENCES Prescription(PrescriptionID)
);

CREATE TABLE Procedure_proj
(
    ProcedureID NUMBER GENERATED ALWAYS AS IDENTITY, 
    Name VARCHAR(50),
    Cost NUMBER,
    PatientID NUMBER,
    CONSTRAINT Procedure_pk PRIMARY KEY (ProcedureID),
    CONSTRAINT procedure_patient_fk FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

CREATE TABLE Stay
(
    StayID          NUMBER GENERATED ALWAYS AS IDENTITY,
    StartTime       TIMESTAMP,
    EndTime         TIMESTAMP,
    PatientID       NUMBER,
    PhysicianID     NUMBER,
    RoomID          NUMBER,
    NurseID         NUMBER,
    CONSTRAINT Stay_pk PRIMARY KEY (StayID),
    CONSTRAINT Stay_patient_fk FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    CONSTRAINT Stay_room_fk FOREIGN KEY (RoomID) REFERENCES Room(RoomID),
    CONSTRAINT Stay_physican_fk FOREIGN KEY (PhysicianID) REFERENCES Physician(PhysicianID),
    CONSTRAINT Stay_nurse_fk FOREIGN KEY (NurseID) REFERENCES Nurse(NurseID)
);

CREATE TABLE PerformedIn
(
    ProcedureID NUMBER,
    StayID NUMBER, 
    CONSTRAINT Procedure_stay_pk PRIMARY KEY (ProcedureID, StayID),
    CONSTRAINT Stay_procedure_fk FOREIGN KEY (StayID) REFERENCES Stay(StayID),
    CONSTRAINT Procedure_stay_fk FOREIGN KEY (ProcedureID) REFERENCES Procedure_proj(ProcedureID)
);

CREATE TABLE Bill
(
    BillID NUMBER GENERATED ALWAYS AS IDENTITY,
    FinalCost NUMBER, 
    PatientID NUMBER, 
    CONSTRAINT Bill_pk PRIMARY KEY (BillID),
    CONSTRAINT Bill_patient_fk FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

CREATE SEQUENCE Patient_pk
    START WITH 1
    INCREMENT BY 1;
    
CREATE SEQUENCE Department_pk
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE Physician_pk
    START WITH 1
    INCREMENT BY 1;
    
CREATE SEQUENCE Nurse_pk
    START WITH 1
    INCREMENT BY 1;
    
CREATE SEQUENCE Room_pk
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE Appointment_pk
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE Medication_pk
    START WITH 1
    INCREMENT BY 1;
    
CREATE SEQUENCE Prescription_pk
    START WITH 1
    INCREMENT BY 1;
    
CREATE SEQUENCE Procedure_pk
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE Bill_pk
    START WITH 1
    INCREMENT BY 1;
    
CREATE INDEX idx_patient_lastname ON Patient(LastName);
CREATE INDEX idx_physician_lastname ON Physician(LastName);
CREATE INDEX idx_nurse_lastname ON Nurse(LastName);

INSERT INTO Patient (FirstName, LastName, DOB, InsuranceID)
VALUES ('Dom', 'Monde', DATE '1985-10-28', 349420941);

INSERT INTO Patient (FirstName, LastName, DOB, InsuranceID)
VALUES ('Linda', 'Kerrigan', DATE '2002-02-03', 534350681);

INSERT INTO Department_proj (FloorNum, DeptName, NurseID, PhysicianID)
VALUES (2, 'Cardiology', NULL, NULL);

INSERT INTO Department_proj (FloorNum, DeptName, NurseID, PhysicianID)
VALUES (3, 'Neurology', NULL, NULL);

INSERT INTO Physician (FirstName, LastName, DOB, DepartmentID)
VALUES ('Gregory', 'House', DATE '1960-06-11', 1);

INSERT INTO Physician (FirstName, LastName, DOB, DepartmentID)
VALUES ('Meredith', 'Grey', DATE '1978-09-02', 2);

INSERT INTO Nurse (FirstName, LastName, DOB, StayID, DepartmentID)
VALUES ('Nina', 'Keller', DATE '1990-01-12', NULL, 1);

INSERT INTO Nurse (FirstName, LastName, DOB, StayID, DepartmentID)
VALUES ('Sam', 'Harper', DATE '1988-03-19', NULL, 2);

INSERT INTO Room (RoomNumber, Unavaliable, DepartmentID)
VALUES (101, 0, 1);

INSERT INTO Room (RoomNumber, Unavaliable, DepartmentID)
VALUES (202, 0, 2);

INSERT INTO Appointment (StartTime, EndTime, PatientID, PhysicianID)
VALUES (TIMESTAMP '2025-11-10 10:00:00', TIMESTAMP '2024-01-10 10:30:00', 1, 1);

INSERT INTO Appointment (StartTime, EndTime, PatientID, PhysicianID)
VALUES (TIMESTAMP '2025-10-11 14:00:00', TIMESTAMP '2024-01-11 14:45:00', 2, 2);

INSERT INTO AssignedTo (AppointmentID, NurseID)
VALUES (1, 1);

INSERT INTO AssignedTo (AppointmentID, NurseID)
VALUES (2, 2);

INSERT INTO Medication (Brand, Description, Name)
VALUES ('Pfizer', 'Covid Vaccine', 'Comirnaty');

INSERT INTO Medication (Brand, Description, Name)
VALUES ('Pfizer', 'Antibiotic', 'Zithromax');

INSERT INTO Prescription (Dose, DatePrescribed, PatientID)
VALUES ('10mg', DATE '2024-01-12', 1);

INSERT INTO Prescription (Dose, DatePrescribed, PatientID)
VALUES ('5mg', DATE '2024-01-13', 2);

INSERT INTO Includes (PrescriptionID, MedicationID)
VALUES (1, 1);

INSERT INTO Includes (PrescriptionID, MedicationID)
VALUES (2, 2);

INSERT INTO Procedure_proj (Name, Cost, PatientID)
VALUES ('MRI Scan', 3200, 1);

INSERT INTO Procedure_proj (Name, Cost, PatientID)
VALUES ('CMP Testing', 200, 2);

INSERT INTO Stay (StartTime, EndTime, PatientID, PhysicianID, RoomID, NurseID)
VALUES (TIMESTAMP '2024-12-11 08:00:00', TIMESTAMP '2024-12-12 08:00:00', 1, 1, 1, 1);

INSERT INTO Stay (StartTime, EndTime, PatientID, PhysicianID, RoomID, NurseID)
VALUES (TIMESTAMP '2025-01-10 09:00:00', TIMESTAMP '2025-01-11 09:00:00', 2, 2, 2, 2);

INSERT INTO PerformedIn (ProcedureID, StayID)
VALUES (1, 1);

INSERT INTO PerformedIn (ProcedureID, StayID)
VALUES (2, 2);

INSERT INTO Bill (FinalCost, PatientID)
VALUES (3500, 1);

INSERT INTO Bill (FinalCost, PatientID)
VALUES (500, 2);

/*Selecting procedures and cost for each patient*/
SELECT 
    p.PatientID,
    p.FirstName || ' ' || p.LastName AS PatientName,
    pr.ProcedureID,
    pr.Name AS ProcedureName,
    pr.Cost,
    s.StayID,
    s.StartTime AS StayStart,
    s.EndTime AS StayEnd
FROM Procedure_proj pr
JOIN PerformedIn pi 
    ON pr.ProcedureID = pi.ProcedureID
JOIN Stay s
    ON pi.StayID = s.StayID
JOIN Patient p
    ON s.PatientID = p.PatientID
ORDER BY p.PatientID, s.StayID, pr.ProcedureID;

/*Selecting Appointments for each patient*/
SELECT 
    a.AppointmentID,
    p.FirstName || ' ' || p.LastName AS PatientName,
    phy.FirstName || ' ' || phy.LastName AS PhysicianName,
    n.FirstName || ' ' || n.LastName AS NurseName,
    a.StartTime,
    a.EndTime
FROM Appointment a
JOIN Patient p 
    ON a.PatientID = p.PatientID
JOIN Physician phy 
    ON a.PhysicianID = phy.PhysicianID
LEFT JOIN AssignedTo at
    ON a.AppointmentID = at.AppointmentID
LEFT JOIN Nurse n
    ON at.NurseID = n.NurseID
ORDER BY a.StartTime;

/*ROLLBACK;*/
/*COMMIT;*/