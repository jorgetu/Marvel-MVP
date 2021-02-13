//
//  ComicList.swift
//  Marvel-MVP
//
//  Created by Jorge Arias Brasa on 06/02/2021.
//

import Foundation

enum FormatComic: String {
    case comic = "Comic"
    case paperback = "Trade Paperback"
}

// MARK: - Model
struct ComicList {
    var list: [Comic] = []
    var totalItems: Int = 0
    var offset: Int = 0
}

struct Comic {
    let title: String?
    let issueNumber: Int?
    let description: String?
    let format: FormatComic?
    let pageCount: Int?
    let thumbnail: URL?
    let printPrice: Double?
    let digitalPrice: Double?
    let onSaleDate: String?
}

// MARK: - Service Model
struct ComicListServiceResponse: Codable {
    let code: Int?
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let offset, limit, total, count: Int?
    let results: [Element]?
}

// MARK: - Element
struct Element: Codable {
    let id, digitalID: Int?
    let title: String?
    let thumbnail: ThumbnailElement?
    let pageCount: Int?
    let dates: [DateElement]?
    let prices: [PriceElement]?
    let issueNumber: Int?
    let description: String?
    let format: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case digitalID
        case title
        case thumbnail
        case pageCount
        case dates
        case prices
        case issueNumber
        case description
        case format
    }
}

// MARK: - ThumbnailElement
struct ThumbnailElement: Codable {
    let path: String?
    let ext: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
    var fullName: String? {
        if let path = path, let ext = ext {
            return path + "." + ext
        } else {
            return nil
        }
    }
}

// MARK: - DateElement
struct DateElement: Codable {
    let type: String?
    let date: String?
}

// MARK: - Price
struct PriceElement: Codable {
    let type: String?
    let price: Double?
}

// MARK: - Binding class
internal final class ComicListBinding {

    static func bind(_ apiComicList: ComicListServiceResponse) -> ComicList {

        var list: [Comic] = []

        apiComicList.data?.results?.forEach { apiComic in

            let title = apiComic.title!
            let issueNumber = apiComic.issueNumber
            let description = apiComic.description
            var format: FormatComic?
            if let safeFormat = apiComic.format {
                format = FormatComic(rawValue: safeFormat)
            }
            let pageCount = apiComic.pageCount
            var url: URL?
            if let thumbnail = apiComic.thumbnail, let fullName = thumbnail.fullName {
                url = URL(string: fullName)
            }
            
            let printPrice = apiComic.prices?.filter({$0.type == "printPrice"}).first?.price
            let digitalPurchasePrice = apiComic.prices?.filter({$0.type == "digitalPurchasePrice"}).first?.price
            let onSaleDate = apiComic.dates?.filter({$0.type == "onsaleDate"}).first?.date
            
            let comic = Comic(title: title, issueNumber: issueNumber, description: description, format: format, pageCount: pageCount, thumbnail: url, printPrice: printPrice, digitalPrice: digitalPurchasePrice, onSaleDate: onSaleDate)
            list.append(comic)
        }
        
        let totalItems = apiComicList.data?.total ?? 0
        let offset = (apiComicList.data?.offset ?? 0) + (apiComicList.data?.count ?? 0)

        return ComicList(list: list, totalItems: totalItems, offset: offset)
    }
}
