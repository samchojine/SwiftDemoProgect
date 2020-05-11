//
//  HomeNaviColor1VC.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/5/11.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit

class HomeNaviColor1VC: PJBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "与导航栏不同颜色"
    }
    
     override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.barTintColor = UIColor.red
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController!.navigationBar.tintColor = .white;
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.barTintColor = .white
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
