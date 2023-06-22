import QRScanner
import UIKit

final class QRReaderViewController: UIViewController {

    // これ読みながらQRコードを読むやつやって欲しい: https://github.com/mercari/QRScanner
    // QRScannerはインストール済みなので導入するところから始めてくださいー！

    override func viewDidLoad() {
        super.viewDidLoad()
    }

//    private func extractRoomID() {
        // QRから読んだURLからroomIDだけ正規表現で抜き出す
        // Result<String, InvalidURLError>型で返ってくるので良い感じに使ってくださいー
        // let result = URL.extractRoomID(inputURL: "https://dj-life-is-tech.com/sample-gassi")
        // print(result) // .success("result")

//    }

}
