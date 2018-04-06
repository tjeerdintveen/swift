// RUN: %target-swift-frontend -typecheck %s -import-objc-header %S/Inputs/enum-new.h -verify -enable-nonfrozen-enum-exhaustivity-diagnostics
// REQUIRES: OS=macosx

_ = .Red as Color
_ = .Cyan as MoreColor

func test() {
  switch getColor() { // expected-warning {{switch must be exhaustive}} expected-note{{handle unknown values using "@unknown default"}}
  case .Red, .Blue, .Green: break
  }

  switch getMoreColor() { // expected-warning {{switch must be exhaustive}} expected-note{{handle unknown values using "@unknown default"}}
  case .Yellow, .Magenta, .Black, .Cyan: break
  }

  switch getColorOptions() { // expected-error {{switch must be exhaustive}} expected-note{{do you want to add a default clause?}}
  case ColorOptions.Pastel: break
  case ColorOptions.Swift: break
  }
  
  switch 5 as Int16 { // expected-error {{'switch' statement body must have at least one 'case' or 'default' block; do you want to add a default case?}}
  }
}
