//
//  CombineExtension.swift
//  Algorithm-Visualizer
//
//  Created by Min-Kyu Lee on 2024-04-27.
//

import Foundation
import Combine

extension Publisher {
	public func combineLatest<P, Q, R, S>(
		_ publisher1: P,
		_ publisher2: Q,
		_ publisher3: R,
		_ publisher4: S
	) -> AnyPublisher<(Self.Output, P.Output, Q.Output, R.Output, S.Output), Self.Failure>
		where P: Publisher,
			  Q: Publisher,
			  R: Publisher,
			  S: Publisher,
			  Self.Failure == P.Failure,
			  P.Failure == Q.Failure,
			  Q.Failure == R.Failure,
			  R.Failure == S.Failure {
				  return Publishers.CombineLatest(
					self,
					Publishers.CombineLatest4(
						publisher1,
						publisher2,
						publisher3,
						publisher4
					)
				  ).map { selfVal, tupleOfVals in
					  return (selfVal, tupleOfVals.0, tupleOfVals.1, tupleOfVals.2, tupleOfVals.3)
				  }
				  .eraseToAnyPublisher()

	}

	public func combineLatest<P, Q, R, S, T>(
		_ publisher1: P,
		_ publisher2: Q,
		_ publisher3: R,
		_ publisher4: S,
		_ publisher5: T
	) -> AnyPublisher<(Output, P.Output, Q.Output, R.Output, S.Output, T.Output), Failure>
		where P: Publisher,
			  Q: Publisher,
			  R: Publisher,
			  S: Publisher,
			  T: Publisher,
			  P.Failure == Failure,
			  Q.Failure == Failure,
			  R.Failure == Failure,
			  S.Failure == Failure,
			  T.Failure == Failure {
				  return Publishers.CombineLatest(
					Publishers.CombineLatest3(
						self,
						publisher1,
						publisher2
					),
					Publishers.CombineLatest3(
						publisher3,
						publisher4,
						publisher5
					)
				  ).map { a, b in
					  return (a.0, a.1, a.2, b.0, b.1, b.2)
				  }
				  .eraseToAnyPublisher()

	}

	public func combineLatest<P, Q, R, S, T, U>(
			_ publisher1: P,
			_ publisher2: Q,
			_ publisher3: R,
			_ publisher4: S,
			_ publisher5: T,
			_ publisher6: U
		) -> AnyPublisher<(Output, P.Output, Q.Output, R.Output, S.Output, T.Output, U.Output), Failure>
			where P: Publisher,
				  Q: Publisher,
				  R: Publisher,
				  S: Publisher,
				  T: Publisher,
				  U: Publisher,
				  Failure == P.Failure,
				  P.Failure == Q.Failure,
				  Q.Failure == R.Failure,
				  R.Failure == S.Failure,
				  S.Failure == T.Failure,
				  T.Failure == U.Failure {

			return Publishers.CombineLatest(
				Publishers.CombineLatest4(
					self,
					publisher1,
					publisher2,
					publisher3
				),
				Publishers.CombineLatest3(
					publisher4,
					publisher5,
					publisher6
				)
			)
			.map { a, b in
				return (a.0, a.1, a.2, a.3, b.0, b.1, b.2)
			}
			.eraseToAnyPublisher()
		}

	public func combineLatest<P1, P2, P3, P4, P5, P6, P7>(
			_ publisher1: P1,
			_ publisher2: P2,
			_ publisher3: P3,
			_ publisher4: P4,
			_ publisher5: P5,
			_ publisher6: P6,
			_ publisher7: P7
		) -> AnyPublisher<(Output, P1.Output, P2.Output, P3.Output, P4.Output, P5.Output, P6.Output, P7.Output), Failure>
			where P1: Publisher,
				  P2: Publisher,
				  P3: Publisher,
				  P4: Publisher,
				  P5: Publisher,
				  P6: Publisher,
				  P7: Publisher,
				  Failure == P1.Failure,
				  P1.Failure == P2.Failure,
				  P2.Failure == P3.Failure,
				  P3.Failure == P4.Failure,
				  P4.Failure == P5.Failure,
				  P5.Failure == P6.Failure,
				  P6.Failure == P7.Failure {

			return Publishers.CombineLatest(
				Publishers.CombineLatest4(
					self,
					publisher1,
					publisher2,
					publisher3
				),
				Publishers.CombineLatest4(
					publisher4,
					publisher5,
					publisher6,
					publisher7
				)
			)
			.map { a, b in
				return (a.0, a.1, a.2, a.3, b.0, b.1, b.2, b.3)
			}
			.eraseToAnyPublisher()
		}

	public func combineLatest<P1, P2, P3, P4, P5, P6, P7, P8>(
			_ publisher1: P1,
			_ publisher2: P2,
			_ publisher3: P3,
			_ publisher4: P4,
			_ publisher5: P5,
			_ publisher6: P6,
			_ publisher7: P7,
			_ publisher8: P8
	) -> AnyPublisher<
		(Output, P1.Output, P2.Output, P3.Output, P4.Output, P5.Output, P6.Output, P7.Output, P8.Output),
		Self.Failure
	>
			where P1: Publisher,
				  P2: Publisher,
				  P3: Publisher,
				  P4: Publisher,
				  P5: Publisher,
				  P6: Publisher,
				  P7: Publisher,
				  P8: Publisher,
				  Self.Failure == P1.Failure,
				  P1.Failure == P2.Failure,
				  P2.Failure == P3.Failure,
				  P3.Failure == P4.Failure,
				  P4.Failure == P5.Failure,
				  P5.Failure == P6.Failure,
				  P6.Failure == P7.Failure,
				  P7.Failure == P8.Failure {

			return Publishers.CombineLatest3(
				Publishers.CombineLatest4(
					self,
					publisher1,
					publisher2,
					publisher3
				),
				Publishers.CombineLatest4(
					publisher4,
					publisher5,
					publisher6,
					publisher7
				),
				publisher8
			)
			.map { a, b, c in
				return (a.0, a.1, a.2, a.3, b.0, b.1, b.2, b.3, c)
			}
			.eraseToAnyPublisher()
		}
}
