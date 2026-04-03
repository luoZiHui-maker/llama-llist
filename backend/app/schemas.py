from pydantic import BaseModel
from datetime import datetime
from typing import Optional

# 笔记相关
class NoteBase(BaseModel):
    title: str
    content: Optional[str] = None
    image_paths: Optional[str] = None
    tag_id: Optional[int] = None

class NoteCreate(NoteBase):
    pass

class NoteOut(NoteBase):
    id: int
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True

# 标签相关
class TagBase(BaseModel):
    name: str

class TagCreate(TagBase):
    pass

class TagOut(TagBase):
    id: int

    class Config:
        from_attributes = True