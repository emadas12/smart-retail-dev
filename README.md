# Smart Retail Inventory System

---

**Real-time inventory control platform for modern retail**  
Empowering businesses with analytics, automation, and disaster recovery.

Built using **Flask**, **React**, **PostgreSQL**, **Docker**, **Kubernetes**, **Jenkins**, **Prometheus**, and **Grafana** — delivering performance, scalability, and full DevOps integration.

---

## Features

- **Inventory API** – Full CRUD operations for managing products with Flask + PostgreSQL  
- **Restocking Automation** – Intelligent system with audit logs for every restock event  
- **Low-Stock Detection** – Alerts for items under threshold to avoid inventory shortages  
- **Analytics Dashboard** – Track stock trends and product movement over time  
- **Integrated Purchase Flow** – Automatically deduct stock on every product purchase  
- **Dockerized Architecture** – Portable setup via Docker & Docker Compose  
- **Cloud-Native Deployments** – Kubernetes manifests with GitOps via ArgoCD  
- **Monitoring & Alerts** – Prometheus for metrics, Grafana for dashboards  
- **CI/CD Pipelines** – Automated Jenkins flow: build, push, deploy

---

## Tech Stack

| Category           | Technologies                                             |
|--------------------|----------------------------------------------------------|
| Backend & API      | Python 3.9 · Flask · Flask-RESTful                       |
| Frontend           | React · TypeScript · Tailwind CSS · React Query          |
| Database           | PostgreSQL                                               |
| Containerization   | Docker · Docker Compose                                  |
| Orchestration      | Kubernetes (Minikube) · ArgoCD (GitOps)                  |
| Cloud Platform     | AWS EC2 (Disaster Recovery ready)                        |
| Monitoring         | Prometheus · Grafana · Alertmanager                      |
| CI/CD              | Jenkins (Dockerized)                                     |

---

## Quick Start (Development)

Follow these steps to get the backend running locally:

```bash
# 1. Clone the repository
git clone https://github.com/RaniSaed/smart-retail-dev.git
cd smart-retail-dev/backend

# 2. Set up a Python virtual environment
python3 -m venv venv
source venv/bin/activate

# 3. Install dependencies
pip install -r requirements.txt

# 4. Run the Flask server
python app.py  # Visit: http://localhost:5000
```

---

## Docker Setup

Use Docker for consistent local and production environments.

### Run Backend Only

```bash
docker build -t rani19/backend .
docker run -p 5000:5000 rani19/backend
```

### Run Full Stack

```bash
docker-compose up
```

This will launch:
- Backend API (Flask)
- PostgreSQL database
- Frontend (React)
- pgAdmin for DB management

---


### Full Stack with Docker Compose

Deploy the entire application stack (backend, frontend, database, and pgAdmin) using Docker Compose:

```bash
docker-compose up
```

-----

## ⚙️ API Reference

The Smart Retail Inventory System exposes a comprehensive RESTful API for managing products and inventory.

### `/api/products`

| Method | Description                       |
| :----- | :-------------------------------- |
| `GET`  | Retrieve a list of all products.  |
| `POST` | Add a new product to the inventory. |

### `/api/products/<id>`

| Method   | Description                               |
| :------- | :---------------------------------------- |
| `GET`    | Retrieve a specific product by its ID.    |
| `PUT`    | Update an existing product by its ID.     |
| `DELETE` | Remove a product from the inventory by its ID. |

### `/api/products/<id>/restock`

| Method | Description                                  |
| :----- | :------------------------------------------- |
| `POST` | Record a restock event and update the quantity for a product. |

### Analytics & Monitoring Endpoints

| Endpoint                      | Description                                   |
| :---------------------------- | :-------------------------------------------- |
| `/api/products/low-stock`     | Get a list of all products currently low on stock. |
| `/api/analytics/stock-trends` | Access data for visualizing product stock trends over time. |
| `/metrics`                    | Prometheus metrics endpoint for monitoring.   |
| `/health`                     | Application health check endpoint.            |

-----

## 🌐 Kubernetes Deployment

