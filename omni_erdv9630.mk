#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Omni stuff.
$(call inherit-product, vendor/omni/config/common.mk)

# Inherit from erdv9630 device
$(call inherit-product, device/vivo/erdv9630/device.mk)

PRODUCT_DEVICE := erdv9630
PRODUCT_NAME := omni_erdv9630
PRODUCT_BRAND := vivo
PRODUCT_MODEL := vivo
PRODUCT_MANUFACTURER := vivo

PRODUCT_GMS_CLIENTID_BASE := android-vivo

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="full_erdv880_q_launching-user 10 QP1A.190711.020 compiler09021438 release-keys"

BUILD_FINGERPRINT := vivo/PD2002/PD2002:10/QP1A.190711.020/compiler09021438:user/release-keys
