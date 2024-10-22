create schema healthcare_database;

use healthcare_database;

CREATE TABLE visits (
    Date_of_Visit DATE,
    Patient_ID INT,
    Provider_ID INT,
    Department_ID INT,
    Diagnosis_ID INT,
    Procedure_ID INT,
    Insurance_ID INT,
    Service_Type VARCHAR(50),
    Treatment_Cost DECIMAL(10, 2),
    Medication_Cost DECIMAL(10, 2),
    Follow_Up_Visit_Date DATE,
    Patient_Satisfaction_Score INT,
    Referral_Source VARCHAR(50),
    Emergency_Visit VARCHAR(3),
    Payment_Status VARCHAR(10),
    Discharge_Date DATE,
    Admitted_Date DATE,
    Room_Type VARCHAR(50),
    Insurance_Coverage DECIMAL(10, 2),
    Room_Charges_Daily_Rate DECIMAL(10, 2)
);



show variables like 'local_infile';

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/visits.csv'
into table visits
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows
(@date_str, Patient_ID, Provider_ID, Department_ID, Diagnosis_ID, Procedure_ID, Insurance_ID, Service_Type, 
Treatment_Cost, Medication_Cost, @date_str, Patient_Satisfaction_Score, Referral_Source, 
Emergency_Visit, Payment_Status, @date_str, @date_str, Room_Type, Insurance_Coverage, 
Room_Charges_Daily_Rate)
set Date_of_Visit = STR_TO_DATE(@date_str, '%m/%d/%Y'),
    Follow_Up_Visit_Date = STR_TO_DATE(@followup_date_str, '%m/%d/%Y'),
    Discharge_Date = STR_TO_DATE(@discharge_date_str, '%m/%d/%Y'),
    Admitted_Date = STR_TO_DATE(@admitted_date_str, '%m/%d/%Y');



select count(*) as total_rows_in_visits from visits;
