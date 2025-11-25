# asyncio-based timer utility
import asyncio
from datetime import timedelta
from typing import Any, Callable


class Timer:
    def __init__(self, duration: timedelta, *, callback: Callable[[], Any]):
        self._duration = duration.total_seconds()
        self._callback = callback
        self._task: asyncio.Task | None = None

    @property
    def is_running(self) -> bool:
        return self._task is not None

    async def _run(self):
        await asyncio.sleep(self._duration)
        self._callback()
        self._task = None

    def start(self):
        assert self._task is None, "Timer is already running"
        self._task = asyncio.create_task(self._run())
        return self

    def cancel(self):
        if not self._task:
            return
        self._task.cancel()
        self._task = None

    def restart(self):
        self.cancel()
        self.start()
