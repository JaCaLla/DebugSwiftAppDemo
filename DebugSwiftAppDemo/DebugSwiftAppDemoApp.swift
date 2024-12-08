//
//  DebugSwiftAppDemoApp.swift
//  DebugSwiftAppDemo
//
//  Created by Javier Calatrava on 6/12/24.
//

import SwiftUI
#if DEBUG
    import DebugSwift
#endif

@main
struct DebugSwiftAppDemoApp: App {

    var body: some Scene {
        WindowGroup {
            CharacterView()
                .onAppear {
                #if DEBUG
                    setupDebugSwift()
                #endif
            }
            .onShake {
                #if DEBUG
                    DebugSwift.show()
                #endif
            }
        }
    }

    fileprivate func setupDebugSwift() {
        DebugSwift
            .setup()
        // MARK: - Custom Info

        DebugSwift.App.customInfo = {
            [
                    .init(
                    title: "Info 1",
                    infos: [
                            .init(title: "title 1", subtitle: "subtitle 1")
                    ]
                )
            ]
        }

        // MARK: - Custom Actions

        DebugSwift.App.customAction = {
            [
                    .init(
                    title: "Action 1",
                    actions: [
                            .init(title: "action 1") { // [weak self] in
                            print("Action 1")
                        }
                    ]
                )
            ]
        }

        // MARK: Leak Detector

        DebugSwift.Performance.LeakDetector.onDetect { data in
            // If you send data to some analytics
            print(data.message)
        }

        // MARK: - Custom Controllers

         DebugSwift.App.customControllers = {
             let controller1 = UITableViewController()
             controller1.title = "Custom TableVC 1"

             let controller2 = UITableViewController()
             controller2.title = "Custom TableVC 2"

             return [controller1, controller2]
         }

        // MARK: - Enable/Disable Debugger
        DebugSwift.Debugger.logEnable = true
        DebugSwift.Debugger.feedbackEnable = true
    }
}


/*
        // MARK: - Custom Info

        DebugSwift.App.customInfo = {
            [
                    .init(
                    title: "Info 1",
                    infos: [
                            .init(title: "title 1", subtitle: "subtitle 1")
                    ]
                )
            ]
        }

        // MARK: - Custom Actions

        DebugSwift.App.customAction = {
            [
                    .init(
                    title: "Action 1",
                    actions: [
                            .init(title: "action 1") { // [weak self] in
                            print("Action 1")
                        }
                    ]
                )
            ]
        }

        // MARK: Leak Detector

        DebugSwift.Performance.LeakDetector.onDetect { data in
            // If you send data to some analytics
            print(data.message)
        }

        // MARK: - Custom Controllers

        // DebugSwift.App.customControllers = {
        //     let controller1 = UITableViewController()
        //     controller1.title = "Custom TableVC 1"

        //     let controller2 = UITableViewController()
        //     controller2.title = "Custom TableVC 2"

        //     return [controller1, controller2]
        // }

        // MARK: - Customs

        // DebugSwift.Network.ignoredURLs = ["https://reqres.in/api/users/23"]
        // DebugSwift.Console.onlyLogs = ["DebugSwift"]
*/
