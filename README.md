# opcua-client-gui-kor

이 저장소는 [FreeOpcUa/opcua-client-gui](https://github.com/FreeOpcUa/opcua-client-gui) 저장소의 한국어 포크입니다.

[asyncua](https://github.com/FreeOpcUa/opcua-asyncio)와 PyQt6로 만든 간단한 OPC UA GUI 클라이언트입니다.

![스크린샷](/screenshot.png?raw=true "스크린샷")

## 기능

- 연결 및 연결 해제. 전송 연결이 끊어지면 자동으로 다시 연결하며, 세션을 복구하는 동안 화면이 회색으로 바뀌고 상태 표시줄에 안내가 표시됩니다.
- 노드 유형별 아이콘으로 주소 공간 탐색.
- 선택한 노드의 속성과 참조 표시.
- 변수 데이터 변경 및 이벤트 구독.
- 변수 값 쓰기.
- 애플리케이션 인증서와 서버별 보안 모드·정책을 설정하는 GUI.
- 메서드 호출 대화상자.
- 구독한 변수의 실시간 그래프(pyqtgraph).
- `QSettings`를 통한 연결 기록, 서버별 마지막 탐색 노드 및 창 배치 저장.
- NodeId 또는 전체 탐색 경로를 복사하는 컨텍스트 메뉴. 복사한 경로는 다음과 같이 코드에 붙여 넣을 수 있습니다.
  `client.nodes.root.get_child(['0:Objects', '2:MyNode'])`

## 설치

Python 3.14 이상과 [`uv`](https://docs.astral.sh/uv/)가 필요합니다. [MeteorClear/opcua-client-gui](https://github.com/MeteorClear/opcua-client-gui-kor.git) 저장소를 복제한 뒤 의존성을 설치하고 실행합니다.

```
git clone https://github.com/MeteorClear/opcua-client-gui-kor.git
cd opcua-client-gui-kor
uv sync
uv run python app.py
```

## 언어 선택

`Settings -> Select Language`에서 `System Default`, `English`, `한국어` 중 하나를 선택할 수 있습니다. 선택한 언어는 저장되며 애플리케이션을 다시 시작한 뒤 적용됩니다.

`System Default`는 운영체제 UI 언어 목록에서 처음 발견한 지원 언어를 사용합니다. 지원하는 언어가 없으면 영어를 사용하며, 한국어 번역 파일을 읽지 못해도 영어로 실행됩니다.

## 개발

이 프로젝트는 환경 및 빌드 관리에 [`uv`](https://docs.astral.sh/uv/)를 사용합니다.

```
uv sync                         # 의존성과 개발 도구를 .venv에 설치
uv run python app.py
uv run python tests.py          # 통합 테스트에는 사용 가능한 포트가 필요
uv run mypy uaclient uawidgets  # 타입 검사
```

`.ui` 또는 `.qrc` 원본을 수정한 뒤에는 `make`를 실행해 `uaclient/*_ui.py`, `uaclient/theme/breeze_resources.py`, `uawidgets/resources.py`를 다시 생성합니다. Windows에서 GNU Make 명령이 `gmake`로 설치된 경우 아래 명령의 `make`를 `gmake`로 바꿉니다.

- `make` — Qt 원본에서 UI·리소스 Python 및 번역 QM 파일을 다시 생성합니다.
- `make run` — GUI를 실행합니다.
- `make edit` — Qt Creator에서 메인 `.ui`를 엽니다.
- `make translations-update` — 원본 `.ui`와 Python에서 한국어 TS 원본을 갱신합니다.
- `make translations-release` — 완료된 TS를 애플리케이션이 읽는 QM 파일로 컴파일합니다.

번역문을 편집하려면 TS 갱신 후 Qt Linguist를 열고, 편집이 끝나면 QM을 컴파일합니다. Windows 개발 환경에서는 다음 명령을 실행합니다.

```
uv run gmake translations-update
uv run pyside6-linguist uaclient/translations/opcua-client_ko.ts
uv run gmake translations-release
```

릴리스 생성:

```
uv run python release.py    # pyproject.toml 버전 변경, 태그 생성, uv build 및 uv publish
```

현재 `asyncua` 2.x가 시험 출시 단계이므로 로컬 경로 소스(`[tool.uv.sources] asyncua = { path = "../opcua-asyncio", editable = true }`)를 사용합니다. `asyncua>=2.0`이 PyPI에 게시되면 이 소스 항목을 제거합니다.
