# TWRP 11+ Configuration for vivo Y70s (erdv9630)

# Inherit from the common configuration
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit device configuration
$(call inherit-product, device/vivo/erdv9630/device.mk)

# Device identifier
PRODUCT_DEVICE := erdv9630
PRODUCT_NAME := twrp_erdv9630
PRODUCT_BRAND := vivo
PRODUCT_MODEL := vivo
PRODUCT_MANUFACTURER := vivo

# Build fingerprint
PRODUCT_GMS_CLIENTID_BASE := android-vivo

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="full_erdv880_q_launching-user 10 QP1A.190711.020 compiler09021438 release-keys"

BUILD_FINGERPRINT := vivo/PD2002/PD2002:10/QP1A.190711.020/compiler09021438:user/release-keys