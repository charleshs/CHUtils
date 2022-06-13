@testable import CHUtils
import Foundation
import Nimble
import Quick

final class PersistedSpec: QuickSpec {
    var subscription: PersistenceSubscription?

    override func spec() {
        @PersistedPref(key: "balance", defaultValue: 0, persistence: UserDefaultsWrapper(.standard), dataTransform: NullTransformer.default)
        var balance: Int

        @PersistedInfo(key: "message", persistence: UserDefaultsWrapper(.standard), dataTransform: NullTransformer.default)
        var message: String?

        @PersistedInfo(key: "student", persistence: UserDefaultsWrapper(.standard), dataTransform: CodableJSONTransformer())
        var student: Student?

        beforeEach {
            balance = 0
            message = nil
            student = nil
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
        describe("PersistedInfo for custom types with transformer") {
            it("can store value") {
                student = Student(name: "Charles", grade: 99, gender: .male)
                expect(student).toNot(beNil())
                expect(student?.name).to(equal("Charles"))
                expect(student?.grade).to(equal(99))
                expect(student?.gender).to(equal(.male))
            }
        }
        describe("PersistenceSubscribers") {
            it("removes listeners when subscription is deallocated") {
                self.subscription = $student.addListener(onChanged: { _, _ in })
                expect($student.listeners).toNot(beEmpty())
                self.subscription = nil
                expect($student.listeners).to(beEmpty())
            }
            it("removes listeners when listener call unregister") {
                self.subscription = $student.addListener(onChanged: { _, _ in })
                expect($student.listeners).toNot(beEmpty())
                self.subscription?.unregister()
                expect($student.listeners).to(beEmpty())
            }
            it("will notify listeners on value changes") {
                student = Student(name: "Charles", grade: 99, gender: .male)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    student = Student(name: "Snoopy", grade: 87, gender: .male)
                }
                var newStudent: Student?
                var oldStudent: Student?
                self.subscription = $student.addListener(onChanged: { new, old in
                    newStudent = new
                    oldStudent = old
                })
                expect(newStudent?.name).toEventually(equal("Snoopy"))
                expect(oldStudent?.name).toEventually(equal("Charles"))
            }
        }

        afterEach {
            self.subscription = nil
        }
    }
}

extension PersistedSpec {
    struct Student: Codable {
        enum Gender: Codable { case male, female }

        let name: String
        let grade: Int
        let gender: Gender
    }
}
