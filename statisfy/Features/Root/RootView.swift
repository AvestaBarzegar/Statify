//
//  RootView.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2023-10-13.
//

import Combine
import ComposableArchitecture
import SwiftUI

enum RootState: Codable {
	case loggedIn(accessToken: String)
	case demo
	case loggedOut

	static var userDefaultsKey: String {
		return "root_state"
	}

	private static let decoder = JSONDecoder()
	private static let encoder = JSONEncoder()

	static func convert(from rootStateDictionary: [String: Any?]) -> RootState {
		guard let dictData = try? JSONSerialization.data(withJSONObject: rootStateDictionary),
			  let rootState = try? JSONDecoder().decode(RootState.self, from: dictData) else {
			return .loggedOut
		}
		return rootState
	}

	var userDefaultSaveFormat: [String: Any?] {
		guard let data = try? Self.encoder.encode(self),
			  let dictUncast = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
			  let dict = dictUncast as? [String: Any?] else {
			// TODO: Add some logging
			debugPrint("Failed to write new rootState")
			return [:]
		}
		return dict
	}
}

extension UserDefaults {

	private static let decoder = JSONDecoder()

	@objc var rootStateDict: [String: Any]? {
		get {
			return dictionary(forKey: RootState.userDefaultsKey)
		}
		set {
			set(newValue, forKey: RootState.userDefaultsKey)
		}
	}

}

@Observable class RootViewModel {
	
	var rootState: RootState = .loggedOut

	private var cancellables: Set<AnyCancellable> = []

	private let jsonDecoder = JSONDecoder()

	init() {
		UserDefaults.standard.publisher(for: \.rootStateDict)
			.compactMap { $0 }
			.map { dict in
				RootState.convert(from: dict)
			}
			.sink { [weak self] newState in
				self?.rootState = newState
			}
			.store(in: &cancellables)
	}
}

@main
struct RootView: App {

	private let rootViewModel = RootViewModel()

	var body: some Scene {
		WindowGroup {
			switch rootViewModel.rootState {
			case .loggedIn(accessToken: _):
				Text("A")
			case .loggedOut:
				WelcomeScreen(
					store: Store(
						initialState: WelcomeScreenFeature.State(),
						reducer: { WelcomeScreenFeature() })
					)
			case .demo:
				Text("ABC")
			}
		}
	}
}
