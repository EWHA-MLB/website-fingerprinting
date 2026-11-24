# ensemble

실험 6. LR·SVM·RF의 확률을 같은 가중치로 평균하는 soft voting 앙상블.

## 노트북

| 파일 | 내용 |
| --- | --- |
| `MLB_SVM_probability.ipynb` | SVM 확률 파일 생성. 실험 4 설정 그대로 `SVC(probability=True)`로 학습, 공통 fold로 OOF 확률 저장 |
| `MLB_Experiment6_Ensemble.ipynb` | RF 확률(npz) 변환, 모델 간 record_id·정답·클래스 정렬 검사, 조합별 평균, 이진 임계값 비교 |

- 입력: 각 모델의 `{모델}_oof_{과제}.csv`, `{모델}_test_proba_{과제}.csv` (Drive `MLB-Project/results/`)
- 출력: `results/ensemble/ensemble_{closed|multi|binary}.csv`, `ensemble_binary_threshold.csv`
- 확률 파일은 커서 저장소에 올리지 않는다.

## 결과 (test 정확도)

| 구성 | Closed | 다중 | 이진 |
| --- | --- | --- | --- |
| LR | 0.6861 | 0.6338 | 0.7745 |
| SVM | 0.8503 | 0.8328 | 0.8983 |
| RF | 0.8600 | 0.8312 | 0.9031 |
| LR + SVM | 0.8005 | 0.7760 | 0.8903 |
| LR + RF | 0.8111 | 0.7705 | 0.8564 |
| **SVM + RF** | **0.8876** | **0.8564** | **0.9145** |
| LR + SVM + RF | 0.8513 | 0.8221 | 0.9012 |

SVM + RF가 세 과제 모두 OOF·test 1위다. LR이 들어간 조합은 모두 더 강한 단독 모델보다 낮다.

## 주의

- SVM 단독 값은 확률의 최댓값으로 예측한 값이라 실험 4(`predict`)와 소수 셋째 자리 정도 다르다. 앙상블 비교는 이 표 안에서 한다.
- RF는 공통 fold 대신 자체 fold로 OOF를 만들었다. 각 OOF 확률이 그 모델이 해당 기록을 학습하지 않은 상태의 값이라 평균 결합에는 문제없다.
- 가중치는 1:1 고정이며, test를 보고 조정하지 않았다.
