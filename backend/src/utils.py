import asyncio
from datetime import UTC, timedelta, datetime
from typing import Any, Callable


class Timer:
    def __init__(self, duration: timedelta, *, callback: Callable[[], Any]):
        self.duration = duration.total_seconds()

        self._start_time = datetime.min
        self._task: asyncio.Task | None = None
        self._callback = callback

    @property
    def is_running(self) -> bool:
        return self._task is not None

    @property
    def ends_at(self) -> datetime:
        if not self.is_running:
            return datetime.max
        return self._start_time + timedelta(seconds=self.duration)

    async def _run(self):
        await asyncio.sleep(self.duration)
        self._callback()
        self._task = None

    def start(self):
        assert self._task is None, "Timer is already running"
        self._start_time = datetime.now(tz=UTC)
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
