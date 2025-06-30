
<h1 align="center">🛍️ Smart Retail Inventory System</h1>

<p align="center">
  <strong>Real-time inventory management, analytics, and disaster recovery system</strong><br>
  Built with <code>Flask</code>, <code>PostgreSQL</code>, <code>Docker</code>, <code>Kubernetes</code>, <code>Prometheus</code>, and <code>Jenkins</code>
</p>

---

## ✨ Features

- 📦 <strong>Inventory Management</strong> – Full CRUD API using Flask + PostgreSQL
- 🔁 <strong>Restocking Operations</strong> – Track restock events with audit trail
- ⚠️ <strong>Low‑Stock Alerts</strong> – Automatically flag items below threshold
- 📊 <strong>Analytics & Trends</strong> – Visualize inventory movement and trends
- 🛒 <strong>Purchase Flow</strong> – Deduct stock in real-time after purchase
- 🐳 <strong>Containerized</strong> – Docker-first approach with `docker-compose`
- ☁️ <strong>Cloud‑Ready</strong> – Kubernetes manifests + ArgoCD GitOps support
- 📈 <strong>Monitoring</strong> – Prometheus metrics & Grafana dashboards
- 🚀 <strong>CI/CD</strong> – Jenkins-based automated pipeline

---

## 🧱 Tech Stack

| 🧩 Layer            | ⚙️ Technology                                      |
|--------------------|---------------------------------------------------|
| API                | Python 3.9 · Flask · Flask-RESTful               |
| Database           | PostgreSQL                                        |
| Containerization   | Docker · Docker Compose                          |
| Orchestration      | Kubernetes (Minikube / EC2) · ArgoCD (GitOps)    |
| Cloud              | AWS EC2 · GitOps-ready for EKS                   |
| Observability      | Prometheus · Grafana · Alertmanager              |
| CI/CD              | Jenkins (Dockerized)                             |

---

## ⚡ Quick Start

```bash
# Clone the repository
git clone https://github.com/RaniSaed/smart-retail-dev.git
cd smart-retail-dev/backend

# Set up Python environment
python3 -m venv venv && source venv/bin/activate
pip install -r requirements.txt

# Run the API
python app.py  # visit: http://localhost:5000
```

---

## 🐳 Docker Setup

```bash
# Build backend image
docker build -t rani19/backend .

# Run container
docker run -p 5000:5000 rani19/backend

# Or use full stack (Backend + PostgreSQL + Frontend + pgAdmin)
docker-compose up
```

---

## 📡 API Reference

### ▸ Inventory

| Method | Endpoint                                  | Description                         |
|--------|-------------------------------------------|-------------------------------------|
| GET    | /api/products                             | Get all products                    |
| POST   | /api/products                             | Add a new product                   |
| GET    | /api/products/<id>                        | Get a specific product              |
| PUT    | /api/products/<id>                        | Update a specific product           |
| DELETE | /api/products/<id>                        | Delete a product                    |
| POST   | /api/products/<id>/restock                | Restock a product                   |
| GET    | /api/products/low-stock                   | Get low-stock products              |
| GET    | /api/restocks                             | Get latest restock logs             |
| GET    | /api/dashboard/summary                    | Get dashboard summary               |
| GET    | /health                                   | App health check                    |
| GET    | /metrics                                  | Prometheus metrics endpoint         |


### ▸ Restocking

| Method | Endpoint                     | Description           |
|--------|------------------------------|-----------------------|
| POST   | /api/products/<id>/restock   | Add stock quantity    |

### ▸ Analytics

| Method | Endpoint                        | Description          |
|--------|----------------------------------|----------------------|
| GET    | /api/products/low-stock         | Get low stock items  |
| GET    | /api/analytics/stock-trends     | Get stock trends     |

> 🔐 Metrics available at `/metrics` for Prometheus scraping.

---

## 🚀 Deployment

### ☸️ Kubernetes

```bash
kubectl apply -f k8s/
kubectl get all -l app=smart-retail-backend
```

### ☁️ AWS EC2 (Demo)

```bash
docker pull rani19/backend:latest
docker run -p 5000:5000 -e DATABASE_URL=<your_postgres_url> rani19/backend
```

---

## 📊 Monitoring & Observability

| Metric            | Source              | Grafana Panel        |
|-------------------|---------------------|-----------------------|
| API Latency       | Prometheus Exporter | `API Latency (ms)`    |
| CPU / Memory      | Node Exporter       | `Container Resources` |
| Low-stock alerts  | Custom Exporter     | `Inventory Health`    |

---

## 🗂️ Repository Structure

```txt
smart-retail-dev/
├── backend/             # Flask API backend
├── frontend/            # React frontend
├── docker-compose.yml   # Local environment stack
├── k8s/                 # Kubernetes manifests
├── Jenkins_Backend/     # Jenkinsfile for backend CI/CD
├── Jenkins_Frontend/    # Jenkinsfile for frontend CI/CD
├── scripts/             # DR automation and failover scripts
├── logs/                # Logs for failover monitoring
└── README.md
```

---

