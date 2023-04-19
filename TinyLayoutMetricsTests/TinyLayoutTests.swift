//
//  LayoutTests.swift
//  LayoutTests
//
//  Created by lls on 2022/11/2.
//

import XCTest

extension UIView {
    var test_constraints: [AnyObject] {
        return self.constraints.filter { $0.isActive }
    }
}

final class LayoutTests: XCTestCase {
    
    let view = UIView()
    let container = UIView()
    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
    }
    
    func testMakeConstraints() {
        let v1 = View()
        let v2 = View()
        self.container.addSubview(v1)
        self.container.addSubview(v2)
        
        v1.ty.makeConstraints { view, superView in
            view.top == v2.top + 50
            view.left == v2.top + 50
        }
        
        XCTAssertEqual(self.container.test_constraints.count, 2, "Should have 2 constraints installed")
        
        v2.ty.makeConstraints { view, superView in
            view.top == v1.top
            view.left == v1.left
            view.right == v1.right
            view.bottom == v1.bottom
        }
        
        XCTAssertEqual(self.container.test_constraints.count, 6, "Should have 6 constraints installed")
        
    }
    
    func testHorizontalVerticalEdges() {
        let v1 = View()
        self.container.addSubview(v1)
        
        v1.ty.makeConstraints { view, superView in
            view.top == superView.top
            view.bottom == superView.bottom
            view.left == superView.left
            view.right == superView.right
        }
        
        XCTAssertEqual(self.container.test_constraints.count, 4, "Should have 4 constraints installed")
        
        XCTAssertTrue(container.constraints.count == 4)
        XCTAssertTrue(container.constraints.allSatisfy { $0.firstItem === v1 && $0.secondItem === v1.superview })
        XCTAssertNotNil(container.constraints.first { $0.firstAttribute == .left && $0.secondAttribute == .left })
        XCTAssertNotNil(container.constraints.first { $0.firstAttribute == .right && $0.secondAttribute == .right })
        XCTAssertNotNil(container.constraints.first { $0.firstAttribute == .top && $0.secondAttribute == .top })
        XCTAssertNotNil(container.constraints.first { $0.firstAttribute == .bottom && $0.secondAttribute == .bottom })
    }
    
    func testHorizontalVerticalDirectionalEdges() {
        let v1 = View()
        self.container.addSubview(v1)
        
        v1.ty.makeConstraints { view, superView in
            view.top == superView.top
            view.bottom == superView.bottom
            view.leading == superView.leading
            view.trailing == superView.trailing
        }
        
        XCTAssertEqual(self.container.test_constraints.count, 4, "Should have 4 constraints installed")
        
        XCTAssertTrue(container.constraints.count == 4)
        XCTAssertTrue(container.constraints.allSatisfy { $0.firstItem === v1 && $0.secondItem === v1.superview })
        XCTAssertNotNil(container.constraints.first { $0.firstAttribute == .leading && $0.secondAttribute == .leading })
        XCTAssertNotNil(container.constraints.first { $0.firstAttribute == .trailing && $0.secondAttribute == .trailing })
        XCTAssertNotNil(container.constraints.first { $0.firstAttribute == .top && $0.secondAttribute == .top })
        XCTAssertNotNil(container.constraints.first { $0.firstAttribute == .bottom && $0.secondAttribute == .bottom })
    }
    
    func testGuideMakeConstraints() {
        guard #available(iOS 9.0, OSX 10.11, *) else { return }
        let v1 = View()
        
        let g1 = ConstraintLayoutGuide()
        self.container.addSubview(v1)
        self.container.addLayoutGuide(g1)
        
        v1.ty.makeConstraints { view, superView in
            view.top == g1.top + 50
            view.left == g1.top + 50
        }
        
        XCTAssertEqual(self.container.test_constraints.count, 2, "Should have 2 constraints installed")
        
        g1.ty.makeConstraints { guide, superView in
            guide.top == v1.top
            guide.left == v1.left
            guide.right == v1.right
            guide.bottom == v1.bottom
        }
        
        XCTAssertEqual(self.container.test_constraints.count, 6, "Should have 6 constraints installed")
    }
    
    func testMakeImpliedSuperviewConstraints() {
        let v1 = View()
        let v2 = View()
        self.container.addSubview(v1)
        self.container.addSubview(v2)
        
        v1.ty.makeConstraints { view, superView in
            view.top == superView.top + 50
            view.left == superView.left + 50
        }
        
        XCTAssertEqual(self.container.test_constraints.count, 2, "Should have 2 constraints installed")
        
        v2.ty.makeConstraints { view, superView in
            view.top == v1.top
            view.bottom == v1.bottom
            view.left == v1.left
            view.right == v1.right
        }
        
        XCTAssertEqual(self.container.test_constraints.count, 6, "Should have 6 constraints installed")
    }
    
    func testUpdateConstraints() {
        let v1 = View()
        let v2 = View()
        self.container.addSubview(v1)
        self.container.addSubview(v2)
        
        v1.ty.makeConstraints { view, superView in
            view.top == v2.top + 50
            view.left == v2.top + 50
        }
        
        XCTAssertEqual(self.container.test_constraints.count, 2, "Should have 2 constraints installed")
        
        v1.ty.updateConstraints { view, superView in
            view.top == v2.top + 15
        }
        
        XCTAssertEqual(self.container.test_constraints.count, 2, "Should still have 2 constraints installed")
        
    }
    
    func testRemakeConstraints() {
        let v1 = View()
        let v2 = View()
        self.container.addSubview(v1)
        self.container.addSubview(v2)
        
        v1.ty.makeConstraints { view, superView in
            view.top == v2.top + 50
            view.left == v2.left + 50
        }
        
        XCTAssertEqual(self.container.test_constraints.count, 2, "Should have 2 constraints installed")
        
        v1.ty.remakeConstraints { view, superView in
            view.top == v2.top
            view.left == v2.left
            view.right == v2.right
            view.bottom == v2.bottom
        }
        
        XCTAssertEqual(self.container.test_constraints.count, 4, "Should have 4 constraints installed")
        
    }
    
    func testRemoveConstraints() {
        let v1 = View()
        let v2 = View()
        self.container.addSubview(v1)
        self.container.addSubview(v2)
        
        v1.ty.makeConstraints { view, superView in
            view.top == v2.top + 50
            view.left == v2.left + 50
        }
        
        XCTAssertEqual(self.container.test_constraints.count, 2, "Should have 2 constraints installed")
        
        print(self.container.test_constraints)
        
        v1.ty.removeConstraints()
        
        print(self.container.test_constraints)
        
        XCTAssertEqual(self.container.test_constraints.count, 0, "Should have 0 constraints installed")
        
    }
    
    func testPrepareConstraints() {
        let v1 = View()
        let v2 = View()
        self.container.addSubview(v1)
        self.container.addSubview(v2)
        
        let constraints = [v1.top == v2.top, v1.bottom == v2.bottom, v1.left == v2.left, v1.right == v2.right]
        
        XCTAssertEqual(self.container.test_constraints.count, 0, "Should have 0 constraints installed")
        
        NSLayoutConstraint.activate(constraints)
        
        XCTAssertEqual(self.container.test_constraints.count, 4, "Should have 4 constraints installed")
        
        NSLayoutConstraint.deactivate(constraints)
        
        XCTAssertEqual(self.container.test_constraints.count, 0, "Should have 0 constraints installed")
        
    }
    
    func testReactivateConstraints() {
        let v1 = View()
        let v2 = View()
        self.container.addSubview(v1)
        self.container.addSubview(v2)
        
        let constraints = v1.snp.prepareConstraints { (make) -> Void in
            make.edges.equalTo(v2)
            return
        }
        
        
        XCTAssertEqual(self.container.test_constraints.count, 0, "Should have 0 constraints installed")
        
        for constraint in constraints {
            constraint.activate()
        }
        
        XCTAssertEqual(self.container.test_constraints.count, 4, "Should have 4 constraints installed")
        
        for constraint in constraints {
            constraint.deactivate()
        }
        
        XCTAssertEqual(self.container.test_constraints.count, 0, "Should have 0 constraints installed")
    }
    
    func testActivateDeactivateConstraints() {
        let v1 = View()
        let v2 = View()
        self.container.addSubview(v1)
        self.container.addSubview(v2)
        
        var c1: Constraint? = nil
        var c2: Constraint? = nil
        
        v1.snp.prepareConstraints { (make) -> Void in
            c1 = make.top.equalTo(v2.snp.top).offset(50).constraint
            c2 = make.left.equalTo(v2.snp.top).offset(50).constraint
            return
        }
        
        XCTAssertEqual(self.container.test_constraints.count, 0, "Should have 0 constraints")
        
        c1?.activate()
        c2?.activate()
        
        XCTAssertEqual(self.container.test_constraints.count, 2, "Should have 2 constraints")
        
        c1?.deactivate()
        c2?.deactivate()
        
        XCTAssertEqual(self.container.test_constraints.count, 0, "Should have 0 constraints")
        
        c1?.activate()
        c2?.activate()
        
        XCTAssertEqual(self.container.test_constraints.count, 2, "Should have 2 constraints")
        
    }
    
    func testSetIsActivatedConstraints() {
        let v1 = View()
        let v2 = View()
        self.container.addSubview(v1)
        self.container.addSubview(v2)
        
        let c1 = v1.top == v2.top + 50
        let c2 = v1.left == v2.top + 50
                
        XCTAssertEqual(self.container.test_constraints.count, 0, "Should have 0 constraints")
        
        c1.isActive = true
        c2.isActive = false
        
        XCTAssertEqual(self.container.test_constraints.count, 1, "Should have 1 constraint")

        c1.isActive = true
        c2.isActive = true
        
        XCTAssertEqual(self.container.test_constraints.count, 2, "Should have 2 constraints")

        c1.isActive = false
        c2.isActive = false
        
        XCTAssertEqual(self.container.test_constraints.count, 0, "Should have 0 constraints")
        
    }
    
    func testEdgeConstraints() {
        let view = View()
        self.container.addSubview(view)
        
        view.ty.makeConstraints { view, superView in
            view.top == superView.top + 50
            view.bottom == superView.bottom + 50
            view.left == superView.left + 50
            view.right == superView.right + 50
        }
        
        XCTAssertEqual(self.container.test_constraints.count, 4, "Should have 4 constraints")
        
        
        let constraints = self.container.test_constraints as! [NSLayoutConstraint]
        
        XCTAssertEqual(constraints[0].constant, 50, "Should be 50")
        XCTAssertEqual(constraints[1].constant, 50, "Should be 50")
        XCTAssertEqual(constraints[2].constant, 50, "Should be 50")
        XCTAssertEqual(constraints[3].constant, 50, "Should be 50")
    }
    
    func testUpdateReferencedConstraints() {
        let v1 = View()
        let v2 = View()
        self.container.addSubview(v1)
        self.container.addSubview(v2)
        
        var c1 = v1.top == v2.top + 50
        var c2 = v1.bottom == v2.bottom + 25
        NSLayoutConstraint.activate([c1, c2])
        
        XCTAssertEqual(self.container.test_constraints.count, 2, "Should have 2 constraints")
        
        let constraints = (self.container.test_constraints as! [NSLayoutConstraint]).sorted { $0.constant > $1.constant }
        
        XCTAssertEqual(constraints[0].constant, 50, "Should be 50")
        XCTAssertEqual(constraints[1].constant, 25, "Should be 25")
        
        c1.constant = 15
        c2.constant = 20
        
        XCTAssertEqual(self.container.test_constraints.count, 2, "Should have 2 constraints")
        
        XCTAssertEqual(constraints[0].constant, 15, "Should be 15")
        XCTAssertEqual(constraints[1].constant, 20, "Should be 20")

        c1.constant = 15
        c2.constant = -20
        
        XCTAssertEqual(self.container.test_constraints.count, 2, "Should have 2 constraints")
        
        XCTAssertEqual(constraints[0].constant, 15, "Should be 15")
        XCTAssertEqual(constraints[1].constant, -20, "Should be -20")
        
    }
    
    func testInsetsAsConstraintsConstant() {
        let view = View()
        self.container.addSubview(view)
        
        view.ty.makeConstraints { view, superView in
            view.top == superView.top + 50
            view.bottom == superView.bottom - 50
            view.left == superView.left + 50
            view.right == superView.right - 50
        }
        
        XCTAssertEqual(self.container.test_constraints.count, 4, "Should have 4 constraints")
        
        let constraints = (self.container.test_constraints as! [NSLayoutConstraint]).sorted { $0.constant > $1.constant }
        
        XCTAssertEqual(constraints[0].constant, 50, "Should be 50")
        XCTAssertEqual(constraints[1].constant, 50, "Should be 50")
        XCTAssertEqual(constraints[2].constant, -50, "Should be -50")
        XCTAssertEqual(constraints[3].constant, -50, "Should be -50")
    }
    
    func testConstraintInsetsAsImpliedEqualToConstraints() {
        let view = View()
        self.container.addSubview(view)
        
        view.ty.makeConstraints { view, superView in
            view.top == superView.top + 25
            view.left == superView.left + 25
            view.bottom == superView.bottom - 25
            view.right == superView.right - 25
        }
        
        XCTAssertEqual(self.container.test_constraints.count, 4, "Should have 4 constraints")
        
        
        let constraints = (self.container.test_constraints as! [NSLayoutConstraint]).sorted { $0.constant > $1.constant }
        
        XCTAssertEqual(constraints[0].constant, 25, "Should be 25")
        XCTAssertEqual(constraints[1].constant, 25, "Should be 25")
        XCTAssertEqual(constraints[2].constant, -25, "Should be -25")
        XCTAssertEqual(constraints[3].constant, -25, "Should be -25")
    }
    
    func testConstraintInsetsAsConstraintsConstant() {
        let view = View()
        self.container.addSubview(view)
        
        view.ty.makeConstraints { view, superView in
            view.top == superView.top + 25
            view.bottom == superView.bottom - 25
            view.left == superView.left + 25
            view.right == superView.right - 25
        }
        
        XCTAssertEqual(self.container.test_constraints.count, 4, "Should have 4 constraints")
        
        
        let constraints = (self.container.test_constraints as! [NSLayoutConstraint]).sorted { $0.constant > $1.constant }
        
        XCTAssertEqual(constraints[0].constant, 25, "Should be 25")
        XCTAssertEqual(constraints[1].constant, 25, "Should be 25")
        XCTAssertEqual(constraints[2].constant, -25, "Should be -25")
        XCTAssertEqual(constraints[3].constant, -25, "Should be -25")
    }
    
