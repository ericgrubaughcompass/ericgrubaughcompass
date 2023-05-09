module.exports = {
	defaultProjectFolder: 'src',
	commands: {
		"project:deploy": {
			beforeExecuting: (options) => {
				options.arguments.accountspecificvalues = "WARNING";
				return options;
			}
		},
		"project:validate": {
			beforeExecuting: (options) => {
				options.arguments.accountspecificvalues = "WARNING";
				options.arguments.server = true;
				return options;
			}
		}
	}
};
