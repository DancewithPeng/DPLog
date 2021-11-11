// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DPLog",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "DPLog",
            targets: ["DPLog", "DPLog-ObjC"]),
//        .library(
//            name: "DPLogObjC",
//            targets: ["DPLog-ObjC"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "DPLog",
            dependencies: [],
            path: "DPLog/Sources",
            exclude: [
                "ObjC",
                "Info.plist",
                "DPLog.h"
            ]
        ),
        .target(
            name: "DPLog-ObjC",
            dependencies: [
                "DPLog"
            ],
            path: "DPLog/Sources/ObjC"
        ),
        .testTarget(
            name: "DPLogTests",
            dependencies: [
                "DPLog"
            ],
            path: "DPLogTests",
            exclude: [
                "Info.plist"
            ]
        ),
        .testTarget(
            name: "DPLogObjCTests",
            dependencies: [
                "DPLog-ObjC"
            ],
            path: "DPLogObjCTests"
        ),
    ]
)
