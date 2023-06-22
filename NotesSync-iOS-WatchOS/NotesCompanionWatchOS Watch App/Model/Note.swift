//
//  Note.swift
//  Notes Watch OS Watch App
//
//  Created by Narayan Shettigar on 17/06/23.
//

import Foundation

struct Note : Identifiable, Codable, Equatable {
    let id : UUID
    let text : String
}
