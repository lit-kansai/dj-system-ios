import UIKit

class CooltimeViewController: UIViewController {

    @IBOutlet private var timerLabel: UILabel!

    let cooltimeService = CooltimeService(dataSource: CooltimeDataSource())
    let cooltimeDataSource = CooltimeDataSource()

    var coolTimeTimer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()

        let leftTime = cooltimeService.getRemainingCooltime()
        timerLabel.text = leftTime

        guard let leftTime = leftTime else {
            return
        }

        timer()
    }

    func timer() {
        coolTimeTimer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(self.countDown),
            userInfo: nil,
            repeats: true
        )

    }

    @objc
    func countDown() {
        let savedTime = try! cooltimeDataSource.fetch()
        let setTime = cooltimeService.calculateTimeLeft(cooltime:Int(savedTime))
        let text = cooltimeService.formatTime(hours: setTime.0, minutes: setTime.1, seconds: setTime.2)

        var timerCheck = cooltimeService.hasExpired

        timerLabel.text = text

        if timerCheck == true {
            coolTimeTimer.invalidate()
        }
    }

}
