````markdown
# Smart Retail Inventory System

A production-grade system for real-time inventory management, purchasing workflow, and automated disaster recovery — powered by modern DevOps tooling.  
Built with `Flask`, `React`, `PostgreSQL`, `Docker`, `Kubernetes`, `Jenkins`, `Prometheus`, and `Grafana`.

---

## Features

- Inventory CRUD API – Built with Flask & PostgreSQL  
- Restocking Workflow – With full audit trail & logs  
- Low-Stock Alerts – Auto-flag products below threshold  
- Analytics & Trends – Track product stock changes over time  
- Purchase Flow – Reduce stock after each purchase  
- Containerized – Dockerized with Compose support  
- Cloud-Ready – Kubernetes manifests + ArgoCD GitOps  
- Monitoring – Prometheus metrics & Grafana dashboards  
- CI/CD – Automated Jenkins pipelines (build, push, deploy)

---

## Tech Stack

| Layer             | Technologies                                               |
|------------------|------------------------------------------------------------|
| API & Backend     | Python 3.9 · Flask · Flask-RESTful                         |
| Frontend (User)   | React · TypeScript · Tailwind CSS · React Query            |
| Database          | PostgreSQL                                                 |
| Containerization  | Docker · Docker Compose                                    |
| Orchestration     | Kubernetes (Minikube) · ArgoCD (GitOps)                    |
| Cloud             | AWS EC2 (DR-ready)                                         |
| Monitoring        | Prometheus · Grafana · Alertmanager                        |
| CI/CD             | Jenkins (Dockerized)                                       |

---

## Quick Start (Dev)

```bash
git clone https://github.com/RaniSaed/smart-retail-dev.git
cd smart-retail-dev/backend

python3 -m venv venv && source venv/bin/activate
pip install -r requirements.txt

python app.py  # Run on http://localhost:5000
```

---

## Docker Setup

```bash
# Backend only
docker build -t rani19/backend .
docker run -p 5000:5000 rani19/backend

# Full stack (backend + frontend + db + pgAdmin)
docker-compose up
```

---

## API Reference

### /api/products

| Method | Description       |
| ------ | ----------------- |
| GET    | Get all products  |
| POST   | Add a new product |

### /api/products/<id>

| Method | Description          |
| ------ | -------------------- |
| GET    | Get product by ID    |
| PUT    | Update product by ID |
| DELETE | Delete product by ID |

### /api/products/<id>/restock

| Method | Description                |
| ------ | -------------------------- |
| POST   | Add restock log + quantity |

### Analytics & Monitoring

| Endpoint                    | Description                 |
| --------------------------- | --------------------------- |
| /api/products/low-stock     | Get low-stock products      |
| /api/analytics/stock-trends | Visualize product trends    |
| /metrics                    | Prometheus metrics endpoint |
| /health                     | App health check            |

---

## Kubernetes Deployment

```bash
kubectl apply -f k8s/
kubectl get all -l app=smart-retail-backend
```

> Includes Deployments, Services, ConfigMaps, and Ingress

---

## Monitoring & Alerting

| Component        | Tool            | Description              |
| ---------------- | --------------- | ------------------------ |
| API Metrics      | Prometheus      | Track requests & latency |
| Resource Usage   | Node Exporter   | Monitor CPU / Memory     |
| Inventory Alerts | Custom Exporter | Trigger low-stock alerts |
| Dashboards       | Grafana         | Visual panels            |
| Alerts           | Alertmanager    | Email notifications      |

---

## CI/CD Pipeline (Jenkins)

Jenkinsfile stages:

1. Clone Dev & Config repositories  
2. Build Docker image  
3. Push to Docker Hub (`rani19/backend`)  
4. Update Kubernetes manifests  
5. Commit & push changes  
6. Trigger ArgoCD sync via GitOps  

> Pipelines are stored under `Jenkins_Backend/Jenkinsfile` and `Jenkins_Frontend/Jenkinsfile`

---

## Repository Structure

```txt
smart-retail-dev/
├── backend/
│   ├── app.py               # Flask app with REST API
│   ├── models.py            # Product & Restock models
│   ├── app_config.py        # DB config & env vars
│   ├── Dockerfile           # Flask container
│   ├── requirements.txt     # Python deps
│   └── seed.py              # Optional: populate DB
│
├── frontend/
│   ├── src/                 # React TSX components
│   ├── Dockerfile           # Frontend container
│   └── vite.config.ts       # Proxy config to backend
│
├── scripts/
│   ├── failover-check.sh    # Detect backend failure
│   ├── start-dev.sh         # Port forwarding helpers
│   └── auto-forward.sh      # Script automation
│
├── docker-compose.yml       # Full stack orchestrator
└── README.md
```

---

## Useful Links

* Dev Repository: [https://github.com/RaniSaed/smart-retail-dev](https://github.com/RaniSaed/smart-retail-dev)  
* Config Repository: [https://github.com/RaniSaed/smart-retail-config](https://github.com/RaniSaed/smart-retail-config)  
* Docker Hub: [https://hub.docker.com/u/rani19](https://hub.docker.com/u/rani19)

---

## Author

Rani Saed  
DevOps Engineer | Cloud & Kubernetes Enthusiast  
Email: [Rani.saed19@gmail.com](mailto:Rani.saed19@gmail.com)  
LinkedIn: [https://www.linkedin.com/in/rani-saed](https://www.linkedin.com/in/rani-saed)
````
