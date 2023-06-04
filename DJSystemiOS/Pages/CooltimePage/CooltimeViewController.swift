import UIKit

class CooltimeViewController: UIViewController {

    @IBOutlet private var timerLabel: UILabel!

    let cooltimeService = CooltimeService(dataSource: CooltimeDataSource())

    var coolTimeTimer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()

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
            coolTimeTimer.invalidate()
        }
    }

}
