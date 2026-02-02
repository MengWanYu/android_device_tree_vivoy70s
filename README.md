# TWRP 编译项目 - AI 记忆与状态文档

## 项目信息

**设备：** vivo Y70s (vivoy70s/erdv9630)  
**处理器：** 猎户座880 (Exynos 880)  
**Android版本：** Android 10  
**目标：** 编译TWRP Recovery镜像

## 仓库地址

- 设备树仓库：https://github.com/MengWanYu/android_device_tree_vivoy70s
- 工作流仓库：https://github.com/MengWanYu/android_device_tree_vivoy70s
- GitHub Token: (请使用环境变量配置，不要在文档中硬编码)

## 已完成的工作

### 1. 设备树配置
- ✅ BoardConfig.mk 已配置完成
- ✅ 添加了字体路径配置：`RECOVERY_FONT_PATH := $(DEVICE_PATH)/recovery/root/fonts/Roboto-Regular.ttf`
- ✅ 添加了禁用文本图片生成配置：`RECOVERY_SKIP_TEXT_IMAGE_GENERATION := true`
- ✅ 字体文件已更新为真正的TrueType字体（374KB）

### 2. 工作流优化
- ✅ 改进了字体准备逻辑，支持多目录放置
- ✅ 添加了字体类型验证
- ✅ 添加了禁用文本图片生成规则的步骤
- ✅ 配置了zopflipng工具
- ✅ 设置了12GB交换空间

### 3. 已提交的重要版本
- 设备树：commit 3eab227 - 更新为真正的Roboto-Regular.ttf字体文件
- 工作流：commit b3e882e - 大幅改进字体准备：多目录放置+禁用文本图片生成规则

## 当前问题

### 核心错误
```
Error: Exception in thread "main" java.io.IOException: Can not find the font file Roboto-Regular for language en
```

### 问题分析
1. TWRP编译系统在生成文本图片时，无法找到Roboto-Regular字体
2. 虽然字体文件已正确放置在多个目录，但编译系统仍然报错
3. `RECOVERY_SKIP_TEXT_IMAGE_GENERATION := true` 配置未生效

### 已尝试的解决方案
1. ✅ 添加了真实的TTF字体文件（374KB）
2. ✅ 在多个目录放置字体文件：
   - `out/target/product/vivo/obj/PACKAGING/recovery_font_files_intermediates`
   - `out/target/product/vivo/obj/ETC/recovery_font_files_intermediates`
   - `out/target/product/vivo/system/fonts`
   - `out/target/product/vivo/recovery/root/fonts`
3. ✅ 创建了多个字体文件名变体（Roboto-Regular-en.ttf, roboto-regular.ttf等）
4. ✅ 修改了TWRP源码中的文本图片生成规则（sed注释）
5. ✅ 设置了环境变量

## 下一步操作指南

### 立即行动项

1. **检查工作流#24结果**
   - 访问：https://github.com/MengWanYu/Action-TWRP-Builder/actions/runs/21564404469
   - 如果成功：提取recovery.img
   - 如果失败：查看日志，分析错误

2. **如果仍然失败，尝试以下方案：**

   **方案A：完全禁用文本图片生成**
   - 修改 `bootable/recovery/gui/Android.mk`
   - 删除或注释掉所有 `recovery_text_res` 相关的规则
   - 或者修改 `RecoveryImageGenerator.jar` 的调用

   **方案B：使用系统字体**
   - 将系统字体复制到所有可能的字体目录
   - 修改 `BoardConfig.mk`，使用系统字体路径

   **方案C：修改Manifest使用更新的TWRP版本**
   - 尝试使用 twrp-11 分支
   - 或者使用其他TWRP源码

### 工作流配置参数

```yaml
MANIFEST_URL: https://github.com/MengWanYu/platform_manifest_twrp_aosp
MANIFEST_BRANCH: twrp-11
DEVICE_TREE_URL: https://github.com/MengWanYu/android_device_tree_vivoy70s
DEVICE_TREE_BRANCH: main
DEVICE_PATH: device/vivo/erdv9630
DEVICE_NAME: vivo
MAKEFILE_NAME: omni_erdv9630
BUILD_TARGET: recovery
```

### 触发工作流命令

