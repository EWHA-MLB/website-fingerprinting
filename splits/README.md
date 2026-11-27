# splits

모델팀이 공유하는 분할 파일. 모든 모델이 같은 파일을 써야 결과를 비교할 수 있다.

| 파일 | 내용 |
| --- | --- |
| `split_seed42.csv` | `record_id`, `split`(train/test). mon은 하위 페이지별 비율 유지, unmon은 무작위, 80:20 |
| `cv_folds_seed42.csv` | `task`(closed/binary/multi), `record_id`, `fold`(0~4). 실험 5·6 공통 교차검증 fold |
| `extra_split_seed42.csv` | Extra credit 방문 단위 분할. `source_group_id`, `dataset`, `label`, `split`, `source`, `fold`. extra credit 방문은 메인 기록과 같은 방문이라 mon과 메인에 있던 unmon은 `split_seed42.csv`의 train/test를 따르고(`source=main_matched`), extra에만 있는 unmon 8,441개는 따로 80:20으로 나눈다(`source=new`). train 30,523 / test 7,477 방문 |
