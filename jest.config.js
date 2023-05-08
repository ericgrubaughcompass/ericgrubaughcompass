const SuiteCloudJestConfiguration = require("@oracle/suitecloud-unit-testing/jest-configuration/SuiteCloudJestConfiguration");
const cliConfig = require("./suitecloud.config");

module.exports = {
	...SuiteCloudJestConfiguration.build({
		projectFolder: cliConfig.defaultProjectFolder,
		projectType: SuiteCloudJestConfiguration.ProjectType.ACP,
	}),
	reporters: [
		"default",
		['jest-junit', {outputDirectory: 'reports', outputName: 'jest.xml'}]
	],
	collectCoverage: false,
	collectCoverageFrom: [`${cliConfig.defaultProjectFolder}/FileCabinet/SuiteScripts/**/*.{js,jsx}`],
	coverageDirectory: "reports/coverage",
	coverageReporters: ["json-summary", "json", "html"]
};
