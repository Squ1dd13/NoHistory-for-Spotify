ARCHS = armv7 arm64
TARGET = iphone:clang: 9.3:7.0

include /var/theos/makefiles/common.mk

TWEAK_NAME = NoHistory
NoHistory_CFLAGS = -fobjc-arc
NoHistory_FILES = NoHistoySpoti.xm

include $(THEOS_MAKE_PATH)/tweak.mk



after-install::
	install.exec "killall -9 SpringBoard"
