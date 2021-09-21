//
//  QueueExecutable.swift
//  Fruits
//
//  Created by Anton Sokolchenko on 20.09.2021.
//

import Foundation
import CocoaLumberjackSwift
import BoltsSwift

/// The protocol implementation of a convenient queue executor using BoltsSwift tasks. The tasks can be chained, executed from multiple methods and the protocol checks if the block are running inside the same queue, so it will dispatch them right now instead of potentially blocking the current queue.
/// By default, tasks are executed right after creation. This class wraps them into closures to delay their execution to the time when it is needed
protocol QueueExecutable {
	var queue: DispatchQueue! { get }
	var queueLabel: String { get }
	var queueQoS: DispatchQoS { get }
	func executeOnCacheQueue<Result: Any>(isWriteOperation: Bool, queueBlock: @escaping () -> Result?) -> Task<Result>
	func executeOnCacheQueue<Result: Any>(isWriteOperation: Bool, fromClosure queueBlockResultFromTask: @escaping (() -> Task<Result>)) -> Task<Result>
}

extension QueueExecutable {
	private func isExecuted(inQueue queue: DispatchQueue) -> Bool {
		let cNameOfCurrentQueue = __dispatch_queue_get_label(nil)
		let nameOfCurrentQueue = String(cString: cNameOfCurrentQueue, encoding: .utf8)
		return nameOfCurrentQueue == queue.label
	}
	
	// Use continueWith Executor to execute your completion on your queue
	@discardableResult
	func executeOnCacheQueue<Result: Any>(isWriteOperation: Bool, queueBlock: @escaping () -> Result?) -> Task<Result> {
		let completion = TaskCompletionSource<Result>()
		
		let queueBlock = {
			let result = queueBlock()
			
			if let errorResult = result as? Error {
				completion.set(error: errorResult)
			} else if let result = result {
				completion.set(result: result)
			} else {
				completion.set(error: QueueExecutableError.unkownError)
			}
		}
		
		if isWriteOperation {
			if isExecuted(inQueue: queue) {
				//
				queueBlock()
			} else {
				queue.async(group: nil, qos: queue.qos, flags: .barrier, execute: queueBlock)
			}
		} else {
			if isExecuted(inQueue: queue) {
				queueBlock()
			} else {
				queue.async(execute: queueBlock)
			}
		}
		return completion.task
	}
	
	// Closure is required here. In this way we delay task execution
	@discardableResult
	func executeOnCacheQueue<Result: Any>(isWriteOperation: Bool, fromClosure queueBlockResultFromTask: @escaping (() -> Task<Result>)) -> Task<Result> {
		let completion = TaskCompletionSource<Result>()
		
		let queueBlock = {
			let task = queueBlockResultFromTask()
			task.waitUntilCompleted()
			task.continueWith(continuation: { task in
				if let result = task.result {
					completion.set(result: result)
				} else {
					completion.set(error: task.error!)
				}
			})
		}
		
		if isWriteOperation {
			if isExecuted(inQueue: queue) {
				// Is it wrong?
				queueBlock()
			} else {
				queue.async(group: nil, qos: queue.qos, flags: .barrier, execute: queueBlock)
			}
		} else {
			if isExecuted(inQueue: queue) {
				queueBlock()
			} else {
				queue.async(execute: queueBlock)
			}
		}
		return completion.task
	}
}
