//
//  ViewController.swift
//  BankApp
//
//  Created by Vlad Kulakovsky  on 17.01.23.
//

import UIKit
import GoogleMaps

//@IBOutlet weak var mapView: GMSMapView!
//var locationManager = CLLocationManager()
//
//class YourControllerClass: UIViewController,CLLocationManagerDelegate {
//
//    //Your map initiation code
//    let mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
//    self.view = mapView
//    self.mapView?.myLocationEnabled = true
//
//    //Location Manager code to fetch current location
//    self.locationManager.delegate = self
//    self.locationManager.startUpdatingLocation()
//}
//
//
////Location Manager delegates


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
            //self.drawMarkers(array: self.filials)
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
        AtmProvider().getCurrency(city: city) { atmsArr in
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
    
    private func drawMarkers(filials: [FiliasModel]) {
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
        
        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()
        
    }
}
