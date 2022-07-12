//
//  DataLoader.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import Foundation

class DataLoader {
    public static var shared = DataLoader()
    
    private var baseURL = URL(string: "https://relistenapi.alecgorge.com/api/")
    private var session = URLSession.shared
    private var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return decoder
    }()
    
    func fetchArtists() async throws -> [Artist] {
        guard let url = baseURL?.appendingPathComponent("v3/artists") else {
            throw DataLoaderError.invalidURL
        }
        let (data, _) = try await session.data(from: url)
        return try decoder.decode([Artist].self, from: data)
    }
    
    func fetchShows(artistSlug: String) async throws -> [Show] {
        guard let url = baseURL?.appendingPathComponent("v2/artists/\(artistSlug)/shows/top") else {
            throw DataLoaderError.invalidURL
        }
        let (data, _) = try await session.data(from: url)
        return try decoder.decode([Show].self, from: data)
    }
    
    func fetchYears(artistSlug: String) async throws -> [Year] {
        guard let url = baseURL?.appendingPathComponent("v2/artists/\(artistSlug)/years") else {
            throw DataLoaderError.invalidURL
        }
        let (data, _) = try await session.data(from: url)
        return try decoder.decode([Year].self, from: data)
    }
    
    func fetchRecentShows(artistSlug: String) async throws -> [Show] {
        guard let url = baseURL?.appendingPathComponent("v2/artists/\(artistSlug)/shows/recently-performed") else {
            throw DataLoaderError.invalidURL
        }
        let (data, _) = try await session.data(from: url)
        return try decoder.decode([Show].self, from: data)
    }
    
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
