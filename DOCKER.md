# Docker 部署指南 🐳

本项目已使用 Docker Compose 进行容器化封装，支持生产环境和开发环境的一键部署。

## 快速开始

### 1. 环境准备

确保你的系统已安装：
- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

### 2. 配置环境变量

复制环境变量模板并配置你的 API Keys：

```bash
cp env.example .env
```

编辑 `.env` 文件，设置以下必要的 API Keys：

```bash
# Azure OpenAI 配置 (推荐)
AZURE_OPENAI_API_KEY=your_azure_openai_api_key_here
AZURE_OPENAI_ENDPOINT=https://your-resource-name.openai.azure.com/
AZURE_OPENAI_API_VERSION=2024-02-15-preview
AZURE_OPENAI_DEPLOYMENT_NAME=your-deployment-name

# Tavily API 配置 (用于实时搜索)
TAVILY_API_KEY=tvly-your-actual-key-here

# LangSmith API 配置 (用于监控和调试)
LANGSMITH_API_KEY=ls__your-actual-key-here

# Agent 服务 URL (本地 LangGraph 服务)
AGENT_URL=http://agent:8123
```

### 3. 启动项目

#### 生产环境启动

```bash
# 一键启动生产环境
./start.sh

# 或者手动启动
docker compose up -d
```

#### 开发环境启动

```bash
# 一键启动开发环境 (支持热重载)
./start-dev.sh

# 或者手动启动
docker compose -f docker-compose.dev.yml up -d
```

## 服务访问

启动成功后，你可以访问：

- **前端应用**: http://localhost:3000
- **Agent 服务**: http://localhost:8123

## 常用命令

### 生产环境

```bash
# 启动服务
./start.sh

# 停止服务
./start.sh stop
# 或
docker compose down

# 重启服务
./start.sh restart
# 或
docker compose restart

# 查看日志
./start.sh logs
# 或
docker compose logs -f

# 查看服务状态
./start.sh status
# 或
docker compose ps

# 清理所有容器和镜像
./start.sh clean
# 或
docker compose down -v --rmi all
```

### 开发环境

```bash
# 启动开发环境
./start-dev.sh

# 停止开发环境
./start-dev.sh stop
# 或
docker compose -f docker-compose.dev.yml down

# 重启开发环境
./start-dev.sh restart
# 或
docker compose -f docker-compose.dev.yml restart

# 查看开发环境日志
./start-dev.sh logs
# 或
docker compose -f docker-compose.dev.yml logs -f

# 查看开发环境状态
./start-dev.sh status
# 或
docker compose -f docker-compose.dev.yml ps

# 清理开发环境
./start-dev.sh clean
# 或
docker compose -f docker-compose.dev.yml down -v --rmi all
```

## 项目结构

```
open-research-ANA/
├── agent/                    # Python Agent 代码
├── frontend/                 # Next.js 前端代码
├── docker-compose.yml        # 生产环境配置
├── docker-compose.dev.yml    # 开发环境配置
├── Dockerfile.agent          # Agent 生产环境镜像
├── Dockerfile.agent.dev      # Agent 开发环境镜像
├── Dockerfile.frontend       # 前端生产环境镜像
├── Dockerfile.frontend.dev   # 前端开发环境镜像
├── start.sh                  # 生产环境启动脚本
├── start-dev.sh              # 开发环境启动脚本
├── env.example               # 环境变量模板
└── DOCKER.md                 # Docker 部署文档
```

## 开发环境特性

开发环境提供以下特性：

- **热重载**: 前端代码修改后自动重新加载
- **代码挂载**: Agent 代码修改后自动生效
- **实时日志**: 可以实时查看服务日志
- **快速调试**: 支持断点调试和错误追踪

## 生产环境特性

生产环境提供以下特性：

- **优化构建**: 使用多阶段构建优化镜像大小
- **安全运行**: 使用非 root 用户运行服务
- **性能优化**: 使用国内镜像源加速构建
- **稳定运行**: 适合生产环境部署

## 故障排除

### 常见问题

1. **端口冲突**: 确保 3000 和 8123 端口未被占用
2. **API Key 错误**: 检查 `.env` 文件中的 API Keys 是否正确
3. **构建失败**: 检查网络连接，确保可以访问镜像源
4. **服务启动失败**: 查看日志 `docker compose logs -f`

### 查看详细日志

```bash
# 查看所有服务日志
docker compose logs -f

# 查看特定服务日志
docker compose logs -f frontend
docker compose logs -f agent
```

### 重新构建镜像

```bash
# 重新构建所有镜像
docker compose build --no-cache

# 重新构建特定服务镜像
docker compose build --no-cache frontend
docker compose build --no-cache agent
```

## 镜像优化

本项目使用了以下优化策略：

- **国内镜像源**: 使用华为云镜像加速下载
- **多阶段构建**: 减少最终镜像大小
- **依赖缓存**: 优化构建时间
- **非 root 用户**: 提高安全性

## 支持

如果遇到问题，请：

1. 查看本文档的故障排除部分
2. 检查 Docker 和 Docker Compose 版本
3. 查看服务日志获取详细错误信息
4. 确保所有必要的 API Keys 已正确配置
