// RUN: %target-swift-ide-test -code-completion -source-filename %s -code-completion-token=CONSTRAINT1 | FileCheck %s -check-prefix=CONSTRAINT1
// RUN: %target-swift-ide-test -code-completion -source-filename %s -code-completion-token=CONSTRAINT2 | FileCheck %s -check-prefix=CONSTRAINT2

public protocol P1 {}
public protocol P2 {}
public struct Example<T: Any> {}

extension Example where T: P1 {
  func P1Method() {}
}

extension Example where T: P2 {
  func P2Method() {}
}

public struct S1 : P1 {}
public struct S2 : P2 {}

func foo1() {
  var I1 = Example<S1>()
  I1.#^CONSTRAINT1^#
}

// CONSTRAINT1: 	 Begin completions, 1 items
// CONSTRAINT1-NEXT: Decl[InstanceMethod]/CurrNominal:   P1Method()[#Void#]; name=P1Method()
// CONSTRAINT1-NEXT: End completions

func foo2() {
  var I2 = Example<S2>()
  I2.#^CONSTRAINT2^#
}

// CONSTRAINT2:      Begin completions, 1 items
// CONSTRAINT2-NEXT: Decl[InstanceMethod]/CurrNominal:   P2Method()[#Void#]; name=P2Method()
// CONSTRAINT2-NEXT: End completions