#if os(iOS) || os(tvOS)
    @available(iOS 11.0, tvOS 11.0, *)
    func testConstraintDirectionalInsetsAsImpliedEqualToConstraints() {
        let view = View()
        self.container.addSubview(view)
        
        view.ty.makeConstraints { view, superView in
            view.top == superView.top + 25 // 3
            view.bottom == superView.bottom - 25 // 4
            view.leading == superView.leading + 25 //
            view.trailing == superView.trailing - 25 //
        }
        
        XCTAssertEqual(self.container.test_constraints.count, 4, "Should have 4 constraints")
        
        
        let ty_constraints = (self.container.test_constraints as! [NSLayoutConstraint]).sorted { $0.firstAttribute.rawValue < $1.firstAttribute.rawValue }
        
        let verify: (NSLayoutConstraint, NSLayoutConstraint.Attribute, CGFloat) -> Void = { constraint, attribute, constant in
            XCTAssertEqual(constraint.firstAttribute, attribute, "First attribute \(constraint.firstAttribute.rawValue) is not \(attribute.rawValue)")
            XCTAssertEqual(constraint.secondAttribute, attribute, "Second attribute \(constraint.secondAttribute.rawValue) is not \(attribute.rawValue)")
            XCTAssertEqual(constraint.constant, constant, "Attribute \(attribute.rawValue) should have constant \(constant)")
        }
        
        verify(ty_constraints[0], .top, 25)
        verify(ty_constraints[1], .bottom, -25)
        verify(ty_constraints[2], .leading, 25)
        verify(ty_constraints[3], .trailing, -25)
    }
