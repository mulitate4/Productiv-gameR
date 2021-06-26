import sys
try:
    import ctypes
    ctypes.windll.shell32.SetCurrentProcessExplicitAppUserModelID("myappid")
except:
    pass

from PyQt5.QtCore import QObject, Qt, QThread, QTimer, QUrl
from PyQt5.QtGui import QGuiApplication, QCursor, QIcon
from PyQt5.QtWidgets import QSystemTrayIcon, QAction, QMenu, QApplication

from PyQt5.QtQml import QQmlApplicationEngine, qmlRegisterType

from logic import gaming_timer, speak_time

def main():
    app = QApplication(sys.argv)
    app.setQuitOnLastWindowClosed(False)

    engine = QQmlApplicationEngine()
    engine.quit.connect(app.quit)
    engine.load('ui/main.qml')

    root = engine.rootObjects()[0]
    mainWindow = root.findChild(QObject, "mainWindow")

    icon = QIcon("ui/images/controller.png")
    app.setWindowIcon(icon)

    #? HELPER FUNCTIONS SECTION
    def gaming_timer_start():
        gaming_timer.obj.timer_allowed = True

    def gaming_timer_stop():
        gaming_timer.obj.timer_allowed = False

    def update_time():
        root.setProperty("timerTime", gaming_timer.obj.time_elapsed_str)

    def speak_time_check():
        if speakTimeCheckBox.property("checked"):
            speak_time.obj.speak_allowed = True
        speak_time.obj.speak_allowed = False

    def social_media_blocker_check():
        hosts_path = r"C:\Windows\System32\drivers\etc\hosts"
        redirect = "127.0.0.1"
        urls = [
            "https://www.facebook.com", 
            "https://www.instagram.com", 
            "https://www.discord.com/app", 
            "https://www.discord.com", 
            "https://www.twitter.com"
        ]

        if socialMediaBlockerCheckBox.property("checked"):
            with open(hosts_path, 'r+') as file:
                content = file.read()
                for website in urls:
                    if website in content:
                        pass
                    else:
                        # mapping hostnames to your localhost IP address
                        file.write(redirect + " " + website + "\n")

        else:
            with open(hosts_path, 'r+') as file:
                content=file.readlines()
                file.seek(0)
                for line in content:
                    if not any(website in line for website in urls):
                        file.write(line)
    
                # removing hostnmes from host file
                file.truncate()


            # print("block social media")

    def gaming_reminder_check():
        if gamingBreakCheckbox.property("checked"):
            gaming_timer.obj.gaming_break_allowed = True
        gaming_timer.obj.gaming_break_allowed = False

    def drink_water_check():
        if drinkWaterCheckbox.property("checked"):
            speak_time.obj.water_break_allowed = True
        speak_time.obj.water_break_allowed = False

    def tray_check(reason):
        if reason == QSystemTrayIcon.DoubleClick:
            root.setProperty("visible", True)

    tray = QSystemTrayIcon()
    tray.setIcon(icon)
    tray.setVisible(True)

    trayMenu = QMenu()
    openApp = QAction("Open Menu")
    openApp.triggered.connect(lambda: root.setProperty("visible", True))
    trayMenu.addAction(openApp)

    tray.activated.connect(tray_check)

    quit = QAction("Quit")
    quit.triggered.connect(app.quit)
    trayMenu.addAction(quit)

    tray.setContextMenu(trayMenu)

    #? CONNECTIONS SECTION
    speakTimeCheckBox = root.findChild(QObject, "speakTimeCheckBox")
    speakTimeCheckBox.clicked.connect(speak_time_check)

    startTimer = root.findChild(QObject, "startTimer")
    startTimer.clicked.connect(gaming_timer_start)

    stopTimer = root.findChild(QObject, "stopTimer")
    stopTimer.clicked.connect(gaming_timer_stop)

    gamingBreakCheckbox = root.findChild(QObject, "gamingBreakCheckbox")
    gamingBreakCheckbox.clicked.connect(gaming_reminder_check)

    drinkWaterCheckbox = root.findChild(QObject, "drinkWaterCheckbox")
    drinkWaterCheckbox.clicked.connect(drink_water_check)


    #? Update Gaming Timer
    timerText = root.findChild(QObject, "timerText")

    timer = QTimer()
    timer.setInterval(10)
    timer.timeout.connect(update_time)
    timer.start()

    app.exec_()

sys.exit(main())