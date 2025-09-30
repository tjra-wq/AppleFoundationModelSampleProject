/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A Playground for testing Foundation Models framework features.
*/

import FoundationModels
import Playgrounds

#Playground {
    let instructions = """
        Your job is to create an itinerary for the user.
        Each day needs an activity, hotel and restaurant.

        Always include a title, a short description, and a day-by-day plan.
        """

    let session = LanguageModelSession(instructions: instructions)
    let response = try await session.respond(to: "Generate a 3-day itinerary to Paris.")
}


//1.3 Handling model availability
#Playground {
    let model = SystemLanguageModel.default

    // The availability property provides detailed information on the model's state.
    switch model.availability {
        case .available:
            print("Foundation Models is available and ready to go!")

        case .unavailable(.deviceNotEligible):
            print("The model is not available on this device.")

        case .unavailable(.appleIntelligenceNotEnabled):
            print("Apple Intelligence is not enabled in Settings.")

        case .unavailable(.modelNotReady):
            print("The model is not ready yet. Please try again later.")

        case .unavailable(let other):
            print("The model is unavailable for an unknown reason.")
    }
}

