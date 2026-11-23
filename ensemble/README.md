# ensemble

실험 6. LR·SVM·RF의 확률을 같은 가중치로 평균하는 soft voting 앙상블.

- 입력: 각 모델의 `{모델}_oof_{과제}.csv`, `{모델}_test_proba_{과제}.csv` (공통 fold 사용)
- 출력: `ensemble_{closed|multi|binary}.csv`, `ensemble_binary_threshold.csv`
