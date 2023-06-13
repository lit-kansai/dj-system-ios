import Foundation

protocol RoomHistoryWritable {
    func addRoomHistory(_ room: RoomHistory)
}

protocol RoomHistoryReadable {
    func getAllRoomHistory() -> [RoomHistory]
}

final class RoomHistoryService: RoomHistoryReadable, RoomHistoryWritable {
    func getAllRoomHistory() -> [RoomHistory] {
        return []
    }

    func addRoomHistory(_ room: RoomHistory) {

    }

}

