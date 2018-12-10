//  QuestionSetCollectionViewController.swift
//  Study App iOS
//
//  Created by Solomon Kieffer on 12/5/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.

import UIKit

class QuestionSetCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var CollectionView: UICollectionView!
    var selectedStyle: QuestionSet.Style?
    var sender: UIViewController?
    
    var newQuestionSet: ((QuestionSet) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return StorageEnclave.Access.getQuestionSetCount(ofStyle: selectedStyle!)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let IDs = StorageEnclave.Access.getQuestionSetIndices(ofStyle: selectedStyle!)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! QuestionSetCollectionViewCell
        
        let index = IDs[((indexPath.section + 1) * 2) - (2 - indexPath.row)]
        cell.QSID = index
        cell.QSTitle.text = StorageEnclave.Access.getQuestionSet(at: index)?.title
        cell.QSDescription.text = StorageEnclave.Access.getQuestionSet(at: index)?.details
        if cell.QSDescription.text == "" {
            cell.QSDescription.text = "No Description"
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = collectionView.cellForItem(at: indexPath) as! QuestionSetCollectionViewCell
        self.dismiss(animated: true) {
            self.newQuestionSet!(StorageEnclave.Access.getQuestionSet(at: item.QSID)!)
            StorageEnclave.Access.setDefault(for: self.selectedStyle!, to: item.QSID)
        }
    }
    @IBAction func cancleUpdate(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
