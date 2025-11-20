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
    CONSTRAINT Room_pk PRIMARY KEY (RoomID)
);

CREATE TABLE LocatedIn
(
    RoomID Number NOT NULL,
    DepartmentID NUMBER NOT NULL,
    CONSTRAINT RoomDepartment_pk PRIMARY KEY (RoomID, DepartmentID),
    CONSTRAINT RoomDepartment_room_fk FOREIGN KEY (RoomID) REFERENCES Room(RoomID),
    CONSTRAINT RoomDepartment_deparment_fk FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

CREATE TABLE Appointment
(
    AppointmentID NUMBER NOT NULL,
    StartTime TIMESTAMP NOT NULL,
    EndTiME TIMESTAMP NOT NULL,
    PatientID NUMBER,
    PhysicianID NUMBER,
    NurseID NUMBER,
    CONSTRAINT Appointment_pk PRIMARY KEY (AppointmentID),
    CONSTRAINT Appointment_patient_fk FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    CONSTRAINT Appointment_physician_fk FOREIGN KEY (PhysicianID) REFERENCES Physician(PhysicianID),
    CONSTRAINT Appointment_nurse_fk FOREIGN KEY (NurseID) REFERENCES Nurse(NurseID)
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
    MedicationCode NUMBER,
    Dose VARCHAR(50) NOT NULL,
    DatePrescribe Date NOT NULL,
    PatientID NUMBER,
    MedicationID NUMBER,
    CONSTRAINT Prescription_pk PRIMARY KEY (PrescriptionID),
    CONSTRAINT Prescription_patient_fk FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    CONSTRAINT Prescription_medication_fk FOREIGN KEY (MedicationID) REFERENCES Medication(MedicationID)
    
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
    Cost NUMBER
    CONSTRAINT Procedure_pk PRIMARY KEY (ProcedureID) 
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
    CONSTRAINT Stay_room_fk FOREIGN KEY (RoomID) REFERENCES Room(RoomID),
    CONSTRAINT Stay_nurse_fk FOREIGN KEY (NurseID) REFERENCES Nurse(NurseID)
);


CREATE TABLE Bill
(
    BillID NUMBER UNIQUE,
    FinalCost NUMBER
    CONSTRAINT Bill_pk PRIMARY KEY (BillID),
    CONSTRAINT Bill_patient_fk FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);






