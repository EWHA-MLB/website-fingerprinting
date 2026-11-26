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
| `EC_GPU` | 0 | 1이면 RAPIDS `cuml.accel`로 SVC를 GPU에서 실행 (Linux + NVIDIA GPU, `pip install cuml-cu12` 등 CUDA 버전에 맞게). 결과가 CPU와 조금 다를 수 있어 `note`에 기록된다 |
| `EC_SMOKE`, `EC_SMOKE_DIR` | 0 | 1이면 방문 3%로 코드 점검, 결과는 `EC_SMOKE_DIR`에 저장 |

### 진행 상황 (2026-11-26 23:20)

- 완료: Closed 110개 A·B·C × 포함·제외, B 포함 전체 데이터 참고(`B_full100`), Closed 53개 A × 포함·제외
- 남음: Closed 53개(g1+g6) B·C × 포함·제외, Open-world 이진(선택)
- GPU 옵션은 아직 실제 GPU에서 시험하지 않았다. 서버에서는 먼저 `EC_SMOKE=1 EC_GPU=1`로 GPU가 쓰이는지, CPU 결과와 얼마나 다른지 확인한 뒤 본 실행한다. GPU로 본 실행하면 SVM 조건끼리 비교가 공정하도록 110개 조건도 다시 돌린다 (`ec_summary.csv`를 다른 이름으로 옮기면 처음부터 실행).
- 주의: 53개 모델(C=2¹⁴)은 split 데이터에서 수렴이 매우 느리다. 30% 샘플링한 B 포함 하나가 93분 넘게 5-fold 보정 학습을 끝내지 못해 중단했다 (같은 조건의 110개 모델은 4.3분).
