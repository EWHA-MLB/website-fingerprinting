# data

원본 데이터는 용량(최대 716MB)과 수업 제공 데이터라는 이유로 저장소에 올리지 않는다.

| 파일 | 내용 | 기록 수 |
| --- | --- | --- |
| `mon_standard.pkl` | monitored 95개 사이트 (페이지 950개 × 접속 20회) | 19,000 |
| `unmon_standard10.pkl` | unmonitored | 10,000 |
| `unmon_standard10_3000.pkl` | unmonitored 축소판 (10,000의 일부) | 3,000 |

위 pkl 파일을 이 폴더(`data/`)에 둔다. extra credit 특징(`data/extra/`)은 데이터팀이 추출한 결과로, 저장소에 포함되어 있다.

```
data/
├── mon_standard.pkl
├── unmon_standard10.pkl
├── extra/                                  (저장소에 포함)
│   ├── features_extra_split_trim0.csv.gz   split 190,000행, 약 79MB
│   └── features_extra_join_trim0.csv.gz    join 38,000행, 약 22MB
└── extra_raw/                              (extra credit 특징을 다시 추출할 때만)
    ├── mon.zip
    └── unmon.zip
```
