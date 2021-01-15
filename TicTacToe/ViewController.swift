
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var cardView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    func setupUI() {
        startBtn.layer.cornerRadius = 10
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowOpacity = 0.4
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowRadius = 10
        cardView.layer.shadowOffset = .zero
    }
    
    @IBAction func startBtnClicked(_ sender: UIButton) {
        let controller = storyboard?.instantiateViewController(identifier: "gameScene") as! GameViewController
        controller.modalTransitionStyle = .flipHorizontal
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
    }
    
}

