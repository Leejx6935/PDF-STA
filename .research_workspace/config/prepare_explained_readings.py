"""Prepare four independent, cached-fulltext teaching and verification tasks."""
from pathlib import Path
import json

WORK = Path(__file__).resolve().parents[1]
ROOT = WORK.parent
papers = [
    ('L03','8720803',11,'T017B_L03R1','10.1016/j.ejcon.2022.100659',
     'T017B_L03R1_修订审核_2026-10-28.md',
     '从(16)(17)与对象方程重推观测误差动力学，保留漂移差和扰动导数；检查(19)-(21)的条件。区分原文显式假设、推导缺口、排版与OCR。解释时间变换为何改变误差尺度，但不能仅从指数比较式推出精确有限时间。'),
    ('L13','8f7be38',20,'T017B_L13_fulltext','10.1016/j.apm.2026.116848',
     'T017B_L13_补核审核_2026-10-28.md',
     '重推(44)与Lemma 1的系数对应；区分c=0与c>0的时间/残差集。解释单网络和非匹配不确定性重构的价值；检查真实位置误差的坐标，不机械复制旧对照表可能混入L07的式号/变量。参数条件和权重W的依赖分别核查。'),
    ('L07','36d2694',15,'T017B_L07_fulltext','10.1016/j.apm.2024.03.026',
     'T017B_L07_补核审核_2026-10-28.md',
     '重推(29)到真实位置误差的关系、(44)参数泄漏项的Young配平，检查(47)系数条件。说明滤波补偿的实际作用与代价；非光滑虚拟控制的导数只是可能有问题，不能不分轨迹声称必然无界。'),
    ('L09','5a17f6a',16,'T017B_L09_fulltext','10.1016/j.ymssp.2025.112928',
     'T017B_L09_补核审核_2026-10-28.md',
     '解释actor/critic/identifier信息流；核对代价是否使用绝对虚拟控制、在非消失周期参考下是否适定。秩一结论只针对瞬时外积，不外推时间积分矩阵。P到零与H到零严格区分；只在必要附加条件下讨论学习项极限。不把这篇的边界推广为所有学习控制缺陷。')]

style = Path.home()/'.agents/skills/research-literature-interpretation/references/writing-style.md'
for pid, doc, pages, old, doi, review, focus in papers:
    task = WORK/'tasks'/f'T021_{pid}_explained'
    task.mkdir(parents=True,exist_ok=True)
    source = WORK/'sources/parsed'/f'{pid}_fulltext.md'
    if pid == 'L03' and not source.exists():
        source = WORK/'inputs/four_papers/L03_Zotero.pdf'
    prompt = f'''# 单篇精读教学稿与关键证明复核：{pid}

用户要求开始四篇精读。本地其实已有2026-10-28的原始报告及审核，本任务在其基础上形成可学习的新稿，不覆盖任何旧产物。本轮只处理{pid}，不扩展检索、不设计新控制器、不仿真、不操作浏览器/账户、不上传全文、不推送Git。

DOI：{doi}。PDF：{WORK/'inputs/four_papers'/f'{pid}_Zotero.pdf'}。
MinerU缓存：doc:{doc}/tier:standard，总页数{pages}。
已有解析：{source}。先用read_document读取缓存首页核验身份；如全稿存在可用Read阅读MinerU解析md，必须核对页覆盖、截断标记；缺页再read_document按locator续读。只复用缓存，不调用parse_pdf；缓存失败则说明阻塞，不自行切换解析器/质量/远程。
旧报告：{WORK/'tasks'/old/'output'}。
必须读审核：{WORK/'reviews'/review}；旧报告结论可能仍有误，应与原式核对，不能照抄为事实。
目的：帮助熟悉滑模/自适应基础的研究生理解“问题—关键改变—实现机制—证明—证据—边界”，不能只列原文目录或批评清单。
优先复核：{focus}

只写三份新交付物，使用research.write_report写入本任务output：
1. explained_reading_zh.md：中文导师式精读讲义，约2500-4000汉字，含不超过三个核心命题。用3-6句开头交代问题、机制、最强证据和主要边界。解释关键符号及控制链，选一个决定性证明步骤完整推导，其余定位引用。明确“原文事实”“作者主张”“我的解释”“待验证”四层。保留方法的优点、何时值得借鉴，不能只找错。末尾给3-5个自测问题及简短答案，并给出本篇对本项目有条件的启发，不能宣布创新。重要公式必须注明页码和式号。作者仿真/实验结果不当作本项目复现结果。
2. proof_check.md：独立重算上述关键步骤，写清原式、每次代换/不等式、成立条件、原文和旧报告的分歧；可补最小反例或标量数值复算，不虚构运行结果。未闭合的地方停在精确缺口，不用“类似可得”。额外有界性假设必须明示。
3. reading_evidence.json：本篇DOI、MinerU ID、总页数/已读页、来源版本、缓存读取证据、关键定位、原图是否核过、采用的旧审核更正、仍待验证项。凡未亲自核对原图必须如实注明，不沿用旧审核者“原图已核”作为你自己的查看动作。

讲义必须符合research-literature-interpretation-evidence-v1。文件开头使用YAML frontmatter（---分隔），填写标量字段：interpretation_contract: research-literature-interpretation-evidence-v1；source_id；evidence_depth（按实际阅读设置）；read_scope（fulltext时写正文/证明页覆盖，不写“仅摘要”）；stable_citation；question；method；key_results；limitations；supports_or_refutes。这些是证据索引，不代替正文。
写作前读取：{style}。正文每段尽量不超过160字，长推导放display math或proof_check。避免引号大段复制；以解释和独立推导为主。末尾列DOI一手URL https://doi.org/{doi}、出版版/页范围、访问日期：2026-11-01。机械校验由审核者执行，不能自称已运行。

项目边界：目标ISA Transactions，理论学习不限制分区；位置与两腔压力可测、速度估计；当前四状态仿真不等于已核验三阶模型。本文不符合项目条件时说明差异，不悄悄修改项目条件。非零扰动/有界输入不自动排除有限时间；带正常数余项的不等式自身不能推出精确归零，但不由此否认其他鲁棒结构的能力。
'''
    (task/'prompt.md').write_text(prompt,encoding='utf-8')
    (task/'required_outputs.json').write_text(json.dumps(['explained_reading_zh.md','proof_check.md','reading_evidence.json']),encoding='utf-8')
    print(task.name)
