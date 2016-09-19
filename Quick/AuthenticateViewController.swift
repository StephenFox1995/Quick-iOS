
import UIKit
import Cartography

protocol AuthenticateViewControllerDelegate: class {
  func authenticateViewControllerSignUpDetailsEntered (_ viewController: AuthenticateViewController,
                                                      email: String,
                                                      fullname: String,
                                                      password: String)
  func authenticateViewControllerLoginDetailsEntered (_ viewController: AuthenticateViewController,
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
    self.setupViews()
    self.view.backgroundColor = UIColor.white
    self.navigationController?.isNavigationBarHidden = true
    self.dataSource = self
    
    let initialViewController = self.viewControllerAtIndex(0)
    let viewControllers = [initialViewController]
    self.setViewControllers(viewControllers, direction: .forward, animated: false, completion: nil)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.isNavigationBarHidden = false
  }
  
  fileprivate func setupViews() {
    UIPageControl.changePageIndicator(UIColor.pageControlGrayColor(),
                                      indicatorCurrentPage: UIColor.pageControlCurrentPageGrayColor())
    
    let imageView = UIImageView(image: UIImage(named: "QuickLogo"))
    self.view.addSubview(imageView)
    constrain(self.view, imageView) {
      (superView, imageView) in
      imageView.centerX == superView.centerX
      imageView.width == superView.width * 0.3
      imageView.height == superView.width * 0.3
      imageView.top == superView.top + 40
    }
  }
  
  /// Determines the view controller to show based on its index.
  fileprivate func viewControllerAtIndex(_ index: NSInteger) -> UIViewController {
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
  func loginDetailsEntered(_ viewController: LoginViewController, email: String, password: String) {
    if let delegate = self.authDelegate {
      delegate.authenticateViewControllerLoginDetailsEntered(self, email: email, password: password)
    }
  }
}
// MARK: SignUpViewControllerDelegate
extension AuthenticateViewController {
  func signUpDetailsEntered(_ viewController: SignUpViewController,
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
  func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerAfter viewController: UIViewController) -> UIViewController? {
    var index = (viewController as! QuickViewController).index
    if (index == 1) {
      return nil
    }
    index = index! + 1
    return self.viewControllerAtIndex(index!)
  }
  
  func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerBefore viewController: UIViewController) -> UIViewController? {
    var index = (viewController as! QuickViewController).index
    if (index == 0) {
      return nil
    }
    index = index! + 1
    return self.viewControllerAtIndex(index!)
  }
  
  func presentationCount(for pageViewController: UIPageViewController) -> Int {
    return 2
  }
  func presentationIndex(for pageViewController: UIPageViewController) -> Int {
    return 0
  }
}



