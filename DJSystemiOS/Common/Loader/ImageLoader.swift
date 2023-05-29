import UIKit

enum ImageLoader {
    static func fetchImages(from urls: [URL]) async -> [URL: UIImage?] {
        await withTaskGroup(of: (URL, UIImage?).self) { group in
            for url in urls {
                group.addTask {
                    let image = await self.fetchImage(from: url)
                    return (url, image)
                }
            }

            var images = [URL: UIImage?]()
            for await (url, image) in group {
                images[url] = image
            }
            return images
        }
    }

    static func fetchImage(from url: URL) async -> UIImage? {
        do {
            let (imageData, response) = try await URLSession.shared.data(for: URLRequest(url: url))
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return nil }
            return UIImage(data: imageData)
        } catch {
            return nil
        }
    }
}
