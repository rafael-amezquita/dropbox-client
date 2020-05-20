//
//  DataModel.swift
//  DropboxClientApp
//
//  Created by Rafael Amezquita on 19/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import Foundation

/*
 {
     ".tag" = folder;
     id = "id:sLaesr-SzWAAAAAAAAAAEg";
     name = "folder-a";
     "path_display" = "/folder-a";
     "path_lower" = "/folder-a";
 }
 */
// id and tag are not accesible
struct Document: Codable {
    var name: String
    var path: String
}
