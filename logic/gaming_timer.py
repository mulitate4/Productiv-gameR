import time
from datetime import datetime
import threading
import math
import pyttsx3

speak = pyttsx3.init()

class Timer():
	time_elapsed_str: str
	time_start: int
	timer_allowed: bool
	gaming_break_allowed: bool = False

	def __init__(self):
		self.timer_allowed = False
		self.time_elapsed_str = "00:00:00"

		t2 = threading.Thread(target = self.time_elapsed)
		t2.daemon = True
		t2.start()

	def time_elapsed(self):
		self.time_start = round(time.time())
		
		while True:
			if not self.timer_allowed:
				self.time_start = math.floor(time.time())
				self.time_elapsed_str = "00:00:00"
				for i in range(0, 10):
					time.sleep(0.1)
				continue

			time_elapsed = math.floor(time.time()) - self.time_start

			self.time_elapsed_str = time.strftime("%H:%M:%S", time.gmtime(time_elapsed))

			if self.time_elapsed_str.split(":")[1] == "59" and self.time_elapsed_str.split(":")[2] == "59" and self.gaming_break_allowed:
				speak.say("You should take a break")
				speak.runAndWait()

			for i in range(0, 100):
				#? If the time_allowed is set before 1 second is over, it should still stop
				if not self.timer_allowed:
					continue
				time.sleep(0.01)

obj = Timer()