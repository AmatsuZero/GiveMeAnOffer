//
// Created by daubert on 19-6-13.
//

import Foundation

@discardableResult
@available(iOS, unavailable)
func shell(_ args: String...) -> (code: Int32, output: String?) {
    let task = Process()
    task.launchPath = "/usr/bin/env"
    task.arguments = args
    task.waitUntilExit()

    let pipe = Pipe()
    task.standardOutput = pipe

    task.launch()
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)
    // 如果任务还在进行， Pending
    while task.isRunning {
        print("Shell Task: \(args.joined(separator: " ")) is Executing!")
    }
    return (task.terminationStatus, output)
}
