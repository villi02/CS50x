
import UIKit
import Firebase
import FirebaseDatabaseSwift

class StartScreenViewController: UIViewController {

    
    @IBOutlet weak var logInnButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        //super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements() {
        view.backgroundColor = .systemRed
        testStockAPI(symbol: "AAPL")
        view.backgroundColor = .systemPink
        print(User.portfolio)
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("users").child("buUuCUD0gsJgzfthVmXM").observeSingleEvent(of: .value, with: {(snapshot) in
            print(snapshot.value as! [String: AnyObject])
        })
        
       // self.ref.child("users").child()
    }
  

}