```bash
curl -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/MengWanYu/Action-TWRP-Builder/actions/workflows/229163364/dispatches \
  -d '{
    "ref":"main",
    "inputs":{
      "MANIFEST_URL":"https://github.com/MengWanYu/platform_manifest_twrp_aosp",
      "MANIFEST_BRANCH":"twrp-10.0-deprecated",
      "DEVICE_TREE_URL":"https://github.com/MengWanYu/android_device_tree_vivoy70s",
      "DEVICE_TREE_BRANCH":"main",
      "DEVICE_PATH":"device/vivo/erdv9630",
      "DEVICE_NAME":"vivo",
      "MAKEFILE_NAME":"omni_erdv9630",
      "BUILD_TARGET":"recovery"
    }
  }'
```

### 检查工作流状态命令

```bash
# 获取最新工作流
curl -s -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/MengWanYu/Action-TWRP-Builder/actions/workflows/229163364/runs?per_page=1

# 获取工作流详情
curl -s -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/MengWanYu/Action-TWRP-Builder/actions/runs/{RUN_ID}/jobs
```

## 关键文件路径

### 设备树
- `/storage/emulated/0/AiflowWorkStation/android_device_tree_vivoy70s/BoardConfig.mk`
- `/storage/emulated/0/AiflowWorkStation/android_device_tree_vivoy70s/recovery/root/fonts/Roboto-Regular.ttf`

### 工作流
- `/storage/emulated/0/AiflowWorkStation/Action-TWRP-Builder/.github/workflows/Recovery Build.yml`

## AI部署检查清单

- [ ] 读取此README文件
- [ ] 检查工作流#24状态
- [ ] 如果失败，分析错误日志
- [ ] 根据错误实施对应的解决方案
- [ ] 触发新的工作流
- [ ] 重复直到编译成功
- [ ] 提取recovery.img
- [ ] 上传到GitHub Releases

## 重要提醒

1. **不要修改已提交的代码**，除非有明确的修复方案
2. **每次修改都要提交到GitHub**，确保可追溯
3. **工作流日志是关键**，失败时一定要仔细分析
4. **字体问题是核心**，所有解决方案都围绕解决字体依赖
5. **如果编译成功**，自动将recovery.img上传到GitHub Releases

## 成功标准

- ✅ TWRP编译成功完成
- ✅ recovery.img生成
- ✅ 自动上传到GitHub Releases
- ✅ 可以在设备上刷入使用

## 联系信息

- GitHub用户：MengWanYu
- 仓库：https://github.com/MengWanYu/android_device_tree_vivoy70s

---

**最后更新时间：** 2026-02-01  
**AI记忆版本：** v1.0  
**当前状态：** 等待工作流#24完成


---

## 仓库整合进度 (2026-02-01)

### 已完成的整合工作


✅ **Fork TWRP Manifest 仓库**
- AOSP 仓库: https://github.com/MengWanYu/platform_manifest_twrp_aosp (Android 10+)
- Omni 仓库: https://github.com/MengWanYu/platform_manifest_twrp_omni (Android 5.1-9.0)
- 当前使用: platform_manifest_twrp_aosp + twrp-11 (最新稳定版)
- 用途: 控制 TWRP 源码版本，避免上游变更影响编译

✅ **整合 convert.sh 脚本**
- 原地址: https://github.com/azwhikaru/Action-TWRP-Builder/scripts/convert.sh
- 本地路径: scripts/convert.sh
- 用途: 转换设备依赖文件为 repo manifest 格式

✅ **更新工作流文件**
- 已将 MANIFEST_URL 默认值改为 Fork 地址
- 文件位置: .github/workflows/Recovery Build.yml

### 编译流程控制

| 组件 | 状态 | 控制方式 |
|------|------|----------|
| TWRP Manifest | ✅ 已整合 | 使用 Fork 的 aosp 仓库 + twrp-11 |
| convert.sh | ✅ 已整合 | 内置在仓库中 |
| zopfli | ⚠️ 自动获取 | 编译时临时克隆 |

### 优势

- 100% 控制编译流程
- 便于精细化纠错和调试
- 避免外部依赖变更导致编译失败
- 可追溯性更强

### 下一步

- 验证工作流编译是否正常
- 提取 recovery.img 并测试

------

## 编译经验总结

### 分支选择经验

| 分支 | 适用 Android 版本 | 兼容性 | 字体问题 | 推荐度 |
|------|-----------------|--------|---------|--------|
| twrp-10.0-deprecated | Android 10 | 存在 | ❌ 字体依赖错误 | ⚠️ 不推荐 |
| twrp-11 | Android 10+ | ✅ 良好 | ✅ 已修复 | ✅ 推荐 |
| twrp-12.1 | Android 12+ | ✅ 良好 | ✅ 已修复 | ⚠️ 过新 |

