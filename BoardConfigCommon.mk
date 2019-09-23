# Copyright (C) 2013 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# inherit from msm8974-common
include device/sony/msm8974-common/BoardConfigCommon.mk

#TARGET_SPECIFIC_HEADER_PATH += device/sony/rhine-common/include

COMMON_PATH := device/sony/rhine-common

# Platform
BOARD_VENDOR_PLATFORM := rhine
PRODUCT_PLATFORM := rhine

# Kernel information
BOARD_KERNEL_IMAGE_NAME := zImage-dtb
BOARD_KERNEL_BASE     := 0x00000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_CMDLINE  := androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x3b7 ehci-hcd.park=3 androidboot.bootdevice=msm_sdcc.1 vmalloc=300M dwc3.maximum_speed=high dwc3_msm.prop_chg_detect=Y
BOARD_KERNEL_CMDLINE  += androidboot.selinux=permissive
BOARD_MKBOOTIMG_ARGS  := --ramdisk_offset 0x02000000 --tags_offset 0x01E00000
#BOARD_KERNEL_SEPARATED_DT := true

# ANT+
BOARD_ANT_WIRELESS_DEVICE := "qualcomm-smd"

# Audio
BOARD_USES_ALSA_AUDIO := true
USE_LEGACY_LOCAL_AUDIO_HAL := true
AUDIO_FEATURE_ENABLED_FM_POWER_OPT := true
USE_XML_AUDIO_POLICY_CONF := 1
#USE_CUSTOM_AUDIO_POLICY := 1

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_QCOM := true
BLUETOOTH_HCI_USE_MCT := true


# Lineage Hardware
BOARD_HARDWARE_CLASS += $(COMMON_PATH)/lineagehw

# Camera
TARGET_PROVIDES_CAMERA_HAL := true
USE_DEVICE_SPECIFIC_CAMERA := true
TARGET_NEEDS_PLATFORM_TEXT_RELOCATIONS := true
TARGET_HAS_LEGACY_CAMERA_HAL1 := true
TARGET_USES_MEDIA_EXTENSIONS := true
TARGET_NEEDS_LEGACY_CAMERA_HAL1_DYN_NATIVE_HANDLE := true
TARGET_PROCESS_SDK_VERSION_OVERRIDE := \
    /system/bin/mediaserver=22

# Charger
HEALTHD_ENABLE_TRICOLOR_LED := true
BOARD_CHARGER_ENABLE_SUSPEND := true
BOARD_CHARGER_SHOW_PERCENTAGE := true
BOARD_CHARGER_DISABLE_INIT_BLANK := true
BACKLIGHT_PATH :=/sys/class/leds/lcd-backlight/brightness
RED_LED_PATH := /sys/class/leds/led:rgb_red/brightness
GREEN_LED_PATH := /sys/class/leds/led:rgb_green/brightness
BLUE_LED_PATH := /sys/class/leds/led:rgb_blue/brightness

# Font
EXTENDED_FONT_FOOTPRINT := true

# Dexpreopt
ifeq ($(HOST_OS),linux)
  ifneq ($(TARGET_BUILD_VARIANT),eng)
    ifeq ($(WITH_DEXPREOPT),)
      WITH_DEXPREOPT := true
      WITH_DEXPREOPT_BOOT_IMG_AND_SYSTEM_SERVER_ONLY := true
    endif
  endif
endif

# exFAT
TARGET_EXFAT_DRIVER := exfat

# GPS
BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE := $(TARGET_BOARD_PLATFORM)
BOARD_VENDOR_QCOM_LOC_PDK_FEATURE_SET := true
TARGET_NO_RPC := true

# Graphics
USE_OPENGL_RENDERER := true
TARGET_USES_ION := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
OVERRIDE_RS_DRIVER := libRSDriver_adreno.so
TARGET_USES_GRALLOC1_ADAPTER := true
TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS := 0x02000000U
SF_VSYNC_EVENT_PHASE_OFFSET_NS := 5000000
VSYNC_EVENT_PHASE_OFFSET_NS := 7500000

