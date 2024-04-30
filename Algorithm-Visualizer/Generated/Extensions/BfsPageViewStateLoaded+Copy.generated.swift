// Generated using Sourcery 2.2.3 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import Foundation
import SwiftUI

extension BfsPageViewStateLoaded {
    func copy(
            colorGrid: CopyParameter<[[Color]]> = .old,
            currentSelectedCellType: CopyParameter<CellType> = .old,
            algorithmRunning: CopyParameter<Bool> = .old,
            algorithmComplete: CopyParameter<Bool> = .old,
            startIndices: CopyParameter<(Int, Int)> = .old,
            targetIndices: CopyParameter<(Int, Int)> = .old,
            algorithmSpeed: CopyParameter<Double> = .old,
            queueString: CopyParameter<String> = .old
    ) -> BfsPageViewStateLoaded {
        let colorGridParam = switch colorGrid {
        case .old:
            self.colorGrid
        case .new(let newValue):
            newValue
        }

        let currentSelectedCellTypeParam = switch currentSelectedCellType {
        case .old:
            self.currentSelectedCellType
        case .new(let newValue):
            newValue
        }

        let algorithmRunningParam = switch algorithmRunning {
        case .old:
            self.algorithmRunning
        case .new(let newValue):
            newValue
        }

        let algorithmCompleteParam = switch algorithmComplete {
        case .old:
            self.algorithmComplete
        case .new(let newValue):
            newValue
        }

        let startIndicesParam = switch startIndices {
        case .old:
            self.startIndices
        case .new(let newValue):
            newValue
        }

        let targetIndicesParam = switch targetIndices {
        case .old:
            self.targetIndices
        case .new(let newValue):
            newValue
        }

        let algorithmSpeedParam = switch algorithmSpeed {
        case .old:
            self.algorithmSpeed
        case .new(let newValue):
            newValue
        }

        let queueStringParam = switch queueString {
        case .old:
            self.queueString
        case .new(let newValue):
            newValue
        }

        return BfsPageViewStateLoaded(
            colorGrid: colorGridParam,
            currentSelectedCellType: currentSelectedCellTypeParam,
            algorithmRunning: algorithmRunningParam,
            algorithmComplete: algorithmCompleteParam,
            startIndices: startIndicesParam,
            targetIndices: targetIndicesParam,
            algorithmSpeed: algorithmSpeedParam,
            queueString: queueStringParam
        )
    }

    enum CopyParameter<T> {
		case old
		case new(T)
	}
}
