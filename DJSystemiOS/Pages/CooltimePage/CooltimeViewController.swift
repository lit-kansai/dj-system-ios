import UIKit

class CooltimeViewController: UIViewController {

    @IBOutlet private var timerLabel: UILabel!

    let cooltimeService = CooltimeService(dataSource: CooltimeDataSource())

    var coolTimeTimer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()

        cooltimeService.saveCooltime(unixTime: Date().timeIntervalSince1970 + 30)
        updateCooltimeLabel()

        if let _ = cooltimeService.getRemainingCooltime() {
            timer()
        }

    }

    func timer() {
        coolTimeTimer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(countDown),
            userInfo: nil,
            repeats: true
        )

    }

    func updateCooltimeLabel() {
        if let leftTime = cooltimeService.getRemainingCooltime() {
            timerLabel.text = leftTime
        } else {
            return
        }
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
