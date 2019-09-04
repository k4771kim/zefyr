// Copyright (c) 2018, the Zefyr project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'controller.dart';
import 'editable_text.dart';
import 'mode.dart';
import 'scaffold.dart';
import 'scope.dart';
import 'theme.dart';

/// Widget for editing Zefyr documents.
class ZefyrEditor extends StatefulWidget {
  const ZefyrEditor({
    Key key,
    @required this.controller,
    @required this.focusNode,
    this.autofocus: true,
    this.mode: ZefyrMode.edit,
    this.padding: const EdgeInsets.symmetric(horizontal: 16.0),
    this.selectionControls,
    this.physics,
  })  : assert(mode != null),
        assert(controller != null),
        assert(focusNode != null),
        super(key: key);

  /// Controls the document being edited.
  final ZefyrController controller;

  /// Controls whether this editor has keyboard focus.
  final FocusNode focusNode;

  /// Whether this editor should focus itself if nothing else is already
  /// focused.
  ///
  /// If true, the keyboard will open as soon as this text field obtains focus.
  /// Otherwise, the keyboard is only shown after the user taps the text field.
  ///
  /// Defaults to true. Cannot be null.
  final bool autofocus;

  /// Editing mode of this editor.
  final ZefyrMode mode;


  /// Delegate for resolving embedded images.
  ///
  /// This delegate is required if embedding images is allowed.

  /// Optional delegate for building the text selection handles and toolbar.
  ///
  /// If not provided then platform-specific implementation is used by default.
  final TextSelectionControls selectionControls;

  /// Controls physics of scrollable editor.
  final ScrollPhysics physics;

  /// Padding around editable area.
  final EdgeInsets padding;

  @override
  _ZefyrEditorState createState() => _ZefyrEditorState();
}

class _ZefyrEditorState extends State<ZefyrEditor> {
  ZefyrScope _scope;
  ZefyrThemeData _themeData;
  ZefyrScaffoldState _scaffold;



  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(ZefyrEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    _scope.mode = widget.mode;
    _scope.controller = widget.controller;
    _scope.focusNode = widget.focusNode;
 
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final parentTheme = ZefyrTheme.of(context, nullOk: true);
    final fallbackTheme = ZefyrThemeData.fallback(context);
    _themeData = (parentTheme != null)
        ? fallbackTheme.merge(parentTheme)
        : fallbackTheme;

    if (_scope == null) {
      _scope = ZefyrScope.editable(
        mode: widget.mode,
        controller: widget.controller,
        focusNode: widget.focusNode,
        focusScope: FocusScope.of(context),
      );
    } else {
      final focusScope = FocusScope.of(context);
      _scope.focusScope = focusScope;
    }

    final scaffold = ZefyrScaffold.of(context);
    if (_scaffold != scaffold) {
      _scaffold = scaffold;
    }
  }

  @override
  void dispose() {
    _scope.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget editable = ZefyrEditableText(
      controller: _scope.controller,
      focusNode: _scope.focusNode,
      selectionControls: widget.selectionControls,
      autofocus: widget.autofocus,
      mode: widget.mode,
      padding: widget.padding,
      physics: widget.physics,
    );

    return ZefyrTheme(
      data: _themeData,
      child: ZefyrScopeAccess(
        scope: _scope,
        child: editable,
      ),
    );
  }
}
