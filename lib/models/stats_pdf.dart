import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stats_pdf.freezed.dart';

@freezed
class StatsPdf with _$StatsPdf {
  const factory StatsPdf({
    required DateTime date,
    required MemoryImage image,
  }) = _StatsPdf;
}
