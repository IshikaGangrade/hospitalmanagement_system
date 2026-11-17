CREATE DATABASE hospitaldb;
USE hospitaldb;
CREATE TABLE admin(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(100)
);
INSERT INTO admin(name,email,password)
VALUES('admin','admin@gmail.com','admin123');
CREATE TABLE patient (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(15),
    gender VARCHAR(20),
    age INT,
    address VARCHAR(200),
    disease VARCHAR(100),
    blood VARCHAR(10)
);
INSERT INTO patient(name,email,phone,gender,age,address,disease,blood)
VALUES('rahul sharma','rahul@gmail.com','9876543210','Male','30','bhopal','fever','B+'),
('Anjali verma','anjali@gmail.com','9876543315','Female','35','delhi','headache','A+'),
('Aman gupta','aman@gmail.com','9876553412','Male','25','pune','heart problem','o+');

CREATE TABLE doctors (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    experience INT NOT NULL,
    department_id INT NOT NULL
);
INSERT INTO doctors
(name, email, phone, specialization, experience, department_id)
VALUES
('Dr. Amit Verma', 'amit@hospital.com', '9000800002', 'Cardiology', 10, 1),
('Dr. Neha Jain', 'neha@hospital.com', '9000000002', 'Orthopedics', 8, 2),
('Dr. Raj Malhotra', 'raj@hospital.com', '9000000003', 'Neurology', 12, 3),
('Dr. Simran Kaur', 'simran@hospital.com', '9000000004', 'ENT', 6, 4);

CREATE TABLE IF NOT EXISTS departments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);
 
INSERT INTO departments (name, description) VALUES
('Cardiology', 'Treats diseases related to the heart and blood vessels, including heart attack, chest pain, and hypertension.'),
('Orthopedics', 'Deals with bones, joints, muscles, and injuries like fractures, arthritis, and sprains.'),
('Neurology', 'Focuses on disorders of the brain, spine, and nervous system such as stroke, epilepsy, and migraines.');
 
CREATE TABLE IF NOT EXISTS appointment (
    id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Pending',
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(id)
);
INSERT IGNORE INTO appointment (id, appointment_date, appointment_time, patient_id, doctor_id, status) VALUES
(1, '2026-06-11', '10:00:00', 1, 1, 'Completed'),
(2, '2026-06-11', '11:00:00', 2, 2, 'Completed'),
(3, '2026-06-12', '12:00:00', 3, 1, 'Pending'),
(4, '2026-06-12', '13:00:00', 4, 3, 'Cancelled'),
(5, '2026-06-12', '17:58:00', 5, 4, 'Pending');

UPDATE patient SET name = 'Rahul Sharma' WHERE patient_id = 1;
UPDATE patient SET name = 'Arjun Gupta'  WHERE patient_id = 3;
INSERT INTO patient (name)
SELECT 'Anjali Verma' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM patient WHERE name = 'Anjali Verma');

INSERT INTO patient (name)
SELECT 'Pooja Singh' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM patient WHERE name = 'Pooja Singh');

INSERT INTO patient (name)
SELECT 'Aysha' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM patient WHERE name = 'Aysha');
INSERT IGNORE INTO appointment (id, appointment_date, appointment_time, patient_id, doctor_id, status)
SELECT 2, '2026-06-11', '11:00:00', p.patient_id, d.id, 'Completed'
FROM patient p, doctors d
WHERE p.name = 'Anjali Verma' AND d.name LIKE '%Neha Jain%' LIMIT 1;

INSERT IGNORE INTO appointment (id, appointment_date, appointment_time, patient_id, doctor_id, status)
SELECT 4, '2026-06-12', '13:00:00', p.patient_id, d.id, 'Cancelled'
FROM patient p, doctors d
WHERE p.name = 'Pooja Singh' AND d.name LIKE '%Raj Malhotra%' LIMIT 1;

INSERT IGNORE INTO appointment (id, appointment_date, appointment_time, patient_id, doctor_id, status)
SELECT 5, '2026-06-12', '17:58:00', p.patient_id, d.id, 'Pending'
FROM patient p, doctors d
WHERE p.name = 'Aysha' AND d.name LIKE '%Simran Kaur%' LIMIT 1;
CREATE TABLE IF NOT EXISTS bill (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL DEFAULT 0,
    status VARCHAR(20) NOT NULL DEFAULT 'Pending',
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);
INSERT IGNORE INTO bill (id, patient_id, amount, status) VALUES
(1, 1,  2500.00, 'Paid'),
(2, 2,  1200.00, 'Pending'),
(3, 3,  1500.00, 'Paid'),
(4, 4,   800.00, 'Pending'),
(9, 5, 10000.00, 'Paid');
ALTER TABLE bill AUTO_INCREMENT = 10;
USE hospitaldb;
SELECT COUNT(*) AS totalPatients
FROM patient;
SELECT COUNT(*) AS totalDoctors
FROM doctors;
SELECT COUNT(*) AS totalAppointments
FROM appointment;
SELECT COALESCE(SUM(amount), 0) AS totalRevenue
FROM bill
WHERE LOWER(status) = 'paid';
SELECT
    p.name AS patient_name,
    d.name AS doctor_name,
    a.appointment_date,
    a.appointment_time,
    a.status
FROM appointment a
JOIN patient p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.id
ORDER BY a.appointment_date DESC,
         a.appointment_time DESC
LIMIT 5;
SELECT
    d.name AS doctor_name,
    d.specialization,
    COUNT(a.id) AS total_appointments
FROM doctors d
LEFT JOIN appointment a ON d.id = a.doctor_id
GROUP BY d.id, d.name, d.specialization;
SELECT
    p.name AS patient_name,
    d.name AS doctor_name,
    a.appointment_date,
    a.appointment_time,
    a.status
FROM appointment a
JOIN patient p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.id
ORDER BY a.appointment_date DESC
LIMIT 10;
