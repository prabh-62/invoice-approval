struct WorkFlowQuestion: Codable {
    var Question: String?
    var QuestionType: String?
    var Answers = [String]()
}

public struct WorkFlowScenarioQueue {
    var Id: Int?
    var Name: String?
    var SourceQueue: String?
    var DestinationQueue = [String]()
    var Questions = [WorkFlowQuestion]()
}
