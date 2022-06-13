import CHUtils
import Nimble
import Quick

final class CollectionExtensionsSpec: QuickSpec {
    override func spec() {
        describe("Collection extensions") {
            it("provides safe access of element by index") {
                let nums = [1, 3, 4, 6, 8, 11]
                expect(nums[at: -1]).to(beNil())
                expect(nums[at: 0]).to(equal(1))
                expect(nums[at: 1]).to(equal(3))
                expect(nums[at: 2]).to(equal(4))
                expect(nums[at: 3]).to(equal(6))
                expect(nums[at: 4]).to(equal(8))
                expect(nums[at: 5]).to(equal(11))
                expect(nums[at: 6]).to(beNil())
            }
            it("provides operation to mutate elements") {
                var nums = [1, 3, 4, 6, 8, 11]
                nums.mutate { num in
                    if num % 2 == 0 {
                        num = -1
                    }
                }
                expect(nums).to(equal([1, 3, -1, -1, -1, 11]))
            }
        }
    }
}
