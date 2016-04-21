//
//  DataModule.swift
//  base-app-ios
//
//  Created by Roberto Frontado on 2/11/16.
//  Copyright © 2016 Roberto Frontado. All rights reserved.
//

import Swinject
import RxCache

class DataModule {
    
    static func setup(defaultContainer: Container) {
        
        defaultContainer.register(RxCache.self) { _ in RxCache.Providers }
        
        defaultContainer.register(RestApi.self) { _ in RestApiMoya() }
            .inObjectScope(.Container)
        
        // Repositories
        
        defaultContainer.register(WireframeRepository.self) { r in
            WireframeRepository(restApi: r.resolve(RestApi.self)!, rxProviders: r.resolve(RxCache.self)!) }
            .inObjectScope(.Container)
        
        defaultContainer.register(NotificationRepository.self) { r in
            NotificationRepository(restApi: r.resolve(RestApi.self)!, rxProviders: r.resolve(RxCache.self)!) }
            .inObjectScope(.Container)
        
        defaultContainer.register(UserRepository.self) { r in
            UserRepository(restApi: r.resolve(RestApi.self)!, rxProviders: r.resolve(RxCache.self)!) }
            .inObjectScope(.Container)
    }
}