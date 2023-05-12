import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShortcutsExample extends StatelessWidget {
// #docregion ShortcutsExample
  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyA):
            SelectAllIntent(),
      },
      child: Actions(
        dispatcher: LoggingActionDispatcher(),
        actions: <Type, Action<Intent>>{
          SelectAllIntent: SelectAllAction(model),
        },
        child: Builder(
          builder: (context) => TextButton(
            child: const Text('SELECT ALL'),
            onPressed: Actions.handler<SelectAllIntent>(
              context,
              SelectAllIntent(),
            ),
          ),
        ),
      ),
    );
  }
// #enddocregion ShortcutsExample
}

// #docregion LoggingShortcutManager
class LoggingShortcutManager extends ShortcutManager {
  @override
  KeyEventResult handleKeypress(BuildContext context, RawKeyEvent event) {
    final KeyEventResult result = super.handleKeypress(context, event);
    if (result == KeyEventResult.handled) {
      print('Handled shortcut $event in $context');
    }
    return result;
  }
}
// #enddocregion LoggingShortcutManager

class SelectAllIntent extends Intent {
  const SelectAllIntent({this.controller});

  final TextEditingController? controller;
}

class Model {
  void selectAll() {}
}

Model model = Model();

// #docregion SelectAllAction
class SelectAllAction extends Action<SelectAllIntent> {
  SelectAllAction(this.model);

  final Model model;

  @override
  void invoke(covariant SelectAllIntent intent) => model.selectAll();
}
// #enddocregion SelectAllAction

void callbackActionSample() {
// #docregion CallbackAction
  CallbackAction(onInvoke: (intent) => model.selectAll());
// #enddocregion CallbackAction
}

class SelectAllExample extends StatelessWidget {
  SelectAllExample({required this.child});

  final Widget child;

// #docregion SelectAllExample
  @override
  Widget build(BuildContext context) {
    return Actions(
      actions: <Type, Action<Intent>>{
        SelectAllIntent: SelectAllAction(model),
      },
      child: child,
    );
  }
// #enddocregion SelectAllExample
}

late BuildContext context;

void findAndInvokeExample() {
// #docregion MaybeFindExample
  Action<SelectAllIntent>? selectAll =
      Actions.maybeFind<SelectAllIntent>(context);
// #enddocregion MaybeFindExample
// #docregion InvokeActionExample
  Object? result;
  if (selectAll != null) {
    result = Actions.of(context).invokeAction(selectAll, SelectAllIntent());
  }
// #enddocregion InvokeActionExample
  print('$result');
}

void maybeInvokeExample() {
// #docregion MaybeInvokeExample
  Object? result =
      Actions.maybeInvoke<SelectAllIntent>(context, SelectAllIntent());
// #enddocregion MaybeInvokeExample
  print('$result');
}

class HandlerExample extends StatelessWidget {
  HandlerExample(this.controller);

  final TextEditingController controller;

// #docregion HandlerExample
  @override
  Widget build(BuildContext context) {
    return Actions(
      actions: <Type, Action<Intent>>{
        SelectAllIntent: SelectAllAction(model),
      },
      child: Builder(
        builder: (context) => TextButton(
          child: const Text('SELECT ALL'),
          onPressed: Actions.handler<SelectAllIntent>(
            context,
            SelectAllIntent(controller: controller),
          ),
        ),
      ),
    );
  }
// #enddocregion HandlerExample
}

// #docregion LoggingActionDispatcher
class LoggingActionDispatcher extends ActionDispatcher {
  @override
  Object? invokeAction(
    covariant Action<Intent> action,
    covariant Intent intent, [
    BuildContext? context,
  ]) {
    print('Action invoked: $action($intent) from $context');
    super.invokeAction(action, intent, context);

    return null;
  }
}
// #enddocregion LoggingActionDispatcher

class LoggingActionDispatcherExample extends StatelessWidget {
// #docregion LoggingActionDispatcherExample
  @override
  Widget build(BuildContext context) {
    return Actions(
      dispatcher: LoggingActionDispatcher(),
      actions: <Type, Action<Intent>>{
        SelectAllIntent: SelectAllAction(model),
      },
      child: Builder(
        builder: (context) => TextButton(
          child: const Text('SELECT ALL'),
          onPressed: Actions.handler<SelectAllIntent>(
            context,
            SelectAllIntent(),
          ),
        ),
      ),
    );
  }
// #enddocregion LoggingActionDispatcherExample
}


class CallbackShortcutsExample extends StatefulWidget {
  const CallbackShortcutsExample({super.key});

  @override
  State<CallbackShortcutsExample> createState() => _CallbackShortcutsExampleState();
}

class _CallbackShortcutsExampleState extends State<CallbackShortcutsExample> {
  int count = 0;

// #docregion CallbackShortcuts
  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        const SingleActivator(LogicalKeyboardKey.arrowUp): () {
          setState(() => count = count + 1);
        },
        const SingleActivator(LogicalKeyboardKey.arrowDown): () {
          setState(() => count = count - 1);
        },
      },
      child: Focus(
        autofocus: true,
        child: Column(
          children: <Widget>[
            const Text('Press the up arrow key to add to the counter'),
            const Text('Press the down arrow key to subtract from the counter'),
            Text('count: $count'),
          ],
        ),
      ),
    );
  }
// #enddocregion CallbackShortcuts
}
