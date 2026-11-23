# Website Fingerprinting — Team MLB

이화여자대학교 기계학습 2026-2 팀 프로젝트. Tor 트래픽 기록에서 추출한 특징 110개로 접속한 웹사이트를 식별하고, Logistic Regression·SVM·Random Forest를 비교한다.

## 팀원과 역할

| 이름 | 역할 |
| --- | --- |
| (이름) | 데이터팀 — 특징 설계·추출 |
| (이름) | 데이터팀 — 특징 설계·추출 |
| 김미리 | 모델팀 — Logistic Regression, 실험 5·6 |
| (이름) | 모델팀 — SVM |
| (이름) | 모델팀 — Random Forest |

## 과제

| 과제 | 설명 |
| --- | --- |
| Closed-world | monitored 95개 사이트 중 어디인지 식별 (95 클래스) |
| Open-world 이진 | 관심 사이트(monitored)인지 여부 (mon 1 / unmon -1) |
| Open-world 다중 | 95개 사이트 + 관심 밖(-1) = 96 클래스 |

## 폴더 구조

```
docs/          제안서, 특징 정의서, 실험 보고서
data/          원본 데이터 안내 (파일은 올리지 않음)
features/      특징 추출 노트북 (데이터팀)
splits/        모델팀 공유 학습/평가 분할, 공통 교차검증 fold
models/        모델별 실험 노트북
ensemble/      실험 6. soft voting 앙상블
extra_credit/  TrafficSliver 분할 트래픽 실험
results/       모델별 요약 결과 CSV
```

## 실행 방법

모든 노트북은 Google Colab에서 Google Drive를 연결해 실행한다. Drive 안의 폴더 구조는 다음과 같다.

```
MyDrive/MLB-Project/
├── data/       원본 pkl (data/README.md 참고)
├── feature/    features_*.csv
└── results/    split_seed42.csv, cv_folds_seed42.csv, 모델별 결과 폴더
```

실행 순서: `features/` → `models/` (모델별 필수 실험 → 추가 실험) → `ensemble/`

## 공통 실험 조건

- 특징: 데이터팀 정의 110개 (g1~g6), 원본(trim0) 기준
- 분할: `splits/split_seed42.csv` — mon은 하위 페이지별 비율 유지, unmon은 무작위, 학습 80 : 평가 20
- 교차검증: `StratifiedKFold(n_splits=5, shuffle=True, random_state=42)`, 학습 데이터 안에서만 수행
- 최종 평가 데이터는 특징·하이퍼파라미터·임계값 선택에 사용하지 않음

## 주의: 데이터의 수집 흔적

제공된 데이터에서 monitored 기록의 99.98%가 처음 14개 패킷(인덱스 0~13)의 방향 패턴을 공유하며, unmonitored에서는 같은 패턴이 거의 나타나지 않는다. unmonitored 데이터를 축소하는 과정에서 생긴 패턴으로 확인되었다. 이에 따라

- 특정 번째 패킷의 방향을 직접 쓰는 특징이나 규칙은 사용하지 않는다.
- Closed-world는 영향이 없고, Open-world 결과는 이 영향을 고려해 해석한다.
- 이진 분류보다 다중 분류 결과를 중심으로 보고한다.

## 주요 결과

(최종 결과 확정 후 작성)
