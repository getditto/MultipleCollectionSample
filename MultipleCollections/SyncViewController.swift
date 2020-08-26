import UIKit

final class SyncViewController: UIViewController {
    @IBOutlet private weak var countUpAButton: UIButton! {
        didSet {
            countUpAButton.layer.cornerRadius = 8
        }
    }
    @IBOutlet private weak var countUpBButton: UIButton! {
        didSet {
            countUpBButton.layer.cornerRadius = 8
        }
    }
    @IBOutlet private weak var countALabel: UILabel!
    @IBOutlet private weak var countBLabel: UILabel!

    @IBAction func changeAStatus(_ sender: UISwitch) {
        sender.isOn ? dittoHandler.observe(type: .A) : dittoHandler.stop(type: .A)
    }
    @IBAction func changeBStatus(_ sender: UISwitch) {
        sender.isOn ? dittoHandler.observe(type: .B) : dittoHandler.stop(type: .B)
    }
    @IBAction func reset(_ sender: UIButton) {
        dittoHandler.reset()
    }

    private var dittoHandler: DittoHandlerType!

    override func viewDidLoad() {
        super.viewDidLoad()

        let didChangeCounts: ((DittoHandler.CollectionType, Int) -> Void) = { [weak self] type, count in
            guard let self = self else { return }
            switch type {
            case .A:
                self.countALabel.text = String(count)
            case .B:
                self.countBLabel.text = String(count)
            }
        }

        dittoHandler = DittoHandler(didChangeCounts: didChangeCounts)

        countUpAButton.addTarget(self, action: #selector(countUpA), for: .touchUpInside)
        countUpBButton.addTarget(self, action: #selector(countUpB), for: .touchUpInside)
    }

    @objc private func countUpA() {
        dittoHandler.countUp(type: .A)
    }

    @objc private func countUpB() {
        dittoHandler.countUp(type: .B)
    }
}

