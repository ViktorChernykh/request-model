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
	case html
	case data
	case file
	case none

	public var header: (String, String) {
		switch self {
		case .json: ("Content-Type", "application/json")
		case .text: ("Content-Type", "text/plain; charset=utf-8")
		case .html: ("Content-Type", "text/html; charset=utf-8")
		case .data: ("Content-Type", "application/octet-stream")
		case .file: ("Content-Type", "multipart/form-data")
		case .none: ("", "")
		}
	}
}
