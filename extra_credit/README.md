# extra_credit

TrafficSliver(BWR)로 트래픽을 5개로 분할한 데이터에서 일반·분할·혼합 학습을 비교한다.

- 같은 기록의 `split_0~4.cell`은 반드시 같은 쪽(학습/평가)에 배치한다.

## SVM (`MLB_SVM_extra.ipynb`)

결과 보고서: `docs/reports/MLB_SVM_ExtraCredit.md` · 결과: `results/svm/extra_credit/`

### 실행

로컬 또는 서버에서 실행한다 (Colab 아님). 필요한 파일:

| 파일 | 위치 | 비고 |
| --- | --- | --- |
| `features_extra_split_trim0.csv.gz` | `data/extra/` | Drive `feature/extra credit features/include_zero_row/full_trim0/`. 저장소에 올리지 않음 |
| `features_extra_join_trim0.csv.gz` | `data/extra/` | 선택 (join 참고 평가) |
| 메인 특징, 분할 파일 | `features/기본 실험/`, `splits/` | 저장소에 있음 |

```bash
pip install numpy pandas scikit-learn nbformat nbclient ipykernel
# 셀마다 출력을 노트북에 저장하며 실행. 끝난 조건(ec_summary.csv에 행이 있는 것)은 건너뛴다
EC_N_JOBS=5 EC_CLOSED_FRAC=0.3 EC_RUN_BINARY=0 \
  python extra_credit/run_notebook.py extra_credit/MLB_SVM_extra.ipynb extra_credit/MLB_SVM_extra.ipynb extra_credit
```

| 환경 변수 | 기본값 | 의미 |
| --- | --- | --- |
| `EC_N_JOBS` | 5 | 확률 보정 5-fold 병렬 수. 작업 하나당 메모리 약 0.5~0.9GB |
| `EC_CLOSED_FRAC` | 0.3 | Closed B·C 학습 방문 샘플링 비율 |
| `EC_RUN_BINARY` | 0 | 1이면 Open-world 이진도 실행 |
| `EC_BINARY_FRAC` | 0.3 | 이진 B·C 학습 방문 샘플링 비율 |
| `EC_GPU` | 0 | 1이면 RAPIDS `cuml.accel`로 SVC를 GPU에서 실행 (Linux + NVIDIA GPU, `pip install cuml-cu12`). **이진 분류만 GPU에서 돈다.** 다중 클래스(Closed)는 cuml.accel이 CPU로 되돌리고 fold 병렬도 1로 고정돼 오히려 느려지므로 Closed에는 쓰지 않는다. `note`에 기록된다 |
| `EC_OVO_JOBS` | 0 | 2 이상이면 Closed의 다중 클래스 SVC를 클래스 쌍(one-vs-one) 4,465개의 이진 SVC로 나눠 CPU 코어 여러 개로 학습한다. 기존 방식과 모델이 같다(3% 점검에서 지표·support vector 수·확률값 일치). `EC_GPU=1`이면 무시된다 |
| `EC_SMOKE`, `EC_SMOKE_DIR` | 0 | 1이면 방문 3%로 코드 점검, 결과는 `EC_SMOKE_DIR`에 저장 |

### 진행 상황 (2026-11-27)

- 모든 조건 완료: Closed 110개·53개 A·B·C × 포함·제외, `B_full100` 참고, Open-world 이진 A·B·C × 포함·제외, join 참고 평가(`svm_ec_join_reference.csv`)
- 실행 방법 (서버, 48코어 + RTX 2000 Ada). 스크립트와 로그는 `results/svm/extra_credit/logs/`
  - Closed 53개 B·C: `EC_OVO_JOBS=24` (CPU, `nice 19`). 조건 하나에 학습 41~54분 + 예측 26~35분, 4개 합쳐 약 5.4시간
  - 이진: `EC_GPU=1 EC_RUN_BINARY=1` (GPU). 조건 하나에 학습 0.6~3.6분. 3% 점검에서 CPU와의 차이는 ROC-AUC 0.0001 수준
  - Closed 110개와 53개 A는 이전 로컬 실행(CPU libsvm) 결과 그대로
- GPU를 Closed에 쓰지 않은 이유: 53개 모델(C=2¹⁴)은 480행짜리 클래스 쌍 하나가 50만~180만 번 반복해야 수렴한다. 이 반복은 순차적이라 GPU에서 더 느리다 (쌍 하나에 CPU 0.3~1.5초, cuML GPU 4.8~12초).
- 두 번째 실행(이진)이 노트북을 덮어써서 노트북의 Closed 53개 셀 출력은 `[skip]`으로 남아 있다. 학습 로그가 남은 판은 `results/svm/extra_credit/logs/MLB_SVM_extra_closed_run.ipynb`와 `closed_53.log`.
