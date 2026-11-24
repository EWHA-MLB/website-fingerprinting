# RF 실험 결과

요약 CSV를 과제별로 구분했습니다. 큰 예측·확률 파일, 모델 객체, 학습 캐시와 원본 데이터는 이 폴더에 포함하지 않습니다.

- [closed_world](closed_world/): Monitored 95개 사이트 구분
- [open_binary](open_binary/): Monitored(1) / Unmonitored(-1)
- [open_multi](open_multi/): 95개 사이트 + Unmonitored(-1), 96클래스

## 출처와 정밀도

**CSV는 최종 노트북의 출력 표·로그에서 추출한 요약본입니다. Drive의 원본 CSV를 직접 복사한 것이 아닙니다.**

- 화면에 표시된 소수 자릿수를 유지했습니다. 전체 정밀도의 원본 CSV를 복원한 것으로 해석하지 않습니다.
- 생략된 열(`...`) 및 잘린 경로·객체 열은 제외했습니다. 누락 값을 추정하지 않았으며 NaN은 빈 칸입니다. 깊이 제한 없음은 `None`으로 표시합니다.
- CV/OOF와 test를 파일명으로 구분했습니다. 실험 2는 Closed-world CV만 수행했으므로 test 파일이 없습니다.

## 파일 이름

- `baseline_*`: 추가 실험 이전에 수행한 최초 RF 실험(`MLB_RF.ipynb`)의 결과입니다. 튜닝 결과와 참고 비교를 포함하며, RF 기본 설정만을 뜻하지 않습니다.
- `experiment1`~`experiment5`: 각 추가 실험의 결과입니다.

| 파일 | 내용 |
|---|---|
| `baseline_summary.csv` | 최초 선택 RF 요약. 기본 RF·balanced 참고 모델은 variant로 구분 |
| `baseline_cv.csv` | 최초 5개 후보와 출력된 CV 정확도 |
| `baseline_ablation.csv` | 최초 그룹 제거 결과(Closed-world·이진) |
| `baseline_site_accuracy.csv` | 출력에 보이는 정확도 하위 10개 사이트만 포함 |
| `baseline_confused_pairs.csv` | 출력에 보이는 혼동 쌍 상위 15개만 포함 |
| `baseline_feature_importance.csv` | Closed-world 중요도로 고른 출력 상위 15개 특징의 중요도. 이진 파일도 같은 특징 부분집합 |
| `baseline_group_importance.csv` | 전체 여섯 그룹의 중요도 합계·평균 |
| `experiment1.csv` | 전체 및 g1~g6 단독 조건의 검증·test 성능 |
| `experiment2.csv` | full/g1+g6, 50/100지점 네 조건의 CV |
| `experiment2_comparison.csv` | 실험 2의 50→100 차이·개선 fold 수·시간 |
| `experiment3.csv` | 다섯 설정의 CV·시간·선택 여부 |
| `experiment4_cv.csv` | 선택 RF의 CV/OOF 요약에서 출력에 보이는 열 |
| `experiment4_test.csv` | 선택 RF 최종 test 성능 |
| `experiment5_oof.csv` | 이진 OOF에서 고른 임계값의 검증 성능 |
| `experiment5_test.csv` | 같은 임계값을 고정 적용한 test 성능 |

## 핵심 최종 test 결과

| 과제 | 실험 4 정확도 | Macro-F1 |
|---|---:|---:|
| Closed-world | 0.8600 | 0.8594 |
| Open-world 다중 | 0.8312 | 0.8244 |
| Open-world 이진 | 0.9031 | 0.8888 |

다중 분류의 실제 Monitored 사이트 번호 정답률은 0.7503입니다. 이진 FPR 5% 목표로 검증에서 고른 임계값 0.73의 test TPR/FPR/Precision은 0.81447/0.04300/0.97296입니다.

## 출력 근거

셀 번호는 물리적 셀 순서(1부터)이며 코드 실행 번호와 다릅니다.

