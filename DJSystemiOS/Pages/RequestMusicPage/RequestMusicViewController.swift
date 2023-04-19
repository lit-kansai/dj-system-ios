import SwiftUI
import UIKit

protocol RequestMusicViewControllerProtocol: AnyObject {
    func postMusic(radioName: String, message: String) async
}

class RequestMusicViewController: UIViewController {
    var roomId: String
    var music: Music

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(roomId: String, music: Music) {
        self.roomId = roomId
        self.music = music
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let requestMusicView = RequestMusicView(controller: self, music: music, roomId: roomId)
        let hostingVC = UIHostingController(rootView: requestMusicView)
        addChild(hostingVC)
        view.addSubview(hostingVC.view)
        hostingVC.didMove(toParent: self)
        hostingVC.coverView(parent: view)
    }
}

extension RequestMusicViewController: RequestMusicViewControllerProtocol {
    func postMusic(radioName: String, message: String) async {
        try! await Room.API().requestMusic(input: Room.API.RequestMusicInput(musics: [music.id], radioName: radioName, message: message, roomId: roomId))
    }
}
