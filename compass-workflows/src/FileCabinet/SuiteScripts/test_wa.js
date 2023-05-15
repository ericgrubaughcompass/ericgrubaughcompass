/**
 * Module Description...
 *
 * @type {Object} module-name
 *
 * @copyright 2023 Compass
 * @author Eric Grubaugh <eric.grubaugh@compass.com>
 *
 * @NApiVersion 2.1
 * @NModuleScope SameAccount

 * @NScriptType WorkflowActionScript
 */
define([], () => {
  /**
   * onAction event handler
   *
   * @gov XXX
   *
   * @param {Object} context
   * @param {Record} context.newRecord - The new record with all changes. save() is not permitted
   * @param {Record} context.oldRecord - The old record with all changes. save() is not permitted
   * @param {Form} context.form - The UI form in context; only available in beforeLoad context
   * @param {string} context.type - Event Type, such as create, edit, delete
   * @param {number} context.workflowId - Internal ID of the currently executing workflow
   */
  function onAction(context) {
    // TODO
  }

  return {onAction};
});
