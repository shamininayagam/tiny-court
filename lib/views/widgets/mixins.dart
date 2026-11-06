import '../../ui.dart';

mixin StateMixin<T extends StatefulWidget> on State<T> {
  GlobalKey<ScaffoldState>? _scaffoldKey;

  GlobalKey get scaffoldKey {
    _scaffoldKey ??= GlobalKey();
    return _scaffoldKey!;
  }

  Future<void> showSnack(String text) async {
    context.scaffoldMessenger.showSnackBar(SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 2),
    ));
  }

  bool _loading = false;

  bool get loading => _loading;

  void setLoading() {
    if (mounted) {
      setState(() {
        _loading = true;
      });
    }
  }

  void resetLoading() {
    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }
}

mixin FormStateMixin<T extends StatefulWidget> on State<T> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool validateForm() => formKey.currentState!.validate();

  void saveForm() => formKey.currentState!.save();

  void resetForm() => formKey.currentState!.reset();
}

mixin FutureStateMixin<S extends StatefulWidget, T> on State<S> {
  Future<T>? _future;

  @mustCallSuper
  @override
  void initState() {
    super.initState();
    _future = getData();
  }

  Future<T> getData() => Future<T>.value();

  Future<void> refresh() {
    return _setFuture(getData());
  }

  Future<T> _setFuture(Future<T> f) async {
    _future = f;
    if (mounted) {
      setState(() {});
    }
    return _future!;
  }

  Widget errorBuilder(
    BuildContext context,
    Object? error,
    StackTrace? stackTrace,
  ) {
    return ElevatedButton(
      onPressed: refresh,
      child: Text(context.strings.retry),
    );
  }

  Widget progressBuilder(BuildContext context) {
    return const AppProgressIndicator();
  }

  Widget dataBuilder(BuildContext context, T? data) {
    return Text('$data');
  }

  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot<T> snap) {
        if (snap.connectionState != ConnectionState.done) {
          return progressBuilder(context);
        }

        if (snap.hasError) {
          return errorBuilder(context, snap.error, snap.stackTrace);
        }

        return dataBuilder(context, snap.data);
      },
    );
  }
}

mixin StreamStateMixin<S extends StatefulWidget, T> on State<S> {
  Stream<T>? _stream;

  @mustCallSuper
  @override
  void initState() {
    super.initState();
    _stream = getStream();
  }

  Future<void> refresh() async {
    setState(() {
      _stream = getStream();
    });
  }

  Stream<T> getStream();

  Widget errorBuilder(
    BuildContext context,
    Object? error,
    StackTrace? stackTrace,
  ) {
    return ElevatedButton(
      onPressed: refresh,
      child: Text(context.strings.retry),
    );
  }

  Widget progressBuilder(BuildContext context) {
    return const AppProgressIndicator();
  }

  Widget dataBuilder(BuildContext context, T? data) {
    return Text('$data');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: _stream,
      builder: (BuildContext context, AsyncSnapshot<T> snap) {
        if (snap.connectionState != ConnectionState.done ||
            snap.connectionState != ConnectionState.active) {
          return progressBuilder(context);
        }

        if (snap.hasError) {
          return errorBuilder(context, snap.error, snap.stackTrace);
        }

        return dataBuilder(context, snap.data);
      },
    );
  }
}

mixin PaginatedMixin<S extends StatefulWidget, T> on State<S> {
  int get itemsPerPage => 20;

  List<T> get items;

  Axis get axis => Axis.vertical;

  bool get pageEnded => false;

  @override
  void initState() {
    super.initState();
    onLoadPage();
  }

  Widget errorBuilder(
    BuildContext context,
    Object? error,
    StackTrace? stackTrace,
  ) {
    return ElevatedButton(
      onPressed: onRefresh,
      child: AppText(context.strings.retry),
    );
  }

  Widget noItemsBuilder(
    BuildContext context,
    String message,
  ) {
    return Column(
      children: <Widget>[
        AppText(message),
      ],
    );
  }

  Future<void> onRefresh();

  Future<void> onLoadPage();

  Future<void> onCurrentPage();

  bool get onLoading => false;

  Widget pageItemBuilder(BuildContext context, int index);

  Widget completionBuilder() {
    return AppText(context.strings.noMore);
  }

  Widget buildScrollable(
    BuildContext context, {
    required IndexedWidgetBuilder pageItemBuilder,
  }) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: axis,
      itemCount: items.length,
      itemBuilder: pageItemBuilder,
    );
  }

  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    bool onNotification(Notification notification) {
      if (notification is ScrollEndNotification) {
        onLoadPage();
      }
      return false;
    }

    return NotificationListener<Notification>(
      onNotification: onNotification,
      child: buildScrollable(
        context,
        pageItemBuilder: pageItemBuilder,
      ),
    );
  }
}
