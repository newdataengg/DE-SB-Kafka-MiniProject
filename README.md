# **Kafka Fraud Detection System**

A real-time streaming fraud detection system built with Apache Kafka and Python that processes financial transactions and identifies potentially fraudulent activities.

## **Architecture**

```
Transaction Generator → Kafka Broker → Fraud Detector → Legitimate/Fraudulent Topics
```

## **Quick Start**

### **Prerequisites**
- Docker Desktop running
- 4GB+ RAM available

### **Setup**
```bash
# 1. Create network
docker network create kafka-network

# 2. Start Kafka cluster
docker-compose -f docker-compose.kafka.yml up -d

# 3. Wait 15 seconds for Kafka to initialize, then start applications
docker-compose up
```

### **Monitor Results**
```bash
# View fraud detection in real-time
docker-compose logs -f detector

# Monitor legitimate transactions
docker-compose -f docker-compose.kafka.yml exec broker kafka-console-consumer --bootstrap-server localhost:9092 --topic streaming.transactions.legit

# Monitor fraudulent transactions  
docker-compose -f docker-compose.kafka.yml exec broker kafka-console-consumer --bootstrap-server localhost:9092 --topic streaming.transactions.fraud
```

## **Project Structure**
```
├── docker-compose.yml              # Application services
├── docker-compose.kafka.yml        # Kafka cluster
├── detector/                       # Fraud detection service
│   ├── Dockerfile
│   ├── app.py                      # Consumer + fraud logic
│   └── requirements.txt
└── generator/                      # Transaction generator service
    ├── Dockerfile
    ├── app.py                      # Producer
    ├── transactions.py             # Transaction utilities
    └── requirements.txt
```

## **How It Works**

1. **Generator** creates fake transactions (1/second) → `queueing.transactions` topic
2. **Detector** consumes transactions, applies fraud logic (amount ≥ $900 = fraud)
3. **Output** routes to `streaming.transactions.legit` or `streaming.transactions.fraud`

## **Sample Transaction**
```json
{
  "source": "abc123def456",
  "target": "xyz789uvw012", 
  "amount": 543.21,
  "currency": "USD"
}
```

## **Expected Results**
- ~90% legitimate transactions (< $900)
- ~10% fraudulent transactions (≥ $900)

## **Screenshots**

### **System Running**
![System Output](screenshots/system-running.png)

### **Fraud Detection in Action**
![Fraud Detection](screenshots/fraud-detection.png)

### **Kafka Topics with Messages**
![Kafka Topics](screenshots/kafka-topics.png)

## **Cleanup**
```bash
# Stop applications
docker-compose down

# Stop Kafka
docker-compose -f docker-compose.kafka.yml down

# Remove network
docker network rm kafka-network
```

## **Technologies**
- **Apache Kafka** - Stream processing
- **Python** - Application logic  
- **kafka-python** - Kafka client
- **Docker** - Containerization

## **Troubleshooting**

**Connection issues?**
```bash
# Ensure Kafka is running
docker-compose -f docker-compose.kafka.yml ps

# Check logs
docker-compose logs
```

**No messages?** Wait 30 seconds for Kafka initialization before starting applications.

---

**Built for demonstrating real-time stream processing with Kafka** 🚀