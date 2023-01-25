//
//  RequestHistoryCell.swift
//  BankApp
//
//  Created by Vlad Kulakovsky  on 25.01.23.
//

import UIKit

class RequestHistoryCell: UITableViewCell {
    static let id = String(describing: RequestHistoryCell.self)
    
    @IBOutlet weak var cellLabelREquestType: UILabel!
    @IBOutlet weak var cellLabelRequestTime: UILabel!
    @IBOutlet weak var cellLabelRequestStatusCode: UILabel!
    
    private(set) var requestModel = RealmRequestHistoryModel()
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(request: RealmRequestHistoryModel) {
        self.requestModel = request
        setupCell()
    }
    
    private func formatData(timeStamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timeStamp))

        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        dayTimePeriodFormatter.locale = .current
        let dateString = dayTimePeriodFormatter.string(from: date)
        
        return dateString
    }
    
    private func setupCell() {
        cellLabelREquestType.text = "Тип запроса: \(requestModel.requestType)"
        cellLabelRequestTime.text = "Время запроса \(formatData(timeStamp: requestModel.requestTimeStamp))"
        cellLabelRequestStatusCode.text = "Статус код ответа: \(requestModel.requestCodeAnswer)"
    }
}
