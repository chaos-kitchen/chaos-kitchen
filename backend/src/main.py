from uuid import UUID

from fastapi import FastAPI, WebSocket

app = FastAPI()


@app.get("/")
def read_root():
    return {"Hello": "World"}

@app.websocket("/ws/{room_id}/{client_id}")
async def websocket_endpoint(websocket: WebSocket, room_id: UUID, client_id: UUID):
    await websocket.accept()
    while True:
        data = await websocket.receive_text()
        await websocket.send_text(data)

