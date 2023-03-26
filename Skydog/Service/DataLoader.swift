//
//  DataLoader.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import Foundation

/**
 A class used to load data from an API.
 
 To use, create an instance of `DataLoader`, and call one of its methods to fetch data from the API. All methods are asynchronous and should be called from an `async` context.
 
 - Important: The `baseURL` property must be set before any data can be fetched.
 
 - Note: This class is a singleton, accessible via the `shared` property.
 */
class DataLoader {
    /// The shared instance of `DataLoader`.
    public static var shared = DataLoader()
    
    /// The base URL for the API.
    private var baseURL = URL(string: "https://relistenapi.alecgorge.com/api/")
    
    /// The session used for network requests.
    private var session = URLSession.shared
    
    /// The decoder used for JSON decoding.
    private var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    /**
     Fetches a list of all artists from the API.
     
     - Returns: An array of `Artist` objects.
     - Throws: An error of type `DataLoaderError` if the URL is invalid or the data can't be decoded.
     */
    func fetchArtists() async throws -> [Artist] {
        guard let url = baseURL?.appendingPathComponent("v3/artists") else {
            throw DataLoaderError.invalidURL
        }
        let (data, _) = try await session.data(from: url)
        return try decoder.decode([Artist].self, from: data)
    }
    
    /**
     Fetches a list of all shows for a given artist from the API.
     
     - Parameter artistSlug: The slug of the artist to fetch shows for.
     - Returns: An array of `Show` objects.
     - Throws: An error of type `DataLoaderError` if the URL is invalid or the data can't be decoded.
     */
    func fetchShows(artistSlug: String) async throws -> [Show] {
        guard let url = baseURL?.appendingPathComponent("v2/artists/\(artistSlug)/shows/top") else {
            throw DataLoaderError.invalidURL
        }
        let (data, _) = try await session.data(from: url)
        return try decoder.decode([Show].self, from: data)
    }
    
    /**
     Fetches a list of all years for a given artist from the API.
     
     - Parameter artistSlug: The slug of the artist to fetch years for.
     - Returns: An array of `Year` objects.
     - Throws: An error of type `DataLoaderError` if the URL is invalid or the data can't be decoded.
     */
    func fetchYears(artistSlug: String) async throws -> [Year] {
        guard let url = baseURL?.appendingPathComponent("v2/artists/\(artistSlug)/years") else {
            throw DataLoaderError.invalidURL
        }
        let (data, _) = try await session.data(from: url)
        return try decoder.decode([Year].self, from: data)
    }
    
    /**
     Fetches a list of recent shows for a given artist from the API.
     
     - Parameter artistSlug: The slug of the artist to fetch recent shows for.
     - Returns: An array of `Show` objects.
     - Throws: An error of type `DataLoaderError` if the URL is invalid or the data can't be decoded.
     */
    func fetchRecentShows(artistSlug: String) async throws -> [Show] {
        guard let url = baseURL?.appendingPathComponent("v2/artists/\(artistSlug)/shows/recently-performed") else {
            throw DataLoaderError.invalidURL
        }
        let (data, _) = try await session.data(from: url)
        return try decoder.decode([Show].self, from: data)
    }
    
    /**
     Fetches a list of sources available for a given show.
     
     - Parameters:
        - showUUID: The UUID of the show for which sources are to be fetched.
     
     - Returns: An array of `Source` objects representing the sources available for the show.
     
     - Throws: `DataLoaderError.invalidURL` if the URL for the API call is invalid.
     */
    func fetchSources(showUUID: String) async throws -> [Source] {
        guard let url = baseURL?.appendingPathComponent("v3/shows/\(showUUID)") else {
            throw DataLoaderError.invalidURL
        }
        
        struct Sources: Decodable { // this struct is temporary
            let sources: [Source]
        }
        
        let (data, _) = try await session.data(from: url)
        return try decoder.decode(Sources.self, from: data).sources
    }

    /**
     Fetches a list of all shows for a given artist and year.
     
     - Parameters:
        - artistSlug: The slug of the artist for which shows are to be fetched.
        - year: The year for which shows are to be fetched.
     
     - Returns: An array of `Show` objects representing the shows for the artist and year.
     
     - Throws: `DataLoaderError.invalidURL` if the URL for the API call is invalid.
     */
    func fetchShows(artistSlug: String, year: String) async throws -> [Show] {
        guard let url = baseURL?.appendingPathComponent("v2/artists/\(artistSlug)/years/\(year)") else {
            throw DataLoaderError.invalidURL
        }
        
        struct Shows: Decodable { // this struct is temporary
            let shows: [Show]
        }
        
        let (data, _) = try await session.data(from: url)
        return try decoder.decode(Shows.self, from: data).shows
    }
}

enum DataLoaderError: Error {
    case invalidURL
}

extension DataLoaderError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .invalidURL:
            return "URL is invalid"
        }
    }
}
