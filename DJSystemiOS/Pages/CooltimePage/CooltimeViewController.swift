import UIKit

class CooltimeViewController: UIViewController {

    @IBOutlet private var timerLabel: UILabel!

    let cooltimeService = CooltimeService(dataSource: CooltimeDataSource())

    var coolTimeTimer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()

        updateCooltimeLabel()

        if cooltimeService.hasExpired {
            startTimer()
        }

    }

    func startTimer() {
        coolTimeTimer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(countDown),
            userInfo: nil,
            repeats: true
        )

    }

    func updateCooltimeLabel() {
        guard let leftTime = cooltimeService.getRemainingCooltime() else {
            return
        }

        timerLabel.text = leftTime
    }

    @objc
    func countDown() {
        updateCooltimeLabel()

        if cooltimeService.hasExpired {
            timerLabel.text = "00:00"
            coolTimeTimer.invalidate()
        }
    }

}
