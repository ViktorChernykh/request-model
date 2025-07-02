//
//  RequestProtocol.swift
//  RequestModel
//
//  Created by Victor Chernykh on 14.06.2025.
//

import struct Foundation.Data

/// Defines the structure of a network request.
public protocol RequestProtocol {
	var path: String { get }

	var requestType: RequestMethod { get }
	var contentType: ContentType { get }
	var cachePolicy: CachePolicy { get }

	var headers: [(String, String)] { get set }

	/// Query params
	var queries: [String: String] { get }

	/// Optional request body of type Codable.
	var body: (any Codable)? { get }

	/// Optional raw data body.
	var data: Data? { get }

	/// Maximum number of repetitions if the response is bad.
	var repeatIfBadResponse: UInt8 { get }

	/// Seconds to close `Connection` to avoid remoteConnectionClosed timeout by responder.
	var timeout: Int64 { get }
}

// MARK: - Default RequestProtocol

public extension RequestProtocol {
	var body: (any Codable)? { nil }
	var data: Data? { nil }
	var repeatIfBadResponse: UInt8 { 2 }
	var timeout: Int64 { 10 }

	/// Creates path from request params.
	///
	/// - Returns: String path.
	var fullPath: String {
		let params: String = !queries.isEmpty ? "?\(queries.map { "\($0.key)=\($0.value)" }.joined(separator: "&"))" : ""
		return "\(path)\(params)"
	}

	mutating func addHeaders(token: String?) {
		switch cachePolicy {
		case .useNoStoreNoCache:
			headers.append(("Cache-Control", "no-store, max-age=0, must-revalidate"))
		case .usePrivateCachePolicy1day:
			headers.append(("Cache-Control", "private, max-age=86400"))
		}

		switch contentType {
		case .json:
			headers.append(("Content-Type", "application/json"))
		case .text:
			headers.append(("Content-Type", "text/html; charset=utf-8"))
		case .data:
			headers.append(("Content-Type", "application/octet-stream"))
		case .file:
			headers.append(("Content-Type", "multipart/form-data"))
		}

		if let token {
			headers.append(("Authorization", "Bearer \(token)"))
		}
	}
}
