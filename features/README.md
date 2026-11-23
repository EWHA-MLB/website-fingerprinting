# features

데이터팀 특징 추출 노트북. 원본 pkl을 읽어 기록 하나를 특징 110개로 요약한 CSV를 만든다.

- 출력: `features_{mon|unmon10k}_trim{0|10|20}.csv` (정보 열 6개 + 특징 110개)
- 누적 흐름 100개 지점 비교용: `cumul100_mon_trim0.csv`
- 특징 정의: `docs/feature_spec.md`