#endif
    
#if os(iOS) || os(tvOS)
    @available(iOS 11.0, tvOS 11.0, *)
    func testConstraintDirectionalInsetsAsConstraintsConstant() {
        let view = View()
        self.container.addSubview(view)
        
        view.ty.makeConstraints { view, superView in
            view.top == superView.top + 25 // 3
            view.bottom == superView.bottom - 25 // 4
            view.leading == superView.leading + 25 //
            view.trailing == superView.trailing - 25 //
        }
        
        XCTAssertEqual(self.container.test_constraints.count, 4, "Should have 4 constraints")
        
        
        let ty_constraints = (self.container.test_constraints as! [NSLayoutConstraint]).sorted { $0.firstAttribute.rawValue < $1.firstAttribute.rawValue }
        
        let verify: (NSLayoutConstraint, NSLayoutConstraint.Attribute, CGFloat) -> Void = { constraint, attribute, constant in
            XCTAssertEqual(constraint.firstAttribute, attribute, "First attribute \(constraint.firstAttribute.rawValue) is not \(attribute.rawValue)")
            XCTAssertEqual(constraint.secondAttribute, attribute, "Second attribute \(constraint.secondAttribute.rawValue) is not \(attribute.rawValue)")
            XCTAssertEqual(constraint.constant, constant, "Attribute \(attribute.rawValue) should have constant \(constant)")
        }
        
        verify(ty_constraints[0], .top, 25)
        verify(ty_constraints[1], .bottom, -25)
        verify(ty_constraints[2], .leading, 25)
        verify(ty_constraints[3], .trailing, -25)
    }
