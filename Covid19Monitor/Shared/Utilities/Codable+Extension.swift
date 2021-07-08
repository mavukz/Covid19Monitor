//
//  Encodable+Extension.swift
//  Covid19Monitor
//
//  Created by Luntu  Mavukuza on 2021/07/07.
//  Copyright © 2021 Luntu. All rights reserved.
//

import Foundation

extension Decodable {

    static func decode<T: Decodable>(data: Data) -> T? {
        do {
            let model = try JSONDecoder().decode(T.self, from: data)
            return model
        } catch {
            debugPrint("Error in decoding model: \(error)")
        }
        return nil
    }
}

extension Encodable {

}
