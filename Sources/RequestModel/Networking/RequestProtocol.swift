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

	/// Use for response decoding.
	var decoding: String.Encoding { get }

	/// Maximum number of repetitions if the response is bad.
	var repeatIfBadResponse: UInt8 { get }

	/// Seconds to close `Connection` to avoid remoteConnectionClosed timeout by responder.
	var timeout: Int64 { get }
}

// MARK: - Default RequestProtocol

public extension RequestProtocol {
	var body: (any Codable)? { nil }
	var data: Data? { nil }

	/// Creates path from request params.
	///
	/// - Returns: String path.
	var fullPath: String {
		let params: String = !queries.isEmpty ? "?\(queries.map { "\($0.key)=\($0.value)" }.joined(separator: "&"))" : ""
		return "\(path)\(params)"
	}

	mutating func addHeaders(token: String?) {
		if cachePolicy != .none {
			headers.append(cachePolicy.header)
		}

		if contentType != .none {
			headers.append(contentType.header)
		}

		if let token {
			headers.append(("Authorization", "Bearer \(token)"))
		}
	}
}