#endif
    
#if os(iOS) || os(tvOS)
    @available(iOS 11.0, tvOS 11.0, *)
    func testConstraintDirectionalInsetsFallBackForNonDirectionalConstraints() {
        let view = View()
        self.container.addSubview(view)
        
        view.ty.makeConstraints { view, superView in
            view.top == superView.top + 25 // 3
            view.bottom == superView.bottom - 25 // 4
            view.left == superView.left + 25 //
            view.right == superView.right - 25 //
        }
        
        XCTAssertEqual(self.container.test_constraints.count, 4, "Should have 4 constraints")
        
        
        let ty_constraints = (self.container.test_constraints as! [NSLayoutConstraint]).sorted { $0.firstAttribute.rawValue < $1.firstAttribute.rawValue }
        
        let verify: (NSLayoutConstraint, NSLayoutConstraint.Attribute, CGFloat) -> Void = { constraint, attribute, constant in
            XCTAssertEqual(constraint.firstAttribute, attribute, "First attribute \(constraint.firstAttribute.rawValue) is not \(attribute.rawValue)")
            XCTAssertEqual(constraint.secondAttribute, attribute, "Second attribute \(constraint.secondAttribute.rawValue) is not \(attribute.rawValue)")
            XCTAssertEqual(constraint.constant, constant, "Attribute \(attribute.rawValue) should have constant \(constant)")
        }
        
        verify(ty_constraints[0], .left, 25)
        verify(ty_constraints[1], .right, -25)
        verify(ty_constraints[2], .top, 25)
        verify(ty_constraints[3], .bottom, -25)
    }
