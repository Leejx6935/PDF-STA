# 论文研究工作区

最终交付目录：`C:\Users\leejx\Desktop\三阶系统PDF-STA\最终输出`

本目录保存执行任务、检索和解析材料、草稿、审核记录及历史版本。研究者查看最终成果时只需打开“最终输出”。

## 当前任务

- `tasks/T000_bridge_check`：已实际调用VS Code扩展自带的Claude Code引擎，并验证Zotero与MinerU工具调用和报告保存。
- `tasks/T001_literature_pilot`：首批文献处理任务；实时阶段状态见该目录`status.json`，交付物见`output`。
- 执行调用及返回结果保存在`runs`；任务完成不等于审核通过。

## 职责

Claude Code负责文献检索、可得全文获取、Zotero查询、MinerU本地解析和方法卡。审核者检查证据、阅读范围、研究差异和理论推导，审核后发布交付目录。

运行方式是独立命令行会话，不会向VS Code的Claude聊天面板自动输入。此VS Code窗口用来查看文件与状态。模型沿用用户现有配置，目前配置标识为`DeepSeek-V4-Flash[1M]`，不是默认假设为Anthropic Claude模型。

## 文件约定

1. 一个执行任务一个目录，一次运行一个唯一日志目录。
2. 仅审核者发布最终目录；执行者通过工具写本任务`output`。
3. 原始论文和既有工程保留原位；优先复用Zotero附件与MinerU缓存。
4. 修改建议写成新任务和审核记录，不让两个AI同时改同一个理论文件。
5. `sources/parsed`保存可读正文和定位元数据；全文覆盖范围必须明确记录。
6. 论文写作的参考文献由Zotero导出，并记录Zotero item key与BibTeX citation key的对应关系。

## 调度入口

任务由审核者运行`config/run_claude_task.py`调度，不需要研究者手工复制文件。任务脚本沿用现有登录与模型配置，使用指定研究工具，不修改账户设置。

本轮任务由当前对话启动；不代表本对话结束后会持续自动审核后续任务。