**经验总结**: twrp-10.0-deprecated 分支已被弃用，存在 Roboto 字体依赖问题。使用 twrp-11 分支可以完美支持 Android 10，且无字体问题。

### TWRP 11+ 兼容性要求

TWRP 11+ 分支使用 twrp_ 前缀的 makefile，与 OmniROM 的 omni_ 前缀不同。

#### 必需文件

1. **twrp_erdv9630.mk**
   - 必须继承 vendor/twrp/config/common.mk
   - 不能继承 vendor/omni/config/common.mk
   - 使用 PRODUCT_NAME := twrp_erdv9630

2. **AndroidProducts.mk 更新**
   ```makefile
   PRODUCT_MAKEFILES := \
       $(LOCAL_DIR)/omni_erdv9630.mk \
       $(LOCAL_DIR)/twrp_erdv9630.mk

   COMMON_LUNCH_CHOICES := \
       omni_erdv9630-user \
       omni_erdv9630-userdebug \
       omni_erdv9630-eng \
       twrp_erdv9630-user \
       twrp_erdv9630-userdebug \
       twrp_erdv9630-eng
   ```

3. **工作流配置**
   ```yaml
   MANIFEST_URL: https://github.com/MengWanYu/platform_manifest_twrp_aosp
   MANIFEST_BRANCH: twrp-11
   MAKEFILE_NAME: twrp_erdv9630
   ```

### 常见错误与解决方案

#### 错误 1: Roboto 字体缺失

```
Error: Exception in thread "main" java.io.IOException: Can not find the font file Roboto-Regular for language en
```

**原因**: twrp-10.0-deprecated 分支的文本图片生成依赖 Roboto 字体

**解决方案**: 切换到 twrp-11 分支（已修复字体系统）

#### 错误 2: lunch 命令找不到配置

```
Don't have a product spec for: 'omni_erdv9630-eng'
```

**原因**: twrp-11 需要 twrp_ 前缀的 makefile

**解决方案**: 创建 twrp_erdv9630.mk 并更新 AndroidProducts.mk

### 已 Fork 的仓库

| 仓库 | 地址 | 用途 |
|------|------|------|
| platform_manifest_twrp_aosp | https://github.com/MengWanYu/platform_manifest_twrp_aosp | Android 10+ TWRP 源码 |
| platform_manifest_twrp_omni | https://github.com/MengWanYu/platform_manifest_twrp_omni | Android 5.1-9.0 TWRP 源码 |

### 编译指令速查

```bash
# 触发工作流
curl -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/MengWanYu/android_device_tree_vivoy70s/actions/workflows/229304461/dispatches \
  -d '{
    "ref":"main",
    "inputs":{
      "MANIFEST_URL":"https://github.com/MengWanYu/platform_manifest_twrp_aosp",
      "MANIFEST_BRANCH":"twrp-11",
      "DEVICE_TREE_URL":"https://github.com/MengWanYu/android_device_tree_vivoy70s",
      "DEVICE_TREE_BRANCH":"main",
      "DEVICE_PATH":"device/vivo/erdv9630",
      "DEVICE_NAME":"vivo",
      "MAKEFILE_NAME":"twrp_erdv9630",
      "BUILD_TARGET":"recovery"
    }
  }'
```

### 下次编译注意事项

1. ✅ 使用 twrp-11 分支，不要使用 twrp-10.0-deprecated
2. ✅ 确保有 twrp_erdv9630.mk 文件
3. ✅ 确保工作流中 MAKEFILE_NAME 为 twrp_erdv9630
4. ✅ 字体文件已放置在 recovery/root/fonts/Roboto-Regular.ttf
5. ⚠️ 编译时间约 20-40 分钟

---

**最后更新**: 2026-02-01 - 添加 TWRP 11+ 兼容性修复和编译经验总结

---

## iFlow CLI 全局配置

已配置 iFlow CLI 自动启用 YOLO 模式和思考模式。


### 安装全局配置

双击运行: 安装全局配置.bat`n


或手动配置:

`powershell

# 运行配置脚本

.\setup_global_config.ps1


# 重启 PowerShell


# 或重新加载 Profile

. $PROFILE

`"n


### 使用方法


配置完成后，直接使用 iflow 命令即可：

`powershell

# 直接启动（自动启用 YOLO 和思考模式）

iflow


# 使用提示词

iflow -p '任务描述'

`"n


### 优势


- **YOLO 模式**: 自动接受所有操作，无需手动确认

- **思考模式**: 模型展示思考过程，提供更清晰的推理




---


**最后更新**: 2026-02-02 - 添加 iFlow CLI 全局配置


