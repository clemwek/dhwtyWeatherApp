//
//  extension+URLSession.swift
//  WeatherApp
//
//  Created by DHwty on 08/07/2021.
//

import Foundation

extension URLSession {
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult
    func request(
        _ endpoint: Endpoint,
        then handler: @escaping Handler
    ) -> URLSessionDataTask {
        let task = dataTask(
            with: endpoint.url,
            completionHandler: handler
        )
        task.resume()
        return task
    }
}