# Shader cache config options
# Maximum size of the  GLES Shaders that can be cached for reuse.
# Increase the size if shaders of size greater than 12KB are used.
MAX_EGL_CACHE_KEY_SIZE := 12*1024

# Maximum GLES shader cache size for each app to store the compiled shader
# binaries. Decrease the size if RAM or Flash Storage size is a limitation
# of the device.
MAX_EGL_CACHE_SIZE := 2048*1024

# Init configuration for init_sony
# BOARD_USES_INIT_SONY := true

# Lights HAL
TARGET_PROVIDES_LIBLIGHT := true

# Power
TARGET_HAS_LEGACY_POWER_STATS := true
TARGET_HAS_NO_WLAN_STATS := true
TARGET_USES_INTERACTION_BOOST := true

# FM Radio
AUDIO_FEATURE_ENABLED_FM := true
BOARD_HAVE_QCOM_FM := true
TARGET_QCOM_NO_FM_FIRMWARE := true

# Init
TARGET_INIT_VENDOR_LIB := //$(COMMON_PATH):libinit_rhine

# SELinux
#BOARD_SEPOLICY_DIRS += \
#    device/sony/rhine-common/sepolicy
BOARD_SEPOLICY_DIRS += $(COMMON_PATH)/sepolicy-tmp

# Shims
TARGET_LD_SHIM_LIBS := \
	/vendor/bin/credmgrd|/vendor/lib/libshims_signal.so \
	/vendor/bin/iddd|/vendor/lib/libshims_idd.so \
	/vendor/bin/suntrold|/vendor/lib/libshims_signal.so \
	/system/lib/hw/camera.vendor.qcom.so|/vendor/lib/libsonycamera.so \
	/system/lib/hw/camera.vendor.qcom.so|/vendor/lib/libshim_camera.so \
	/system/lib/hw/camera.vendor.qcom.so|/vendor/lib/libshim_cald.so \
	/system/lib/hw/camera.vendor.qcom.so|libsensor.so \
	/system/lib/libcald_pal.so|/vendor/lib/libshim_cald.so \
	/system/lib/libcammw.so|/vendor/lib/libshim_cald.so \
	/system/lib/libcammw.so|libsensor.so \
	/system/lib/libsomc_chokoballpal.so|/vendor/lib/libshim_camera.so \
	/vendor/bin/mm-qcamera-daemon|/vendor/lib/libc_util.so \
	/vendor/bin/mm-qcamera-daemon|libandroid.so

# Platform props
TARGET_SYSTEM_PROP += $(COMMON_PATH)/system.prop

# Wifi
BOARD_HAS_QCOM_WLAN              := true
BOARD_WLAN_DEVICE                := qcwcn
WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
TARGET_USES_WCNSS_MAC_ADDR_REV   := true
WIFI_DRIVER_FW_PATH_STA          := "sta"
WIFI_DRIVER_FW_PATH_AP           := "ap"
WIFI_HIDL_FEATURE_DISABLE_AP_MAC_RANDOMIZATION := true

# RIL
BOARD_PROVIDES_LIBRIL := true

# Filesystem
TARGET_FS_CONFIG_GEN += $(COMMON_PATH)/config.fs
BOARD_FLASH_BLOCK_SIZE := 131072
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4

# Partition information
BOARD_ROOT_EXTRA_FOLDERS := idd lta-label

# Recovery
TARGET_RECOVERY_FSTAB := $(COMMON_PATH)/rootdir/fstab.full
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_USE_CUSTOM_RECOVERY_FONT := \"roboto_23x41.h\"

# Releasetools
TARGET_RELEASETOOLS_EXTENSIONS := device/sony/rhine-common

# Binder API version
TARGET_USES_64_BIT_BINDER := true
