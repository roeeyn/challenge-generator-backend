const fs = require("fs");
const TurndownService = require("turndown");

const html2md = (html, challengeNumber) => {
  const turndownService = new TurndownService();
  const markdown = turndownService.turndown(html);
  return `# Challenge ${challengeNumber + 1}\n${markdown}`;
};

module.exports.parseStarterFn = starterFn => {
  const expression = / .*\(.*\)/;
  const functions = starterFn.join("").match(expression);
  const fnSignature = functions.map(fn => fn.split("("));
  const starterCode = fnSignature
    .map(
      ([fnName, fnParams]) =>
        `module.exports.${fnName.trim()} = (${fnParams} => {\n// Your amazing code here 🚀!\n}`
    )
    .join("\n");
  const fnNames = fnSignature.map(([fnName]) => fnName.trim());
  return { starterCode, fnNames };
};

module.exports.parseTests = (tests, fnNames, challengeNumber) => {
  const importStatements = `const { ${fnNames.join(
    ", "
  )} } = require("./challenge${challengeNumber + 1}.js");`;
  const parsedTests = tests.join("\n");
  const message1 = `/////////// THIS ARE THE ORIGINAL TESTS, THEY WONT RUN WITH JEST //////////////\n`;
  const message2 = `///// you have to modify them manually now, but we're working on a parser /////\n`;
  const message3 = `///// you may see the progress in the repo of this project ////////////////////\n`;
  return `${importStatements}\n\n${message1}${message2}${message3}${parsedTests}`;
};

module.exports.createRepo = (exercise, challengeNumber, rootFolder) => {
  console.log("Generating exercise: ", exercise.url);
  const readmeFile = html2md(exercise.description, challengeNumber);

  const {
    starterCode: starterCodeFile,
    fnNames,
  } = module.exports.parseStarterFn(exercise.starterFn);

  const testFile = module.exports.parseTests(
    exercise.tests,
    fnNames,
    challengeNumber
  );

  return {
    challengeNumber: challengeNumber + 1,
    challengeIndex: challengeNumber,
    starterCodeFile,
    testFile,
    readmeFile,
  };
};
