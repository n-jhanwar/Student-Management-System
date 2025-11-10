# Project Journey: From Local Development to Production
This project details my work and learning process for the [one2n SRE Bootcamp Exercises](https://one2n.io/sre-bootcamp/sre-bootcamp-exercises), It represents my complete journey in building a simple REST API and preparing it for a professional, reliable production environment.

## 🚀 SRE Deployment Milestones
| S.NO. | Milestone | Focus Area |
| :---: | :--- | :--- |
| **1** | Create a simple REST API Webserver | Building the foundational application. |
| **2** | Containerise REST API | Packaging the application using **Docker** for environment consistency. |
| **3** | Setup one-click local development setup | Streamlining the developer experience and setup process. |
| **4** | Setup a CI pipeline | Implementing **Continuous Integration** for automated testing and building. |
| **5** | Deploy on bare metal | The initial, simpler production deployment. |
| **6** | Setup Kubernetes cluster | Establishing the environment for scalable **container orchestration**. |
| **7** | Deploy in K8s | Running the application inside the **Kubernetes (K8s)** cluster. |

## Prerequisites
### Ruby version
3.4.7
### Rails Version
8.1.1
### PostgreSQL
[PostgreSQL@18](https://postgresapp.com/downloads.html)

## Setup and Installation
- Clone the repository and navigate into the project directory.
```
git clone git@github.com:n-jhanwar/Student-Management-System.git
```
- Run
  ```
  bundle install
  ```
- The project should have a file named `config/database.yml.example`. Copy it to `config/database.yml` and edit the credentials for your local PostgreSQL setup.
  ```
  cp config/database.yml.example config/database.yml
  ```
- Create database and run migrations
  ```
  rails db:create
  rails db:migrate
  ```
- Start rails server
  ```
  rails s
  ```

