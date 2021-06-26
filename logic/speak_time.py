import pyttsx3
import os
from datetime import datetime
import time
import threading

speak = pyttsx3.init()

class Speaker():
	speak_allowed: bool=False
	water_break_allowed: bool=False

	def __init__(self):
		t1 = threading.Thread(target = self.speak_time)
		t1.daemon = True
		t1.start()

	def speak_time(self):
		while True:
			now = datetime.now()

			if now.minute == 15 or now.minute == 30 or now.minute == 45:
				minutes = "The time is" + str(now.hour) + str(now.minute)
				if not self.speak_allowed:
					continue
				speak.say(minutes)
				speak.runAndWait()
				for x in range(0, 19):
					time.sleep(1)

			elif (now.minute == 35 or now.minute == 5) and self.water_break_allowed:
				speak.say("You should drink water")
				speak.runAndWait()

			elif now.minute == 0:
				minutes = "The time is" + str(now.hour)
				if not self.speak_allowed:
					continue
				speak.say(minutes)
				speak.runAndWait()
				for x in range(0, 19):
					time.sleep(1)

			else:
				for x in range(0, 20):
					time.sleep(1)

obj = Speaker()