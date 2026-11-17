# 🏥 Hospital Management System

> A full-stack Java web application that digitizes hospital operations — patients, doctors, appointments and billing — in one secure, database-driven platform.

**Java** • **JSP & Servlets** • **JDBC** • **MySQL** • **Apache Tomcat** • **Eclipse IDE**
📌 Problem Statement
Hospitals require centralized control over patient records, doctor management, department administration, appointment scheduling, prescriptions, and audit tracking.

Manual or disconnected systems introduce inefficiencies, security risks, and poor traceability.
This system provides a structured, secure, database-driven platform to manage multi-role healthcare operations in a unified environment.

## 📖 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Skills Highlighted](#-skills-highlighted)
- [Tech Stack](#%EF%B8%8F-tech-stack--what-i-used-it-for)
- [Architecture](#%EF%B8%8F-architecture)
- [Database Design](#%EF%B8%8F-database-design)
- [Getting Started](#-getting-started)
- [Project Structure](#-project-structure)
- [Key Learnings](#-key-learnings)
- [Roadmap](#%EF%B8%8F-roadmap)
- [License](#-license)
- [Author](#-author)

---

## 🎯 Overview

Hospitals manage a huge amount of data every day — patient histories, doctor schedules, appointments and payments. Managing this on paper leads to lost records, double bookings and long queues.

**Hospital Management System** replaces manual registers with a centralized web application. Staff can register patients, manage doctors, schedule appointments and handle billing, while every record is stored reliably in a relational database.

| | |
|---|---|
| **Problem** | Manual, error-prone hospital record keeping |
| **Solution** | A structured, searchable, database-backed web application |
| **Outcome** | Faster workflows, fewer errors, one source of truth |

---

## ✨ Features

| Module | Description |
|--------|-------------|
| 👤 **Patient Management** | Register patients; create, view, update, search and delete records |
| 🩺 **Doctor Management** | Maintain doctor profiles with specialization and contact details |
| 📅 **Appointment Mangement** | Book and manage patient–doctor appointments by date and time |
| 💳 **Billing** | Generate bills and track payment details for each patient |
| 🔐 **Secure Login** | Authenticated access so only authorized staff can use the system |
| 🗄️ **Reliable Storage** | Relational MySQL database with a ready-to-import SQL schema |

---

## 🚀 Skills Highlighted

This project demonstrates practical, job-relevant engineering skills:

| Skill | How it is demonstrated |
|-------|------------------------|
| ☕ **Core & Advanced Java** | Object-oriented design, classes, exception handling, collections |
| 🌐 **Java Web Development** | Servlets and JSP handling HTTP requests and dynamic pages |
| 🗄️ **Database Design (SQL)** | Normalized tables with primary and foreign keys |
| 🔌 **JDBC Integration** | Connecting Java to MySQL and running CRUD queries |
| 🧱 **MVC Architecture** | Separation of view, controller and data-access logic |
| 🛠️ **Server Deployment** | Configuring and running a web app on Apache Tomcat |
| 🔍 **Debugging & Problem Solving** | Tracing request flow, SQL errors and server logs |
| 🔀 **Version Control** | Git and GitHub workflow with structured commits |
| 📝 **Documentation** | Clear README, setup guide and schema file |

---

## 🛠️ Tech Stack — What I Used It For

| Technology | Purpose in this project |
|------------|------------------------|
| **Java** | Core application and business logic |
| **JSP** | Dynamic pages and forms for the user interface |
| **Servlets** | Controllers that process requests and responses |
| **JDBC** | Database connectivity and CRUD operations |
| **MySQL** | Persistent storage of patients, doctors, appointments and bills |
| **HTML / CSS** | Page structure and styling |
| **Apache Tomcat** | Web server to deploy and run the application |
| **Eclipse IDE** | Development as a Dynamic Web Project |
| **Git & GitHub** | Version control and project hosting |

---

## 🏗️ Architecture

The application follows a layered **MVC** design:

```text
 ┌────────────┐    ┌─────────────┐    ┌─────────────┐    ┌───────────┐
 │ JSP / HTML │ ─► │  Servlets   │ ─► │ DAO / JDBC  │ ─► │   MySQL   │
 │   (View)   │ ◄─ │(Controller) │ ◄─ │   (Model)   │ ◄─ │ (Database)│
 └────────────┘    └─────────────┘    └─────────────┘    └───────────┘
```

**Request flow:** user submits a form → servlet validates and routes → DAO runs the SQL query → result is returned to a JSP page.
## 🗃️ Database Design

Full schema: [`HospitalMangementSystem.sql`](./HospitalMangementSystem.sql)

```text
   PATIENT ───< APPOINTMENT >─── DOCTOR
      │
      └────< BILL
```

- One patient → many appointments and bills
- One doctor → many appointments
- Primary and foreign keys enforce data integrity

---

## 🚀 Getting Started

### Prerequisites

- JDK 17 or higher
- Eclipse IDE for Enterprise Java Developers
- Apache Tomcat 10 or compatible
- MySQL Server and MySQL Connector/Jar9

### Installation

**1. Clone the repository**

```bash
git clone https://github.com/IshikaGangrade/hospitalmanagement_system.git
cd hospitalmanagement_system
```

**2. Import the database**

```sql
CREATE DATABASE hospital_management;
USE hospital_management;
SOURCE HospitalMangementSystem.sql;
```

**3. Open in Eclipse**

`File → Import → General → Existing Projects into Workspace`

**4. Add the MySQL connector**

Place `mysql-connector-j.jar` in the build path and in `WEB-INF/lib`.

**6. Run**

Right-click the project → `Run As → Run on Server` → select Tomcat, then open:

```
http://localhost:8080/hospitalmanagement_system
```

---

## 📂 Project Structure

```text
hospitalmanagement_system/
├── src/main/                      # Java source code & web content
├── build/classes/                 # Compiled output
├── HospitalMangementSystem.sql    # Database schema
├── .classpath / .project          # Eclipse configuration
├── .settings/                     # Eclipse settings
├── LICENSE                        # Apache 2.0
└── README.md
```

🔒 Security Implementation
Session-based authentication
Role-based authorization
AuthFilter for login protection
RoleFilter for endpoint-level access control
Restricted dashboard access per role
Direct JSP access prevention

## 🎓 Key Learnings

- Designing a normalized relational database from real-world requirements
- Building full CRUD flows across the view, controller and database layers
- Debugging Java web applications and server-side errors on Tomcat
- Structuring code for readability and future extension

---

## 🗺️ Roadmap

- [ ] Role-based access (Admin, Doctor, bills, Patient)
- [ ] Password hashing and stronger input validation
- [ ] Email / SMS appointment reminders
- [ ] PDF bills and medical reports
- [ ] Analytics dashboard
- [ ] Unit tests and CI with GitHub Actions

---

## 📄 License

Licensed under the **Apache License 2.0** — see [`LICENSE`](./LICENSE).

---

## 👩‍💻 Author

**Ishika Gangrade**

GitHub: [@IshikaGangrade](https://github.com/IshikaGangrade)

⭐ *If this project helped or impressed you, please give it a star!*
