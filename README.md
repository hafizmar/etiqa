# Etiqa - To-Do List

### Project Overview

This project aims to develop a To-Do List application using Flutter for the front-end and Laravel for the back-end. The application will leverage the GetX state management library in Flutter for efficient and reactive state management. The database will be implemented in the Laravel framework using SQLite.

### Technologies 

* Flutter: For developing the front-end mobile application.
* GetX: For state management within the Flutter application.
* Laravel: For creating the back-end API and handling server-side logic. Laravel is hosted at www.hafizmar.com
* SQLite: For the database to store tasks and user data within Laravel.

### Prerequisites

* Flutter 3.x or higher
* Composer
* PHP 8.x or higher
* Laravel 11.x or higher
* SQLite

### Architecture

![architecture design](https://github.com/hafizmar/etiqa/blob/main/assets/etiqa_archi.JPG?raw=true)

### Features

* Task Management: CRUD (Create, Read, Update, Delete) operations for tasks.
* Real-Time Updates: Immediate reflection of changes in the UI using GetX state management.

### Architecture

1. Front-end (Flutter)
* UI Components: Using Flutter widgets to create a visually appealing and user-friendly interface.
* State Management: GetX for reactive state management, dependency injection, and route management.
* HTTP Requests: Using built-in HTTP client for API communication

2. Back-end (Laravel)
* API Routes: Defining routes for task management (CRUD operations).
* Controllers: Handling incoming requests and returning appropriate responses.
* Models: Representing data and business logic.
* Migrations: Defining and running migrations to create and update the SQLite database schema.

3. Database (SQLite)
* Schema Design: Designing tables for users, tasks, and categories.
* Migrations: Using Laravel migrations to manage database schema.

### Installation

1. Clone the repo

* git clone https://github.com/hafizmar/etiqa.git
* flutter run

### License 

This project is use for assessment only.