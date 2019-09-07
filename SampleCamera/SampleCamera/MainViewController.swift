//
//  MainViewController.swift
//  SampleCamera
//
//  Created by Hidehiko Matsuda on 2019/09/06.
//  Copyright © 2019 Hidehiko Matsuda. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, FilterListViewcontrollerDelegate {
    
    var selectedIndex: Int = 0//選択したフィルターの順番を保持しておく変数
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    var myImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCameraBottunTapped(_ sender: Any) {
        let controller: UIAlertController = UIAlertController(title: "", message: "どの方法で写真を読み込みますか？", preferredStyle: UIAlertController.Style.actionSheet)
        
        //一つ目の選択肢
        controller.addAction(UIAlertAction(title: "写真を撮影する", style: UIAlertAction.Style.default, handler: {(action) in self.selectedCamera()}))
        //二つ目の選択肢
        controller.addAction(UIAlertAction(title: "カメラロールから読みこむ", style: UIAlertAction.Style.default, handler: {(action) in self.selectedLibrary()}))
        //キャンセルボタンを用意。自動で追加されないので手動で追加する
        controller.addAction(UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: nil))
        //UIAlertControllerを表示する
        self.present(controller, animated: true, completion: nil)
        
    }
    @IBAction func onSaveBottunTapped(_ sender: Any) {
    }
    @IBAction func onEditBottunTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "MoveFilterListView", sender: nil)

    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 撮影、選択した写真が正しく取得できたかをチェック
        // UIImagePickerControllerOriginalImageで取得した写真を取り出せる
        if let editedImage: UIImage = info[.originalImage] as! UIImage {
            // UIImageViewに画像をセット
            myImageView.image = editedImage
            // オリジナルデータをセット
            myImage = editedImage
        }
        // 画像が正しく表示されるようであれば、注意書きを消す
        if myImageView.image != nil {
            myLabel.isHidden = true
        }
        // UIImagePickerControllerを閉じる
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func selectedCamera(){
        //カメラが使用できるかチェック
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            //UIImagePickerControllerのインスタンスを生成
            let picker:UIImagePickerController = UIImagePickerController()
            //カメラを起動する
            picker.sourceType = UIImagePickerController.SourceType.camera
            //UIImagePickerControllerDelegateを自身に設定
            picker.delegate = self
            // UIImagePickerController(カメラ画面)を表示
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    func selectedLibrary(){
        //写真のライブラリが読み込めるかどうかチェック
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            //UIImagePickerControllerのインスタンスを生成
            let picker: UIImagePickerController = UIImagePickerController()
            //ライブラリーから写真を読み込む
            picker.sourceType = UIImagePickerController.SourceType.photoLibrary
            //UIImagePickerControllerDelegateを自身に設定
            picker.delegate = self
            //UIImagePickerControllerを表示
            self.present(picker, animated: true, completion: nil)
        }
    }
    func filterListViewController(_ controller: FilterListViewController, didSelectFilter filter: String, index: Int) {
        //選択したフィルターの順番を保持しておく
        selectedIndex = index
    }
    //storuboardで設定した遷移時に実装されるメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //念のために識別子のチェック
        if segue.identifier == "MoveFilterListView"{
            //遷移先のFilterListViewControllerのインスタンスを取得
            let controller: FilterListViewController = segue.destination as! FilterListViewController
            
            //デリゲート先をMainViewControllerに指定
            controller.delegate = self
            
            //選択している番号を渡す
            controller.selectedIndex = selectedIndex
        }
    }
    


}
