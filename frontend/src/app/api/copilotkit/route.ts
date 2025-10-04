import {
  CopilotRuntime,
  ExperimentalEmptyAdapter,
  copilotRuntimeNextJSAppRouterEndpoint,
} from "@copilotkit/runtime";

import { LangGraphHttpAgent } from "@ag-ui/langgraph";

import { NextRequest } from "next/server";
 
// 1. Create the LangGraph agent
const langGraphAgent = new LangGraphHttpAgent({
  url: process.env.AGENT_URL || "http://agent:8123/runs/stream"
});

// 2. Create the service adapter
const serviceAdapter = new ExperimentalEmptyAdapter();
 
// 3. Create the CopilotRuntime instance
const runtime = new CopilotRuntime();
 
// 4. Build a Next.js API route that handles the CopilotKit runtime requests.
export const POST = async (req: NextRequest) => {
  const { handleRequest } = copilotRuntimeNextJSAppRouterEndpoint({
    runtime, 
    serviceAdapter,
    endpoint: "/api/copilotkit",
  });

  return handleRequest(req);
};