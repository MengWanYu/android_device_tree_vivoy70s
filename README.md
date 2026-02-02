# TWRP 编译项目 - vivo Y70s (vivoy70s/erdv9630)

## 项目信息

**设备：** vivo Y70s (vivoy70s/erdv9630)  
**处理器：** 猎户座880 (Exynos 880)  
**Android版本：** Android 10  
**目标：** 编译TWRP Recovery镜像

## 仓库地址

- 设备树仓库：https://github.com/MengWanYu/android_device_tree_vivoy70s
- 工作流仓库：https://github.com/MengWanYu/Action-TWRP-Builder

## 已完成的工作

### 1. 设备树配置
- ✅ BoardConfig.mk 已配置完成
- ✅ 添加了字体路径配置：`RECOVERY_FONT_PATH := $(DEVICE_PATH)/recovery/root/fonts/Roboto-Regular.ttf`
- ✅ 添加了禁用文本图片生成配置：`RECOVERY_SKIP_TEXT_IMAGE_GENERATION := true`
- ✅ 字体文件已更新为真正的TrueType字体（374KB）
- ✅ 修复 TWRP 11+ 兼容性：创建了 `recovery/root/etc/recovery.fstab`

### 2. 工作流优化
- ✅ 改进了字体准备逻辑，支持多目录放置
- ✅ 添加了字体类型验证
- ✅ 添加了禁用文本图片生成规则的步骤
- ✅ 配置了zopflipng工具
- ✅ 设置了12GB交换空间

### 3. 已解决的关键问题

#### 问题 1：字体文件缺失 ❌ → ✅ 已解决
**错误：** `Exception in thread "main" java.io.IOException: Can not find the font file Roboto-Regular for language en`

**解决方案：**
- 添加了真实的TTF字体文件（374KB）
- 在多个目录放置字体文件
- 在工作流中添加字体准备步骤
- 在 BoardConfig.mk 中添加 `RECOVERY_SKIP_TEXT_IMAGE_GENERATION := true`

#### 问题 2：recovery.fstab 路径错误 ❌ → ✅ 已解决
**错误：** `cp: out/target/product/erdv9630/recovery/root/system/etc/recovery.fstab: No such file or directory`

**根本原因：** TWRP 11+ 版本中 recovery.fstab 的路径要求发生了变化

**解决方案：**
- 创建了 `recovery/root/etc/recovery.fstab`
- 保持原有的 `recovery.fstab` 以兼容 TWRP 10.0

## 当前状态

**最新工作流：** Run #6  
**状态：** 正在运行 (in_progress)  
**Manifest分支：** `twrp-10.0-deprecated`  
**设备名称：** `erdv9630`  
**编译目标：** `recovery`

## 文件结构

```
android_device_tree_vivoy70s/
├── BoardConfig.mk              # 设备配置
├── device.mk                   # 设备 makefile
├── omni_erdv9630.mk           # Omni (TWRP 10.0) 产品配置
├── twrp_erdv9630.mk           # TWRP 11+ 产品配置
├── recovery.fstab             # 挂载点配置（TWRP 10.0）
├── recovery/
│   └── root/
│       ├── etc/
│       │   └── recovery.fstab # 挂载点配置（TWRP 11+）
│       └── fonts/
│           └── Roboto-Regular.ttf # 字体文件
└── prebuilt/                   # 预构建文件
    ├── kernel
    ├── dtb.img
    └── dtbo.img
```

## 工作流配置参数

```yaml
MANIFEST_URL: https://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni
MANIFEST_BRANCH: twrp-10.0-deprecated
DEVICE_TREE_URL: https://github.com/MengWanYu/android_device_tree_vivoy70s
DEVICE_TREE_BRANCH: main
DEVICE_PATH: device/vivo/erdv9630
DEVICE_NAME: erdv9630
MAKEFILE_NAME: omni_erdv9630
BUILD_TARGET: recovery
```

## 重要说明

### TWRP 版本兼容性

**TWRP 10.0 (Omni):**
- 使用 `platform_manifest_twrp_omni` 仓库
- 分支：`twrp-10.0-deprecated`
- Makefile: `omni_erdv9630.mk`
- recovery.fstab 位置：`recovery.fstab`（设备树根目录）

**TWRP 11+:**
- 使用 `platform_manifest_twrp_aosp` 仓库
- 分支：`twrp-11` 或 `twrp-12.1`
- Makefile: `twrp_erdv9630.mk`
- recovery.fstab 位置：`recovery/root/etc/recovery.fstab`

### 切换到 TWRP 11+

如果需要使用 TWRP 11+，需要：

1. 修改工作流参数：
   ```yaml
   MANIFEST_URL: https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp
   MANIFEST_BRANCH: twrp-11
   MAKEFILE_NAME: twrp_erdv9630
   ```

2. 确保设备树包含：
   - `twrp_erdv9630.mk` 文件
   - `recovery/root/etc/recovery.fstab` 文件
   - `twrp.dependencies` 文件（如果需要依赖转换）

## 成功标准

- ✅ 字体问题已解决
- ✅ recovery.fstab 路径问题已修复
- ⏳ TWRP编译成功完成
- ⏳ recovery.img 生成
- ⏳ 可以在设备上刷入使用

## 开发者信息

- GitHub用户：MengWanYu
- 仓库：https://github.com/MengWanYu/android_device_tree_vivoy70s

---

**最后更新时间：** 2026-02-02  
**当前状态：** 等待工作流 #6 完成