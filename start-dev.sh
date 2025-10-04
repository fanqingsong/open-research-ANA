#!/bin/bash

# Open Research ANA 项目开发环境一键启动脚本
# 作者: AI Assistant
# 描述: 使用 Docker Compose 启动开发环境

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印带颜色的消息
print_message() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}  Open Research ANA 开发环境启动器${NC}"
    echo -e "${BLUE}================================${NC}"
}

# 检查 Docker 是否安装
check_docker() {
    if ! command -v docker &> /dev/null; then
        print_error "Docker 未安装，请先安装 Docker"
        exit 1
    fi
    
    if ! command -v docker compose &> /dev/null; then
        print_error "Docker Compose 未安装，请先安装 Docker Compose"
        exit 1
    fi
}

# 检查环境变量文件
check_env_file() {
    if [ ! -f ".env" ]; then
        print_warning "未找到 .env 文件，正在创建..."
        if [ -f "env.example" ]; then
            cp env.example .env
            print_warning "请编辑 .env 文件，设置你的 API Keys"
            print_warning "然后重新运行此脚本"
            exit 1
        else
            print_error "未找到 env.example 文件"
            exit 1
        fi
    fi
    
    # 检查是否设置了必要的 API Keys
    has_openai_key=$(grep -q "OPENAI_API_KEY=sk-" .env && echo "true" || echo "false")
    has_azure_key=$(grep -q "AZURE_OPENAI_API_KEY=" .env && echo "true" || echo "false")
    has_azure_endpoint=$(grep -q "AZURE_OPENAI_ENDPOINT=" .env && echo "true" || echo "false")
    has_azure_deployment=$(grep -q "AZURE_OPENAI_DEPLOYMENT_NAME=" .env && echo "true" || echo "false")
    has_tavily_key=$(grep -q "TAVILY_API_KEY=tvly-" .env && echo "true" || echo "false")
    has_langsmith_key=$(grep -q "LANGSMITH_API_KEY=lsv2_" .env && echo "true" || echo "true")
    has_agent_url=$(grep -q "AGENT_URL=" .env && echo "true" || echo "false")
    
    # 检查 OpenAI 或 Azure OpenAI 配置
    if [ "$has_openai_key" = "false" ] && [ "$has_azure_key" = "false" ]; then
        print_warning "请在 .env 文件中设置 OPENAI_API_KEY 或 Azure OpenAI 配置"
    fi
    
    if [ "$has_azure_key" = "true" ]; then
        if [ "$has_azure_endpoint" = "false" ]; then
            print_warning "请在 .env 文件中设置 AZURE_OPENAI_ENDPOINT"
        fi
        if [ "$has_azure_deployment" = "false" ]; then
            print_warning "请在 .env 文件中设置 AZURE_OPENAI_DEPLOYMENT_NAME"
        fi
    fi
    
    if [ "$has_tavily_key" = "false" ]; then
        print_warning "请在 .env 文件中设置 TAVILY_API_KEY"
    fi
    
    if [ "$has_langsmith_key" = "false" ]; then
        print_warning "请在 .env 文件中设置 LANGSMITH_API_KEY"
    fi
    
    if [ "$has_agent_url" = "false" ]; then
        print_warning "请在 .env 文件中设置 AGENT_URL"
    fi
    
    # 检查必要的配置
    if [ "$has_openai_key" = "false" ] && [ "$has_azure_key" = "false" ]; then
        print_warning ""
        print_warning "请编辑 .env 文件，设置 OpenAI 或 Azure OpenAI 配置"
        print_warning "然后重新运行此脚本"
        exit 1
    fi
    
    if [ "$has_tavily_key" = "false" ] || [ "$has_langsmith_key" = "false" ] || [ "$has_agent_url" = "false" ]; then
        print_warning ""
        print_warning "请编辑 .env 文件，设置所有必要的 API Keys"
        print_warning "然后重新运行此脚本"
        exit 1
    fi
}

# 停止现有容器
stop_containers() {
    print_message "停止现有容器..."
    docker compose -f docker-compose.dev.yml down --remove-orphans 2>/dev/null || true
}

# 构建镜像
build_images() {
    print_message "构建开发环境 Docker 镜像..."
    docker compose -f docker-compose.dev.yml build --no-cache
}

# 启动服务
start_services() {
    print_message "启动开发环境服务..."
    docker compose -f docker-compose.dev.yml up -d
    
    # 等待服务启动
    print_message "等待服务启动..."
    sleep 15
    
    # 检查服务状态
    if docker compose -f docker-compose.dev.yml ps | grep -q "Up"; then
        print_message "开发环境服务启动成功！"
        print_message "前端服务: http://localhost:3000"
        print_message "Agent 服务: http://localhost:8123"
        print_message ""
        print_message "开发模式特性:"
        print_message "- 前端支持热重载"
        print_message "- Agent 支持代码热重载"
        print_message "- 实时日志输出"
    else
        print_error "服务启动失败，请检查日志"
        docker compose -f docker-compose.dev.yml logs
        exit 1
    fi
}

# 显示服务状态
show_status() {
    print_message "服务状态:"
    docker compose -f docker-compose.dev.yml ps
    
    echo ""
    print_message "查看日志命令:"
    echo "  docker compose -f docker-compose.dev.yml logs -f          # 查看所有服务日志"
    echo "  docker compose -f docker-compose.dev.yml logs -f frontend # 查看前端服务日志"
    echo "  docker compose -f docker-compose.dev.yml logs -f agent    # 查看 Agent 服务日志"
    
    echo ""
    print_message "停止服务命令:"
    echo "  docker compose -f docker-compose.dev.yml down             # 停止所有服务"
    echo "  docker compose -f docker-compose.dev.yml down -v          # 停止服务并删除数据卷"
}

# 主函数
main() {
    print_header
    
    # 检查依赖
    check_docker
    check_env_file
    
    # 停止现有容器
    stop_containers
    
    # 构建并启动
    build_images
    start_services
    
    # 显示状态
    show_status
    
    print_message "开发环境启动完成！"
}

# 处理命令行参数
case "${1:-}" in
    "stop")
        print_message "停止所有开发环境服务..."
        docker compose -f docker-compose.dev.yml down
        ;;
    "restart")
        print_message "重启所有开发环境服务..."
        docker compose -f docker-compose.dev.yml restart
        ;;
    "logs")
        docker compose -f docker-compose.dev.yml logs -f
        ;;
    "status")
        docker compose -f docker-compose.dev.yml ps
        ;;
    "clean")
        print_message "清理所有开发环境容器和镜像..."
        docker compose -f docker-compose.dev.yml down -v --rmi all
        ;;
    *)
        main
        ;;
esac
