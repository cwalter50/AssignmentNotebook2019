//
//  Assignment.swift
//  AssignmentNotebook
//
//  Created by  on 11/19/19.
//  Copyright © 2019 DocsApps. All rights reserved.
//

import UIKit

class Assignment: Codable
{
    var name: String
    var dueDate: String
    
    init()
    {
        name = "ToDo"
        dueDate = "Tomorrow"
    }
    
    init(theName: String, theDueDate: String)
    {
        name = theName
        dueDate = theDueDate
    }
}
