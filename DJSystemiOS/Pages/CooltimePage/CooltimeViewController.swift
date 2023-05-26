import UIKit

class CooltimeViewController: UIViewController {

    @IBOutlet private var timerLabel: UILabel!

    let cooltimeService = CooltimeService(dataSource: CooltimeDataSource())

    var time = Date().timeIntervalSince1970 + 300

    var coolTimeTimer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()

        var setTime = cooltimeService.getRemainingCooltime()

        if setTime == nil {
            var setTime = cooltimeService.calculateTimeLeft(cooltime: Int(time))
            var text = cooltimeService.formatTime(hours: setTime.0, minutes: setTime.1, seconds: setTime.2)
            timerLabel.text = text
        } else {
            timerLabel.text = setTime
        }

        timer()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        cooltimeService.saveCooltime(unixTime: time)

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
        var setTime = cooltimeService.calculateTimeLeft(cooltime: Int(time))
        var text = cooltimeService.formatTime(hours: setTime.0, minutes: setTime.1, seconds: setTime.2)
        timerLabel.text = text

        if text == "00:00" {
            coolTimeTimer.invalidate()
        }
    }

}


/*TODO:
 画面がロードされたときにCooltimeServiceからクールタイムを取得し表示する
 1秒間隔でCooltimeServiceから残り時間を取得し、更新する
 クールタイムが0になった時、なったらタイマーを止める
 */
