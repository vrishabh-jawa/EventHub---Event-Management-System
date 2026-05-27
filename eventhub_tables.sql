CREATE TABLE IF NOT EXISTS users (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    first_name  VARCHAR(50)  NOT NULL,
    last_name   VARCHAR(50)  NOT NULL,
    email       VARCHAR(100) NOT NULL UNIQUE,
    phone       VARCHAR(15),
    password    VARCHAR(255) NOT NULL,
    role        ENUM('attendee', 'organizer', 'admin') DEFAULT 'attendee',
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS events (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    title        VARCHAR(150) NOT NULL,
    description  TEXT,
    category     VARCHAR(50),
    event_date   DATE NOT NULL,
    event_time   TIME,
    location     VARCHAR(200),
    capacity     INT DEFAULT 100,
    price        DECIMAL(10,2) DEFAULT 0.00,
    organizer_id INT,
    status       ENUM('active', 'upcoming', 'cancelled', 'completed') DEFAULT 'upcoming',
    created_at   DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (organizer_id) REFERENCES users(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS bookings (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    user_id      INT,
    event_id     INT NOT NULL,
    fullname     VARCHAR(100) NOT NULL,
    email        VARCHAR(100) NOT NULL,
    phone        VARCHAR(15),
    tickets      INT DEFAULT 1,
    total_amount DECIMAL(10,2) DEFAULT 0.00,
    notes        TEXT,
    status       ENUM('confirmed', 'pending', 'cancelled') DEFAULT 'pending',
    booked_at    DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id)  REFERENCES users(id)  ON DELETE SET NULL,
    FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE
);

INSERT INTO users (first_name, last_name, email, phone, password, role) VALUES
('Admin', 'User', 'admin@eventhub.com', '9876543210',
 '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin');

INSERT INTO users (first_name, last_name, email, phone, password, role) VALUES
('Vrishabh', 'Jawa', 'vrishabh@email.com', '9876543211',
 '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'organizer');

INSERT INTO users (first_name, last_name, email, phone, password, role) VALUES
('Ananya', 'Sharma', 'ananya@email.com', '9876543212',
 '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'attendee');

INSERT INTO events (title, description, category, event_date, event_time, location, capacity, price, organizer_id, status) VALUES
('Hackathon 2025', '48-hour coding challenge open to all branches!', 'Tech', '2025-11-20', '09:00:00', 'Bennett University, Greater Noida', 200, 0.00, 2, 'active'),
('AI & Innovation Summit', 'Industry leaders discuss the future of AI and technology.', 'Tech', '2025-12-15', '10:00:00', 'New Delhi, India', 500, 499.00, 2, 'upcoming'),
('Annual Cultural Fest', 'Dance, music, art and food from across India!', 'Cultural', '2025-12-05', '11:00:00', 'Shyam Nagar, Jaipur', 300, 199.00, 2, 'upcoming'),
('Startup Pitch Day', 'Present your idea to top investors and VCs.', 'Business', '2026-01-10', '09:30:00', 'Cyber Hub, Gurugram', 100, 299.00, 2, 'upcoming');

INSERT INTO bookings (user_id, event_id, fullname, email, phone, tickets, total_amount, status) VALUES
(3, 1, 'Ananya Sharma', 'ananya@email.com', '9876543212', 1, 0.00, 'confirmed'),
(3, 2, 'Ananya Sharma', 'ananya@email.com', '9876543212', 1, 499.00, 'confirmed');
