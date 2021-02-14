# Unsplashrimp

## Introduce

이미지를 탐색하고 저장하는 앱 Unsplash를 Unsplash API를 사용하여 클론한 앱입니다.

### Scenes

![https://raw.githubusercontent.com/statios/diagrams/9a9e85e9fe2c92af059070f839831821642baa84/unsplashrimp_scenes_wireframe.svg](https://raw.githubusercontent.com/statios/diagrams/9a9e85e9fe2c92af059070f839831821642baa84/unsplashrimp_scenes_wireframe.svg)

### Splash

Explore에서 사용할 Topics API를 호출하여 각 topic의 Photos API를 호출하여 각각 저장합니다.

네트워크가 완료되면 Main scene으로 present합니다. 

이 때 Explore 인스턴스를 생성하여 topics, photos 데이터를 전달합니다.

### Explore

![Unsplashrimp%2092b8339979f04798b963235b158dc37f/2021-02-14_21-24-36.2021-02-14_21_27_32.gif](Unsplashrimp%2092b8339979f04798b963235b158dc37f/2021-02-14_21-24-36.2021-02-14_21_27_32.gif)

Splash에서 전달받은 topics와 photos를 테이블 뷰로 display 합니다.

테이블 뷰 스크롤이 마지막 인덱스에 도달하면 다음 페이지에 해당하는 Photos API를 호출하여,

추가되는 사진을 화면에 업데이트합니다.

### Search

![Unsplashrimp%2092b8339979f04798b963235b158dc37f/2021-02-14_21-28-42.2021-02-14_21_30_46.gif](Unsplashrimp%2092b8339979f04798b963235b158dc37f/2021-02-14_21-28-42.2021-02-14_21_30_46.gif)

사용자로부터 입력받는 검색 키워드에 따라 Search API를 호출하여,

전달받는 Photos를 테이블 뷰로 바인드하여 업데이트합니다.

displayed cell indexPath 위치에 따라 pagination을 구현하여 화면을 업데이트합니다.

### Detail

![Unsplashrimp%2092b8339979f04798b963235b158dc37f/2021-02-14_21-32-54.2021-02-14_21_34_24.gif](Unsplashrimp%2092b8339979f04798b963235b158dc37f/2021-02-14_21-32-54.2021-02-14_21_34_24.gif)

explore, search에서 display된 photo를 선택하여 진입합니다.

해당 photo의 상세보기를 제공합니다.

## Environment

Xcode — 12.3

iOS target — 12.0 +

Swift

## Architecture

프로젝트 아키텍처는 Clean Swift를 채택하여 구현하였습니다.

라이브러리 사용이 제한되었기 때문에 Reactive Programming이 필수적으로 요구되지 않으며,

각 레이어가 protocol로 정의되어 역할이 명확하게 구분된다는 점에서 Clean Swift를 선택하게 되었습니다.

레이어 간 참조는 콘크리트 타입이 아닌 프로토콜 타입으로 작성하여

유닛 테스트 빌드에서는 Test Double을 주입할 수 있도록하였습니다.

![https://raw.githubusercontent.com/statios/diagrams/9a9e85e9fe2c92af059070f839831821642baa84/karrot_clone_architecture.svg](https://raw.githubusercontent.com/statios/diagrams/9a9e85e9fe2c92af059070f839831821642baa84/karrot_clone_architecture.svg)

### Models

View - Interactor - Presenter간 데이터 전달에 필요한 데이터 타입을 정의합니다.

사이클 구간 별로 각각 Request, Response 그리고 ViewModel 타입을 정의하게 됩니다.

```dart
enum ExploreModels {
  enum Topics {
    struct Request { 
			//...
		}
    struct Response {
			//...
    }
    struct ViewModel { 
			//...
    }
  }
}
```

### ViewController

이니셜라이저에서 Scene 사이클을 구성하는 인스턴스를 세팅하여 각 계층에 주입합니다.

```dart
extension ExploreViewController {
	//Call in init
  override func build() {
    // 1. initiate
		// 2. dependency injection to each layer
  }
}
```

유저 인터렉션이나 뷰컨트롤러 상태 변화에 따라 interactor로 Request를 생성하여 전달합니다.

```dart
override func viewDidLoad() {
  super.viewDidLoad()
  interactor?.fetchTopics(request: .init())
}
```

presenter로부터 전달받은 viewModel을 바인딩하여 UI를 업데이트합니다.

```dart
extension ExploreViewController: ExploreDisplayLogic {
  func displayTopics(viewModel: ExploreModels.Topics.ViewModel) {
		// UI binding
  }
}
```

### Interactor

Interactor는 Worker를 경유하여 영구데이터(내부 또는 외부)를 fetch하고 Response 객체를 생성합니다.

아래의 ExploreInteractor 코드는 Splash로부터 topics를 prefetch 하여 전달받았기 때문에,

따로 네트워킹하지 않고 presenter로 넘겨줍니다.

```dart
protocol ExploreBusinessLogic: class {
  func fetchTopics(request: ExploreModels.Topics.Request)
	//...
}

func fetchTopics(request: ExploreModels.Topics.Request) {
	//...
  presenter?.presentTopics(response: .init(topics: topics))
}
```

DataStore 프로토콜을 채택하여 필요한 데이터를 멤버변수로 저장합니다.

해당 데이터는 Interactor 내의 상태값을 저장하기도 하고, 

Routing하는 scene으로 전달할 데이터를 저장하기도 합니다.

```dart
protocol ExploreDataStore: DetailRoutableDataStore {
  var topics: [Topic] { get set }
	//...
}

final class ExploreInteractor: BaseInteractor, ExploreDataStore {
  //...
  var topics: [Topic] = []
  //...
}
```

### Presenter

Interactor로부터 전달받은 Response를 가공하여

ViewController에서 UI 바인딩할 수 있는 형태로 정의된 ViewModel을 생성하여 전달합니다.

```dart
protocol ExplorePresentationLogic: class {
  func presentTopics(response: ExploreModels.Topics.Response)
}

extension ExplorePresenter: ExplorePresentationLogic {
  func presentTopics(response: ExploreModels.Topics.Response) {
    view?.displayTopics(viewModel: .init(topics: response.topics))
  }
}
```

## Networking

Worker 레이어에서 네트워킹 모듈을 작성하였습니다.

네트워킹을 요청하는 request 메서드를 포함합니다.

```dart
protocol NetworkWorkerLogic {
  func request<T: Codable>(
    _ target: TargetType,
    type: T.Type,
    completion: @escaping (Result<T, NetworkError>) -> Void
  )
}
```

### TargetType

NetworkWorker의 네트워킹 request 메서드에서 제네릭타입으로 받게되며,

API 제공자에 따라 TargetType을 구현하여 EndPoint를 정의합니다.

```dart
protocol TargetType {
  var scheme: String { get }
  var host: String { get }
  var path: String { get }
  var queryItems: [URLQueryItem] { get }
  var header: [String: String] { get }
}

enum UnsplashAPI: TargetType {
	//...
}
```
