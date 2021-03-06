//
//  CTError.swift
//  CodeaddictTask
//
//  Created by Mateusz Zacharski on 14/01/2021.
//

import Foundation

enum CTError: String, Error {
    case noSpacesAllowed = "Using spaces is not allowed in GitHub repository search!"
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case commitsEmpty = "The repo has no commits inside."
    case wrongCommitsUrl = "Unable to get the commits because of the wrong URL address. Please try again."
    case wrongRepoUrl = "Unable to get the repo info because of the wrong URL address. Please try again."
}
