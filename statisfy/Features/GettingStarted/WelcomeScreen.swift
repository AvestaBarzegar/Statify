//
//  WelcomeScreen.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-08-25.
//

import ComposableArchitecture
import SwiftUI

struct WelcomeScreenFeature: Reducer {

	struct State: Equatable {
		@PresentationState var authScreenState: String? = nil
	}

	enum Action {
		case presentAuthSheet
		case dismissAuthSheet
		case authScreenAction(PresentationAction<String>)
	}

	var body: some ReducerOf<Self> {
		Reduce { state, action in
			switch action {
			case .presentAuthSheet:
				state.authScreenState = "ABCD"
				return .none
			case .dismissAuthSheet:
				state.authScreenState = nil
				return .none
			case .authScreenAction(_):
				return .none
			}
			return .none
		}
//		.ifLet(\.$authScreenState, action: /Action.authScreenAction) {
//			WelcomeScreenFeature()
//		}

	}

}

struct WelcomeScreen: View {

	let store: StoreOf<WelcomeScreenFeature>
    
    var body: some View {
		WithViewStore(store, observe: { $0 }) { viewStore in
			ZStack {
				Color(UIColor.backgroundColor)
					.ignoresSafeArea()
				VStack {
					Spacer()
					Text("Welcome")
						.font(.welcomeFont)
						.textColor(.spotifyWhite)
						.padding()
					Text("Tap the get started button to link your account and view your stats")
						.font(.welcomeSubtitleFont)
						.textColor(.spotifyWhite)
						.padding(EdgeInsets(vertical: Spacing.halfX, horizontal: Spacing.fourX))
					Spacer()
					Button("Get Started") {
						viewStore.send(.presentAuthSheet)
					}
					.padding(EdgeInsets(vertical: Spacing.oneAndHalfX, horizontal: Spacing.eightX))
					.background(Color(UIColor.spotifyGreen))
					.foregroundColor(Color(UIColor.spotifyWhite))
					.font(Font(uiFont: UIFont.tableCellFontBolded))
					.clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
					Button("Demo the app") {
						print("ABCD")
					}
					.foregroundColor(Color(UIColor.spotifyWhite))
					.font(Font(uiFont: UIFont.tableCellFontBolded))
					.padding(EdgeInsets(vertical: Spacing.twoX, horizontal: Spacing.sixX))
				}
			}
//			.fullScreenCover(store: <#T##Store<PresentationState<State>, PresentationAction<Action>>#>, content: <#T##(Store<State, Action>) -> View##(Store<State, Action>) -> View##(_ store: Store<State, Action>) -> View#>)
//			.fullScreenCover(isPresented: $viewModel.showSheet) {
//				AuthScreen(viewModel: viewModel)
//			}

		}
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen(
			store: Store(
				initialState: WelcomeScreenFeature.State(),
				reducer: {
					WelcomeScreenFeature()
				})
		)
    }
}
