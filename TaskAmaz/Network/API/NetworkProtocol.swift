
//
//  NetworkProtocols.swift
//  TaskAmaz
//
//  Created by Mohamed Shemy on Tue 11 Aug 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import Foundation

protocol Networkable
{
    func getPopularPersons(in page: Int, completion: @escaping (Result<PageResponse<[Person]>, Error>) -> Void)
    func searchForPerson(with name: String, in page: Int, completion: @escaping (Result<PageResponse<[Person]>, Error>) -> Void)
    func getPersonImages(with id: Int, completion: @escaping (Result<ProfileResponse, Error>) -> Void)
}

protocol NetworkManagerInjected { }
