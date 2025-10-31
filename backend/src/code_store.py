import random

ALPHABET = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
NUMBERS = '0123456789'

class RoomCodeStore:
    def __init__(self):
        self.codes = set()

    def get_code(self):
        for _ in range(100):
            code = ''.join([
                random.choice(ALPHABET),
                random.choice(ALPHABET),
                random.choice(NUMBERS),
                ' ',
                random.choice(NUMBERS),
                random.choice(ALPHABET),
                random.choice(NUMBERS),
            ])
            if code in self.codes:
                continue
            self.codes.add(code)
            return code
        raise RuntimeError("Failed to obtain a unique room code")

    def free_code(self, code: str):
        self.codes.discard(code)
