#!/bin/bash
echo "🛑 Stopping all services..."
docker-compose down 2>/dev/null
docker-compose -f docker-compose.kafka.yml down 2>/dev/null

echo "🔧 Setting up network..."
docker network rm kafka-network 2>/dev/null || true
docker network create kafka-network

echo "🚀 Starting Kafka cluster..."
docker-compose -f docker-compose.kafka.yml up -d

echo "⏳ Waiting for Kafka to initialize..."
sleep 15

echo "✅ Starting fraud detection system..."
docker-compose up

echo "🎉 System ready! Press Ctrl+C to stop."