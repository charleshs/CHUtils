import CHUtils
import Foundation
import Nimble
import Quick

final class PersistedSpec: QuickSpec {
    override func spec() {
        @PersistedPref(key: "balance", defaultValue: 0, persistence: UserDefaultsWrapper(.standard), dataTransform: NullTransformer.default)
        var balance: Int

        @PersistedInfo(key: "message", persistence: UserDefaultsWrapper(.standard), dataTransform: NullTransformer.default)
        var message: String?

        beforeEach {
            balance = 0
            message = nil
        }
        describe("PersistedPref without transformer") {
            it("can store value") {
                expect(balance).to(equal(0))
                expect(UserDefaults.standard.integer(forKey: "balance")).to(equal(0))
                balance = 9999
                expect(balance).to(equal(9999))
                expect(UserDefaults.standard.integer(forKey: "balance")).to(equal(9999))
            }
            it("returns default value if key does not exist") {
                UserDefaults.standard.removeObject(forKey: "balance")
                expect(balance).to(equal(0))
            }
        }
        describe("PersistedInfo without transformer") {
            it("can store value") {
                let greetings = "Hello Swift!"
                expect(message).to(beNil())
                message = greetings
                expect(message).to(equal(greetings))
                expect(UserDefaults.standard.string(forKey: "message")).to(equal(greetings))
            }
            it("can remove value") {
                message = "something"
                expect(message).toNot(beNil())
                message = nil
                expect(UserDefaults.standard.string(forKey: "message")).to(beNil())
            }
        }
    }
}
