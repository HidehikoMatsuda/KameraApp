//
//  FirstListTableViewController.swift
//  SampleCamera
//
//  Created by Hidehiko Matsuda on 2019/09/06.
//  Copyright © 2019 Hidehiko Matsuda. All rights reserved.
//

import UIKit

protocol FilterListViewControllerDelegate: class {
    func filterListViewController(_ controller: FilterListViewController, didSelectFilter filter:String, index: Int)
}


class FilterListViewController: UITableViewController {
    
    let filterList:[String] = ["", "CIPhotoEffectChrome", "CIPhotoEffectFade", "CIPhotoEffectInstant", "CIPhotoEffectMono", "CIPhotoEffectNoir", "CIPhotoEffectProcess", "CIPhotoEffectTonal", "CIPhotoEffectTransfer", "CISepiaTone", "CIVignette",]
    
    weak var delegate: FilterListViewControllerDelegate? = nil
    //デリゲート先を保存しておく変数
    var selectedIndex: Int = 0 //選択済みの番号を記録しておく変数
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    //UITableViewのセクションの数を設定
    override func numberOfSections(in tableView: UITableView) -> Int {
        //セクションは一つ
        return 1
    }
    //セクション内のセル数の設定
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //フィルターの配列に格納されている数（フィルター１０個）を表示する
        return filterList.count
    }
    
    //表示するUITableViewCellの設定
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //表示するUITableViewCellは識別子「”Cell”」で設定
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //フィルター名を取得
        var filterName = filterList[indexPath.row]
        
        //フィルター名が空の時は「”No Effect”」と表示させる
        if filterName.isEmpty {
            filterName = "No Effect"
        }
        
        //セルにフィルター名を記載
        cell.textLabel?.text = filterName
        
        //チェックを一旦消す
        cell.accessoryType = UITableViewCell.AccessoryType.none
        //選択された番号であればチェックを表示する
        if indexPath.row == selectedIndex{
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        
        //設定したセルを返す
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //デリゲート先が正しく設定されているかのnilチェック
        if let myDelegate = delegate{
            //設定されていたら、各情報を引数に渡してデリゲートメソッドを実行
            myDelegate.filterListViewController(self, didSelectFilter: filterList[indexPath.row], index: indexPath.row)
        }
        
        
        //前の画面に戻る
        self.navigationController?.popViewController(animated: true)
    }
    
}
