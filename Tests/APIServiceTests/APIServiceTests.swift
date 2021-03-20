import XCTest
@testable import APIService
@testable import NetworkService

final fileprivate class NetworkServiceMock: NetworkProvider {
    
    public var nextObject: Decodable? = nil
    
    var successfulStatusCodes: Range<Int> = 100..<300
    
    var defaultHeaders: [String : String] = [:]
    
    func setSuccessfulStatusCodes(_ range: Range<Int>) {
        successfulStatusCodes = range
    }
    
    func performRequest<T>(for resource: Resource, decodingTo type: T.Type, completion: @escaping (Result<T, NetworkError>) -> ()) where T : Decodable {
        
        guard let nextObject = nextObject as? T else {
            completion(.failure(.badData))
            return
        }
        
        completion(.success(nextObject))
    }
    
    func performRequest(for resource: Resource, completion: @escaping (Result<Data, NetworkError>) -> ()) {

        completion(.success("data".data(using: .utf8)!))
    }
    
    
}

final fileprivate class APIServiceMock: APIProvider {

    var config: APIConfig = APIConfig(scheme: "https",
                                      host: "mock.com",
                                      mainPath: "/main",
                                      gamePath: "/game")

    var networkService: NetworkProvider = NetworkServiceMock()
    
    init(nextObject: Decodable? = nil) {
        
        guard let service = networkService as? NetworkServiceMock else {
            fatalError()
        }
        
        service.nextObject = nextObject
    }
    
}

final fileprivate class APIServiceMockError: APIProvider {

    var config: APIConfig = APIConfig(scheme: "error",
                                      host: "error",
                                      mainPath: "error",
                                      gamePath: "error")

    var networkService: NetworkProvider = NetworkServiceMock()
    
}

extension MainResponse: Equatable {
    
    public static func == (lhs: MainResponse, rhs: MainResponse) -> Bool {
        lhs.games.first?.id == rhs.games.first?.id
    }
    
}

extension GameConfig: Equatable {

    public static func == (lhs: GameConfig, rhs: GameConfig) -> Bool {
        lhs.url == rhs.url
    }

}

final class APIServiceTests: XCTestCase {
    
    let mainURL = URL(string: "https://mock.com/main")!
    let gameURL = URL(string: "https://mock.com/game/gameID")!
    
    let apiMock: APIProvider = APIServiceMock()
    let errorApiMock: APIProvider = APIServiceMockError()
    
    func testMakeResource() {
        
        guard let mainResource = try? apiMock.makeMainResource(),
              let gameResource = try? apiMock.makeGameResource(for: "gameID") else {
            XCTFail()
            return
        }
        
        do {
            let _ = try errorApiMock.makeMainResource()
            
            XCTFail()
        } catch {
            return
        }
        
        do {
            let _ = try errorApiMock.makeGameResource(for: "")
            
            XCTFail()
        } catch {
            return
        }
        
        let mockMainResource = Resource(method: .get, url: mainURL)
        let mockGameResource = Resource(method: .get, url: gameURL)
        
        XCTAssertEqual(mockMainResource.method, mainResource.method)
        XCTAssertEqual(mockMainResource.url, mainResource.url)
        XCTAssertEqual(mockMainResource.body, mainResource.body)
        XCTAssertEqual(mockMainResource.headers, mainResource.headers)
        
        XCTAssertEqual(mockGameResource.method, gameResource.method)
        XCTAssertEqual(mockGameResource.url, gameResource.url)
        XCTAssertEqual(mockGameResource.body, gameResource.body)
        XCTAssertEqual(mockGameResource.headers, gameResource.headers)
    }
    
    func testFetch() {
        
        let mainMock = MainResponse(providers: [.init(id: "id", name: "name")],
                                    categories: [.init(id: "id", name: "name")],
                                    tags: [.init(id: "id", name: "name")],
                                    games: [.init(id: "id",
                                                  provider: "id",
                                                  category: ["id"],
                                                  name: "name",
                                                  tags: ["id"])])
        
        let gameConfigMock = GameConfig(url: "url",
                                        image: "image",
                                        game: .init(id: "id",
                                                    provider: "id",
                                                    category: ["id"],
                                                    name: "name",
                                                    tags: ["id"]))
        
        let apiMock = APIServiceMock(nextObject: mainMock)
        
        apiMock.fetchMain { result in
            switch result {
            case .success(let main):
                XCTAssertEqual(mainMock, main)
            case .failure(_):
                XCTFail()
            }
        }
        
        let nextApiMock = APIServiceMock(nextObject: gameConfigMock)
        
        nextApiMock.fetchGame(with: "id") { result in
            switch result {
            case .success(let gameConfig):
                XCTAssertEqual(gameConfigMock, gameConfig)
            case .failure(_):
                XCTFail()
            }
        }
    }

    static var allTests = [
        ("testMakeResource", testMakeResource),
    ]
}