| CSV | 노트북 | 출력 위치 | 행 수 |
|---|---|---|---:|
| [closed_world/baseline_summary.csv](closed_world/baseline_summary.csv) | [MLB_RF.ipynb](../../models/random_forest/MLB_RF.ipynb) | cells 13/15/17/19/21/31: summary and displayed reference logs | 2 |
| [open_binary/baseline_summary.csv](open_binary/baseline_summary.csv) | [MLB_RF.ipynb](../../models/random_forest/MLB_RF.ipynb) | cells 13/15/17/19/21/31: summary and displayed reference logs | 2 |
| [open_multi/baseline_summary.csv](open_multi/baseline_summary.csv) | [MLB_RF.ipynb](../../models/random_forest/MLB_RF.ipynb) | cells 13/15/17/19/21/31: summary and displayed reference logs | 1 |
| [closed_world/baseline_cv.csv](closed_world/baseline_cv.csv) | [MLB_RF.ipynb](../../models/random_forest/MLB_RF.ipynb) | cell 13: five displayed CV candidate scores (4 decimals) | 5 |
| [open_binary/baseline_cv.csv](open_binary/baseline_cv.csv) | [MLB_RF.ipynb](../../models/random_forest/MLB_RF.ipynb) | cell 15: five displayed CV candidate scores (4 decimals) | 5 |
| [open_multi/baseline_cv.csv](open_multi/baseline_cv.csv) | [MLB_RF.ipynb](../../models/random_forest/MLB_RF.ipynb) | cell 19: five displayed CV candidate scores (4 decimals) | 5 |
| [closed_world/baseline_ablation.csv](closed_world/baseline_ablation.csv) | [MLB_RF.ipynb](../../models/random_forest/MLB_RF.ipynb) | cell 29: first displayed table; truncated best_params omitted | 7 |
| [open_binary/baseline_ablation.csv](open_binary/baseline_ablation.csv) | [MLB_RF.ipynb](../../models/random_forest/MLB_RF.ipynb) | cell 29: second displayed table; truncated best_params omitted | 7 |
| [closed_world/baseline_site_accuracy.csv](closed_world/baseline_site_accuracy.csv) | [MLB_RF.ipynb](../../models/random_forest/MLB_RF.ipynb) | cell 27: displayed lowest 10 sites only, not all 95 | 10 |
| [closed_world/baseline_confused_pairs.csv](closed_world/baseline_confused_pairs.csv) | [MLB_RF.ipynb](../../models/random_forest/MLB_RF.ipynb) | cell 27: displayed top 15 confused pairs only | 15 |
| [closed_world/baseline_feature_importance.csv](closed_world/baseline_feature_importance.csv) | [MLB_RF.ipynb](../../models/random_forest/MLB_RF.ipynb) | cell 25: displayed 15 features ranked by Closed-world importance; not full vector | 15 |
| [closed_world/baseline_group_importance.csv](closed_world/baseline_group_importance.csv) | [MLB_RF.ipynb](../../models/random_forest/MLB_RF.ipynb) | cell 25: all six feature groups | 6 |
| [open_binary/baseline_feature_importance.csv](open_binary/baseline_feature_importance.csv) | [MLB_RF.ipynb](../../models/random_forest/MLB_RF.ipynb) | cell 25: displayed 15 features ranked by Closed-world importance; not full vector | 15 |
| [open_binary/baseline_group_importance.csv](open_binary/baseline_group_importance.csv) | [MLB_RF.ipynb](../../models/random_forest/MLB_RF.ipynb) | cell 25: all six feature groups | 6 |
| [closed_world/experiment1.csv](closed_world/experiment1.csv) | [MLB_RF_Experiment1.ipynb](../../models/random_forest/MLB_RF_Experiment1.ipynb) | cell 12: full + g1...g6 displayed table | 7 |
| [open_multi/experiment1.csv](open_multi/experiment1.csv) | [MLB_RF_Experiment1.ipynb](../../models/random_forest/MLB_RF_Experiment1.ipynb) | cell 14: full + g1...g6 displayed table | 7 |
| [open_binary/experiment1.csv](open_binary/experiment1.csv) | [MLB_RF_Experiment1.ipynb](../../models/random_forest/MLB_RF_Experiment1.ipynb) | cell 16: full + g1...g6 displayed table | 7 |
| [closed_world/experiment2.csv](closed_world/experiment2.csv) | [MLB_RF_Experiment2.ipynb](../../models/random_forest/MLB_RF_Experiment2.ipynb) | cell 12: four configurations; truncated local result_folder omitted | 4 |
| [closed_world/experiment2_comparison.csv](closed_world/experiment2_comparison.csv) | [MLB_RF_Experiment2.ipynb](../../models/random_forest/MLB_RF_Experiment2.ipynb) | cell 14: full and g1_g6 50/100-point comparisons | 2 |
| [closed_world/experiment3.csv](closed_world/experiment3.csv) | [MLB_RF_Experiment3_4_5.ipynb](../../models/random_forest/MLB_RF_Experiment3_4_5.ipynb) | cells 7 and 13: candidate parameters and CV table | 5 |
| [open_multi/experiment3.csv](open_multi/experiment3.csv) | [MLB_RF_Experiment3_4_5.ipynb](../../models/random_forest/MLB_RF_Experiment3_4_5.ipynb) | cells 7 and 15: candidate parameters and CV table | 5 |
| [open_binary/experiment3.csv](open_binary/experiment3.csv) | [MLB_RF_Experiment3_4_5.ipynb](../../models/random_forest/MLB_RF_Experiment3_4_5.ipynb) | cells 7 and 17: candidate parameters and CV table | 5 |
| [closed_world/experiment4_cv.csv](closed_world/experiment4_cv.csv) | [MLB_RF_Experiment3_4_5.ipynb](../../models/random_forest/MLB_RF_Experiment3_4_5.ipynb) | cell 19: displayed OOF summary; hidden columns omitted | 1 |
| [closed_world/experiment4_test.csv](closed_world/experiment4_test.csv) | [MLB_RF_Experiment3_4_5.ipynb](../../models/random_forest/MLB_RF_Experiment3_4_5.ipynb) | cell 25: full displayed final test summary | 1 |
| [open_binary/experiment4_cv.csv](open_binary/experiment4_cv.csv) | [MLB_RF_Experiment3_4_5.ipynb](../../models/random_forest/MLB_RF_Experiment3_4_5.ipynb) | cell 19: displayed OOF summary; hidden columns omitted | 1 |
| [open_binary/experiment4_test.csv](open_binary/experiment4_test.csv) | [MLB_RF_Experiment3_4_5.ipynb](../../models/random_forest/MLB_RF_Experiment3_4_5.ipynb) | cell 25: full displayed final test summary | 1 |
| [open_multi/experiment4_cv.csv](open_multi/experiment4_cv.csv) | [MLB_RF_Experiment3_4_5.ipynb](../../models/random_forest/MLB_RF_Experiment3_4_5.ipynb) | cell 19: displayed OOF summary; hidden columns omitted | 1 |
| [open_multi/experiment4_test.csv](open_multi/experiment4_test.csv) | [MLB_RF_Experiment3_4_5.ipynb](../../models/random_forest/MLB_RF_Experiment3_4_5.ipynb) | cell 25: full displayed final test summary | 1 |
| [open_binary/experiment5_oof.csv](open_binary/experiment5_oof.csv) | [MLB_RF_Experiment3_4_5.ipynb](../../models/random_forest/MLB_RF_Experiment3_4_5.ipynb) | cell 21: all five threshold rules, OOF selection data | 5 |
| [open_binary/experiment5_test.csv](open_binary/experiment5_test.csv) | [MLB_RF_Experiment3_4_5.ipynb](../../models/random_forest/MLB_RF_Experiment3_4_5.ipynb) | cell 25: five fixed threshold rules on test | 5 |

자세한 설정과 해석은 [실험 보고서](../../docs/reports/MLB_RF_Experiment3_4_5.md)를 참고하세요.
