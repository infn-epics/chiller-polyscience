# Makefile at top of application tree
TOP = .
include $(TOP)/configure/CONFIG

DIRS := configure
DIRS += polyscienceApp
polyscienceApp_DEPEND_DIRS = configure

DIRS += iocBoot
iocBoot_DEPEND_DIRS = polyscienceApp

include $(TOP)/configure/RULES_TOP
