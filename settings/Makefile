include theos/makefiles/common.mk

BUNDLE_NAME = CalendarX
CalendarX_FILES = CalendarX.mm
CalendarX_INSTALL_PATH = /Library/PreferenceBundles
CalendarX_FRAMEWORKS = UIKit
CalendarX_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/CalendarX.plist$(ECHO_END)
