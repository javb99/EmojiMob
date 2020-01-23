//
//  ViewController.swift
//  EmojiMob
//
//  Created by Joseph Van Boxtel on 1/22/20.
//  Copyright © 2020 Joseph Van Boxtel. All rights reserved.
//

import UIKit

typealias Completion<T> = (Result<T, Error>) -> Void
typealias EmojiProvider = (@escaping Completion<[Emoji]>) -> Void

class ViewController: UICollectionViewController {
    internal init(getEmoji: @escaping EmojiProvider) {
        self.getEmoji = getEmoji
        super.init(collectionViewLayout: Self.createLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum Section: String {
        case emojis
    }
    
    static func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    var getEmoji: EmojiProvider
    lazy var dataSource = UICollectionViewDiffableDataSource<Section, Emoji>.init(collectionView: self.collectionView, cellProvider: self.cellForEmoji)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.register(UINib(nibName: "EmojiCell", bundle: nil), forCellWithReuseIdentifier: "EmojiCell")
        self.getEmoji{ result in
            switch (result) {
            case let .success(emojis):
                self.update(with: emojis)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func update(with emojis: [Emoji]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Emoji>()
        snapshot.appendSections([.emojis])
        snapshot.appendItems(emojis)
        dataSource.apply(snapshot)
    }
    
    func cellForEmoji(collectionView: UICollectionView, indexPath: IndexPath, emoji: Emoji) -> UICollectionViewCell? {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiCell", for: indexPath) as? EmojiCell
        
        cell?.emojiLabel.text = emoji.character
        
        return cell
    }
}

