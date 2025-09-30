/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A SwiftUI view for displaying the appropriate view based on the availability of the System Language Model.
*/

import FoundationModels
import SwiftUI

struct LandmarkDetailView: View {
    let landmark: Landmark
    
    private let model = SystemLanguageModel.default

    var body: some View {
        // MARK: - [CODE-ALONG] Chapter 1.4.3: Replace availability with model.availability
        switch model.availability {
        case .available:
            LandmarkTripView(landmark: landmark)
            
        case .unavailable(.deviceNotEligible):
            MessageView(
                landmark: self.landmark,
                message: """
                         Trip Planner is not available on this device.
                         """
            )

        case .unavailable(.appleIntelligenceNotEnabled):
            MessageView(
                landmark: self.landmark,
                message: """
                         Trip Planner is unavailable because \
                         Apple Intelligence has not been turned on.
                         """
            )

        case .unavailable(.modelNotReady):
            MessageView(
                landmark: self.landmark,
                message: """
                         Trip Planner is not ready yet. Please try again later.
                         """
            )
            
        @unknown default:
            MessageView(
                landmark: self.landmark,
                message: """
                         Trip Planner is unavailable. Please try again later..
                         """
            )
        }
    }
}
