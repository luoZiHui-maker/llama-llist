from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from typing import List
from app import crud, schemas
from app.database import get_db

router = APIRouter(prefix="/notes", tags=["notes"])

@router.post("/", response_model=schemas.NoteOut, status_code=status.HTTP_201_CREATED)
async def create_note(
    note: schemas.NoteCreate,
    db: AsyncSession = Depends(get_db)
):
    # 标题不能为空校验（后端二次校验）
    if not note.title or not note.title.strip():
        raise HTTPException(status_code=400, detail="标题不能为空")
    return await crud.create_note(db, note)

@router.get("/", response_model=List[schemas.NoteOut])
async def list_notes(
    skip: int = 0,
    limit: int = 100,
    db: AsyncSession = Depends(get_db)
):
    notes = await crud.get_notes(db, skip=skip, limit=limit)
    return notes