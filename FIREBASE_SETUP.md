# Firebase 설정 가이드

## 1. Firebase 콘솔에서 프로젝트 생성

### 1.1 Firebase 콘솔 접속
1. [Firebase Console](https://console.firebase.google.com/)에 접속
2. Google 계정으로 로그인

### 1.2 새 프로젝트 생성
1. "프로젝트 추가" 클릭
2. 프로젝트 이름: `stepping-stone-game` (또는 원하는 이름)
3. Google Analytics 활성화 여부 선택 (권장: 활성화)
4. Analytics 계정 선택 (기본값 사용)
5. "프로젝트 만들기" 클릭

## 2. Authentication 설정

### 2.1 Authentication 서비스 활성화
1. Firebase 콘솔에서 프로젝트 선택
2. 왼쪽 메뉴에서 "Authentication" 클릭
3. "시작하기" 클릭

### 2.2 로그인 방법 설정
1. "Sign-in method" 탭 클릭
2. 다음 제공업체들을 활성화:

**이메일/비밀번호:**
- "이메일/비밀번호" 클릭
- "사용 설정" 토글 활성화
- "저장" 클릭

**Google 로그인:**
- "Google" 클릭
- "사용 설정" 토글 활성화
- 프로젝트 지원 이메일 설정
- "저장" 클릭

**익명 로그인:**
- "익명" 클릭
- "사용 설정" 토글 활성화
- "저장" 클릭

## 3. Firestore Database 설정

### 3.1 Firestore 활성화
1. 왼쪽 메뉴에서 "Firestore Database" 클릭
2. "데이터베이스 만들기" 클릭
3. 보안 규칙: "테스트 모드에서 시작" 선택 (개발용)
4. 위치: `asia-northeast3 (Seoul)` 선택 (한국 서버)
5. "완료" 클릭

### 3.2 보안 규칙 설정 (개발용)
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // 사용자 문서: 인증된 사용자만 자신의 데이터 읽기/쓰기 가능
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // 게임 점수: 모든 사용자가 읽기 가능, 본인만 쓰기 가능
    match /scores/{scoreId} {
      allow read: if true;
      allow write: if request.auth != null && request.auth.uid == resource.data.userId;
    }
    
    // 랭킹: 모든 사용자가 읽기 가능
    match /rankings/{rankingId} {
      allow read: if true;
      allow write: if request.auth != null;
    }
  }
}
```

## 4. Flutter 앱 등록

### 4.1 Android 앱 추가
1. 프로젝트 설정 (⚙️ 아이콘) 클릭
2. "앱 추가" → Android 아이콘 선택
3. Android 패키지 이름: `com.example.webview_game`
4. 앱 닉네임: `Stepping Stone Game`
5. SHA-1 서명 인증서(선택사항): 나중에 추가 가능
6. "앱 등록" 클릭

### 4.2 iOS 앱 추가 (Mac에서만)
1. "앱 추가" → iOS 아이콘 선택
2. iOS 번들 ID: `com.example.webviewGame`
3. 앱 닉네임: `Stepping Stone Game`
4. "앱 등록" 클릭

## 5. 다음 단계

Firebase 프로젝트 생성이 완료되면:

1. Firebase CLI로 로그인:
   ```bash
   firebase login
   ```

2. Flutter 프로젝트에서 Firebase 설정:
   ```bash
   cd webview_game
   flutterfire configure
   ```

3. 생성된 설정 파일들을 Git에 커밋

## 📝 주의사항

1. **보안 규칙**: 운영 환경에서는 더 엄격한 보안 규칙 적용 필요
2. **API 키**: `firebase_options.dart` 파일의 API 키는 공개되어도 안전함
3. **Google 로그인**: SHA-1 인증서는 릴리즈 빌드 시 필요
4. **비용**: Firebase 무료 플랜 한도 확인 필요

## 🔧 설정 완료 후 확인사항

- [ ] Firebase 프로젝트 생성 완료
- [ ] Authentication 서비스 활성화
- [ ] 이메일/비밀번호 로그인 활성화
- [ ] Google 로그인 활성화
- [ ] 익명 로그인 활성화
- [ ] Firestore Database 생성 완료
- [ ] Android 앱 등록 완료
- [ ] iOS 앱 등록 완료 (Mac인 경우)
- [ ] Firebase CLI 로그인 완료
- [ ] FlutterFire 설정 완료