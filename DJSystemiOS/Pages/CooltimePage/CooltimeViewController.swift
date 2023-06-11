import UIKit

class CooltimeViewController: UIViewController {

    @IBOutlet private var timerLabel: UILabel!
    private let cooltimeService: CooltimeServiceProtocol
    private let roomId: String
    private var cooltimeTimer = Timer()

    init?(coder: NSCoder, cooltimeService: CooltimeServiceProtocol, roomId: String) {
        self.cooltimeService = cooltimeService
        self.roomId = roomId
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        updateCooltimeLabel()
        if !cooltimeService.hasExpired {
            startTimer()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cooltimeTimer.invalidate()
    }

    func startTimer() {
        cooltimeTimer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(countDown),
            userInfo: nil,
            repeats: true
        )

    }

    func updateCooltimeLabel() {
        guard let leftTime = cooltimeService.getRemainingCooltime() else { return }
        timerLabel.text = leftTime
    }

    @objc
    func countDown() {
        updateCooltimeLabel()

        if cooltimeService.hasExpired {
            timerLabel.text = "00:00"
            cooltimeTimer.invalidate()
            guard let navigationController else { return }
            let searchMusicViewController = Factory.searchMusicViewController(roomId: roomId)
            navigationController.pushViewController(searchMusicViewController, animated: true)
        }
    }

}
