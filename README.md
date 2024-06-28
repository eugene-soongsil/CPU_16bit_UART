MIPS 프로세서 기반 5 Stage Pipeline CPU
---

이번 프로젝트에서 구현한 파이프라인 MIPS 프로세서는 명령어를 Fetch, Decode, Execute,
Memory Access, WriteBack 하는 5 단계 파이프라인으로 구성된 간단한 CPU이다. 각 단계는 독립적인 모듈로 구현되어 있으며, 명령어가 각 단계에서 병렬로 처리될 수 있도록 설계하였다.

아래는 탑 모듈의 Schemetic이다.
![CPU_TOP_finalSch](https://github.com/eugene-soongsil/Project_CPU/assets/163282235/67132849-565a-4cf8-be47-e375f71c50e9)
