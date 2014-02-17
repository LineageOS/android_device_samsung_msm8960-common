ifeq ($(TARGET_PROVIDES_CAMERA_HAL),true)

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

ifeq ($(TARGET_NEED_DISABLE_AUTOFOCUS),true)
    LOCAL_CFLAGS += -DDISABLE_AUTOFOCUS
endif

ifeq ($(TARGET_NEED_DISABLE_FACE_DETECTION),true)
    LOCAL_CFLAGS += -DDISABLE_FACE_DETECTION
endif

ifeq ($(TARGET_NEED_DISABLE_FACE_DETECTION_BOTH_CAMERAS),true)
    LOCAL_CFLAGS += -DDISABLE_FACE_DETECTION_BOTH_CAMERAS
endif

ifeq ($(TARGET_NEED_FFC_RESTRICT_PREVIEW),true)
    LOCAL_CFLAGS += -DFFC_RESTRICT_PREVIEW
endif

ifeq ($(TARGET_NEED_CAMERA_ZSL),true)
    LOCAL_CFLAGS += -DENABLE_ZSL
endif

ifeq ($(TARGET_NEED_SAMSUNG_MAGIC_ZSL_1508),true)
    LOCAL_CFLAGS += -DMAGIC_ZSL_1508
endif

ifeq ($(TARGET_NEED_PREVIEW_SIZE_FIXUP),true)
    LOCAL_CFLAGS += -DPREVIEW_SIZE_FIXUP
endif

ifeq ($(TARGET_ADD_ISO_MODE_1600),true)
    LOCAL_CFLAGS += -DISO_MODE_1600
endif

ifeq ($(TARGET_ADD_ISO_MODE_HJR),true)
    LOCAL_CFLAGS += -DISO_MODE_HJR
endif

LOCAL_SRC_FILES := \
    CameraWrapper.cpp

LOCAL_SHARED_LIBRARIES := \
    libhardware liblog libcamera_client libutils

LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
LOCAL_MODULE := camera.MSM8960
LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)

endif
