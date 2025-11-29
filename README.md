# Chaos Kitchen

A 2-player chaotic mobile cooking game blending Overcooked and
Keep Talking and Nobody Explodes, where players must work together to
solve cooking puzzles, face unexpected events, and survive the kitchen.

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
# '-d all' runs flutter on all connected devices - useful when
# testing multiplayer flows
flutter run -d all
```

### Protobuf

To generate protobuf types for Dart and Python (only necessary
when changing protobuf messages):

```bash
cd protobuf
buf generate
```

## Screenshots

![Main menu](./screenshots/main_menu.png)
![Cook view](./screenshots/cook.png)
![Instructor view](./screenshots/instructor.png)
![Mixing](./screenshots/mixing.png)

For more screenshots, see [Screenshots](./SCREENSHOTS.md).
