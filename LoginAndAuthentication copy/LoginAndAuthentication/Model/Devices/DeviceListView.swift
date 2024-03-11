//
//  DeviceListView.swift
//  LoginAndAuthentication
//
//  Created by Takudzwa Zindoga on 8/3/2024.
//

import SwiftUI


struct DevicesListView: View {
    var devices: [Device]


    var body: some View {
        VStack(alignment: .leading) {
            Text("Devices")
                .font(.title)
            List(devices, id: \.name) { device in
                Text("\(device.name) - \(device.description) - \(device.status)")
            }
        }
    }

}
