

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var playerNameLbl: UILabel!
    @IBOutlet weak var playerScoreLbl: UILabel!
    @IBOutlet weak var playerTwoScoreLbl: UILabel!
    @IBOutlet weak var box1: UIImageView!
    @IBOutlet weak var box2: UIImageView!
    @IBOutlet weak var box3: UIImageView!
    @IBOutlet weak var box4: UIImageView!
    @IBOutlet weak var box5: UIImageView!
    @IBOutlet weak var box6: UIImageView!
    @IBOutlet weak var box7: UIImageView!
    @IBOutlet weak var box8: UIImageView!
    @IBOutlet weak var box9: UIImageView!
    
    var playerName: String!
    var playerTwoName: String!
    var lastValue = "o"
    
    // Skapar en tom array av [box] array
    var playerChoices: [Box] = []
    var playerTwoChoices: [Box] = []
    // Håller koll på den spelare som spelar
    var activePlayer = 1
    
    @IBOutlet weak var playerOneLabel: UILabel!
    @IBOutlet weak var playerTwoLabel: UILabel!
    
    @IBOutlet weak var winnerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTap(on: box1, type: .one)
        createTap(on: box2, type: .two)
        createTap(on: box3, type: .three)
        createTap(on: box4, type: .four)
        createTap(on: box5, type: .five)
        createTap(on: box6, type: .six)
        createTap(on: box7, type: .seven)
        createTap(on: box8, type: .eight)
        createTap(on: box9, type: .nine)
    }
    
    func createTap(on imageView: UIImageView, type box: Box) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.boxClicked(_:)))
        tap.name = box.rawValue
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
    }
    
    
    @objc func boxClicked(_ sender: UITapGestureRecognizer) {
        let selectedBox = getBox(from: sender.name ?? "")
        if selectedBox.image == nil {
            if(activePlayer == 1) {
                playerTwoLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
                playerOneLabel.font = nil
                makeChoice(selectedBox)
                playerChoices.append(Box(rawValue: sender.name!)!)
                checkIfWon()
                activePlayer = 2
            } else {
                playerOneLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
                playerTwoLabel.font = nil
                makeChoice(selectedBox)
                playerTwoChoices.append(Box(rawValue: sender.name!)!)
                checkIfWon()
                activePlayer = 1
            }
        }
    }
    
    
    // När man gör ett val. Kollar vad sista värdet var och sätter det nya
    func makeChoice(_ selectedBox: UIImageView) {
        guard selectedBox.image == nil else { return }
        if lastValue == "x" {
            selectedBox.image = #imageLiteral(resourceName: "Add a heading (1)")
            lastValue = "o"
        } else {
            selectedBox.image = #imageLiteral(resourceName: "Add a heading")
            lastValue = "x"
        }
    }
    
    // Animation som visar vem som vann
    func animateWinnerLabel(name: String) {
        winnerLabel.text = name
        UIView.animate(withDuration: 0.5, animations: {self.winnerLabel.alpha = 1.0})
    }
    
    
    // Kollar vem som vann
    func checkIfWon() {
        var correct = [[Box]]()
        let firstRow: [Box] = [.one, .two, .three]
        let secondRow: [Box] = [.four, .five, .six]
        let thirdRow: [Box] = [.seven, .eight, .nine]
        
        let firstCol: [Box] = [.one, .four, .seven]
        let verticalCheck: [Box] = [.two, .five, .eight]
        let thirdCol: [Box] = [.three, .six, .nine]
        
        let backwardSlash: [Box] = [.one, .five, .nine]
        let forwardSlash: [Box] = [.three, .five, .seven]
        
        correct.append(firstRow)
        correct.append(secondRow)
        correct.append(thirdRow)
        correct.append(firstCol)
        correct.append(thirdCol)
        correct.append(verticalCheck)
        correct.append(backwardSlash)
        correct.append(forwardSlash)
        
        for valid in correct {
            let userOne = playerChoices.filter { valid.contains($0) }.count
            let userTwo = playerTwoChoices.filter { valid.contains($0) }.count
            if userOne == valid.count {
                playerScoreLbl.text = String((Int(playerScoreLbl.text ?? "0") ?? 0) + 1)
                animateWinnerLabel(name: "Player 1 won!")
                resetGame()
                break
            } else if userTwo == valid.count {
               playerTwoScoreLbl.text = String((Int(playerTwoScoreLbl.text ?? "0") ?? 0) + 1)
                animateWinnerLabel(name: "Player 2 won!")
                resetGame()
                break
            } else if playerTwoChoices.count + playerChoices.count == 9 {
                animateWinnerLabel(name: "Draw - play agin!")
                resetGame()
                break
           }
        }
        
    }
    
    // Startar om spelet
    func resetGame() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [self] in
            for name in Box.allCases {
                let box = getBox(from: name.rawValue)
                box.image = nil
            }
            winnerLabel.alpha = 0
            lastValue = "o"
            playerChoices = []
            playerTwoChoices = []
        }
    }
    
    // Kollar vilken box och sätter den till boxen
    func getBox(from name: String) -> UIImageView {
        let box = Box(rawValue: name) ?? .one
        
        switch box {
        case .one:
            return box1
        case .two:
            return box2
        case .three:
            return box3
        case .four:
            return box4
        case .five:
            return box5
        case .six:
            return box6
        case .seven:
            return box7
        case .eight:
            return box8
        case .nine:
            return box9
        }
    }
    
    @IBAction func closeBtnClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}


// Kan hitta alla värden med allCases
enum Box: String, CaseIterable {
    case one, two, three, four, five, six, seven, eight, nine
}
