#!/bin/bash

# Firebase 설정 자동화 스크립트
# 사용법: ./setup_firebase.sh

echo "🔥 Firebase 설정을 시작합니다..."

# 1. 현재 위치 확인
if [[ ! -f "pubspec.yaml" ]]; then
    echo "❌ Flutter 프로젝트 루트에서 실행해주세요."
    exit 1
fi

# 2. Firebase CLI 로그인 상태 확인
echo "📋 Firebase 로그인 상태 확인 중..."
if ! firebase projects:list > /dev/null 2>&1; then
    echo "🔑 Firebase에 로그인이 필요합니다."
    echo "다음 명령어를 실행하여 로그인해주세요:"
    echo "firebase login"
    exit 1
fi

echo "✅ Firebase 로그인 확인됨"

# 3. Flutter Firebase 설정
echo "⚡ FlutterFire 설정 시작..."
echo "프로젝트 선택 시 'stepping-stone-game' 또는 생성한 프로젝트를 선택하세요."

flutterfire configure \
    --project=stepping-stone-game \
    --android-package-name=com.example.webview_game \
    --ios-bundle-id=com.example.webviewGame \
    --macos-bundle-id=com.example.webviewGame

# 4. 설정 결과 확인
if [[ -f "lib/firebase_options.dart" ]]; then
    echo "✅ firebase_options.dart 파일이 생성되었습니다."
else
    echo "❌ firebase_options.dart 파일 생성에 실패했습니다."
    echo "수동으로 'flutterfire configure' 명령을 실행해주세요."
    exit 1
fi

# 5. main.dart 파일 업데이트
echo "📝 main.dart 파일을 업데이트합니다..."

# Firebase 초기화 코드 주석 해제
sed -i.bak 's|// await Firebase.initializeApp(|await Firebase.initializeApp(|g' lib/main.dart
sed -i.bak 's|//   options: DefaultFirebaseOptions.currentPlatform,|  options: DefaultFirebaseOptions.currentPlatform,|g' lib/main.dart
sed -i.bak 's|// );|);|g' lib/main.dart

# firebase_options import 추가
if ! grep -q "import 'firebase_options.dart';" lib/main.dart; then
    sed -i.bak '3a\
import '\''firebase_options.dart'\'';' lib/main.dart
fi

# 백업 파일 제거
rm -f lib/main.dart.bak

echo "✅ main.dart 파일이 업데이트되었습니다."

# 6. 빌드 테스트
echo "🔨 Flutter 프로젝트 빌드 테스트..."
if flutter pub get && dart run build_runner build --delete-conflicting-outputs; then
    echo "✅ 빌드 성공!"
else
    echo "❌ 빌드 실패. 설정을 확인해주세요."
    exit 1
fi

# 7. 완료 메시지
echo ""
echo "🎉 Firebase 설정이 완료되었습니다!"
echo ""
echo "📋 다음 단계:"
echo "1. Firebase 콘솔에서 Authentication 서비스 활성화"
echo "2. Firestore Database 생성"
echo "3. 보안 규칙 설정"
echo "4. 'flutter run'으로 앱 실행 및 테스트"
echo ""
echo "📖 자세한 설정 가이드: FIREBASE_SETUP.md 참조"