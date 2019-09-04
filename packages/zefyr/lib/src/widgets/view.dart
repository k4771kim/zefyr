// Copyright (c) 2018, the Zefyr project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:notus/notus.dart';

import 'common.dart';
import 'paragraph.dart';
import 'scope.dart';
import 'theme.dart';

/// Non-scrollable read-only view of Notus rich text documents.
@experimental
class ZefyrView extends StatefulWidget {
  final NotusDocument document;

  const ZefyrView({Key key, @required this.document})
      : super(key: key);

  @override
  ZefyrViewState createState() => ZefyrViewState();
}

class ZefyrViewState extends State<ZefyrView> {
  ZefyrScope _scope;
  ZefyrThemeData _themeData;

  @override
  void initState() {
    super.initState();
    _scope = ZefyrScope.view();
  }

  @override
  void didUpdateWidget(ZefyrView oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final parentTheme = ZefyrTheme.of(context, nullOk: true);
    final fallbackTheme = ZefyrThemeData.fallback(context);
    _themeData = (parentTheme != null)
        ? fallbackTheme.merge(parentTheme)
        : fallbackTheme;
  }

  @override
  void dispose() {
    _scope.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ZefyrTheme(
      data: _themeData,
      child: ZefyrScopeAccess(
        scope: _scope,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _buildChildren(context),
        ),
      ),
    );
  }

  List<Widget> _buildChildren(BuildContext context) {
    final result = <Widget>[];
    for (var node in widget.document.root.children) {
      result.add(_defaultChildBuilder(context, node));
    }
    return result;
  }

  Widget _defaultChildBuilder(BuildContext context, Node node) {
    if (node is LineNode) {
     
      return new ZefyrParagraph(node: node);
    }

 
    throw new UnimplementedError('Block format .');
  }
}