#endif
    
    func testSizeConstraints() {
        let view = View()
        self.container.addSubview(view)
        
        view.ty.makeConstraints { view, superView in
            view.width == 50
            view.height == 50
            view.left == superView.left
            view.top == superView.top
        }
        
        XCTAssertEqual(view.test_constraints.count, 2, "Should have 2 constraints")
        
        XCTAssertEqual(self.container.test_constraints.count, 2, "Should have 2 constraints")
        
        let constraints = view.test_constraints as! [NSLayoutConstraint]
        
        let widthHeight = (LayoutAttribute.width.rawValue, LayoutAttribute.height.rawValue)
        let heightWidth = (widthHeight.1, widthHeight.0)
        let firstSecond = (constraints[0].firstAttribute.rawValue, constraints[1].firstAttribute.rawValue)
        
        XCTAssertTrue(firstSecond == widthHeight || firstSecond == heightWidth, "2 contraint values should match")
        XCTAssertEqual(constraints[0].constant, 50, "Should be 50")
        XCTAssertEqual(constraints[1].constant, 50, "Should be 50")
    }
    
    func testCenterConstraints() {
        let view = View()
        self.container.addSubview(view)
        
        view.ty.makeConstraints { view, superView in
            view.centerX == superView.centerX + 50
            view.centerY == superView.centerY + 50
        }
        
        XCTAssertEqual(self.container.test_constraints.count, 2, "Should have 2 constraints")
        
        
        if let constraints = self.container.test_constraints as? [NSLayoutConstraint], constraints.count > 0 {
            
            XCTAssertEqual(constraints[0].constant, 50, "Should be 50")
            XCTAssertEqual(constraints[1].constant, 50, "Should be 50")
        }
    }
    
    func testConstraintIdentifier() {
        let identifier = "Test-Identifier"
        let view = View()
        self.container.addSubview(view)
        
        let c = view.top == container.top
        c.identifier = identifier
        NSLayoutConstraint.activate([c])
        
        let constraints = container.test_constraints as! [NSLayoutConstraint]
        XCTAssertEqual(constraints[0].identifier, identifier, "Identifier should be 'Test'")
    }
    
    func testEdgesToEdges() {
        var fromAttributes = Set<LayoutAttribute>()
        var toAttributes = Set<LayoutAttribute>()
        
        let view = View()
        self.container.addSubview(view)
        
        view.ty.makeConstraints { view, superView in
            view.top == superView.top
            view.bottom == superView.bottom
            view.left == superView.left
            view.right == superView.right
        }
        
        XCTAssertEqual(self.container.test_constraints.count, 4, "Should have 4 constraints")
        
        for constraint in (container.test_constraints as! [NSLayoutConstraint]) {
            fromAttributes.insert(constraint.firstAttribute)
            toAttributes.insert(constraint.secondAttribute)
        }
        
        XCTAssert(fromAttributes == [.top, .left, .bottom, .right])
        XCTAssert(toAttributes == [.top, .left, .bottom, .right])
    }
    
    func testDirectionalEdgesToDirectionalEdges() {
        var fromAttributes = Set<LayoutAttribute>()
        var toAttributes = Set<LayoutAttribute>()
        
        let view = View()
        self.container.addSubview(view)
        
        view.ty.makeConstraints { view, superView in
            view.top == superView.top
            view.bottom == superView.bottom
            view.leading == superView.leading
            view.trailing == superView.trailing
        }
        
        XCTAssertEqual(self.container.test_constraints.count, 4, "Should have 4 constraints")
        
        for constraint in (container.test_constraints as! [NSLayoutConstraint]) {
            fromAttributes.insert(constraint.firstAttribute)
            toAttributes.insert(constraint.secondAttribute)
        }
        
        XCTAssert(fromAttributes == [.top, .leading, .bottom, .trailing])
        XCTAssert(toAttributes == [.top, .leading, .bottom, .trailing])
    }
    
