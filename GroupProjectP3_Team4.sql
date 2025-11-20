CREATE INDEX idx_patient_lastname ON Patient(LastName);
CREATE INDEX idx_physician_lastname ON Physician(LastName);
CREATE INDEX idx_nurse_lastname ON Nurse(LastName);

CREATE TABLE Patient
(
    PatientID           NUMBER UNIQUE,
    FirstName           VARCHAR(50) NOT NULL,
    LastName            VARCHAR(50) NOT NULL,
    DOB                 DATE NOT NULL,
    InsuranceID         NUMBER,
    CONSTRAINT Patient_pk PRIMARY KEY (PatientID)
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
    CONSTRAINT Physician_pk PRIMARY KEY (PhysicianID),
    CONSTRAINT Physician_department_fk FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

CREATE TABLE Nurse
(
    NurseID     NUMBER UNIQUE,
    FirstName   VARCHAR(50) NOT NULL,
    LastName    VARCHAR(50) NOT NULL,
    DOB         DATE NOT NULL,
    StayID      NUMBER,
    CONSTRAINT Nurse_pk PRIMARY KEY (NurseID),
    CONSTRAINT Nurse_department_fk FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

CREATE TABLE Room 
(
    RoomID NUMBER UNIQUE,
    RoomNumber NUMBER, 
    Unavaliable BOOLEAN, 
    CONSTRAINT Room_pk PRIMARY KEY (RoomID),
    CONSTRAINT Room_department_fk FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

CREATE TABLE Appointment
(
    AppointmentID NUMBER NOT NULL,
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
    MedicationID          NUMBER UNIQUE,
    Brand                 VARCHAR(50),
    Description           VARCHAR(100),
    Name                  VARCHAR(50),
    CONSTRAINT Medication_pk PRIMARY KEY (MedicationID)

);

CREATE TABLE Prescription
(
    PrescriptionID NUMBER,
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

CREATE TABLE Procedure
(
    ProcedureID NUMBER UNIQUE, 
    Name VARCHAR(50),
    Cost NUMBER,
    PatientID NUMBER,
    CONSTRAINT Procedure_pk PRIMARY KEY (ProcedureID),
    CONSTRAINT procedure_patient_fk FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

CREATE TABLE Stay
(
    StayID          NUMBER UNIQUE,
    StartTime       TIMESTAMP,
    EndTime         TIMESTAMP,
    PatientID       NUMBER,
    PhysicianID     NUMBER,
    RoomID          NUMBER,
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
    CONSTRAINT Procedure_stay_fk FOREIGN KEY (ProcedureID) REFERENCES Procedure(ProcedureID)
);

CREATE TABLE Bill
(
    BillID NUMBER UNIQUE,
    FinalCost NUMBER, 
    PatientID NUMBER, 
    CONSTRAINT Bill_pk PRIMARY KEY (BillID),
    CONSTRAINT Bill_patient_fk FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

CREATE SEQUENCE Patient_pk
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE Appointment_pk
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE Prescription_pk
    START WITH 1
    INCREMENT BY 1;







