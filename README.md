# Chaos Kitchen (WIP)

A work-in-progress chaotic co-op cooking mobile game blending Overcooked and
Keep Talking and Nobody Explodes, where players must communicate to cook,
solve puzzles, and survive the kitchen.

## Tech stack

- Frontend: Flutter + Flame game engine
- Backend: Python + FastAPI
- Communication: Websockets + Protobuf

## Development

### Requirements

- [uv](https://github.com/astral-sh/uv)
- [flutter](https://docs.flutter.dev/install)
- [buf](https://github.com/bufbuild/buf)

### Backend

To start the backend:

```bash
cd backend
uv sync
uv run fastapi dev src/main.py
```

### Frontend

To start the mobile app:

```bash
cd frontend
# '-d all' runs flutter on all connected devices - useful when testing multiplayer flows
flutter run -d all
```

### Protobuf

To generate protobuf types for Dart and Python:

```bash
cd protobuf
buf generate
```
