// [
//   {
//     detectedCase: ".assertEquals(",
//     url: "https://edabit.com/challenge/ARr5tA458o2tC9FTN",
//     isValid: true,
//   },
//   {
//     detectedCase: ".assertSimilar(",
//     url: "https://edabit.com/challenge/kJQYTCCWSnzhXG9dn",
//     isValid: true,
//   },
//   {
//     detectedCase: ".assertNotEquals(",
//     url: "https://edabit.com/challenge/T2sDPQQhpaEd9YAiq",
//     isValid: true,
//   },
//   {
//     detectedCase: ".expect(",
//     url: "https://edabit.com/challenge/wBAuop24JYt9MZhXF",
//     isValid: true,
//   },
//   {
//     detectedCase: ".expectError(",
//     url: "https://edabit.com/challenge/vqwqCwfJ3r4zFvzPn",
//     isValid: true,
//   },
//   {
//     detectedCase: ".describe(",
//     url: "https://edabit.com/challenge/GaWzhCsGSHcWyGoZh",
//     isValid: true,
//   },
//   {
//     detectedCase: ".expectNoError(",
//     url: "https://edabit.com/challenge/b7dXbWEhbr3bXCk7i",
//     isValid: true,
//   },
//   {
//     detectedCase: ".assertDeepEquals(",
//     url: "https://edabit.com/challenge/neWTApTYread9ZNdP",
//     isValid: true,
//   },
// ]
const { parseAssertEquals } = require("./parseTestFile.js");

describe("Testing the test parsing", () => {
  xtest("Parse assertEquals", () => {
    const initialTests = [
      `hola soy pedrito Test.assertEquals(hello(), "hello edabit.com", "Did you *return* the result?") hola ya no quiero ser pedrito`,
    ];

    const expectedResults = [
      `hola soy pedrito test("test demo", () => expect(hello()).toBe("hello edabit.com")); hola ya no quiero ser pedrito`,
    ];

    initialTests.forEach((initialTest, idx) =>
      expect(parseAssertEquals(initialTest)).toBe(expectedResults[idx])
    );
  });
  // test("Parse assertSimilar", () => {});
  // test("Parse assertNotEquals", () => {});
  // test("Parse expect", () => {});
  // test("Parse expectError", () => {});
  // test("Parse describe", () => {});
  // test("Parse expectNoError", () => {});
  // test("Parse assertDeepEquals", () => {});
});
