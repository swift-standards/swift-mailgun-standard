//
//  File.swift
//  swift-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 20/12/2024.
//

import Mailgun_Types_Shared

extension URL {
    public static let mailgun_eu_baseUrl: Self = URL(string: "https://api.eu.mailgun.net")!
    public static let mailgun_usa_baseUrl: Self = URL(string: "https://api.mailgun.net")!
}

extension Mailgun {
    public static let eu_baseUrl: URL = .mailgun_eu_baseUrl
    public static let usa_baseUrl: URL = .mailgun_usa_baseUrl
}