#if os(iOS) || os(tvOS)
    func testEdgesToMargins() {
        var fromAttributes = Set<LayoutAttribute>()
        var toAttributes = Set<LayoutAttribute>()
        
        let view = View()
        self.container.addSubview(view)
        
        let c1 = view.top == container.topMargin
        let c2 = view.bottom == container.bottomMargin
        let c3 = view.left == container.leftMargin
        let c4 = view.right == container.rightMargin
        
        c1.identifier = "A"
        c2.identifier = "A"
        c3.identifier = "A"
        c4.identifier = "A"
        
        NSLayoutConstraint.activate([c1, c2, c3, c4])
        
        let temp = self.container.constraints.filter { item in
            item.identifier == "A"
        }
        
        /// 4 + 4 4条约束导致父视图多出额外的4条约束
        XCTAssertEqual(temp.count, 4, "Should have 4 constraints")
        
        for constraint in (temp as! [NSLayoutConstraint]) {
            fromAttributes.insert(constraint.firstAttribute)
            toAttributes.insert(constraint.secondAttribute)
        }
        
        XCTAssert(fromAttributes == [.top, .left, .bottom, .right])
        XCTAssert(toAttributes == [.topMargin, .leftMargin, .bottomMargin, .rightMargin])
        
        fromAttributes.removeAll()
        toAttributes.removeAll()
        
        let c11 = view.topMargin == container.top
        let c21 = view.bottomMargin == container.bottom
        let c31 = view.leftMargin == container.left
        let c41 = view.rightMargin == container.right
        
        c11.identifier = "A"
        c21.identifier = "A"
        c31.identifier = "A"
        c41.identifier = "A"
        
        
        NSLayoutConstraint.deactivate(container.constraints)
        
        NSLayoutConstraint.activate([c11, c21, c31, c41])
        
        let temp2 = self.container.constraints.filter { item in
            item.identifier == "A"
        }
        
        XCTAssertEqual(temp2.count, 4, "Should have 4 constraints")
        
        for constraint in (temp2 as! [NSLayoutConstraint]) {
            fromAttributes.insert(constraint.firstAttribute)
            toAttributes.insert(constraint.secondAttribute)
        }
        
        XCTAssert(toAttributes == [.top, .left, .bottom, .right])
        XCTAssert(fromAttributes == [.topMargin, .leftMargin, .bottomMargin, .rightMargin])
        
    }
    
    func testDirectionalEdgesToDirectionalMargins() {
        var fromAttributes = Set<LayoutAttribute>()
        var toAttributes = Set<LayoutAttribute>()
        
        let view = View()
        self.container.addSubview(view)
        
        container.ty.removeConstraints()
        
        let c1 = view.leading == container.leadingMargin
        let c2 = view.trailing == container.trailingMargin
        let c3 = view.top == container.topMargin
        let c4 = view.bottom == container.bottomMargin
        
        c1.identifier = "A"
        c2.identifier = "A"
        c3.identifier = "A"
        c4.identifier = "A"
        
        NSLayoutConstraint.activate([c1, c2, c3, c4])
        
        let temp = container.constraints.filter { c in
            c.identifier == "A"
        }
        
        XCTAssertEqual(temp.count, 4, "Should have 4 constraints")
        
        for constraint in (temp as! [NSLayoutConstraint]) {
            fromAttributes.insert(constraint.firstAttribute)
            toAttributes.insert(constraint.secondAttribute)
        }
        
        XCTAssert(fromAttributes == [.top, .leading, .bottom, .trailing])
        XCTAssert(toAttributes == [.topMargin, .leadingMargin, .bottomMargin, .trailingMargin])
        
        fromAttributes.removeAll()
        toAttributes.removeAll()
        
        container.ty.removeConstraints()
        
        let c11 = view.leadingMargin == container.leading
        let c21 = view.trailingMargin == container.trailing
        let c31 = view.topMargin == container.top
        let c41 = view.bottomMargin == container.bottom
        
        c11.identifier = "B"
        c21.identifier = "B"
        c31.identifier = "B"
        c41.identifier = "B"
        
        NSLayoutConstraint.activate([c11, c21, c31, c41])
        
        let temp1 = container.constraints.filter { c in
            c.identifier == "B"
        }
        
        XCTAssertEqual(temp1.count, 4, "Should have 4 constraints")
        
        for constraint in (temp1 as! [NSLayoutConstraint]) {
            fromAttributes.insert(constraint.firstAttribute)
            toAttributes.insert(constraint.secondAttribute)
        }
        
        XCTAssert(toAttributes == [.top, .leading, .bottom, .trailing])
        XCTAssert(fromAttributes == [.topMargin, .leadingMargin, .bottomMargin, .trailingMargin])
        
    }
    
    func testLayoutGuideConstraints() {
        let vc = UIViewController()
        vc.view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        
        vc.view.addSubview(self.container)
        
        let c1 = container.top == vc.view.safeAreaLayoutGuide.bottom
        let c2 = container.bottom == vc.view.safeAreaLayoutGuide.top
        c1.identifier = "A"
        c2.identifier = "A"
        NSLayoutConstraint.activate([c1, c2])
        
        let temp = vc.view.constraints.filter { l in
            l.identifier == "A"
        }
        
        XCTAssertEqual(temp.count, 2, "Should have 2 constraints installed")
    }
