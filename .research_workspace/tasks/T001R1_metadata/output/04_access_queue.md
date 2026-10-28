# 04 全文获取队列（2026-10-27）

## 目标

| 字段 | 值 |
|---|---|
| 目标论文 | Zhang T., Zhou B., Zhou H., Ding Y. *Practical Prescribed-Time Control for Active Suspension Systems via Periodic Delayed Sliding Mode Control* |
| DOI | 10.1002/rnc.70302 |
| 期刊 | International Journal of Robust and Nonlinear Control |
| 出版社页面 | https://onlinelibrary.wiley.com/doi/abs/10.1002/rnc.70302 |
| 状态 | **尚未形成已获取全文的可核查记录，等待合法全文获取** |

## 已知事实（仅限本轮可核对的内容）

1. Crossref 元数据检索命中该 DOI，标题、作者、期刊与上表一致；Crossref 记录的在线出版日期为 2025-11-15（该日期为 Crossref 元数据，未与出版社页面核对卷期页码）。
2. Crossref 条目声明了 Wiley 的 PDF 与 full-xml 链接（`intended-application: text-mining`）。这些只是元数据中声明的链接，**本轮未访问、未验证其可下载性**。
3. 本轮**没有**进行浏览器站点登录测试。因此：
   - 不能声称“登录成功”；
   - 不能声称“确定需要付费/确定有权限”；
   - 目前没有任何本地全文文件、没有解析产物、没有页级覆盖记录。
4. 本轮没有尝试任何下载路径，也没有尝试其他搜索引擎；该论文仅做了元数据搜索（P5）。

## 待办

- [ ] 通过合法途径获取全文：机构订阅 / 出版社账号 / 馆际互借（ILL） / 作者授权的公开版本。
- [ ] 下载后在独立空目录保存，记录来源 URL、获取时间、文件大小与校验和（SHA-256）。
- [ ] 用 MinerU（local, standard）解析，记录 doc id 与 tier。
- [ ] 统计页标记（页码范围），做分段通读并保存覆盖证据 JSON（段号、块范围、页码）。
- [ ] 通读完成前，不得把该文列为“已读”或“证据已获取”，也不得据此生成理论候选。

## 与已获取文献的关系

- Ding 2026（DOI 10.1109/TAC.2025.3618707）已获取并完成页级覆盖核对，见 `03_source_manifest.json`；不在本队列中。
- 本队列当前仅 1 项：rnc.70302。
