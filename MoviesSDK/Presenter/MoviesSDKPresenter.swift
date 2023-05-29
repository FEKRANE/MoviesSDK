//
//  MoviesSDKPresenter.swift
//  MoviesSDK
//
//  Created by FEKRANE on 21/5/2023.
//
class MoviesSDKPresenter{
    
    private var interactor: InteractorProtocol
    private var configuration: ApiConfiguration?
    
    init(interactor: InteractorProtocol = MoviesSDKInteractor(), configuration: ApiConfiguration?) {
        self.interactor = interactor
        self.configuration = configuration
    }
    
    func updateConfiguration(configuration: ApiConfiguration){
        self.configuration = configuration
    }
    
    func retrieveUpcomingReleases(of type: MediaType, page: Int, limit: Int, completion: @escaping (UpcomingReleases?, MoviesSDKError?)->Void){
        
        guard let configuration = configuration else {
            completion(nil, .noSetup)
            return
        }
        
        let limit = limit > 8 ? 8 : limit
        let params = UpcomingReleasesRQ(titleType: type.rawValue, page: String(page), limit: limit)
        let headers = HttpHeaders(appID: configuration.appid)
        
        
        self.interactor.executeRequest(fromURL: Constants.API.upcomingReleases, httpMethod: .get, queryParams: params.dictionary, bodyRequest: nil, headers: headers.dictionary,encoding: .JSONEncoding){(result: Result<UpcomingReleasesRS, Error>) in
            
            guard let response = try? result.get() else {
                completion(nil, .serverCommunication)
                return
            }
            
            do {
                let movies = try self.constructUpcomingReleasesFromWSResponse(response)
                completion(movies, nil)
            } catch let error as MoviesSDKError{
                completion(nil,error)
            } catch{
                completion(nil,.unexpected(code: 0))
            }
            
        }
    }
    
}

//MARK: Helpers
extension MoviesSDKPresenter {
    func constructUpcomingReleasesFromWSResponse(_ response: UpcomingReleasesRS) throws -> UpcomingReleases{
        let movieInfo = try response.movies.reduce(into: [MovieInfo]()) { result, item in
            guard let title = item.title?.name,
                  let imageUrl = item.image?.url,
                  let releaseDate = item.releaseDate?.date
            else {throw MoviesSDKError.missingData}
            
            result.append(MovieInfo(title: title, imageUrl: imageUrl, releaseDate: releaseDate))
        }
        
        return UpcomingReleases(count: response.resultsTotal, movies: movieInfo)
    }
}

