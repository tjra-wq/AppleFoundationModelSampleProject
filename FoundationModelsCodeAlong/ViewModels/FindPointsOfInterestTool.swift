import FoundationModels
import SwiftUI

@Observable
final class FindPointsOfInterestTool: Tool {
    
    let name = "findPointsOfInterest"
    let description = "Finds points of interest for a landmark."
    
    let landmark: Landmark
    init(landmark: Landmark) {
        self.landmark = landmark
    }

    @Generable
    struct Arguments {
        @Guide(description: "This is the type of business to look up for.")
        let pointOfInterest: Category
    }
    
    func call(arguments: Arguments) async throws -> String {
        let results = await getSuggestions(category: arguments.pointOfInterest,
                                           landmark: landmark.name)
        return """
        There are these \(arguments.pointOfInterest) in \(landmark.name): 
        \(results.joined(separator: ", "))
        """
    }
}

@Generable
enum Category: String, CaseIterable {
    case hotel
    case restaurant
}

func getSuggestions(category: Category, landmark: String) -> [String] {
    switch category {
    case .hotel : ["Hotel 1", "Hotel 2", "Hotel 3"]
    case .restaurant : ["Restaurant 1", "Restaurant 2", "Restaurant 3"]
    }
}
