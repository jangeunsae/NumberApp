# 📱 NumberListApp02 - ViewController.swift

이 문서는 `NumberListApp02` 프로젝트의 핵심 파일인 `ViewController.swift`의 구조와 역할을 설명합니다.

---

## 🧩 개요

`ViewController.swift`는 Core Data를 활용해 이름, 전화번호, 이미지 URL로 구성된 연락처 목록을 표시하는 메인 화면입니다. UITableView를 사용하여 연락처 정보를 표시하며, 사용자는 새로운 연락처를 추가하거나 기존 데이터를 삭제할 수 있습니다.

---

## 🛠 주요 기능

| 기능 | 설명 |
|------|------|
| 연락처 목록 표시 | Core Data에서 데이터를 불러와 UITableView에 표시 |
| 연락처 추가 | "+" 버튼을 눌러 `AddContactViewController`로 이동 |
| 데이터 삭제 | 앱 실행 시 전체 데이터 초기화 (`deleteAllData()`) |
| 데이터 CRUD | Core Data를 통한 생성/조회/수정/삭제 수행 |

---

## 📂 주요 구성 요소

### 🔹 UI 요소
- `tableView`: 연락처 리스트 표시
- `button`: 연락처 추가 버튼 (`추가` NavigationItem 사용)

### 🔹 Core Data
- `PhoneBook`: Core Data 엔티티
- `persistenContainer`: AppDelegate에서 가져온 `NSPersistentContainer`

---

## 🔧 주요 메서드

### 1. `viewDidLoad()`
- 테이블뷰 셋업
- 버튼 액션 설정
- 타이틀 설정
- 앱 실행 시 기존 데이터 모두 삭제
- 데이터 로드

### 2. `createData()`
- 새로운 PhoneBook 인스턴스 생성
- 저장 (`context.save()`)

### 3. `getData()`
- Core Data에서 모든 PhoneBook 데이터 fetch
- `dataSource` 배열에 저장

### 4. `updateData()`
- 이름이 "sae2"인 데이터를 찾아 "장은새"로 변경

### 5. `deleteData()`
- 이름이 "장은새"인 데이터를 삭제

### 6. `deleteAllData()`
- 앱 실행 시 기존 저장된 모든 PhoneBook 데이터를 삭제

---

## 🧑‍💻 UITableView Delegate & DataSource

- `numberOfRowsInSection`: dataSource 배열 개수 반환
- `cellForRowAt`: 셀 설정 (`TableViewCell.configure()` 호출)
- `didSelectRowAt`: 셀 선택 시 print 로그 출력

---

## 🖼 UI 레이아웃

```swift
NSLayoutConstraint.activate([
    tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
    tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
    tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
    tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20)
])
