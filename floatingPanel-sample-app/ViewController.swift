//
//  ViewController.swift
//  floatingPanel-sample-app
//
//  Created by riku on 2021/05/12.
//

import UIKit
import FloatingPanel

class ViewController: UIViewController {
    
    var fpc = FloatingPanelController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fpc.delegate = self
    }

    @IBAction func tappedBtn(_ sender: Any) {
        // 半モーダル(tip)から下フリックでモーダルを閉じる
        fpc.isRemovalInteractionEnabled = true
        
        // モーダルを角丸にする
        let appearance = SurfaceAppearance()
        appearance.cornerRadius = 9.0
        fpc.surfaceView.appearance = appearance
        
        // 半モーダルにtableviewをセットする
        let tableView = self.storyboard?.instantiateViewController(withIdentifier: "tableview") as? TableViewController
        fpc.set(contentViewController: tableView)
        
        // 半モーダルを表示する
        fpc.addPanel(toParent: self)
    }
}

extension ViewController: FloatingPanelControllerDelegate {
    // カスタム半モーダル
    func floatingPanel(_ fpc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout {
        return LandscapePanelLayout()
    }
}

class LandscapePanelLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .tip
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            // 全モーダル時のレイアウト
            .full: FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea),
            // ハンモーダル時のレイアウト
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 130.0, edge: .bottom, referenceGuide: .safeArea),
        ]
    }
    // モーダルの横幅をカスタマイズ
//    func prepareLayout(surfaceView: UIView, in view: UIView) -> [NSLayoutConstraint] {
//        return [
//            surfaceView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 8.0),
//            surfaceView.widthAnchor.constraint(equalToConstant: 291),
//        ]
//    }
}

