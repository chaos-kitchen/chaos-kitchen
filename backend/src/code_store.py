import random

ALPHABET = 'ABCDEFGHJKLMNPQRSTUVWXYZ' # removed 'i' and 'o' to avoid confusion with 1 and 0
NUMBERS = '0123456789'

class RoomCodeStore:
    def __init__(self):
        self.codes_in_use: set[str] = set()

    def get_unique_code(self):
        for _ in range(100):
            code = ''.join([
                random.choice(ALPHABET),
                random.choice(NUMBERS),
                random.choice(ALPHABET),
                random.choice(NUMBERS),
                random.choice(ALPHABET),
                random.choice(NUMBERS),
            ])
            if code in self.codes_in_use:
                continue
            self.codes_in_use.add(code)
            return code
        raise RuntimeError("Failed to obtain a unique room code")

    def release_code(self, code: str):
        self.codes_in_use.discard(code)
