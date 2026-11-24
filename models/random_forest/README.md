# Random Forest

노트북은 실행 결과(출력)를 남긴 채로 올립니다. 아래 노트북은 전달받은 최종 실행본이며 코드·설정·출력을 유지하고 파일명만 정리했습니다.

| 노트북 | 실험 내용 | 보고서 |
|---|---|---|
| [MLB_RF.ipynb](MLB_RF.ipynb) | 최초 필수 실험: Closed-world, Open-world 이진·다중, 튜닝·기본 RF 비교·특징 중요도·그룹 제거 | [최초 실험](../../docs/reports/MLB_RF.md) |
| [MLB_RF_Experiment1.ipynb](MLB_RF_Experiment1.ipynb) | 전체 110개 및 g1~g6 단독 학습, 세 분류 과제 | [실험 1·2](../../docs/reports/MLB_RF_Experiment1_2.md) |
| [MLB_RF_Experiment2.ipynb](MLB_RF_Experiment2.ipynb) | Closed-world의 g6 50/100지점 비교, train 내부 CV만 수행 | [실험 1·2](../../docs/reports/MLB_RF_Experiment1_2.md) |
| [MLB_RF_Experiment3_4_5.ipynb](MLB_RF_Experiment3_4_5.ipynb) | RF 설정 검증, 선택 RF 최종 test 평가, OOF 임계값 선택·고정 test 평가 | [실험 3·4·5](../../docs/reports/MLB_RF_Experiment3_4_5.md) |

## 입력과 실행 순서

- Google Colab CPU 런타임에서 Google Drive를 연결합니다. 위 표 순서로 각 실험을 확인할 수 있습니다.
- 기본 Drive 경로는 `MyDrive/MLB-Project/`입니다. 노트북 설정 셀에서 경로를 확인하세요.
- 특징: `feature/features_mon_trim0.csv`, `feature/features_unmon10k_trim0.csv`.
- 공유 분할: `results/split_seed42.csv`. 저장소의 [공유 파일](../../splits/)을 사용합니다.
- 추가 실험 2에는 `feature/cumul100_mon_trim0.csv`도 필요합니다.
- 공통 기준은 trim0·110개 특징(g6 50지점), seed 42, train 내부 층화 5-fold입니다. 추가 실험 2에서만 100지점 표현도 비교합니다.
- RF에는 표준화·log 변환·상수 특징 제거를 적용하지 않습니다.
- 입력 데이터는 저장소의 [데이터팀 파일](../../features/)과 [데이터 안내](../../data/README.md)를 참고하세요.

## 설정과 평가 구분

- 최초 실험의 선택 RF 및 실험 1·2 고정 기준: 트리 100개, 깊이 20, 분기 특징 sqrt, 최소 리프 표본 1.
- 실험 3에서 선택한 설정: Closed-world는 트리 500개·깊이 20, Open-world 다중·이진은 트리 100개·깊이 None. 나머지는 sqrt·리프 1입니다.
- 실험 4는 CV로 선택한 RF를 train 전체로 학습한 뒤 test로 평가합니다.
- 실험 5는 OOF에서 임계값을 선택한 뒤 test에 고정 적용합니다. test 결과로 재선택하지 않습니다.
- 실험 2에는 test 평가가 없습니다.
- 실험 3·4·5 노트북은 fold를 자체 생성합니다. 공유 split과 전달된 특징 CSV로 재현해 비교한 배정은 공유 CV와 세 과제 모두 일치했습니다. 노트북 1~5는 공유 파일 0~4와 한 칸 차이입니다. 실제 입력·행 순서가 달라지면 배정을 재확인하세요.
- Open-world 결과는 초반 패킷 방향 등 수집 방식 차이의 영향을 고려해 해석합니다.

## 결과

- [과제별 결과 CSV](../../results/random_forest/)
- [최초 실험 보고서](../../docs/reports/MLB_RF.md)
- [추가 실험 1·2 보고서](../../docs/reports/MLB_RF_Experiment1_2.md)
- [추가 실험 3·4·5 보고서](../../docs/reports/MLB_RF_Experiment3_4_5.md)

## 전달받은 파일과의 대응

| 전달받은 실행본 | 저장소 파일명 |
|---|---|
| `MLB_RandomForest.ipynb` | `MLB_RF.ipynb` |
| `MLB_RF_Experiment1_GroupOnly_clean (1)(1).ipynb` | `MLB_RF_Experiment1.ipynb` |
| `MLB_RF_Experiment2_Cumul50_vs_100 (1)(1).ipynb` | `MLB_RF_Experiment2.ipynb` |
| `MLB_RF_Experiments3_4_5_110features (2).ipynb` | `MLB_RF_Experiment3_4_5.ipynb` |
