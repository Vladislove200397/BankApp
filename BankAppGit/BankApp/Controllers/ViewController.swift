//
//  ViewController.swift
//  BankApp
//
//  Created by Vlad Kulakovsky  on 17.01.23.
//

import UIKit
import GoogleMaps

enum CellKeys: String, CaseIterable {
    case atms = "Банкоматы"
    case filials = "Отделения"
    case all = "Без фильтра"
}

class ViewController: UIViewController {
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var cityCollectionView: UICollectionView!
    @IBOutlet weak var modeCollectionView: UICollectionView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var citys: [String] = []
    var filials: [FiliasModel] = []
    var atms: [AtmModel] = []
    var markers: [GMSMarker] = []
    var types = CellKeys.allCases
    var city = ""
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCitys()
        getAtms()
        registerCell()
        self.cityCollectionView.dataSource = self
        self.cityCollectionView.delegate = self
        self.modeCollectionView.dataSource = self
        self.modeCollectionView.delegate = self
        self.mapView.isMyLocationEnabled = true
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
    }
    
    private func getCitys() {
        self.spinner.startAnimating()
        AtmProvider().getFilials(city: city) { filialsArr in
            self.filials = filialsArr
            self.citys = Array(Set(filialsArr.map({$0.city })))
            self.cityCollectionView.reloadData()
            self.spinner.stopAnimating()
        } failure: { error in
            print(error)
        }
    }
    
    private func getAtms(city: String? = nil) {
        self.spinner.startAnimating()
        self.mapView.clear()
        AtmProvider().getCurrency(city: city) { [self] atmsArr in
            self.atms = atmsArr
            self.spinner.stopAnimating()
            self.drawMarkers(atms: self.atms)
        } failure: { error in
            print(error)
        }
        self.spinner.stopAnimating()
    }
    
    private func registerCell() {
        let nib = UINib(nibName: CityCell.id, bundle: nil)
        self.cityCollectionView.register(nib, forCellWithReuseIdentifier: CityCell.id)
        self.modeCollectionView.register(nib, forCellWithReuseIdentifier: CityCell.id)
    }
    
    private func getFilials(city: String? = nil) {
        self.spinner.startAnimating()
        self.mapView.clear()
        AtmProvider().getFilials(city: city) { filialsArr in
            self.filials = filialsArr
            self.drawMarkers(filials: self.filials)
        } failure: { error in
            print(error)
        }
        
        self.spinner.stopAnimating()
    }
    
//    private func drawMarkers(filials: [FiliasModel]) {
//        filials.forEach { filial in
//            let marker =
//            GMSMarker(position: CLLocationCoordinate2D(
//                latitude: Double(filial.latitude)! ,
//                longitude: Double(filial.longitude)!))
//
//            marker.userData = filials
//            marker.map = mapView
//            markers.append(marker)
//        }
//    }
        
    private func drawMarkerForFilial(filial: FiliasModel) {
            let marker =
            GMSMarker(position: CLLocationCoordinate2D(
                latitude: Double(filial.latitude)! ,
                longitude: Double(filial.longitude)!))
            
            marker.userData = filial
            marker.map = mapView
            markers.append(marker)
        }
    
    private func drawMarkerForAtms(atm: AtmModel) {
        let marker =
        GMSMarker(position: CLLocationCoordinate2D(
            latitude: Double(atm.latitude)! ,
            longitude: Double(atm.longitude)!))
        
        marker.userData = atm
        marker.map = mapView
        markers.append(marker)
    }
    
    private func drawMarkers(atms: [AtmModel]? = nil, filials: [FiliasModel]? = nil) {
        if let atms {
            atms.forEach { atm in
                let marker =
                GMSMarker(position: CLLocationCoordinate2D(
                    latitude: Double(atm.latitude)!,
                    longitude: Double(atm.longitude)!))
                
                marker.userData = atm
                marker.map = mapView
                markers.append(marker)
            }
        }
        
        if let filials {
            filials.forEach { filial in
                let marker =
                GMSMarker(position: CLLocationCoordinate2D(
                    latitude: Double(filial.latitude)! ,
                    longitude: Double(filial.longitude)!))
                
                marker.userData = filials
                marker.map = mapView
                markers.append(marker)
            }
        }
    }
    
    private func drawCircle() {
        if let myLocation = locationManager.location?.coordinate {
            let circle = GMSCircle(position: myLocation, radius: 5000)
            let color = UIColor(red: 40/255, green: 131/255, blue: 217/255, alpha: 0.2)
            circle.strokeColor = color.withAlphaComponent(0.5)
            circle.fillColor = color
            circle.map = mapView
        }
    }
    private func distance(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> CLLocationDistance {
            let from = CLLocation(latitude: from.latitude, longitude: from.longitude)
            let to = CLLocation(latitude: to.latitude, longitude: to.longitude)
            return from.distance(from: to)
        }
    
    private func calculate() {
        guard  let myPosition = mapView.myLocation?.coordinate else { return }
        self.mapView.clear()
        drawCircle()
        self.filials.forEach { filial in
            let lat = Double(filial.latitude)
            let lon = Double(filial.longitude)
            let distance = distance(from: myPosition, to: CLLocationCoordinate2D(latitude: lat!, longitude: lon!)) <= 5000
            print(distance)
            if distance {
                drawMarkerForFilial(filial: filial)
            }
        }
        
        self.atms.forEach { atm in
            let lat = Double(atm.latitude)
            let lon = Double(atm.longitude)
            let distance = distance(from: myPosition, to: CLLocationCoordinate2D(latitude: lat!, longitude: lon!)) <= 5000
            print(distance)
            if distance {
                drawMarkerForAtms(atm: atm)
            }
        }
    }
    
    @IBAction func drawCircleDidTap(_ sender: Any) {
        self.mapView.clear()
        
        calculate()
    }
    
    @IBAction func clearMapButtonDidTap(_ sender: Any) {
        self.mapView.clear()
    }
    
}



extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.cityCollectionView {
            return citys.count
        } else {
            return types.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.cityCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCell.id, for: indexPath)
            (cell as? CityCell)?.cellCityLabel.text = citys[indexPath.row]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCell.id, for: indexPath)
            
            (cell as? CityCell)?.cellCityLabel.text = types[indexPath.row].rawValue
            (cell as? CityCell)?.set(type: types[indexPath.row])
            return cell
        }
    }
    
    
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if collectionView == self.cityCollectionView {
            guard let cell = collectionView.cellForItem(at: indexPath) as? CityCell else { return }
            self.city = cell.cellCityLabel.text!
        } else {
            guard let cell = collectionView.cellForItem(at: indexPath) as? CityCell else { return }
            switch cell.type {
                case .atms:
                    getAtms(city: self.city)
                case .filials:
                    getFilials(city: self.city)
                case .all:
                    getAtms()
                    getFilials()
            }
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        
        self.mapView?.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
    }
}
