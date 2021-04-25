//
//  Logger.swift
//  AppLifecycle
//
//  Created by swamnx on 24.04.21.
//

import Foundation

class Logger {

    var path: URL

    init(path: URL) {
        self.path = path
    }

    func write(logData: String) {
        do {
            if FileManager.default.fileExists(atPath: path.relativePath) {
                if let fileHandle = try? FileHandle(forWritingTo: path) {
                    fileHandle.seekToEndOfFile()
                    fileHandle.write((logData).data(using: .utf8)!)
                    fileHandle.closeFile()
                }
            } else {
                try logData.write(to: path, atomically: true, encoding: .utf8)
            }
        } catch {

        }
    }

    func readLogData() -> String? {
        do {
            return try String(contentsOf: path)
        } catch {

        }
        return nil
    }

    func amountOfSessionsAndDurationBasedOn(logData: String) -> (Int, String) {
        let logs = logData.split(separator: "\n")
        var duration = TimeInterval.init()
        for log in logs {
            let logParts = log.components(separatedBy: ["=", ";"])
            let startDate = AppUtils.shared.dateFormatter.date(from: logParts[1])
            let endDate = AppUtils.shared.dateFormatter.date(from: logParts[2])
            duration += DateInterval(start: startDate!, end: endDate!).duration
        }
        return (logs.count, AppUtils.shared.formatedInterval(duration))
    }
}
