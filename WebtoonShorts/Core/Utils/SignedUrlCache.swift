//
//  SignedUrlCache.swift
//  WebtoonShorts
//
//  Created by byunghak on 2021/09/16.
//

import Foundation

public protocol SignedUrlCacheType {
    
    func url(for relativePath: String) -> URL?
    
    func insertRelativePath(_ url: URL?, for relativePath: String)
    
    func removeUrl(for relativePath: String)
    
    func removeAllUrls()
    
    subscript(_ relativePath: String) -> URL? { get set }
}

public final class SignedUrlCache: SignedUrlCacheType {
    
    public static let shared = SignedUrlCache()

    private lazy var urlCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = config.countLimit
        return cache
    }()
    
    private let lock = NSLock()
    private let config: Config
    
    public struct Config {
        let countLimit: Int
        let memoryLimit: Int

        public static let defaultConfig = Config(countLimit: 100, memoryLimit: 1024 * 100) // 100 KB
    }
    
    // MARK: Lifecycles
    public init(config: Config = Config.defaultConfig) {
        self.config = config
    }
    
    
    // MARK: Methods
    public func url(for relativePath: String) -> URL? {
        lock.lock(); defer { lock.unlock() }
        
        if let url = urlCache.object(forKey: relativePath as AnyObject) as? URL {
            return url
        }
        return nil
    }
    
    public func insertRelativePath(_ url: URL?, for relativePath: String) {
        lock.lock(); defer { lock.unlock() }
        guard let url = url else { return removeUrl(for: relativePath) }
        urlCache.setObject(url as AnyObject, forKey: relativePath as AnyObject, cost: 1)
    }
    
    public func removeUrl(for relativePath: String) {
        lock.lock(); defer { lock.unlock() }
        urlCache.removeObject(forKey: relativePath as AnyObject)
    }
    
    public func removeAllUrls() {
        lock.lock(); defer { lock.unlock() }
        urlCache.removeAllObjects()
    }
    
    public subscript(relativePath: String) -> URL? {
        get {
            return url(for: relativePath)
        }
        set {
            return insertRelativePath(newValue, for: relativePath)
        }
    }
    
    
}
