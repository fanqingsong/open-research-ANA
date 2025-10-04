# open-research-ANA 🔍

This demo showcases ANA (Agent Native Application), a research canvas app that combines Human-in-the-Loop capabilities with [Tavily's](https://tavily.com/) real-time search and [CopilotKit's](https://copilotkit.ai) agentic interface. 

Powered by [LangGraph](https://www.langchain.com/langgraph), it simplifies complex research tasks, making them more interactive and efficient.

<p align="left">
   <a href="https://docs.copilotkit.ai/coagents" rel="dofollow">
      <strong>Explore the CopilotKit docs »</strong>
   </a>
</p>

![tavily-demo](https://github.com/user-attachments/assets/70c7db1b-de5b-4fb2-b447-09a3a1b78d73)

## Quick Start 🚀

### 1. Prerequisites
This projects uses the following tools:

- [pnpm](https://pnpm.io/installation)
- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/)

### 2. API Keys Needed
Running locally, you'll need the following API keys:

- [Azure OpenAI](https://azure.microsoft.com/en-us/products/ai-services/openai-service) (推荐)
- [Tavily](https://tavily.com/#pricing)
- [LangSmith](https://docs.smith.langchain.com/administration/how_to_guides/organization_management/create_account_api_key)

### 3. 环境配置
创建环境配置文件：

```bash
# 复制环境变量模板
cp env.example .env

# 编辑 .env 文件，填入你的 API 密钥
nano .env
```

### 4. 启动应用
使用 Docker Compose 一键启动所有服务：

```bash
# 启动所有服务
docker compose up -d

# 查看服务状态
docker compose ps

# 查看日志
docker compose logs -f
```

### 5. 访问应用
- 前端应用: http://localhost:3000
- 代理服务: http://localhost:8123

## 开发模式 🛠️

如果需要开发模式（支持热重载）：

```bash
# 启动开发环境
docker compose -f docker-compose.dev.yml up -d

# 查看开发环境日志
docker compose -f docker-compose.dev.yml logs -f
```

## 停止服务 🛑

```bash
# 停止所有服务
docker compose down

# 停止并删除所有数据
docker compose down -v
```

## Documentation 📚
- [CopilotKit Docs](https://docs.copilotkit.ai/coagents)
- [LangGraph Docs](https://langchain-ai.github.io/langgraph/)
