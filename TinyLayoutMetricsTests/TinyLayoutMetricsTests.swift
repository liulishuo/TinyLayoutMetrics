//
//  TinyLayoutMetricsTests.swift
//  TinyLayoutMetricsTests
//
//  Created by lls on 2022/11/10.
//

import XCTest

final class TinyLayoutMetricsTests: XCTestCase {
    
    let view = UIView()
    let container = UIView()
    let scale_large = 10000
    let scale_mid = 1000
    let scale_small = 100

    override func setUpWithError() throws {
        
        container.addSubview(view)
        
        view.ty.makeConstraints { view, superView in
            view.leading == superView.leading + 15
            view.centerY == superView.centerY
            view.width == 100~100
            view.width == 32
            view.height == 32
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPerformance_tiny_update() throws {
        measure {
            for _ in 0...scale_large {
                view.ty.updateConstraints { view, superView in
                    view.leading == superView.leading + 150
                    view.centerY == superView.centerY
                    view.width == 1000~100
                    view.width == 320
                    view.height == 320
                }
            }
        }
    }
    
    func testPerformance_snapkit_update() throws {
        measure {
            for _ in 0...scale_large {
                view.snp.updateConstraints { maker in
                    maker.leading.equalToSuperview().offset(150)
                    maker.centerY.equalToSuperview()
                    maker.width.equalTo(1000).priority(100)
                    maker.width.equalTo(320)
                    maker.height.equalTo(320)
                }
            }
        }
    }


    func testPerformance_tiny_large() throws {
        measure {
            for _ in 0...scale_large {
                view.ty.remakeConstraints { view, superView in
                    view.leading == superView.leading + 15
                    view.centerY == superView.centerY
                    view.width == 100~100
                    view.width == 32
                    view.height == 32
                }
            }
        }
    }
    
    func testPerformance_tiny_mid() throws {
        measure {
            for _ in 0...scale_mid {
                view.ty.remakeConstraints { view, superView in
                    view.leading == superView.leading + 15
                    view.centerY == superView.centerY
                    view.width == 100~100
                    view.width == 32
                    view.height == 32
                }
            }
        }
    }
    
    func testPerformance_tiny_samll() throws {
        measure {
            for _ in 0...scale_small {
                view.ty.remakeConstraints { view, superView in
                    view.leading == superView.leading + 15
                    view.centerY == superView.centerY
                    view.width == 100~100
                    view.width == 32
                    view.height == 32
                }
            }
        }
    }
    
    func testPerformance_snapkit_large() throws {
        measure {
            for _ in 0...scale_large {
                view.snp.remakeConstraints { maker in
                    maker.leading.equalToSuperview().offset(15)
                    maker.centerY.equalToSuperview()
                    maker.width.equalTo(100).priority(100)
                    maker.width.equalTo(32)
                    maker.height.equalTo(32)
                }
            }
        }
    }
    
    func testPerformance_snapkit_mid() throws {
        measure {
            for _ in 0...scale_mid {
                view.snp.remakeConstraints { maker in
                    maker.leading.equalToSuperview().offset(15)
                    maker.centerY.equalToSuperview()
                    maker.width.equalTo(100).priority(100)
                    maker.width.equalTo(32)
                    maker.height.equalTo(32)
                }
            }
        }
    }
    
    func testPerformance_snapkit_small() throws {
        measure {
            for _ in 0...scale_small {
                view.snp.remakeConstraints { maker in
                    maker.leading.equalToSuperview().offset(15)
                    maker.centerY.equalToSuperview()
                    maker.width.equalTo(100).priority(100)
                    maker.width.equalTo(32)
                    maker.height.equalTo(32)
                }
            }
        }
    }
}
