# 🏥 Hospital Management System

> A full-stack Java web application that digitizes hospital operations — patients, doctors, appointments and billing — in one secure, database-driven platform.

**Backend:** Java • Servlets • JDBC • MySQL  |  **Frontend:** JSP • HTML5 • CSS3 • JavaScript • Bootstrap  |  **Tools:** Apache Tomcat • Eclipse IDE • Git

---

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
| 📅 **Appointment Scheduling** | Book and manage patient–doctor appointments by date and time |
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
| 🎨 **Frontend Development** | HTML5, CSS3, JavaScript and Bootstrap for clean, responsive, validated forms |
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
| **HTML5** | Semantic page structure and forms |
| **CSS3** | Styling, layout and responsive design |
| **JavaScript** | Client-side form validation and interactivity |
| **Bootstrap** | Responsive grid, tables, forms and ready-made UI components |
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

The complete database used by the application (tables, columns and relationships) is available in the SQL file below:

📄 **[`HospitalMangementSystem.sql`](https://github.com/IshikaGangrade/hospitalmanagement_system/blob/main/HospitalMangementSystem.sql)**

**Get the database**

```bash
# Clone the repository (includes the SQL file)
git clone https://github.com/IshikaGangrade/hospitalmanagement_system.git
cd hospitalmanagement_system
```

**Import it into MySQL**

The SQL file creates the database and its tables by itself, so just run it:

```bash
mysql -u your_username -p < HospitalMangementSystem.sql
```

Or from the MySQL prompt:

```sql
SOURCE HospitalMangementSystem.sql;
```

---

## 🚀 Getting Started

### Prerequisites

- JDK 17 or higher
- Eclipse IDE for Enterprise Java Developers
- Apache Tomcat 9 or compatible
- MySQL Server and MySQL Connector/J

### Installation

**1. Clone the repository**

```bash
git clone https://github.com/IshikaGangrade/hospitalmanagement_system.git
cd hospitalmanagement_system
```

**2. Import the database**

```bash
mysql -u your_username -p < HospitalMangementSystem.sql
```

**3. Open in Eclipse**

`File → Import → General → Existing Projects into Workspace`

**4. Add the MySQL connector**

Place `mysql-connector-j.jar` in the build path and in `WEB-INF/lib`.

**5. Set database credentials**

```java
String url  = "jdbc:mysql://localhost:3306/hospitaldb";
String user = "root";
String pass = "your_password";
```

**6. Run**

Right-click the project → `Run As → Run on Server` → select Tomcat, then open:
```
http://localhost:8080/HospitalManagementSystem/
```

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

## 🎓 Key Learnings

- Designing a normalized relational database from real-world requirements
- Building full CRUD flows across the view, controller and database layers
- Debugging Java web applications and server-side errors on Tomcat
- Structuring code for readability and future extension

---

## 🗺️ Roadmap

- [ ] Role-based access (Admin, Doctor, Receptionist, Patient)
- [ ] Password hashing and stronger input validation
- [ ] Email / SMS appointment reminders
- [ ] PDF bills and medical reports
- [ ] Analytics dashboard
- [ ] REST API and fully responsive UI
- [ ] Unit tests and CI with GitHub Actions

---

## 📄 License

Licensed under the **Apache License 2.0** — see [`LICENSE`](./LICENSE).

---

## 👩‍💻 Author

**Ishika Gangrade**

GitHub: [@IshikaGangrade](https://github.com/IshikaGangrade)

⭐ *If this project helped or impressed you, please give it a star!*
