//
//  NetworkService.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 29/03/22.
//

import Foundation

class NetworkService {
    private let baseEndpointUrl = URL(string: AppConstants.baseURL)
    private let session = URLSession(configuration: .default)
    private var task = URLSessionTask()
    
    private let apiKey: String
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    private func endpoint<T: APIRequest>(for request: T) -> URL {
        guard let baseUrl = URL(string: request.resourceName, relativeTo: baseEndpointUrl) else {
            fatalError("Recurso inválido: \(request.resourceName)")
        }

        var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)!

        let commonQueryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "language", value: "pt-BR")
        ]

        let customQueryItems: [URLQueryItem]

        do {
            customQueryItems = try URLQueryItemEncoder.encode(request)
        } catch {
            fatalError("Parametros incorretos: \(error)")
        }

        components.queryItems = commonQueryItems + customQueryItems
        return components.url!
    }
    
    private func handleUnSuccessfullStatusCode(_ statusCode: Int) -> NetworkServiceError{
        switch statusCode {
        case 401...500: return .authenticationError
        case 501...599: return .badRequest
        default: return .serverError(message: "Server Error \(statusCode)")
        }
    }
    
    public func send<T: APIRequest>(_ request: T, completion: @escaping(Result<T.Response, Error>) -> Void) {
        let endpoint = self.endpoint(for: request)
        
        task = session.dataTask(with: URLRequest(url: endpoint)) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            if (200...299).contains(response.statusCode) {
                guard let _data = data else {
                    completion(.failure(NetworkServiceError.serverError(message: "Sem dados!!!")))
                    return
                }
                
                do {
                    let object = try JSONDecoder().decode(T.Response.self, from: _data)
                    completion(.success(object))
                } catch {
                    print(error)
                    completion(.failure(NetworkServiceError.parsingError))
                }
            } else {
                completion(.failure(self.handleUnSuccessfullStatusCode(response.statusCode)))
            }
        }
        
        task.resume()
    }
    
    func cancel() {
        self.task.cancel()
    }
}

enum NetworkServiceError: LocalizedError {
    
    case parsingError
    case serverError(message: String)
    case parametersNil
    case encodingFailed
    case missingURL
    case authenticationError
    case badRequest
    
    var errorDescription: String? {
        switch self {
        case .parsingError: return "JSON Parsing Failure"
        case .serverError(let message): return "\(message)"
        case .parametersNil: return "Parameters were nil."
        case .encodingFailed: return "Parameter encoding failed."
        case .missingURL: return "URL is nil."
        case .authenticationError: return "Auth Error"
        case .badRequest: return "Bad Request"
        }
    }
    
}
