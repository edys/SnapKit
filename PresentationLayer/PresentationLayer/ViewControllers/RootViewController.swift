//
//  RootViewController.swift
//  PresentationLayer
//
//  Created by Rhys Walden on 15/05/21.
//

import Foundation
import UIKit
import SnapKit
import ReSwift
import BusinessLayer

public class RootViewController : UIViewController{
    
    let loadingCellName = "LoadingCell"
    
    let errorCellName = "ErrorCell"
    
    let imageCellName = "ImageCell"
    
    let appStore:Store<AppState>
    
    let loadImageThunk: ThunkProtocol
    
    let imageCache: ImageCacheProtocol
    
    public init(
        appStore: Store<AppState>,
        loadImageThunk: ThunkProtocol,
        imageCache: ImageCacheProtocol)
    {
        self.appStore = appStore
        self.loadImageThunk = loadImageThunk
        self.imageCache = imageCache
        
        super.init(nibName: nil, bundle: nil)
    }
    
    fileprivate weak var listView:UITableView!
    
    weak var loadImageButton:UIButton!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func registerCells() {
        listView.register(LoadingCell.self, forCellReuseIdentifier: loadingCellName)
        listView.register(ErrorCell.self, forCellReuseIdentifier: errorCellName)
        listView.register(ImageCell.self, forCellReuseIdentifier: imageCellName)
    }
    
    override public func loadView() {

        self.view = UIView()

        listView = UITableView()
            .addTo(view)
        
        listView.separatorStyle = .none
        listView.delegate = self
        listView.dataSource = self
        listView.estimatedRowHeight = UITableView.automaticDimension
        listView.allowsSelection = false
        
        registerCells()

        listView.snp.makeConstraints({[unowned self] (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leadingMargin)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailingMargin)
        })
        
        loadImageButton = UIButton().addTo(view)
        
        loadImageButton.setTitle("Load another image", for: .normal)
        loadImageButton.backgroundColor = UIColor.systemGreen
        loadImageButton.addTarget(self, action: #selector(loadAnotherImage), for: .touchUpInside)
        
        loadImageButton.snp.makeConstraints({[unowned self] (make) in
            make.top.equalTo(listView.snp.bottomMargin)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leadingMargin)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailingMargin)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin)
        })
        
        title = "Ramdom Image Downlaoder" // TODO -  Localise string
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(edit))
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        appStore.subscribe(self) { subcription in
            subcription.select { $0.images }
        }
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        appStore.unsubscribe(self)
    }
    
    @objc func loadAnotherImage()
    {
        self.appStore.dispatch(self.loadImageThunk.action())
    }
    
    @objc func edit()
    {
        listView.isEditing = !listView.isEditing
    }
    
}
extension RootViewController: UITableViewDelegate
{
    public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        switch appStore.state.images[indexPath.row] {
        case .error:
            fallthrough
        case .loading:
            return .none
        default:
            return .delete
        }
    }
    
    public func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        switch appStore.state.images[indexPath.row] {
        case .error:
            fallthrough
        case .loading:
            return false
        default:
            return true
        }
    }
    
    public  func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        switch appStore.state.images[indexPath.row] {
        case .error:
            fallthrough
        case .loading:
            return false
        default:
            return true
        }
    }
    
    public func tableView(_ tableView: UITableView,
                     commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        
        let action = DeleteImageAction(index: indexPath.row)

        self.appStore.dispatch(action)
    }
    
    
    public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        guard  sourceIndexPath.row != destinationIndexPath.row else {
            return
        }
        
        let action = ReorderImageAction(sourceIndex:sourceIndexPath.row, destinationIndex: destinationIndexPath.row)

        self.appStore.dispatch(action)
    }
}

extension RootViewController: UITableViewDataSource
{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appStore.state.images.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let imageState = appStore.state.images[indexPath.row]
        
        switch imageState {
        
        case .loaded(loadedState: let lis):
            let cell = tableView.dequeueReusableCell(withIdentifier: imageCellName) as! ImageCell
            cell.authourLabel.text = lis.author
            imageCache.load(url: NSURL(string: lis.download_url)!) {[weak self] (url, image) in
                self?.UpdateCellForImage(url: url,image: image)
            }
            return cell
                
        case .loading:
            let cell = tableView.dequeueReusableCell(withIdentifier: loadingCellName) as! LoadingCell
            cell.progress.startAnimating()
            return cell
        
        default:
            return tableView.dequeueReusableCell(withIdentifier: errorCellName)!
        }
    }
    
    private func UpdateCellForImage(url:NSURL,image:UIImage?)
    {
        guard image != nil else {
            return
        }
        
        for index in 0..<appStore.state.images.count {
            if case let ImageState.loaded(loadedState: lis) = appStore.state.images[index] {
                if lis.download_url == url.absoluteString {
                    if let cell = listView.cellForRow(at: IndexPath(row: index, section: 1)) as? ImageCell {
                        cell.downLoadedImageView.image = image
                    }
                }
            }
        }
    }
}


extension RootViewController: StoreSubscriber
{
    public typealias StoreSubscriberStateType = [ImageState]
    
    /// Update UI with when image state changes
    public func newState(state: StoreSubscriberStateType) {
        
        DispatchQueue.main.async { [unowned self] in
            self.listView.reloadData()
        }
    }
}
