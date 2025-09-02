//
//  CachePolicy.swift
//  RequestModel
//
//  Created by Victor Chernykh on 15.06.2025.
//

public enum CachePolicy: String {
	case useNoStoreNoCache
	case usePrivateCachePolicy1day
	case none

	public var header: (String, String) {
		switch self {
		case .useNoStoreNoCache: ("Cache-Control", "no-store, max-age=0, must-revalidate")
		case .usePrivateCachePolicy1day: ("Cache-Control", "private, max-age=86400")
		case .none: ("", "")
		}
	}
}
