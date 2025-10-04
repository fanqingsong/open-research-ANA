#!/usr/bin/env python3
"""
FastAPI server for the Research Agent
"""
import os
import uvicorn
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from copilotkit import LangGraphAGUIAgent
from ag_ui_langgraph import add_langgraph_fastapi_endpoint
from langgraph.checkpoint.memory import MemorySaver
from langchain_core.messages import HumanMessage
from typing import Dict, Any, List
import json

from graph import ResearchAgent
from state import ResearchState

# Create FastAPI app
app = FastAPI(title="Research Agent API", version="1.0.0")

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Add memory
memory = MemorySaver()

# Initialize the research agent with memory
research_agent = ResearchAgent(checkpointer=memory)
graph_with_memory = research_agent.graph

# Add LangGraph AG-UI endpoint
add_langgraph_fastapi_endpoint(
    app=app,
    agent=LangGraphAGUIAgent(
        name="sample_agent",
        description="A research agent that can help with research tasks and document generation.",
        graph=graph_with_memory
    ),
    path="/"
)

if __name__ == "__main__":
    # Get port from environment variable or use default
    port = int(os.getenv("PORT", 8123))
    host = os.getenv("HOST", "0.0.0.0")
    reload = os.getenv("RELOAD", "false").lower() == "true"
    
    print(f"Starting Research Agent API on {host}:{port}")
    print(f"Hot reload: {'enabled' if reload else 'disabled'}")
    
    if reload:
        # For hot reload, use import string
        uvicorn.run("server:app", host=host, port=port, reload=True)
    else:
        # For production, use app object
        uvicorn.run(app, host=host, port=port, reload=False)
