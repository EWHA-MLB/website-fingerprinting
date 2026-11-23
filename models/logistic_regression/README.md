# Logistic Regression

모델팀 LR 담당 실험. 데이터팀 특징 110개(trim0)와 모델팀 공유 분할을 사용한다.

## 노트북

| 파일 | 내용 |
| --- | --- |
| `01_lr_main.ipynb` | 필수 실험 ①②③, 초반 제거 비교, 초반 패킷 방향 분석, 계수 해석, 오류 분석, 그룹 제거, 추가 실험 1(그룹 단독)·2(누적 흐름 해상도) |
| `02_lr_experiment5_6.ipynb` | 모델팀 공통 fold 생성, OOF·test 확률 저장, 실험 5(이진 임계값 분석), 실험 6(soft voting 앙상블) |

두 노트북 모두 Google Colab에서 Google Drive를 연결해 실행한다. 경로는 노트북 0번 설정 셀에서 바꾼다.

## 공통 설정

- 특징: 110개 (g1~g6), trim0
- 분할: `splits/split_seed42.csv` (학습 80 : 평가 20)
- 모델: `StandardScaler` + `LogisticRegression`을 Pipeline으로 묶어, 교차검증 학습 구간에서만 표준화 기준을 계산
- C 선택: `StratifiedKFold(5, shuffle=True, random_state=42)` 교차검증, 후보 0.01~1000
- 최종 평가 데이터는 C·임계값 선택에 사용하지 않음

## 필수 실험 결과

| 과제 | best C | CV 정확도 | 최종 평가 정확도 | 비고 |
| --- | --- | --- | --- | --- |
| Closed-world (95 클래스) | 100 | 0.6626 ± 0.0065 | 0.6884 | 튜닝 전(C=1) 0.6413 |
| Open-world 이진 | 1000 | 0.7813 ± 0.0052 | 0.7745 | TPR 0.8905, TNR 0.5540, ROC-AUC 0.8118 |
| Open-world 다중 (96 클래스) | 100 | 0.6321 ± 0.0041 | 0.6343 | monitored 사이트 정답 0.5571 |

## 결과 파일 (`results/logistic_regression/`)

| 파일 | 내용 |
| --- | --- |
| `lr_summary.csv` | 필수 실험·추가 비교 전체 요약 |
| `lr_cv_tables.csv` | 실험별 C 탐색 표 |
| `lr_ablation_closed.csv` / `lr_ablation_binary.csv` | 그룹 제거 실험 |
| `lr_grouponly.csv` | 추가 실험 1. 그룹 단독 학습 |
| `lr_g6_resolution.csv` | 추가 실험 2. 누적 흐름 50 vs 100 지점 (Closed-world) |
| `lr_early_packet_direction.csv` | 위치별 송신 비율 (mon vs unmon, 앞 40개 패킷) |
| `lr_closed_site_acc.csv` / `lr_closed_confused_pairs.csv` | Closed-world 오류 분석 |
| `lr_group_coef.csv` | 그룹별 평균 계수 크기 (참고용) |
| `lr_threshold_binary.csv` | 실험 5. 목표 오탐률별 임계값과 탐지율 |

## 해석할 때 주의

- **수치의 기준은 `lr_summary.csv`다.** `01_lr_main.ipynb`의 5번 셀(Open-world 이진)은 부분 재실행본이라 출력의 C 값(10)이 요약 파일(1000)과 다르다. C=10·100·1000의 CV 정확도가 사실상 같아(0.7810 전후) 결론에는 영향이 없다.
- **계수 크기로 그룹 중요도를 판단하지 않는다.** 계수 크기는 C 선택에 민감하다. 그룹 기여도는 그룹 제거·단독 학습 실험으로 판단한다.
- **Open-world 결과는 수집 흔적의 영향을 받는다.** monitored 기록의 초반 패킷(인덱스 0~13) 방향 패턴이 unmonitored와 다르게 고정되어 있다. 특히 초반·후반 방향 그룹(g4) 3개만으로 이진 정확도 0.7268이 나온다(기준선 0.6552). Closed-world는 영향이 없다.
- **초반 10개를 제거한 조건(trim10)의 정확도 상승(0.7745 → 0.8817)은 성능 향상이 아니다.** 제거 후 첫 패킷 방향 특징이 수집 흔적을 그대로 담게 되어 생긴 결과다.
