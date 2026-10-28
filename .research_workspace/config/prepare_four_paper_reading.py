"""Resolve user-saved Zotero PDFs and prepare individually reviewed reading jobs."""
from pathlib import Path
import hashlib
import json
import shutil
import research_bridge as bridge

WORK = Path(__file__).resolve().parents[1]
PAPERS = [('L03', '564CY589', '10.1016/j.ejcon.2022.100659'),
          ('L07', 'B6W3KVH8', '10.1016/j.apm.2024.03.026'),
          ('L13', 'RB9YSKUY', '10.1016/j.apm.2026.116848'),
          ('L09', 'DH5S9YAT', '10.1016/j.ymssp.2025.112928')]
FOCUS = {
    'L03': '非学习基线：时间变换/增益是否与指定时刻相关；精确位置跟踪还是有限时间进入邻域；噪声是定理还是仿真；时间终点前后输入和闭环有界性。',
    'L07': '命令滤波与死区：滤波补偿变量怎样进入真实误差；有限时间结论对应哪个误差；虚拟控制导数条件和死区已知程度；有无可计算时间界。',
    'L13': '最近竞争工作：固定时间界能否按用户给定时间选参；单神经网络与非匹配不确定性重构；分段函数正则性、逼近域、余项及真实位置误差；不要将fixed-time自动译为预设时间。',
    'L09': '学习优化对照：真实actor/critic结构与独立动态状态；稳定性和优化目标分别如何证明；激励假设、Bellman残差及噪声条件；实际收敛性质。'
}
template = (WORK/'tasks/T017B_fulltext_reading_template.md').read_text(encoding='utf-8')
sources = bridge.call('resolve_sources', {'item_keys': [p[1] for p in PAPERS]})
manifest = {'date': '2026-10-27', 'acquisition': 'User saved PDFs to Zotero; read-only local attachment resolution.',
            'collection_note': 'Actual parent collection names are recorded; do not relocate or rename Zotero items.',
            'records': []}
for (paper_id, key, doi), resolved in zip(PAPERS, sources):
    metadata = bridge.fetch_json('http://127.0.0.1:23119/api/users/0/items/'+key)['data']
    if metadata.get('DOI', '').lower() != doi:
        raise ValueError('Unexpected DOI for '+paper_id)
    attachments = [a for a in resolved['pdf_attachments'] if a.get('exists')]
    if not attachments:
        raise FileNotFoundError('Missing PDF for '+paper_id)
    attachment = attachments[0]
    original = Path(attachment['local_path'])
    data = original.read_bytes()
    if not data.lstrip().startswith(b'%PDF-'):
        raise ValueError('Not a PDF: '+paper_id)
    target = WORK/'inputs/four_papers'/f'{paper_id}_Zotero.pdf'
    target.parent.mkdir(parents=True, exist_ok=True)
    if target.exists() and target.read_bytes() != data:
        raise ValueError('Existing input differs; preserve it: '+str(target))
    if not target.exists():
        shutil.copy2(original, target)
    record = {'id':paper_id, 'doi':doi, 'title':metadata.get('title'), 'zotero_item_key':key,
              'attachment_key':attachment['attachment_key'], 'zotero_original_path':str(original),
              'local_pdf_path':str(target), 'bytes':len(data), 'sha256':hashlib.sha256(data).hexdigest(),
              'pdf_header_verified':True, 'content_identity_status':'pending_mineru_first_page',
              'reading_status':'prepared_not_started', 'zotero_collections':metadata.get('collections',[])}
    manifest['records'].append(record)
    task_id = f'T017B_{paper_id}_fulltext'
    task = WORK/'tasks'/task_id
    task.mkdir(parents=True, exist_ok=True)
    prompt = f'''# 实际下发任务 {task_id}

你是执行者，由审核者逐篇审阅后决定后续工作。仅研究本篇，不操作浏览器，不写入Zotero。
论文：{record['title']}
DOI：{doi}
本地PDF：{target}
来源：用户通过Zotero保存；已核对条目DOI和PDF文件头，内容身份由你先用MinerU首页核验。只有题名、作者、DOI匹配才继续。
SHA256：{record['sha256']}
优先问题：{FOCUS[paper_id]}
用户最新偏好：优先探索预设时间，有限时间是后备；以扎实SCI二区目标为导向，不能保证录用，也不能为时间标签增加未经证实的创新。用户“预设时间”的准确英文类别尚待数学结论区分。
保持量测合同：位置与两腔压力可测、速度估计。识别本篇传感条件差异，但不改变项目合同。
必须先读审核意见：{WORK/'reviews/T016_方法选择审计审核意见_2026-10-27.md'}
报告目录：{task/'output'}；使用research.write_report写入三份要求产物。
避免在工具响应里反复加载整个大文档。先find_document查缓存；没有再parse_pdf，filename用{paper_id}_fulltext.md。若有next_request按页续读，保留定位。禁止用WebFetch替代本地PDF精读。
补充：对可指定时间T的主张，明确T是否事先给定、是否依赖初值/未知常数、控制在T附近是否有奇异性、T后如何定义、对象/滤波/观测/真实位置各自的时间保证。没有结论即写未建立。不得把标题/作者宣称直接作为通过审计的结论。

以下模板的全部约束与三份交付物适用；本轮必须认真复算关键步骤，不只复述论文。

{template}
'''
    (task/'prompt.md').write_text(prompt,encoding='utf-8')
    (task/'required_outputs.json').write_text(json.dumps(['paper_card.md','proof_reconstruction.md','coverage_and_provenance.json']),encoding='utf-8')
    if not (task/'status.json').exists():
        (task/'status.json').write_text(json.dumps({'task_id':task_id,'status':'prepared_not_started','approved':False}),encoding='utf-8')
out = WORK/'sources/four_papers_zotero_acquired_2026-10-27.json'
out.write_text(json.dumps(manifest,ensure_ascii=False,indent=2),encoding='utf-8')
print(json.dumps({'manifest_path':str(out),'records':manifest['records']},ensure_ascii=True))
