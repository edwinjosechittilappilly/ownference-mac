import Foundation

@main
struct CoreTests {
    static func main() throws {
        func expect(_ condition: @autoclosure () -> Bool, _ message: String) {
            if !condition() { fputs("FAIL: \(message)\n", stderr); exit(1) }
        }
        func error(_ text: String, _ direction: String = "") -> InputError? {
            do { _ = try PresetRequest(preset: .rewrite, text: text, direction: direction).prompt(); return nil }
            catch { return error as? InputError }
        }
        expect(Preset.allCases.count == 5, "all five presets exist")
        for preset in Preset.allCases {
            let prompt = try PresetRequest(preset: preset, text: "Café 🦦", direction: "in English").prompt()
            expect(prompt.contains(preset.instruction), "preset instruction included")
            expect(prompt.contains("Café 🦦"), "Unicode source preserved")
            expect(prompt.contains("in English"), "direction preserved")
        }
        expect(Set(Preset.allCases.map(\.instruction)).count == 5, "distinct preset semantics")
        expect(error(" \n") == .emptyText, "empty source rejected")
        expect(error(String(repeating: "🦦", count: 24_000)) == nil, "source boundary accepted")
        expect(error(String(repeating: "🦦", count: 24_001)) == .textTooLong, "source boundary enforced")
        expect(error("ok", String(repeating: "é", count: 2_000)) == nil, "direction boundary accepted")
        expect(error("ok", String(repeating: "é", count: 2_001)) == .directionTooLong, "direction boundary enforced")
        expect(error(String(repeating: "e\u{301}", count: 12_001)) == .textTooLong, "combining scalars counted consistently")
        expect(InputError.emptyText.code == "empty_text", "empty error code")
        expect(InputError.textTooLong.code == "text_too_long", "source error code")
        expect(InputError.directionTooLong.code == "direction_too_long", "direction error code")
        print("core_tests_ok")
    }
}
