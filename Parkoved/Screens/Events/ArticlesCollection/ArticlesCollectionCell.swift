//
//  ArticlesCollectionCell.swift
//  Parkoved
//
//  Created by Sergey Kotov on 26.09.2020.
//

import UIKit

class ArticlesCollectionCell: UITableViewCell {

    @IBOutlet weak var articlesCollection: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupArticlesCollection()
    }
}

extension ArticlesCollectionCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func setupArticlesCollection() {
        articlesCollection.delegate = self
        articlesCollection.dataSource = self
        articlesCollection.register(UINib(nibName: "ArticleCell", bundle: nil), forCellWithReuseIdentifier: "ArticleCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        cell.articleImage.image = indexPath.row % 2 == 0 ? UIImage(named: "articleCircleImage") : UIImage(named: "articlePlaceImage")
        cell.articleTitleLabel.text = indexPath.row % 2 == 0 ? "5 мест, куда\nсходить с девушкой" : "“Цед-Зип” - первое колесо обозрения в городе"
        return cell
    }
}
