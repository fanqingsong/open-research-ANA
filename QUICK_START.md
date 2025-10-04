# 快速开始指南 🚀

## 一键启动

### 1. 配置环境变量

```bash
# 复制环境变量模板
cp env.example .env

# 编辑 .env 文件，设置你的 API Keys
nano .env
```

### 2. 启动项目

#### 生产环境
```bash
./start.sh
```

#### 开发环境 (支持热重载)
```bash
./start-dev.sh
```

### 3. 访问应用

- **前端**: http://localhost:3000
- **Agent API**: http://localhost:8123

## 常用命令

### 生产环境
```bash
./start.sh          # 启动
./start.sh stop     # 停止
./start.sh restart  # 重启
./start.sh logs     # 查看日志
./start.sh status   # 查看状态
./start.sh clean    # 清理所有
```

### 开发环境
```bash
./start-dev.sh          # 启动开发环境
./start-dev.sh stop     # 停止开发环境
./start-dev.sh restart  # 重启开发环境
./start-dev.sh logs     # 查看开发环境日志
./start-dev.sh status   # 查看开发环境状态
./start-dev.sh clean    # 清理开发环境
```

## 需要的 API Keys

1. **Azure OpenAI 配置** - 用于 AI 功能
   - `AZURE_OPENAI_API_KEY` - Azure OpenAI API 密钥
   - `AZURE_OPENAI_ENDPOINT` - Azure OpenAI 端点
   - `AZURE_OPENAI_DEPLOYMENT_NAME` - 部署名称
   - `AZURE_OPENAI_API_VERSION` - API 版本 (默认: 2024-02-15-preview)
2. **Tavily API Key** - 用于实时搜索
3. **LangSmith API Key** - 用于监控和调试
4. **AGENT_URL** - 本地 LangGraph Agent 服务 URL (默认: http://agent:8123)

## 故障排除

如果遇到问题，请查看 [DOCKER.md](./DOCKER.md) 获取详细说明。
