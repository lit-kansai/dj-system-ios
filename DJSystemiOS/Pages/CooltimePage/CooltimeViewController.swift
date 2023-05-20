import UIKit

class CooltimeViewController: UIViewController {

    @IBOutlet var timerLabel: UILabel!
    
    let cooltimeService = CooltimeService(dataSource: CooltimeDataSource())

    var coolTimeTimer = Timer()
    var time = Date().timeIntervalSince1970

    override func viewDidLoad() {
        super.viewDidLoad()

        let remainingTime = cooltimeService.getRemainingCooltime()
        
        timerLabel.text = remainingTime
        
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
            selector: #selector(down(timer:)),
            userInfo: nil,
            repeats: true
        )

    }

    @objc func down(timer: Timer) {
        let remainingTime = cooltimeService.getRemainingCooltime()
        
        time -= 1
        
        let hours = Int(time) / 3_600
        let minutes = (Int(time) % 3_600) / 60
        let seconds = Int(time) % 60
        
        if seconds < 10 {
            timerLabel.text = String("\(minutes):0\(seconds)")
        } else {
            timerLabel.text = String("\(minutes):\(seconds)")
        }
        
        if time == 0 {
            timer.invalidate()
        }
        
    }

}


/*TODO:
 画面がロードされたときにCooltimeServiceからクールタイムを取得し表示する
 1秒間隔でCooltimeServiceから残り時間を取得し、更新する
 クールタイムが0になった時、なったらタイマーを止める
 */
