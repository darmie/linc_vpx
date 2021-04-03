/* Copyright (c) 2011 The WebM project authors. All Rights Reserved. */
/*  */
/* Use of this source code is governed by a BSD-style license */
/* that can be found in the LICENSE file in the root of the source */
/* tree. An additional intellectual property rights grant can be found */
/* in the file PATENTS.  All contributing project authors may */
/* be found in the AUTHORS file in the root of the source tree. */
#include "vpx/vpx_codec.h"
static const char* const cfg = "--enable-vp8 --disable-vp9 --enable-avx2 --enable-avx512 --enable-libyuv --disable-docs --disable-examples --disable-unit-tests --extra-cxxflags=-mmacosx-version-min=10.9 --extra-cflags=-mmacosx-version-min=10.9";
const char *vpx_codec_build_config(void) {return cfg;}
