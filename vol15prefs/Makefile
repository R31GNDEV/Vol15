TARGET := iphone:clang:14.5:12.0
THEOS_PACKAGE_SCHEME = rootless

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = vol15prefs

vol15prefs_FILES = $(wildcard *.m)
vol15prefs_FRAMEWORKS = UIKit
vol15prefs_PRIVATE_FRAMEWORKS = Preferences
vol15prefs_INSTALL_PATH = /Library/PreferenceBundles
vol15prefs_CFLAGS = -fobjc-arc
vol15prefs_LIBRARIES = colorpicker
vol15prefs_EXTRA_FRAMEWORKS = Cephei CepheiPrefs Alderis

include $(THEOS_MAKE_PATH)/bundle.mk
