// Copyright (c) 2018, the Zefyr project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'package:flutter/material.dart';
import 'package:notus/notus.dart';

import 'common.dart';
import 'theme.dart';

/// Represents regular paragraph line in a Zefyr editor.
class ZefyrParagraph extends StatelessWidget {
  ZefyrParagraph({Key key, @required this.node, this.blockStyle})
      : super(key: key);

  final LineNode node;
  final TextStyle blockStyle;

  @override
  Widget build(BuildContext context) {
    final theme = ZefyrTheme.of(context);
    TextStyle style = theme.paragraphTheme.textStyle;
    if (blockStyle != null) {
      style = style.merge(blockStyle);
    }
    return RawZefyrLine(
      node: node,
      style: style,
      padding: theme.paragraphTheme.padding,
    );
  }
}
