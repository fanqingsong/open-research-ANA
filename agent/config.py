import os
from langchain_openai import ChatOpenAI, AzureChatOpenAI

# Description: Configuration file
class Config:
    def __init__(self):
        """
        Initializes the configuration for the agent
        """
        # Check if Azure OpenAI is configured
        if self._is_azure_openai_configured():
            self.BASE_LLM = AzureChatOpenAI(
                azure_deployment=os.getenv("AZURE_OPENAI_DEPLOYMENT_NAME"),
                azure_endpoint=os.getenv("AZURE_OPENAI_ENDPOINT"),
                api_version=os.getenv("AZURE_OPENAI_API_VERSION", "2024-02-15-preview"),
                temperature=0.2
            )
            self.FACTUAL_LLM = AzureChatOpenAI(
                azure_deployment=os.getenv("AZURE_OPENAI_DEPLOYMENT_NAME"),
                azure_endpoint=os.getenv("AZURE_OPENAI_ENDPOINT"),
                api_version=os.getenv("AZURE_OPENAI_API_VERSION", "2024-02-15-preview"),
                temperature=0.0
            )
        else:
            # Fallback to OpenAI API
            self.BASE_LLM = ChatOpenAI(model="gpt-4", temperature=0.2)
            self.FACTUAL_LLM = ChatOpenAI(model="gpt-4o-mini", temperature=0.0)
        
        self.DEBUG = False
    
    def _is_azure_openai_configured(self):
        """
        Check if Azure OpenAI is properly configured
        """
        return (
            os.getenv("AZURE_OPENAI_API_KEY") and
            os.getenv("AZURE_OPENAI_ENDPOINT") and
            os.getenv("AZURE_OPENAI_DEPLOYMENT_NAME")
        )