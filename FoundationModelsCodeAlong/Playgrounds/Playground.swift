/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A Playground for testing Foundation Models framework features.
*/

import FoundationModels
import Playgrounds

//#Playground {
//    let instructions = """
//        Your job is to create an itinerary for the user.
//        Each day needs an activity, hotel and restaurant.
//
//        Always include a title, a short description, and a day-by-day plan.
//        """
//
//    let session = LanguageModelSession(instructions: instructions)
//    let response = try await session.respond(to: "Generate a 3-day itinerary to Paris.")
//}


//1.3 Handling model availability
//#Playground {
//    let model = SystemLanguageModel.default
//
//    // The availability property provides detailed information on the model's state.
//    switch model.availability {
//        case .available:
//            print("Foundation Models is available and ready to go!")
//
//        case .unavailable(.deviceNotEligible):
//            print("The model is not available on this device.")
//
//        case .unavailable(.appleIntelligenceNotEnabled):
//            print("Apple Intelligence is not enabled in Settings.")
//
//        case .unavailable(.modelNotReady):
//            print("The model is not ready yet. Please try again later.")
//
//        case .unavailable(let other):
//            print("The model is unavailable for an unknown reason.")
//    }
//}


//2.1 Getting structured data
//#Playground {
//    let instructions = """
//        Your job is to create an itinerary for the user.
//        """
//
//    let session = LanguageModelSession(instructions: instructions)
//    let prompt = "Generate a 3-day itinerary to the Grand Canyon."
//    let response = try await session.respond(to: prompt,
//                                             generating: Itinerary.self)
//}

// The @Generable macro makes your custom type compatible with the model.
//@Generable
//struct SimpleItinerary {
//    // The @Guide macro provides hints to the model about a property.
//    @Guide(description: "An exciting name for the trip.")
//    let title: String
//
//    @Guide(description: "A short, engaging description of the trip.")
//    let description: String
//
//    @Guide(description: "A list of day-by-day plans, as simple strings.")
//    @Guide(.count(3))
//    let days: [String]
//}

//3.1 Building prompts with PromptBuilder
#Playground{
    let instruction = "Your job is to create an itinerary for the user."
    let session = LanguageModelSession(instructions: instruction)
    
    let kidFriendly = true
    
    //The Prompt Builder allows for conditional logic.
    let prompt = Prompt {
        "Generate a 3-day itinerary to the Grand Canyon."
        if kidFriendly {
            "The itinerary must be kid-friendly."
            "Here is an example of the desired format, but don't copy its content:"
            Itinerary.exampleTripToJapan
        }
    }
    
    let response = try await session.respond(to: prompt, generating: Itinerary.self)
}
