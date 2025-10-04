# Azure OpenAI 配置指南 🔧

本指南将帮助你配置 Azure OpenAI 服务以运行 Open Research ANA 项目。

## 1. 获取 Azure OpenAI 配置信息

### 步骤 1: 登录 Azure 门户
1. 访问 [Azure 门户](https://portal.azure.com/)
2. 使用你的 Azure 账户登录

### 步骤 2: 创建或访问 OpenAI 资源
1. 在搜索框中输入 "OpenAI"
2. 选择 "Azure OpenAI" 服务
3. 如果没有现有资源，点击 "创建" 创建新的 OpenAI 资源

### 步骤 3: 获取配置信息
在 OpenAI 资源页面中，你需要获取以下信息：

1. **API Key**:
   - 在左侧菜单中点击 "Keys and Endpoint"
   - 复制 "Key 1" 或 "Key 2"

2. **Endpoint**:
   - 在同一页面复制 "Endpoint" URL
   - 格式类似: `https://your-resource-name.openai.azure.com/`

3. **Deployment Name**:
   - 在左侧菜单中点击 "Deployments"
   - 复制现有部署的名称，或创建新的部署
   - 推荐使用 GPT-4 模型

4. **API Version**:
   - 通常使用 `2024-02-15-preview` 或最新版本

## 2. 配置环境变量

### 步骤 1: 复制环境变量模板
```bash
cp env.example .env
```

### 步骤 2: 编辑 .env 文件
```bash
nano .env
```

### 步骤 3: 填入 Azure OpenAI 配置
```bash
# Azure OpenAI 配置
AZURE_OPENAI_API_KEY=your_actual_api_key_here
AZURE_OPENAI_ENDPOINT=https://your-resource-name.openai.azure.com/
AZURE_OPENAI_API_VERSION=2024-02-15-preview
AZURE_OPENAI_DEPLOYMENT_NAME=your_deployment_name_here

# 其他必要的 API Keys
TAVILY_API_KEY=your_tavily_api_key_here
LANGSMITH_API_KEY=your_langsmith_api_key_here
AGENT_URL=http://agent:8123
```

## 3. 验证配置

### 步骤 1: 检查环境变量
```bash
# 检查 .env 文件内容
cat .env
```

### 步骤 2: 测试配置
```bash
# 运行启动脚本，它会检查配置
./start.sh
```

## 4. 常见问题解决

### 问题 1: API Key 无效
**症状**: 启动时提示 API Key 错误
**解决方案**:
- 检查 API Key 是否正确复制
- 确保没有多余的空格或换行符
- 尝试使用 Key 2 而不是 Key 1

### 问题 2: Endpoint 连接失败
**症状**: 无法连接到 Azure OpenAI 服务
**解决方案**:
- 检查 Endpoint URL 格式是否正确
- 确保 URL 以 `https://` 开头
- 检查网络连接

### 问题 3: 部署名称错误
**症状**: 提示部署不存在
**解决方案**:
- 在 Azure 门户中检查部署名称
- 确保部署状态为 "Succeeded"
- 检查部署的模型类型

### 问题 4: API 版本不兼容
**症状**: 提示 API 版本错误
**解决方案**:
- 尝试使用 `2024-02-15-preview`
- 或使用 `2024-06-01-preview`
- 检查 Azure OpenAI 资源支持的版本

## 5. 测试连接

### 使用 Python 测试
```python
import os
from langchain_openai import AzureChatOpenAI

# 设置环境变量
os.environ["AZURE_OPENAI_API_KEY"] = "your_api_key"
os.environ["AZURE_OPENAI_ENDPOINT"] = "https://your-resource.openai.azure.com/"
os.environ["AZURE_OPENAI_DEPLOYMENT_NAME"] = "your_deployment"

# 创建客户端
llm = AzureChatOpenAI(
    azure_deployment="your_deployment",
    azure_endpoint="https://your-resource.openai.azure.com/",
    api_version="2024-02-15-preview"
)

# 测试连接
response = llm.invoke("Hello, world!")
print(response.content)
```

## 6. 成本优化建议

### 使用 GPT-4o-mini 进行简单任务
- 在 `agent/config.py` 中，`FACTUAL_LLM` 使用 GPT-4o-mini
- 成本更低，适合事实性查询

### 监控使用情况
- 在 Azure 门户中查看使用量和成本
- 设置预算警报

## 7. 安全最佳实践

### API Key 安全
- 不要将 API Key 提交到版本控制系统
- 使用环境变量或密钥管理服务
- 定期轮换 API Key

### 网络安全
- 使用 VNet 集成（如果适用）
- 配置 IP 白名单
- 启用日志记录和监控

## 8. 故障排除

如果遇到问题，请按以下步骤排查：

1. **检查 Azure 服务状态**
   - 访问 [Azure 状态页面](https://status.azure.com/)

2. **查看日志**
   ```bash
   docker compose logs -f agent
   ```

3. **验证网络连接**
   ```bash
   # 测试网络连接
   curl -H "api-key: YOUR_API_KEY" \
        "https://your-resource.openai.azure.com/openai/deployments/your-deployment/chat/completions?api-version=2024-02-15-preview"
   ```

4. **检查配额限制**
   - 在 Azure 门户中检查是否有配额限制
   - 联系管理员增加配额

## 9. 获取帮助

如果仍然遇到问题，请：

1. 查看 [Azure OpenAI 文档](https://docs.microsoft.com/en-us/azure/cognitive-services/openai/)
2. 检查项目的 GitHub Issues
3. 联系 Azure 支持团队

---

配置完成后，你就可以使用 `./start.sh` 或 `./start-dev.sh` 启动项目了！🚀
