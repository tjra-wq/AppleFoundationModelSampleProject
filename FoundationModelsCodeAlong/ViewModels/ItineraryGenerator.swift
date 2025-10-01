/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A class that generates an itinerary.
*/

import FoundationModels
import Observation

@Observable
@MainActor
final class ItineraryGenerator {
    
    var error: Error?
    let landmark: Landmark
    
    private var session: LanguageModelSession
    
    private(set) var itinerary: Itinerary?
    // MARK: - [CODE-ALONG] Chapter 4.1.1: Change the property to hold a partially generated Itinerary
    private(set) var itineraryContent: String?

    init(landmark: Landmark) {
        self.landmark = landmark
        let instructions = """
            Your job is to create an itinerary for the user.
            Each day needs an activity, hotel and restaurant.
            """
        // MARK: - [CODE-ALONG] Chapter 5.3.1: Update the instructions to use the Tool
        // MARK: - [CODE-ALONG] Chapter 5.3.2: Update the LanguageModelSession with the tool
        // MARK: - [CODE-ALONG] Chapter 1.5.2: Initialize LanguageModelSession
        self.session = LanguageModelSession(instructions: instructions)
    }

    func generateItinerary(dayCount: Int = 3) async {
        do {
//            let prompt = "Generate a \(dayCount)-day itinerary to \(landmark.name)"
            let prompt = Prompt {
                            "Generate a \(dayCount)-day itinerary to \(landmark.name)."
                            "Give it a fun title and description."
                            "Here is an example of the desired format, but don't copy its content:"
                            Itinerary.exampleTripToJapan
                        }

            let response = try await session.respond(to: prompt, generating: Itinerary.self)
            self.itinerary = response.content
        } catch {
            self.error = error
        }
        
        // MARK: - [CODE-ALONG] Chapter 3.3: Update to use one-shot prompting
        // MARK: - [CODE-ALONG] Chapter 4.1.2: Update to use streaming API
        // MARK: - [CODE-ALONG] Chapter 5.3.3: Update `session.streamResponse` to include greedy sampling
        // MARK: - [CODE-ALONG] Chapter 6.2.1: Update to exclude schema from prompt
         
    }

    func prewarmModel() {
        // MARK: - [CODE-ALONG] Chapter 6.1.1: Add a function to pre-warm the model
    }
}
