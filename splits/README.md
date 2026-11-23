# splits

모델팀이 공유하는 분할 파일. 모든 모델이 같은 파일을 써야 결과를 비교할 수 있다.

| 파일 | 내용 |
| --- | --- |
| `split_seed42.csv` | `record_id`, `split`(train/test). mon은 하위 페이지별 비율 유지, unmon은 무작위, 80:20 |
| `cv_folds_seed42.csv` | `task`(closed/binary/multi), `record_id`, `fold`(0~4). 실험 5·6 공통 교차검증 fold |
