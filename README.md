# freight-ui

개발환경 세팅
- 패키지 인스톨
```
$ flutter pub get
```

버전 낮아서 문제일 경우
- Because freight_ui requires SDK version >=3.1.0 <4.0.0, version solving failed.
```
$ flutter upgrade
```

key-store config
```
// https://github.com/mogol/flutter_secure_storage/issues/350 (키체인 공유)
// url : https://pub.dev/packages/flutter_secure_storage
// mac os
// macos/Runner/DebugProfile.entitlements
// macos/Runner/Release.entitlements
<key>keychain-access-groups</key>
```

http request
```
// https://stackoverflow.com/questions/65458903/socketexception-connection-failed-os-error-operation-not-permitted-errno-1
// macos
	<key>com.apple.security.network.client</key>
    <true/>
```
 
## Todo
### Process
1. 운행일지 신규 등록 시 요율 자동 계산.

### CodeLevel
1. Authorization 방식 통일.
2. Jwt 값 저장 위치.
3. 메인화면 연도별 선택 지정.
