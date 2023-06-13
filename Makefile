before-package::
	python3 abi.py $(THEOS_OBJ_DIR)/arm64e/*.dylib

TARGET := iphone:clang:15.0
PREFIX = $(THEOS)/toolchain/linux/usr/bin/
SYSROOT = $(THEOS)/sdks/iPhoneOS14.5.sdk
INSTALL_TARGET_PROCESSES = SpringBoard
THEOS_PACKAGE_SCHEME = rootless
Vol15_EXTRA_FRAMEWORKS +=  Cephei CepheiPrefs Alderis
ARCHS = arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Vol15

Vol15_FILES = $(wildcard *.x)
Vol15_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += vol15prefs
include $(THEOS_MAKE_PATH)/aggregate.mk