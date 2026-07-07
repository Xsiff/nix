[
  {
    key = "cmd+1";
    command = "workbench.action.debug.continue";
    when = "debugState == 'stopped'";
  }
  {
    key = "cmd+2";
    command = "workbench.action.debug.stepOver";
    when = "debugState == 'stopped'";
  }
  {
    key = "cmd+3";
    command = "workbench.action.debug.stepInto";
    when = "debugState == 'stopped'";
  }
  {
    key = "cmd+4";
    command = "workbench.action.debug.stepOut";
    when = "debugState == 'stopped'";
  }
  {
    key = "cmd+5";
    command = "workbench.action.debug.restart";
    when = "debugState == 'stopped'";
  }
  {
    key = "cmd+e";
    command = "editor.debug.action.selectionToRepl";
    when = "debugState == 'stopped'";
  }
]