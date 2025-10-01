/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A class that generates an itinerary.
*/

import Foundation
import FoundationModels
import Observation

@Observable
@MainActor
final class ItineraryGenerator {
    
    var error: Error?
    let landmark: Landmark
    
    private var session: LanguageModelSession

    private(set) var itinerary: Itinerary.PartiallyGenerated?

    init(landmark: Landmark) {
        self.landmark = landmark
        let pointOfInterestTool = FindPointsOfInterestTool(landmark: landmark)
        let instructions = Instructions {
            "Your job is to create an itinerary for the user."
            "For each day, you must suggest one hotel and one restaurant."
            "Always use the 'findPointsOfInterest' tool to find hotels and restaurant in \(landmark.name)"
        }
        
        self.session = LanguageModelSession(tools: [pointOfInterestTool], instructions: instructions)
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

//            let response = try await session.respond(to: prompt, generating: Itinerary.self)
//            self.itinerary = response.content
            let stream = session.streamResponse(to: prompt,
                                                generating: Itinerary.self,
                                                includeSchemaInPrompt: false,
                                                options: GenerationOptions(sampling: .greedy))
            for try await partialResponse in stream {
                self.itinerary = partialResponse.content
            }
            
        } catch {
            self.error = error
        }
    }

    func prewarmModel() {
        session.prewarm(promptPrefix: Prompt {
            "Generate a 3-day itinerary to \(landmark.name)."
        })
    }
}
