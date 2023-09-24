//
//  ViewController.swift
//  1st
//
//  Created by 정의찬 on 2023/09/23.
//

import UIKit
import SnapKit

struct Item {
    let image: UIImage
    let name: String
}

class ViewController: UIViewController {
    
    var items: [Item] = []
    var list = ["인기상품","신상품","특가","쌀.잡곡","화장지","생수.음료","즉석밥","통조림"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        collection.dataSource = self
        collection.delegate = self
        
        makeConst()
        
        for i in 0...7 {
                   if let image = UIImage(named: "photo\(i)") {
                       let name = list[i]
                       let item = Item(image: image, name: name)
                       items.append(item)
                   }
               }
    }
    
    //해결 완료
    private lazy var topView : TopUIView = {
        let view = TopUIView()
        return view
    }()
    
    //해결 완료
    private lazy var firstAdvertisement : TopAdvertiseView = {
        let first = TopAdvertiseView()
        first.layer.borderColor = UIColor.black.cgColor
        first.layer.borderWidth = 1
        first.layer.cornerRadius = 14
        return first
    }()

    //해결 완료
    private lazy var deliveryStack : DeliveryStackView = {
        let dstack = DeliveryStackView()
        return dstack
    }()
    
    // 흠 왜 안뜨지,,
    private lazy var collection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        
        collection.register(SortCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        return collection
    }()
    
    
    private lazy var bottomView : UIView = {
          let view = UIView()
          view.layer.cornerRadius = 5
          view.layer.borderColor = UIColor.black.cgColor
          view.layer.borderWidth = 1
          return view
      }()
      
      private lazy var bottomCouponView : UIImageView = {
          let bview = UIImageView()
          let image = UIImage(named: "adver.jpeg")

          bview.image = image
          bview.contentMode = .scaleToFill
          
          bview.layer.borderColor = UIColor.black.cgColor
          bview.clipsToBounds = true
          bview.layer.cornerRadius = 10
          bview.layer.borderWidth = 1
          
          return bview
      }()
      
      func makeConst(){
          [topView, firstAdvertisement, deliveryStack, bottomView, bottomCouponView].forEach{ self.view.addSubview($0) }
          
          topView.snp.makeConstraints { (make) -> Void in
              make.top.left.right.equalToSuperview()
          }
          
          firstAdvertisement.snp.makeConstraints{ (make) -> Void in
              make.top.equalTo(topView.snp.bottom).offset(10)
              make.left.equalTo(self.view.safeAreaLayoutGuide).offset(15)
              make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-15)
              make.height.equalTo(60)
          }
          
          deliveryStack.snp.makeConstraints{ (make) -> Void in
              make.top.equalTo(firstAdvertisement.snp.bottom).offset(15)
              make.left.equalTo(self.view.safeAreaLayoutGuide).offset(15)
              make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-15)
          }
          
          bottomView.snp.makeConstraints{ (make) -> Void in
              make.top.equalTo(deliveryStack.snp.bottom).offset(15)
              make.left.equalTo(self.view.safeAreaLayoutGuide).offset(15)
              make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-15)
              make.height.equalTo(200)
          }
          
      //    bottomView.addSubview(collection)
       
          bottomCouponView.snp.makeConstraints{ (make) -> Void in
              make.centerX.equalToSuperview()
              make.height.lessThanOrEqualTo(100)
              make.left.equalTo(self.view.safeAreaLayoutGuide).offset(15)
              make.top.equalTo(bottomView.snp.bottom).offset(15)
          }
        
          
          
      }
  }

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SortCollectionViewCell

        if indexPath.item < items.count {
            
            let item = items[indexPath.item]
            cell.configuration(image: item.image, name: item.name)
        } else {
            
            cell.configuration(image: nil, name: "Invalid Item")
        }

        return cell
    }
}
