//
//  AppUtils.swift
//  AppLifecycle
//
//  Created by swamnx on 20.04.21.
//

import Foundation

class AppUtils {

    static var shared: AppUtils = {
          let instance = AppUtils()
          return instance
      }()

    let dateFormatter: DateFormatter
    let dateComponentsFormatter: DateComponentsFormatter
    let sessionHistoryLogger: Logger

    private init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.allowedUnits = [.day, .hour, .minute, .second]
        dateComponentsFormatter.unitsStyle = .full
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let logDataPath = documentsPath.appendingPathComponent("logData.txt")
        sessionHistoryLogger = Logger(path: logDataPath)
    }

    func sessionTextBetween(_ start: Date, _ end: Date) -> String {
        return "log=\(formatedDate(start));\(formatedDate(end))\n"
    }

    func formatedDate(_ date: Date) -> String {
        return dateFormatter.string(from: date)
    }

    func formatedInterval(_ interval: TimeInterval) -> String {
        return dateComponentsFormatter.string(from: interval)!
    }

    func printStartDateAndDuration(_ start: Date, _ end: Date) {
        let sessionInterval = DateInterval(start: start, end: end).duration
        print(formatedDate(start), " ", formatedInterval(sessionInterval))
    }

}
