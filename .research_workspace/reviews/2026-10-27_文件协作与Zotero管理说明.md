# 文件协作、Claude Code与Zotero管理说明

日期：2026-10-27。

## 1. 你需要查看的目录

**最终输出路径：**

`C:\Users\leejx\Desktop\三阶系统PDF-STA\最终输出`

该目录只发布审核后的交付文件。临时解析、程序、日志、原始下载、历史稿和未通过审核的推导保存在：

`C:\Users\leejx\Desktop\三阶系统PDF-STA\.research_workspace`

现有原始论文、旧计划及仿真工程保留原位。本轮没有整理搬迁原始大目录；干净目录是上述“最终输出”。当前项目目标与日程以本轮两个月总计划及用户后续明确修改为准，其他旧版计划只作参考。

## 2. 两个AI如何交接

```text
研究者的目标和反馈
        ↓
审核者生成固定范围的任务
        ↓
Claude Code执行检索、阅读、解析和草稿整理
        ↓
本任务output中的待审核文件
        ↓
审核者核查来源、公式和研究差异
        ├─需要修改 → 新任务 / 新版本
        └─通过 → 发布到最终输出
```

研究者不需要在两个AI之间反复复制或编辑工作文件；审核者可直接启动本机引擎、读取产物并下发修改。科学判断仍需研究者和现实导师参与，尤其是研究范围、实验安排与论文最终内容。

同时使用两个AI时遵守：执行者只写自己的任务目录；审核者通过审核记录返回意见；最终文件由审核者发布。历史版本保留在工作区，最终目录展示当前交付版。该约定避免两方同时覆盖同一份证明；它不是操作系统级的文件访问隔离。

## 3. 已验证的Claude Code调用方式

调用的是VS Code扩展自带的本机可执行程序：

`C:\Users\leejx\.vscode\extensions\anthropic.claude-code-2.1.301-win32-x64\resources\native-binary\claude.exe`

已完成实际调用并收到结果。通过项目研究工具，已完成Zotero状态读取、MinerU版本读取和任务报告写入。

调度器路径：

`C:\Users\leejx\Desktop\三阶系统PDF-STA\.research_workspace\config\run_claude_task.py`

研究工具桥接程序：

`C:\Users\leejx\Desktop\三阶系统PDF-STA\.research_workspace\config\research_bridge.py`

执行方式是独立命令行会话。它不会接管当前VS Code聊天面板，不自动继承那个聊天的上下文。所需上下文通过任务文件和输入资料传入。本轮已发出打开研究工作区和测试报告的VS Code命令；这与在聊天面板操作是不同的方式。

现有模型配置标识为`DeepSeek-V4-Flash[1M]`，本轮沿用，没有修改。Claude Code是执行客户端的名称；不能据此把底层模型称为Anthropic Claude。

## 4. 文献检索、阅读和Future Work

执行者按任务完成：

1. 查Zotero已有记录，避免重复获取。
2. 检索出版社、作者版本和机构仓储，以DOI确认记录。
3. 获取可访问全文，遇到登录/验证则形成准确的访问队列。
4. 用本地MinerU转换为Markdown及定位元数据。
5. 检查覆盖页数、续读提示和公式质量。
6. 输出方法卡、假设表、作者Future Work与阅读者提出的问题。

每篇至少保存：题名、DOI、Zotero item key、PDF路径、解析路径、已读页码、可复查定位、阅读等级。只读摘要的材料不能伪装成全文证据。

作者的Future Work只是候选问题来源。审核者还要检查截至研究执行日的后续工作、证明是否可行、改动是否有意义，然后才能认定论文贡献。

## 5. Zotero与引用管理

本地Zotero 10.0.6接口和Connector已实际响应；可读取已有分类、查找条目、解析附件路径并导出BibTeX。

PDF的主存储优先沿用Zotero附件。解析文本、阅读卡和推导保存在研究工作区，不为了AI阅读而重复修改Zotero内部存储。

引用追踪用三种标识：

- **DOI**：论文的出版标识，适合核对版本和去重。
- **Zotero item key**：如`ASUHEN6J`，定位本地资料库条目。
- **BibTeX citation key**：LaTeX等稿件中使用的引用键，与Zotero item key不同。

本轮提供的seed参考文献若已导出，代表初始检索/阅读集合，不代表论文最终引用列表。写作阶段建立稳定引用键映射，更新元数据时保留正文引用关联。

当前研究工具只读和导出Zotero，没有新增条目、移动分类或合并记录。需要归档新论文时，按明确的入库任务和目标分类处理。

## 6. IEEE、ScienceDirect等登录权限

当前网页检索工具和公开下载工具不会自动继承用户浏览器中的登录状态。对付费全文，优先通过用户已登录浏览器及Zotero Connector保存到本地资料库，随后执行者可直接读取。

Claude Code官方另有Chrome浏览器连接能力，但本轮尚未验证本机扩展、浏览器会话与各论文站点的连接，不能称为已经接管浏览器。只有遇到具体获取受限论文时，再按访问队列处理；需要登录或站点授权的环节由用户在对应浏览器完成，不把账户密码写入任务文件。

参考：[Claude Code程序化运行](https://code.claude.com/docs/en/headless)、[Claude Code与Chrome](https://code.claude.com/docs/en/chrome)、[Zotero Connector](https://www.zotero.org/support/connector)。

## 7. 本轮与后续的边界

已建立本机调度和受控研究工具的工作流程。任务执行成功、PDF解析成功、文献读懂和理论通过审核，是不同的状态，分别记录。

本对话可启动、等待、审核并修改当前任务；不据此承诺对话结束后持续运行无人值守的科学审稿。后续继续研究时，可直接读取工作区中的任务、状态和审核记录接续执行。

## 8. 有限时间文献检索更新

本轮去重文献清单为`06_Zotero有限时间相关文献清单.csv`，逐篇分析为`07_Zotero有限时间论文_FutureWork与改进建议.md`，初步推导为`08_有限时间控制候选问题_初步理论分析.md`。

本轮18项独立工作的引用文件为`finite_time_library.bib`。原`references_seed.bib`仍作为初始8条快照保留；使用时选择相应文献集合，不把两份BibTeX同时重复载入。

Zotero原生导出时，引用键可能随所选集合出现重名后缀变化。本项目已按DOI保留原8条的项目引用键，对新增冲突键添加可追踪后缀；CSV同时记录原导出键与项目键。该调整只影响项目文件，没有修改Zotero资料库。
