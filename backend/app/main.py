from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def default_thingy():
    return {"message": "Backend is running!!!"}