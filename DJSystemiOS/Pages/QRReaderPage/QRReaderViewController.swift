import AVFoundation
import QRScanner
import UIKit

final class QRReaderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupQRScanner()
    }

    private func setupQRScanner() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setupQRScannerView()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                if granted {
                    DispatchQueue.main.async { [weak self] in
                        self?.setupQRScannerView()
                    }
                }
            }
        default:
            showAlert()
        }
    }

    private func setupQRScannerView() {
        let qrScannerView = QRScannerView(frame: view.bounds)
        view.addSubview(qrScannerView)
        qrScannerView.configure(delegate: self, input: .init(isBlurEffectEnabled: true))
        qrScannerView.startRunning()
    }

    private func showAlert() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            let alert = UIAlertController(title: "エラー", message: "このアプリを使うにはカメラへのアクセスを許可する必要があります。", preferredStyle: .alert)
            alert.addAction(.init(title: "OK", style: .default))
            self?.present(alert, animated: true)
        }
    }
}

extension QRReaderViewController: QRScannerViewDelegate {
    func qrScannerView(_ qrScannerView: QRScannerView, didFailure error: QRScannerError) {
        let alert = UIAlertController(title: "エラー", message: "このQRコードは無効です", preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default))
        self.present(alert, animated: true)
    }

    func qrScannerView(_ qrScannerView: QRScannerView, didSuccess code: String) {
        let extractedRoomID = URL.extractRoomID(inputURL: code)
        switch extractedRoomID {
        case .success(let roomID):
            Task{
                let client = APIClient(baseURL: AppConfig().BaseAPIURL)
                let result = await client.get(from: .getRoom(roomId: roomID), dataType: Room.API.GetRoomResponse.self)
                switch result {
                case .success(let response):
                    let roomOverViewPageView = RoomOverviewViewController(roomAPI: Room.API(), roomOverview: RoomOverview(id: response.id, name: response.name, description: response.description))
                    navigationController?.pushViewController(roomOverViewPageView, animated: true)
                case .failure:
                    let alert = UIAlertController(title: "エラー", message: "ルームが見つかりませんでした。", preferredStyle: .alert)
                    alert.addAction(.init(title: "OK", style: .default))
                    self.present(alert, animated: true)
                }
            }
        case .failure:
            let alert = UIAlertController(title: "エラー", message: "このURLに対応するルームが見つかりません。", preferredStyle: .alert)
            alert.addAction(.init(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
}
