from langchain_core.messages import AnyMessage
from langgraph.graph import add_messages
from typing import TypedDict, Dict, Union, List, Annotated, Optional

class ResearchState(TypedDict, total=False):
    messages: Annotated[List[AnyMessage], add_messages]
    title: Optional[str]
    proposal: Optional[Dict[str, Union[str, bool, Dict[str, Union[str, bool]]]]]  # Stores proposed structure before user approval
    outline: Optional[dict]
    sections: Optional[List[dict]]  # list of dicts with 'title','content',and 'idx'
    footnotes: Optional[str]
    sources: Optional[Dict[str, Dict[str, Union[str, float]]]]
    tool: Optional[str]
    logs: Optional[List[dict]]  # list of dicts logs to be sent to frontend with 'message', 'status'


