/**
 * Generate the deploy.xml file for the SDF Project in the current working directory based on a
 * given list of Object files which have changed. The scripts/get_changed_objects script is intended
 * to generate this list.
 *
 * We are only concerned with Object definitions as SDF is already smart enough to determine which
 * Files have changed.
 *
 * @example
 * # Invoke the generate-deploy-file module, passing the output of the get_changed_objects script.
 * # Note the double quotes around the get_changed_object execution are important because we have
 * # Object folder names with spaces, and those will get split apart without the double quotes.
 * node scripts/generate-deploy-file.mjs "$(../scripts/get_changed_objects)"
 */

import { argv, cwd } from 'node:process';
import { writeFileSync } from 'node:fs';
import * as xml2js from '../compass/node_modules/xml2js/lib/xml2js.js';

/**
 * Ignore any Objects within these Folders. Matching is case-sensitive.
 *
 * @type {string[]}
 */
const ignoreFolders = [
  'Searches',
];

/**
 * Normalizes incoming list of file paths to appropriate Object path structure
 *
 * @param {string} paths newline-separated string of Object paths
 *
 * @returns {string[]} List of valid Object file paths
 */
const toPaths = (paths) => paths.split('\n').filter(isValidPath)

/**
 * Determines whether the given Object file path is valid for deployment
 *
 * @param {string} path The Object file path to validate
 *
 * @returns {boolean} true if the given path should be included in deploy.xml; false otherwise
 */
const isValidPath = (path) =>
  path?.endsWith('.xml') && !ignoreFolders.some(folder => path?.includes(folder))


// Validate and transform the paths into the appropriate XML
const xml = new xml2js.Builder({
  rootName: 'deploy',
  headless: true
}).buildObject({
  files: {path: '~/FileCabinet/*'},
  objects: {
    // process.argv contains the command-line elements which triggered execution
    // The first element is the path to the node executable, the second is the executable file,
    // so we're only interested in the third element, which should be our file paths
    path: toPaths(argv[2])
  }
});

// Overwrite the current Project's deploy.xml file with the newly generated XML
writeFileSync(`${cwd()}/src/deploy.xml`, xml);
