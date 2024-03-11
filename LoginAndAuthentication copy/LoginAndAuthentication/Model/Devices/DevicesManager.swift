//
//  DevicesManager.swift
//  LoginAndAuthentication
//
//  Created by Takudzwa Zindoga on 8/3/2024.
//

import SwiftUI

struct Device: Identifiable {
    let id = UUID()
    var name: String
    var description: String
    var status: String // Status: "Working", "Broken"
}

struct BrokenDevice: Identifiable {
    let id = UUID()
    var deviceName: String
    var facilitatorName: String
}



class DeviceManager: ObservableObject {
    @Published var devices = [Device]()
    @Published var brokenDevices = [BrokenDevice(deviceName: "", facilitatorName: "")]

    func addDevice(name: String, description: String, status: String) {
        let newDevice = Device(name: name, description: description, status: status)
        devices.append(newDevice)
    }

}
