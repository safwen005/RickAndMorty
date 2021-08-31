import UIKit

class DataSharingHelper {
  func getReceiver(withIndex: NavBarItems, fromTabBar: UITabBarController?) -> DataReceiverProtocole? {
    var targetDataReceiever: DataReceiverProtocole?
    switch withIndex {
    case .search:
      targetDataReceiever = (
        extractReceiver(withIndex: NavBarItemsConstants.searchIndex,
        fromTabBar: fromTabBar))
    default:
      break
    }
    return targetDataReceiever
  }
  
  func extractReceiver(withIndex: Int, fromTabBar: UITabBarController?) -> DataReceiverProtocole? {
    guard let tabBarViewControllers = fromTabBar?.viewControllers else {
      fatalError()
    }
    if tabBarViewControllers.hasIndex(withIndex) {
      return tabBarViewControllers[withIndex] as? DataReceiverProtocole
    }
    return nil
  }
}
