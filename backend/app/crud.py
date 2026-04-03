from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from app import models, schemas

# ----- 笔记 CRUD -----
async def create_note(db: AsyncSession, note: schemas.NoteCreate):
    db_note = models.Note(**note.dict())
    db.add(db_note)
    await db.commit()
    await db.refresh(db_note)
    return db_note

async def get_notes(db: AsyncSession, skip: int = 0, limit: int = 100):
    result = await db.execute(select(models.Note).offset(skip).limit(limit))
    return result.scalars().all()

# 你可以根据需要继续添加 get_note, update_note, delete_note 等