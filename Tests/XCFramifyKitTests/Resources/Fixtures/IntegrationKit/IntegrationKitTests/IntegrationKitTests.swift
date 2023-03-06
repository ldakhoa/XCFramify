import XCTest
@testable import IntegrationKit

final class UIViewExtensionsTests: XCTestCase {

    var sut: UIView!

    override func setUp() {
        super.setUp()
        sut = UIView()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_anchor() {
        let top = sut.topAnchor
        let leading = sut.leadingAnchor
        let bottom = sut.bottomAnchor
        let trailing = sut.trailingAnchor

        let padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let size = CGSize(width: 100, height: 100)

        let constraints = sut.anchor(top: top, leading: leading, bottom: bottom, trailing: trailing, padding: padding, size: size)

        XCTAssertEqual(constraints.top?.constant ?? 0, 10)
        XCTAssertEqual(constraints.leading?.constant ?? 0, 10)
        XCTAssertEqual(constraints.bottom?.constant ?? 0, -10)
        XCTAssertEqual(constraints.trailing?.constant ?? 0, -10)
        XCTAssertEqual(constraints.width?.constant ?? 0, 100)
        XCTAssertEqual(constraints.height?.constant ?? 0, 100)
    }

    func test_fillSuperview() {
        let superview = UIView()
        superview.addSubview(sut)

        let padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        sut.fillSuperview(padding: padding)

        XCTAssertEqual(sut.topAnchor.constraint(equalTo: superview.topAnchor).constant, 10)
        XCTAssertEqual(sut.leadingAnchor.constraint(equalTo: superview.leadingAnchor).constant, 10)
        XCTAssertEqual(sut.bottomAnchor.constraint(equalTo: superview.bottomAnchor).constant, -10)
        XCTAssertEqual(sut.trailingAnchor.constraint(equalTo: superview.trailingAnchor).constant, -10)
    }

    func test_centerInSuperview() {
        let superview = UIView()
        superview.addSubview(sut)

        let size = CGSize(width: 100, height: 100)

        sut.centerInSuperview(size: size)

        XCTAssertTrue(sut.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive)
        XCTAssertTrue(sut.centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive)
        XCTAssertEqual(sut.widthAnchor.constraint(equalToConstant: 100).constant, 100)
        XCTAssertEqual(sut.heightAnchor.constraint(equalToConstant: 100).constant, 100)
    }

    func test_constrainHeight() {
        let constant: CGFloat = 100

        sut.constrainHeight(constant)

        XCTAssertEqual(sut.heightAnchor.constraint(equalToConstant: constant).constant, constant)
    }

    func test_constrainWidth() {
        let constant: CGFloat = 100

        sut.constrainWidth(constant)

        XCTAssertEqual(sut.widthAnchor.constraint(equalToConstant: constant).constant, constant)
    }

    func test_setupShadow() {
        let opacity: Float = 1
        let radius: CGFloat = 5
        let offset = CGSize(width: 5, height: 5)
        let color = UIColor.red

        sut.setupShadow(opacity: opacity, radius: radius, offset: offset, color: color)

        XCTAssertEqual(sut.layer.shadowOpacity, opacity)
        XCTAssertEqual(sut.layer.shadowRadius, radius)
        XCTAssertEqual(sut.layer.shadowOffset, offset)
        XCTAssertEqual(sut.layer.shadowColor, color.cgColor)
    }

    func test_init() {
        let color = UIColor.red

        sut = UIView(backgroundColor: color)

        XCTAssertEqual(sut.backgroundColor, color)
    }

    func test_withMargins() {
        let margins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        let stackView = UIStackView(arrangedSubviews: [])
        stackView.withMargins(margins)

        XCTAssertEqual(stackView.layoutMargins, margins)
        XCTAssertTrue(stackView.isLayoutMarginsRelativeArrangement)
    }

    func test_paddingLeft() {
        let leftPadding: CGFloat = 10

        let stackView = UIStackView(arrangedSubviews: [])
        stackView.paddingLeft(leftPadding)

        XCTAssertEqual(stackView.layoutMargins.left, leftPadding)
        XCTAssertTrue(stackView.isLayoutMarginsRelativeArrangement)
    }

    func test_paddingTop() {
        let topPadding: CGFloat = 10

        let stackView = UIStackView(arrangedSubviews: [])
        stackView.paddingTop(topPadding)

        XCTAssertEqual(stackView.layoutMargins.top, topPadding)
        XCTAssertTrue(stackView.isLayoutMarginsRelativeArrangement)
    }

}
