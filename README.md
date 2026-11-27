# Website Fingerprinting on Tor

![Python](https://img.shields.io/badge/Python-3.10+-3776AB?logo=python&logoColor=white)
![scikit-learn](https://img.shields.io/badge/scikit--learn-1.6+-F7931E?logo=scikitlearn&logoColor=white)
![Colab](https://img.shields.io/badge/Google%20Colab-CPU-F9AB00?logo=googlecolab&logoColor=white)

Tor 트래픽의 패킷 방향·시간 정보만으로 사용자가 접속한 웹사이트를 식별합니다. 트래픽 기록에서 특징 110개를 직접 설계·추출하고, **Logistic Regression · SVM · Random Forest**를 같은 조건에서 비교했습니다.

이화여자대학교 기계학습(2026-2) 팀 프로젝트 · Team MLB

<br>

## Highlights

- **Closed-world 95개 사이트 식별 정확도 86.0%** (Random Forest), SVM + RF 앙상블로 **88.8%**
- 데이터의 **수집 흔적**을 발견: 7번째 패킷 방향 하나로 monitored/unmonitored가 99.99% 구분됨 → Open-world 결과 해석에 반영
- **TrafficSliver 분할 방어** 평가(Extra credit): 일반 트래픽으로 학습한 모델은 무작위 수준(약 1%)으로 떨어지고, 분할 트래픽으로 학습해도 최고 28.0%

<br>

## Results

최종 평가 데이터 정확도. 공통 특징 110개, 하이퍼파라미터는 학습 데이터의 5-fold 교차검증으로만 선택했습니다.

| Model | Closed-world<br><sub>95 classes</sub> | Open-world 이진<br><sub>mon / unmon</sub> | Open-world 다중<br><sub>96 classes</sub> |
| :--- | :---: | :---: | :---: |
| 기준선 | 0.0105 | 0.6552 | 0.3448 |
| Logistic Regression | 0.6884 | 0.7745 | 0.6343 |
| SVM (RBF) | 0.8521 | 0.8984 | **0.8384** |
| Random Forest | **0.8600** | **0.9031** | 0.8312 |
| **SVM + RF 앙상블** | **0.8876** | **0.9145** | **0.8564** |

<sub>기준선: Closed는 균등 무작위, 이진은 전부 mon, 다중은 전부 unmon으로 답한 정확도. 앙상블은 확률을 1:1로 평균한 soft voting. SVM은 특징 53개(g1+g6)만 쓸 때 Closed-world 0.8650.</sub>

<details>
<summary><b>Extra credit — TrafficSliver 분할 트래픽 (Closed-world 방문 정확도)</b></summary>
<br>

한 방문을 5개 경로로 나눈 트래픽에서, 학습 데이터만 바꿔 같은 split test 3,800방문을 평가했습니다.

| 학습 데이터 | LR | SVM | RF |
| :--- | :---: | :---: | :---: |
| A. 일반 트래픽 | 0.0139 | 0.0118 | 0.0216 |
| B. 분할 트래픽 | **0.1668** | 0.1445 | 0.2703 |
| C. 일반 + 분할 | 0.1397 | **0.1542** | **0.2800** |

- 빈 split 제외 버전 기준. 포함·제외 차이는 세 모델 모두 1%p 이내
- SVM B·C는 학습 시간 때문에 train 방문의 30%만 사용 (전체 학습 시 B 0.1958)
- 자세한 내용: [`extra_credit/`](extra_credit/)

</details>

<details>
<summary><b>데이터의 수집 흔적</b></summary>
<br>

monitored 기록의 99.98%가 처음 14개 패킷(인덱스 0~13)의 방향 패턴을 공유하고, unmonitored에서는 이 패턴이 거의 나타나지 않습니다. unmonitored 데이터를 축소하는 과정에서 생긴 것으로 확인했습니다.

- 특정 번째 패킷의 방향을 직접 쓰는 특징·규칙은 사용하지 않습니다.
- Closed-world는 영향이 없고, Open-world 결과는 이 영향을 고려해 모델 간 상대 비교로만 해석합니다.
- 앞 10개 패킷을 제거한 조건(trim10)의 이진 정확도 상승(0.7745 → 0.8817)은 성능 향상이 아니라 이 흔적이 특징에 더 직접 드러난 결과입니다.

</details>

<br>

## Tasks

| Task | 설명 | 클래스 |
| :--- | :--- | :---: |
| Closed-world | monitored 95개 사이트 중 어디에 접속했는지 | 95 |
| Open-world 이진 | 관심 사이트(monitored)인지 아닌지 | 2 |
| Open-world 다중 | 95개 사이트 + 관심 밖(unmonitored) | 96 |

**Features (110개)** — g1 총량 3 · g2 송신 위치·구간 17 · g3 버스트 6 · g4 초반·후반 방향 3 · g5 시간 31 · g6 누적 흐름 50. 정의: [`features/공통 규칙 문서 정의.md`](features/공통%20규칙%20문서%20정의.md)

<br>

## Getting Started

```bash
git clone https://github.com/EWHA-MLB/website-fingerprinting.git
cd website-fingerprinting
pip install -r requirements.txt
```

노트북은 Google Colab CPU 런타임 또는 로컬 Jupyter에서 실행합니다. 첫 설정 셀이 저장소 루트를 찾아 모든 경로를 잡으므로 경로를 바꿀 필요가 없고, Colab에서 노트북만 열면 저장소를 자동으로 내려받습니다.

**데이터** — 특징 CSV와 분할 파일은 저장소에 포함되어 있어 바로 실행할 수 있습니다. 수업 제공 원본(`*.pkl`, `*.zip`)은 특징을 다시 추출할 때만 필요합니다([`data/README.md`](data/README.md)).

### 실행 순서

| 단계 | 노트북 | 비고 |
| :---: | :--- | :--- |
| 1 | `features/기본 실험/feature_extraction.ipynb` | 원본 pkl → 특징 CSV (생략 가능) |
| 2 | `models/logistic_regression/01_lr_main.ipynb` | LR 필수 실험, 추가 실험, 실험 5 |
| | `models/svm/MLB_SVM_results.ipynb` 외 | SVM 필수·추가 실험 |
| | `models/random_forest/MLB_RF.ipynb` 외 | RF 필수·추가 실험 |
| 3 | `ensemble/MLB_SVM_probability.ipynb` → `MLB_Experiment6_Ensemble.ipynb` | 실험 6. 2단계의 확률 파일 필요 |
| 4 | `extra_credit/make_extra_split.ipynb` → 모델별 extra credit 노트북 | Extra credit |

모델별 노트북 목록과 실행 시간은 각 폴더의 README에 있습니다.

<br>

## Repository Structure

```
├── data/                원본 데이터 위치, extra credit 특징 (data/extra/)
├── features/            특징 추출 노트북, 특징 CSV, 특징 정의서
├── splits/              공통 학습/평가 분할, 교차검증 fold
├── models/
│   ├── logistic_regression/
│   ├── svm/
│   └── random_forest/
├── ensemble/            실험 6. soft voting 앙상블
├── extra_credit/        TrafficSliver 분할 트래픽 실험 (공통 분할, 노트북 위치)
├── results/             모델별 결과 요약 CSV
└── docs/reports/        모델별 실험 보고서
```

<br>

## Experimental Setup

- **분할**: 학습 80 : 평가 20 (`splits/split_seed42.csv`). monitored는 하위 페이지별 비율을 유지하고, unmonitored는 무작위로 나눔. 세 모델이 같은 파일을 사용
- **튜닝**: `StratifiedKFold(n_splits=5, shuffle=True, random_state=42)`로 학습 데이터 안에서만 수행
- **평가**: 최종 평가 데이터는 특징·하이퍼파라미터·임계값 선택에 사용하지 않음
- **환경**: Google Colab CPU 런타임 (CPU 2코어, RAM 12.7GB)

<br>

## Team

| <img src="https://github.com/mirikim404.png" width="90"> | <img src="https://github.com/jasmin0202.png" width="90"> | <img src="https://github.com/arky02.png" width="90"> | <img src="https://github.com/Yangyoonseo27.png" width="90"> | <img src="https://github.com/kimyujin8575.png" width="90"> | 김은규 |
| :---: | :---: | :---: | :---: | :---: | :---: |
| [김미리](https://github.com/mirikim404) | [김가영](https://github.com/jasmin0202) | [김기연](https://github.com/arky02) | [양윤서](https://github.com/Yangyoonseo27) | [김유진](https://github.com/kimyujin8575) | 김은규 |
| Model · LR, 앙상블 | Model · SVM | Model · RF | Data · 특징 | Data · 특징 | Data · 특징 |
