module.exports.parseAssertEquals = originalTestLine => {
  const getTestExpression = /Test\.assertEquals\(.*,*\)/;
  const getParamsExpression = /\(.*,*\)/;

  const originalTest = `${originalTestLine.match(getTestExpression)}`;
  if (originalTest === "") {
    // no occurrences found
    return originalTestLine;
  }

  const testSignature = `${originalTest.match(getParamsExpression)}`;
  const [funcExec, expectedResult] = testSignature
    .substring(1, testSignature.length)
    .split(",");

  const jestTest = `test("test demo", () => expect(${funcExec.trim()}).toBe(${expectedResult.trim()}));`;
  return originalTestLine.replace(originalTest, jestTest);
};
