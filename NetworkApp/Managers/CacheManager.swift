//
//  CacheManager.swift
//  NetworkApp
//
//  Created by Martynov Evgeny on 21.04.22.
//

import AlamofireImage

// не поддается наследованию и все его методы косвенным образом приобретают свойство final
final class CacheManager {
    // MARK: Lifecycle

    private init() {}

    // MARK: Internal

    static let shared = CacheManager()

    let imageCache = AutoPurgingImageCache(
        memoryCapacity: 100_000_000,
        preferredMemoryUsageAfterPurge: 60_000_000
    )
}
