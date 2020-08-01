module.exports.parseTest = originalTestLine => testExpression => jestTestVerb => {
  const getParamsExpression = /\(.*,*\)/;

  const originalTest = `${originalTestLine.match(testExpression)}`;
  if (originalTest === "") {
    // no occurrences found
    return originalTestLine;
  }

  const testSignature = `${originalTest.match(getParamsExpression)}`;
  // For now, this is the best effort for getting the params
  // it may be not much, but it's honest work LOL
  const [funcExec, expectedResult] = testSignature
    .substring(1, testSignature.length)
    .split(",");

  const jestTest = `test("TESTING main fun", () => expect(${funcExec.trim()}).${jestTestVerb}(${expectedResult.trim()}));`;
  return originalTestLine.replace(originalTest, jestTest);
};

module.exports.parseAssertEquals = originalTestLine =>
  module.exports.parseTest(originalTestLine)(/Test\.assertEquals\(.*,*\)/)(
    "toBe"
  );

module.exports.parseAssertSimilar = originalTestLine =>
  module.exports.parseTest(originalTestLine)(/Test\.assertSimilar\(.*,*\)/)(
    "toStrictEqual"
  );

module.exports.parseAssertNotEquals = originalTestLine =>
  module.exports.parseTest(originalTestLine)(/Test\.assertNotEquals\(.*,*\)/)(
    "not.toBe"
  );

module.exports.parseExpect = originalTestLine =>
  module.exports.parseTest(originalTestLine)(/Test\.expect\(.*,*\)/)(
    "toBeTruthy"
  );

module.exports.parseExpectError = originalTestLine =>
  module.exports.parseTest(originalTestLine)(/Test\.expectError\(.*,*\)/)(
    "toThrow" // TODO we need to change the order bc in the original test, they start with the expected error
  );

module.exports.parseExpectNoError = originalTestLine =>
  module.exports.parseTest(originalTestLine)(/Test\.expectNoError\(.*,*\)/)(
    "not.toThrow" // TODO we need to change the order bc in the original test, they start with the expected error
  );

module.exports.parseAssertDeepEquals = originalTestLine =>
  module.exports.parseTest(originalTestLine)(/Test\.assertDeepEquals\(.*,*\)/)(
    "toMatchObject"
  );

module.exports.parseDescribe = "TODO"; // We need to fix the issue for sending the formatted text to the function