Deploy the Smart Retail Inventory System to a Kubernetes cluster for scalable and resilient operations.

```bash
kubectl apply -f k8s/
kubectl get all -l app=smart-retail-backend
```

**Note**: This deployment includes Kubernetes `Deployments`, `Services`, `ConfigMaps`, and `Ingress` resources, providing a complete application setup.

-----

## 📊 Monitoring & Alerting

The system integrates robust monitoring and alerting solutions to ensure high availability and proactive issue detection.

| Component          | Tool            | Description                                                    |
| :----------------- | :---------------- | :------------------------------------------------------------- |
| **API Metrics** | Prometheus      | Tracks API request rates, latency, and error rates.            |
| **Resource Usage** | Node Exporter   | Monitors underlying server resources like CPU, memory, and disk I/O. |
| **Inventory Alerts** | Custom Exporter | Triggers custom alerts specifically for low-stock conditions.  |
| **Dashboards** | Grafana         | Provides interactive and insightful visual panels for all metrics. |
| **Alerts** | Alertmanager    | Manages and dispatches notifications (e.g., email) for critical alerts. |

-----

## 🔄 CI/CD Pipeline (Jenkins)

Automated continuous integration and deployment are handled by Jenkins, ensuring a smooth and efficient development workflow.

The `Jenkinsfile` defines the following stages:

1.  **Clone Repositories**: Clones both development (`smart-retail-dev`) and configuration (`smart-retail-config`) repositories.
2.  **Build Docker Image**: Constructs the Docker image for the application.
3.  **Push to Docker Hub**: Pushes the newly built image to Docker Hub (`rani19/backend`).
4.  **Update Kubernetes Manifests**: Modifies Kubernetes deployment configurations.
5.  **Commit & Push Changes**: Commits updated manifests and pushes them to the Git repository.
6.  **Trigger ArgoCD Sync**: Initiates an ArgoCD synchronization, leveraging GitOps principles for deployment.

<!-- end list -->

  * Pipelines for both backend and frontend are located at:
      * `Jenkins_Backend/Jenkinsfile`
      * `Jenkins_Frontend/Jenkinsfile`

-----

## 📂 Repository Structure

```
smart-retail-dev/
├── backend/
│   ├── app.py               # Main Flask application with REST API endpoints
│   ├── models.py            # Database models for products and restock logs
│   ├── app_config.py        # Application configuration, including database settings and environment variables
│   ├── Dockerfile           # Dockerfile for building the Flask backend container
│   ├── requirements.txt     # Python dependency list
│   └── seed.py              # (Optional) Script to populate the database with initial data
│
├── frontend/
│   ├── src/                 # React TypeScript (TSX) components for the user interface
│   ├── Dockerfile           # Dockerfile for building the React frontend container
│   └── vite.config.ts       # Vite configuration, including proxy settings to the backend
│
├── scripts/
│   ├── failover-check.sh    # Script to detect backend service failures
│   ├── start-dev.sh         # Helper script for development environment setup (e.g., port forwarding)
│   └── auto-forward.sh      # Automation script for port forwarding or other recurring tasks
│
├── docker-compose.yml       # Docker Compose configuration for orchestrating the full application stack
└── README.md                # This README file
```

-----

## 🔗 Useful Links

  * **Development Repository**: [https://github.com/RaniSaed/smart-retail-dev](https://github.com/RaniSaed/smart-retail-dev)
  * **Configuration Repository**: [https://github.com/RaniSaed/smart-retail-config](https://github.com/RaniSaed/smart-retail-config)
  * **Docker Hub Profile**: [https://hub.docker.com/u/rani19](https://hub.docker.com/u/rani19)

-----

## 👨‍💻 Author

**Rani Saed**
DevOps Engineer | Cloud & Kubernetes Enthusiast

  * **Email**: [Rani.saed19@gmail.com](mailto:Rani.saed19@gmail.com)
  * **LinkedIn**: [https://www.linkedin.com/in/rani-saed](https://www.linkedin.com/in/rani-saed)

<!-- end list -->

```
```