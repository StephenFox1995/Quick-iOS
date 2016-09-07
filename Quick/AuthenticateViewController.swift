
import UIKit

protocol AuthenticateViewControllerDelegate: class {
  func authenticateViewControllerSignUpDetailsEntered (viewController: AuthenticateViewController,
                                                      email: String,
                                                      fullname: String,
                                                      password: String)
  func authenticateViewControllerLoginDetailsEntered (viewController: AuthenticateViewController,
                                                     email: String,
                                                     password: String)
}

class AuthenticateViewController: UIPageViewController,
  UIPageViewControllerDataSource,
LoginViewControllerDelegate,
SignUpViewControllerDelegate {
  
  weak var authDelegate: AuthenticateViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.whiteColor()
    self.dataSource = self
    
    let initialViewController = self.viewControllerAtIndex(0)
    let viewControllers = [initialViewController]
    self.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: nil)
  }
  
  /// Determines the view controller to show based on its index.
  private func viewControllerAtIndex(index: NSInteger) -> UIViewController {
    switch index {
    case 0:
      let loginViewController = LoginViewController()
      loginViewController.index = index
      loginViewController.delegate = self
      return loginViewController
    case 1:
      let signUpViewController = SignUpViewController()
      signUpViewController.index = index
      signUpViewController.delegate = self
      return signUpViewController
    default:
      return LoginViewController()
    }
  }
}



// MARK: LoginViewControllerDelegate
extension AuthenticateViewController {
  func loginDetailsEntered(viewController: LoginViewController, email: String, password: String) {
    if let delegate = self.authDelegate {
      delegate.authenticateViewControllerLoginDetailsEntered(self, email: email, password: password)
    }
  }
}
// MARK: SignUpViewControllerDelegate
extension AuthenticateViewController {
  func signUpDetailsEntered(viewController: SignUpViewController,
                            email: String,
                            fullname: String,
                            password: String) {
    if let delegate = self.authDelegate {
      delegate.authenticateViewControllerSignUpDetailsEntered(self, email: email, fullname: fullname, password: password)
    }
  }
}

// MARK: UIPageViewControllerDataSource
extension AuthenticateViewController {
  func pageViewController(pageViewController: UIPageViewController,
                          viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
    var index = (viewController as! QuickViewController).index
    if (index == 1) {
      return nil
    }
    index = index! + 1
    return self.viewControllerAtIndex(index!)
  }
  
  func pageViewController(pageViewController: UIPageViewController,
                          viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
    var index = (viewController as! QuickViewController).index
    if (index == 0) {
      return nil
    }
    index = index! + 1
    return self.viewControllerAtIndex(index!)
  }
  
  func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
    return 2
  }
  func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
    return 0
  }
}



