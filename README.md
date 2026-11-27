# Website Fingerprinting — Team MLB

이화여자대학교 기계학습 2026-2 팀 프로젝트. Tor 트래픽 기록에서 추출한 특징 110개로 접속한 웹사이트를 식별하고, Logistic Regression·SVM·Random Forest를 비교한다.

## 팀원과 역할

| 이름 | 역할 |
| --- | --- |
| 김은규 | 데이터팀 — 특징 설계·추출 |
| 양윤서 | 데이터팀 — 특징 설계·추출 |
| 김유진 | 데이터팀 — 특징 설계·추출 |
| 김미리 | 모델팀 — Logistic Regression, 실험 5·6 |
| 김가영 | 모델팀 — SVM |
| 김기연 | 모델팀 — Random Forest |

## 과제

| 과제 | 설명 |
| --- | --- |
| Closed-world | monitored 95개 사이트 중 어디인지 식별 (95 클래스) |
| Open-world 이진 | 관심 사이트(monitored)인지 여부 (mon 1 / unmon -1) |
| Open-world 다중 | 95개 사이트 + 관심 밖(-1) = 96 클래스 |

## 폴더 구조

```
docs/          제안서, 특징 정의서, 실험 보고서
data/          원본 데이터 위치 (파일은 올리지 않음)
features/      특징 추출 노트북 (데이터팀)
splits/        모델팀 공유 학습/평가 분할, 공통 교차검증 fold
models/        모델별 실험 노트북
ensemble/      실험 6. soft voting 앙상블
extra_credit/  TrafficSliver 분할 트래픽 실험
results/       모델별 요약 결과 CSV
```

## 실행 방법

### 환경

- Python 3.10 이상, `pip install -r requirements.txt`
- Google Colab CPU 런타임 또는 로컬 Jupyter에서 실행한다. GPU는 필요 없다.
- 노트북의 첫 설정 셀은 저장소 루트(`splits/` 폴더가 있는 위치)를 찾아 모든 경로를 그 기준으로 잡는다. Colab에서 GitHub의 노트북만 열었다면 저장소를 `/content/website-fingerprinting`에 내려받은 뒤 같은 방식으로 실행한다.

```bash
git clone https://github.com/EWHA-MLB/website-fingerprinting.git
cd website-fingerprinting
pip install -r requirements.txt
```

### 데이터 준비

| 파일 | 위치 | 저장소 포함 | 사용하는 노트북 |
| --- | --- | --- | --- |
| 원본 `mon_standard.pkl`, `unmon_standard10.pkl` | `data/` | X (`data/README.md`) | 특징 추출, LR 7-추가 |
| 메인 특징 `features_*_trim{0,10,20}.csv`, `cumul100_mon_trim0.csv` | `features/기본 실험/` | O | 모든 모델 |
| 분할 `split_seed42.csv`, `cv_folds_seed42.csv`, `extra_split_seed42.csv` | `splits/` | O | 모든 모델 |
| extra credit 특징 `features_extra_split_trim0.csv.gz` (`features_extra_join_trim0.csv.gz`는 선택) | `data/extra/` | O | `extra_credit/`, 모델별 extra credit 노트북 |
| 수업 제공 extra credit ZIP `mon.zip`, `unmon.zip` | `data/extra_raw/` | X | extra credit 특징 추출 (`features/extra_credit/`) |

### 실행 순서

1. `features/기본 실험/feature_extraction.ipynb` — 원본 pkl에서 특징 CSV 생성. `features/extra_credit/extra_credit_feature_extraction_colab.ipynb` — extra credit ZIP에서 특징 생성. 결과 파일이 저장소에 있으므로 둘 다 건너뛰어도 된다.
2. `models/` — 모델별 필수 실험 → 추가 실험 (모델 폴더의 README 참고)
3. `ensemble/` — 실험 6. LR·SVM·RF 노트북이 만든 OOF·test 확률 파일이 먼저 있어야 한다.
4. `extra_credit/`, 모델별 extra credit 노트북 — `data/extra/`의 특징과 `splits/extra_split_seed42.csv`를 사용한다.

결과 요약 CSV는 `results/{모델}/`에 저장된다. 큰 예측·확률 파일은 저장소에 올리지 않는다(`.gitignore`).

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