#endif
    
    func testCanSetLabel() {
        self.container.snp.setLabel("Hello World")
        
        XCTAssertEqual(self.container.snp.label(), "Hello World")
    }
    
    func testPriorityShortcuts() {
        let view = View()
        self.container.addSubview(view)
        
        container.ty.removeConstraints()
        view.ty.remakeConstraints { view, superView in
            view.left == superView.left + 1000~1000
        }
        XCTAssertEqual(self.container.test_constraints.count, 1, "Should have 1 constraint")
        XCTAssertEqual(self.container.test_constraints.first?.priority, ConstraintPriority.required.value)
        

        container.ty.removeConstraints()
        view.ty.remakeConstraints { view, superView in
            view.left == superView.left + 1000~250
        }
        XCTAssertEqual(self.container.test_constraints.count, 1, "Should have 1 constraint")
        XCTAssertEqual(self.container.test_constraints.first?.priority, ConstraintPriority.low.value)

        container.ty.removeConstraints()
        view.ty.remakeConstraints { view, superView in
            view.left == superView.left + 1000~251
        }
        XCTAssertEqual(self.container.test_constraints.count, 1, "Should have 1 constraint")
        XCTAssertEqual(self.container.test_constraints.first?.priority, ConstraintPriority.low.value + 1)
    }
    
    func testPriorityStride() {
        let highPriority: ConstraintPriority = .high
        let higherPriority: ConstraintPriority = ConstraintPriority.high.advanced(by: 1)
        XCTAssertEqual(higherPriority.value, highPriority.value + 1)
    }
    
}

