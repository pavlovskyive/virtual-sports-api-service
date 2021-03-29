import XCTest
@testable import APILayer
@testable import NetworkService

final class APIServiceTests: XCTestCase {
    
    let config = APIConfig(scheme: "https",
                           host: "virtual-sports-yi3j9.ondigitalocean.app",
                           mainPath: "/Games",
                           favouritesPath: "/User/favourites",
                           favouriteGamePath: "/User/favourite",
                           recentPath: "/User/recent",
                           playGamePath: "/Games/play",
                           gameHistoryPath: "/User/history",
                           recommendedPath: "/User/recommended")

    
    lazy var apiServiceMock = APIService(networkProvider: NetworkService(),
                                     config: config)
    
    func testCreateResourse() {
        let apiService = APIService(networkProvider: NetworkService(), config: config)
        
        guard let _ = apiService.makeGamesResource(path: "/path"),
              let _ = apiService.makeMockedPlayGameResource(gameId: "123"),
              let _ = apiService.makeGamesResource(path: "/path"),
              let _ = apiService.makeDiceHistoryResource(),
              let _ = apiService.makeFavouriteChangeResource(gameId: "123", with: .post),
              let _ = apiService.makePlayGameResource(gameId: "123", bet: Bet(dateTime: "string", betType: 0)),
              let _ = apiService.makeGameHistoryResource(gameId: "123") else {
            XCTFail()
            return
        }
              
    }
    
    func testFetch() {
        
        let networkService = NetworkService(defaultHeaders: ["X-Platform": "ios"])
        let apiService = APIService(networkProvider: networkService, config: config)
        
        apiService.fetchMain() { result in
            switch result {
            case .success(_):
                break
            case .failure(_):
                XCTFail()
            }
        }

    }

    static var allTests = [
        ("testFetch", testFetch),
    ]
}
