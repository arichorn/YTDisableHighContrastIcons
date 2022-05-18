TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = YouTube

ARCHS = armv7 armv7s arm64 arm64e

THEOS_DEVICE_IP = 10.12.3.128

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = YTDisableHighContrastIcons

YTDisableHighContrastIcons_FILES = Tweak.x
YTDisableHighContrastIcons_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
