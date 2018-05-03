import FirebaseDatabase

class ShortShirtViewController: UIViewController, UICollectionViewDataSource {
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadImages()
    }
    
    func loadImages(){
        images.append(UIImage(named: "tshirt.png"))
        images.append(UIImage(named: "tshirt.png"))
        images.append(UIImage(named: "tshirt.png"))
        images.append(UIImage(named: "tshirt.png"))
        
        self.imageCollection.reloadData()
    }
    
    @IBAction func onXOut(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for:indexPath) as! PicsCollectionViewCell
        let image = images[indexPath.row]
        cell.imageView.image = image
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
}
