include theos/makefiles/common.mk

BUNDLE_NAME = Calendar
Calendar_FILES = CalendarController.m
Calendar_INSTALL_PATH = /Library/WeeLoader/Plugins
Calendar_FRAMEWORKS = UIKit CoreGraphics EventKit

include $(THEOS_MAKE_PATH)/bundle.mk

after-install::
	install.exec "killall -9 SpringBoard"
