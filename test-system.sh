#!/bin/bash

echo "=== 测试系统状态 ==="

# 检查 Docker 服务状态
echo "1. 检查 Docker 服务状态..."
docker compose -f docker-compose.dev.yml ps

echo -e "\n2. 检查前端服务..."
curl -s -o /dev/null -w "前端服务状态: %{http_code}\n" http://localhost:3000

echo -e "\n3. 检查 Agent 服务..."
curl -s -o /dev/null -w "Agent 服务状态: %{http_code}\n" http://localhost:8123

echo -e "\n4. 检查环境变量..."
echo "AGENT_URL: ${AGENT_URL:-未设置}"
echo "AZURE_OPENAI_API_KEY: ${AZURE_OPENAI_API_KEY:-未设置}"
echo "AZURE_OPENAI_ENDPOINT: ${AZURE_OPENAI_ENDPOINT:-未设置}"
echo "AZURE_OPENAI_DEPLOYMENT_NAME: ${AZURE_OPENAI_DEPLOYMENT_NAME:-未设置}"

echo -e "\n5. 测试 Agent 端点..."
curl -s -X POST http://localhost:8123/ -H "Content-Type: application/json" -d '{"input": {"messages": [{"role": "user", "content": "Hello"}]}}' | head -100

echo -e "\n=== 测试完成 ==="