//
//  ContentType.swift
//  RequestModel
//
//  Created by Victor Chernykh on 15.06.2025.
//

/// Cases for request Content Type.
public enum ContentType {
	case json
	case text
	case data
	case file

	public var value: String {
		switch self {
		case .json: return "application/json"
		case .text: return "text/html; charset=utf-8"
		case .data: return "application/octet-stream"
		case .file: return "multipart/form-data"
		}
	}
}
