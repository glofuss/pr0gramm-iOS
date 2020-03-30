
import UIKit
import AVKit

class Coordinator {
    
    let pr0grammConnector = Pr0grammConnector()
    private let navigationController = NavigationController()
    private let tabbarController = UITabBarController()
    
    init() {
        navigationController.coordinator = self
    }
    
    func startViewController() -> UIViewController {
        
        if pr0grammConnector.isLoggedIn {
            let viewController = MainCollectionViewController.fromStoryboard()
            viewController.coordinator = self
            navigationController.style = .main
            navigationController.viewControllers = [viewController]
            viewController.tabBarItem = UITabBarItem(title: "Top",
                                                           image: UIImage(systemName: "list.bullet"),
                                                           selectedImage: nil)

            let downloadedFilesTableViewController = DownloadedFilesTableViewController.fromStoryboard()
            downloadedFilesTableViewController.coordinator = self
            downloadedFilesTableViewController.tabBarItem = UITabBarItem(title: "Downloads",
                                                                         image: UIImage(systemName: "square.and.arrow.down"),
                                                                         selectedImage: nil)
            
            tabbarController.setViewControllers([navigationController, downloadedFilesTableViewController], animated: false)

            return tabbarController
        } else {
            let viewController = LoginViewController.fromStoryboard()
            viewController.coordinator = self
            navigationController.style = .login
            navigationController.viewControllers = [viewController]
            return navigationController
        }
    }
    
    func showLogin() {
        let viewController = LoginViewController.fromStoryboard()
        viewController.coordinator = self
        navigationController.viewControllers = [viewController]
    }
    
    func showOverview() {
        let viewController = MainCollectionViewController.fromStoryboard()
        viewController.coordinator = self
        navigationController.viewControllers = [viewController]
    }
    
    func showDetail(for item: Item, at indexPath: IndexPath) {
        let viewController = DetailCollectionViewController.fromStoryboard()
        viewController.coordinator = self
        let detailNavigationController = NavigationController(rootViewController: viewController)
        detailNavigationController.style = .detail
        detailNavigationController.modalPresentationStyle = .fullScreen
        navigationController.present(detailNavigationController, animated: true)
        viewController.scrollTo(indexPath: indexPath)
    }
    
    func showShareSheet(with items: [Any]) {
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        tabbarController.present(ac, animated: true)
    }
    
    func showVideo(with url: URL) {
        let avPlayerViewController = AVPlayerViewController()
        let avPlayer = AVPlayer()
        avPlayer.isMuted = false
        avPlayerViewController.player = avPlayer
        let playerItem = AVPlayerItem(url: url)
        avPlayer.replaceCurrentItem(with: playerItem)
        avPlayer.play()
        tabbarController.present(avPlayerViewController, animated: true)
    }
    
    func showImageViewController(with image: UIImage, from viewController: UIViewController) {
        let imageViewController = ImageDetailViewController.fromStoryboard()
        imageViewController.image = image
        viewController.present(imageViewController, animated: true)
    }
    
    @objc
    func logout() {
        pr0grammConnector.logout()
        showLogin()
    }
}
