import Foundation

extension DataModel {
    struct Music: Codable {}
}

struct Music: Codable {
    let id: String
    let name: String
    let artists:String
    let thumbnail: URL
}

extension Music {
    static let mockData: Music = .init(id: "spotify:track:67T4aWFCAbMNWKamvI3piH", name: "ray", artists: "BUMP OF CHICKEN, 初音ミク", thumbnail: URL(string: "https://i.scdn.co/image/ab67616d0000b2731bc3a96706495fb0a1dbdffd")!)
}

extension Music {
    struct Mock {}
}

extension Music.Mock {
    static let musics: [Music] = [
        .init(
            id: "spotify:track:7ajpbW6tBpqUI9foCtwlLw",
            name: "祝福",
            artists: "YOASOBI",
            thumbnail: URL(string: "https://i.scdn.co/image/ab67616d0000b273c5993ff2f059a0a5a7f6270b")!
        ),
        .init(
            id: "spotify:track:3dPtXHP0oXQ4HCWHsOA9js",
            name: "夜に駆ける",
            artists: "YOASOBI",
            thumbnail: URL(string: "https://i.scdn.co/image/ab67616d0000b273c5716278abba6a103ad13aa7")!
        ),
        .init(
            id: "spotify:track:0T4AitQuq8IJhWBWuZwkFA",
            name: "群青",
            artists: "YOASOBI",
            thumbnail: URL(string: "https://i.scdn.co/image/ab67616d0000b2735235b1b2b4feb3783e12a434")!
        ),
        .init(
            id: "spotify:track:3FUCuf498nFHJXFYR1V9Bd",
            name: "三原色",
            artists: "YOASOBI",
            thumbnail: URL(string: "https://i.scdn.co/image/ab67616d0000b273d6efeab6484d518ae4b9cfd6")!
        ),
        .init(
            id: "spotify:track:6wKmxUeMJAoz2GpMrw95z5",
            name: "ハルカ",
            artists: "YOASOBI",
            thumbnail: URL(string: "https://i.scdn.co/image/ab67616d0000b273bb6370163b04145ed2e87442")!
        ),
        .init(
            id: "spotify:track:06XQvnJb53SUYmlWIhUXUi",
            name: "怪物",
            artists: "YOASOBI",
            thumbnail: URL(string: "https://i.scdn.co/image/ab67616d0000b273f609c79794752ed7ee0976b5")!
        ),
        .init(
            id: "spotify:track:1TXhBe3DnaOFc7onTbEoiB",
            name: "セブンティーン",
            artists: "YOASOBI",
            thumbnail: URL(string: "https://i.scdn.co/image/ab67616d0000b2737f63f3d6c8b925a74145eb24")!
        ),
        .init(
            id: "spotify:track:4BE1OloRc9xwjyqA4wFFuN",
            name: "あの夢をなぞって",
            artists: "YOASOBI",
            thumbnail: URL(string: "https://i.scdn.co/image/ab67616d0000b2730f46d80794891bde2dcbf1")!
        )
    ]

    static let music: Music = .init(id: "spotify:track:67T4aWFCAbMNWKamvI3piH", name: "ray", artists: "BUMP OF CHICKEN, 初音ミク", thumbnail: URL(string: "https://i.scdn.co/image/ab67616d0000b2731bc3a96706495fb0a1dbdffd")!)
}
