CREATE DATABASE IF NOT EXISTS return_my_things;
USE return_my_things;

-- =========================
-- Departments
-- =========================
CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

-- =========================
-- Students
-- =========================
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    register_number VARCHAR(20) UNIQUE NOT NULL,
    student_name VARCHAR(100) NOT NULL,
    department_id INT,
    year_of_study INT,
    email VARCHAR(100),
    phone VARCHAR(15),
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
);

-- =========================
-- Staff
-- =========================
CREATE TABLE staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    staff_code VARCHAR(20) UNIQUE NOT NULL,
    staff_name VARCHAR(100) NOT NULL,
    department_id INT,
    email VARCHAR(100),
    phone VARCHAR(15),
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
);

-- =========================
-- Admin
-- =========================
CREATE TABLE admins (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    full_name VARCHAR(100),
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- =========================
-- Lost Items
-- =========================
CREATE TABLE lost_items (
    lost_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    item_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    description TEXT,
    lost_location VARCHAR(150),
    lost_date DATE,
    item_image VARCHAR(255),
    status ENUM('Pending','Found','Returned') DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- =========================
-- Found Items
-- =========================
CREATE TABLE found_items (
    found_id INT AUTO_INCREMENT PRIMARY KEY,
    staff_id INT,
    item_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    description TEXT,
    found_location VARCHAR(150),
    found_date DATE,
    item_image VARCHAR(255),
    status ENUM('Available','Claimed','Returned') DEFAULT 'Available',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

-- =========================
-- Claim Requests
-- =========================
CREATE TABLE claim_requests (
    claim_id INT AUTO_INCREMENT PRIMARY KEY,
    lost_id INT,
    student_id INT,
    claim_message TEXT,
    claim_status ENUM('Pending','Approved','Rejected') DEFAULT 'Pending',
    request_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (lost_id) REFERENCES lost_items(lost_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- =========================
-- Notifications
-- =========================
CREATE TABLE notifications (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150),
    message TEXT,
    receiver_type ENUM('Student','Staff','Admin'),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- Feedback
-- =========================
CREATE TABLE feedback (
    feedback_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    feedback TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);
-- =========================
-- Default Departments
-- =========================
INSERT INTO departments (department_name) VALUES
('Computer Science Engineering'),
('Information Technology'),
('Electronics and Communication Engineering'),
('Electrical and Electronics Engineering'),
('Mechanical Engineering'),
('Civil Engineering');

-- =========================
-- Default Admin Account
-- =========================
INSERT INTO admins (username, full_name, password)
VALUES
('admin', 'System Administrator', 'admin123');