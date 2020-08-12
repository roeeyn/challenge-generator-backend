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

  if (funcExec && expectedResult) {
    const jestTest = `test("TESTING main fun", () => expect(${funcExec.trim()}).${jestTestVerb}(${expectedResult.trim()});`;
    return originalTestLine.replace(originalTest, jestTest);
  }

  return originalTestLine;
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

module.exports.parseExpectError = originalTestLine => {
  const getParamsExpression = /\(.*,*\)/;

  const originalTest = `${originalTestLine.match(/Test\.expectError\(.*,*\)/)}`;
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

  if (funcExec && expectedResult) {
    const jestTest = `test("TESTING main fun", () => expect(${funcExec.trim()}).toThrow}(${expectedResult.trim()});`;
    return originalTestLine.replace(originalTest, jestTest);
  }

  return originalTestLine;
};

module.exports.parseExpectNoError = originalTestLine => {
  const getParamsExpression = /\(.*,*\)/;

  const originalTest = `${originalTestLine.match(
    /Test\.expectNoError\(.*,*\)/
  )}`;
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

  if (funcExec && expectedResult) {
    const jestTest = `test("TESTING main fun", () => expect(${funcExec.trim()}).not.toThrow}(${expectedResult.trim()});`;
    return originalTestLine.replace(originalTest, jestTest);
  }

  return originalTestLine;
};

module.exports.parseAssertDeepEquals = originalTestLine =>
  module.exports.parseTest(originalTestLine)(/Test\.assertDeepEquals\(.*,*\)/)(
    "toMatchObject"
  );
