import UIKit
import Dispatch

var greeting = "Hello, playground"


//serial queues - default if no attributes are specified - the output will be printer in order the code is executed

let serialQueue = DispatchQueue(label: "serialQueue")

serialQueue.async {
    print("Task 1 started")
        // Do some work..
    print("Task 1 finished")
}

serialQueue.async {
    print("Task 2 started")
        // Do some work..
    print("Task 2 finished")
}


//concurrent queues - the output might not be in order

let myQueue = DispatchQueue(label: "com.multithreading.concurr", attributes: .concurrent)
myQueue.async {
    for i in 0..<10 {
        print("1")
    }
}
myQueue.async {
    for j in 0..<10 {
        print("2")
    }
}


//QOS: this will help to set the priority to the queues. Global queues does not run on main thread but it will run on any available thread
//Global Queues
// Fourth loop (User-interactive) always ends first. The third loop (User-initiated) follows it, then the second loop (Utility) ends. At last, you can see the first loop (Background) ends the task execution.
DispatchQueue.global(qos: .background).async {
    let qos = DispatchQoS.QoSClass(rawValue: qos_class_self()) ?? .unspecified
    
    print("---- First loop start ----- qos: \(qos)")
    for i in 0...5 {
        print("Value is \(i)")
    }
    print("---- First loop end -----")
}

DispatchQueue.global(qos: .utility).async {
    let qos = DispatchQoS.QoSClass(rawValue: qos_class_self()) ?? .unspecified
    
    print("---- Second loop start ----- qos: \(qos)")
    for i in 6...10 {
        print("Value is \(i)")
    }
    print("---- Second loop end -----")
}

DispatchQueue.global(qos: .userInitiated).async {
    let qos = DispatchQoS.QoSClass(rawValue: qos_class_self()) ?? .unspecified
    
    print("---- Third loop start ----- qos: \(qos)")
    for i in 11...15 {
        print("Value is \(i)")
    }
    print("---- Third loop end -----")
}

DispatchQueue.global(qos: .userInteractive).async {
    let qos = DispatchQoS.QoSClass(rawValue: qos_class_self()) ?? .unspecified
    
    print("---- Fourth loop start ----- qos: \(qos)")
    for i in 16...20 {
        print("Value is \(i)")
    }
    print("---- Fourth loop end -----")
}


//Custom Queues - e can create custom queues for specific use cases to have more control.
// Between 11–20 is run on the concurrent queue and they are on different blocks, so the outputs are unordered. Between 0–10 is run on the serial queue and the outputs are ordered. Also, user-interactive is higher level than the utility so we can see the 20 before the 10.

// Serial Queue
let queueA = DispatchQueue(label: "QueueA",
                           qos: .utility)

// Concurrent Queue
let queueB = DispatchQueue(label: "QueueB",
                           qos: .userInteractive,
                           attributes: .concurrent)

queueA.async {
    let qos = DispatchQoS.QoSClass(rawValue: qos_class_self()) ?? .unspecified
    let name =  String(cString:__dispatch_queue_get_label(nil))
    print("---- First loop start ----- qos: \(qos), queueName:\(name)")
    for i in 0...5 {
        print("Value is \(i)")
    }
    print("---- First loop end -----")
}

queueA.async {
    let qos = DispatchQoS.QoSClass(rawValue: qos_class_self()) ?? .unspecified
    let name =  String(cString:__dispatch_queue_get_label(nil))
    print("---- Second loop start ----- qos: \(qos), queueName:\(name)")
    for i in 6...10 {
        print("Value is \(i)")
    }
    print("---- Second loop end -----")
}

queueB.async {
    let qos = DispatchQoS.QoSClass(rawValue: qos_class_self()) ?? .unspecified
    let name =  String(cString:__dispatch_queue_get_label(nil))
    print("---- Third loop start ----- qos:\(qos), queueName:\(name)")
    for i in 11...15 {
        print("Value is \(i)")
    }
    print("---- Third loop end -----")
}

queueB.async {
    let qos = DispatchQoS.QoSClass(rawValue: qos_class_self()) ?? .unspecified
    let name =  String(cString:__dispatch_queue_get_label(nil))
    print("---- Fourth loop start ----- qos: \(qos), queueName:\(name)")
    for i in 16...20 {
        print("Value is \(i)")
    }
    print("---- Fourth loop end -----")
}


//Setting the target queue
//Even the queueD is concurrent when it is targetted to queueC it executed its task in a serial manner. So all the tasks you submitted to queueB will be executed serially because of the target queue. You may realize that order of execution is changed but the QoS of the queueB is the same.
// Serial Queue
let queueC = DispatchQueue(label: "QueueC",
                           qos: .utility)

// Concurrent Queue
let queueD = DispatchQueue(label: "QueueD",
                           qos: .userInteractive,
                           attributes: .concurrent,
                           target: queueC) //******Changed Line******


queueC.async {
    let qos = DispatchQoS.QoSClass(rawValue: qos_class_self()) ?? .unspecified
    let name =  String(cString:__dispatch_queue_get_label(nil))
    print("---- First loop start ----- qos: \(qos), queueName:\(name)")
    for i in 0...5 {
        print("Value is \(i)")
    }
    print("---- First loop end -----")
}

queueC.async {
    let qos = DispatchQoS.QoSClass(rawValue: qos_class_self()) ?? .unspecified
    let name =  String(cString:__dispatch_queue_get_label(nil))
    print("---- Second loop start ----- qos: \(qos), queueName:\(name)")
    for i in 6...10 {
        print("Value is \(i)")
    }
    print("---- Second loop end -----")
}


queueD.async {
    let qos = DispatchQoS.QoSClass(rawValue: qos_class_self()) ?? .unspecified
    let name =  String(cString:__dispatch_queue_get_label(nil))
    print("---- Third loop start ----- qos:\(qos), queueName:\(name)")
    for i in 11...15 {
        print("Value is \(i)")
    }
    print("---- Third loop end -----")
}


queueD.async {
    let qos = DispatchQoS.QoSClass(rawValue: qos_class_self()) ?? .unspecified
    let name =  String(cString:__dispatch_queue_get_label(nil))
    print("---- Fourth loop start ----- qos: \(qos), queueName:\(name)")
    for i in 16...20 {
        print("Value is \(i)")
    }
    print("---- Fourth loop end -----")
}


//The QoS value of queueB is utility even if we set it to the background. But this wasn’t the case when the QoS of queueB was user-interactive. GCD won’t change QoS if the target queue is lower than the existing queue. It only changes the QoS if the target queue’s QoS value is in higher order than the current queue.

// Serial Queue
let queueE = DispatchQueue(label: "QueueE",
                           qos: .utility)

// Concurrent Queue
let queueF = DispatchQueue(label: "QueueF",
                           qos: .background,
                           attributes: .concurrent,
                           target: queueE)


queueE.async {
    let qos = DispatchQoS.QoSClass(rawValue: qos_class_self()) ?? .unspecified
    let name =  String(cString:__dispatch_queue_get_label(nil))
    print("---- First loop start ----- qos: \(qos), queueName:\(name)")
    for i in 0...5 {
        print("Value is \(i)")
    }
    print("---- First loop end -----")
}

queueE.async {
    let qos = DispatchQoS.QoSClass(rawValue: qos_class_self()) ?? .unspecified
    let name =  String(cString:__dispatch_queue_get_label(nil))
    print("---- Second loop start ----- qos: \(qos), queueName:\(name)")
    for i in 6...10 {
        print("Value is \(i)")
    }
    print("---- Second loop end -----")
}


queueF.async {
    let qos = DispatchQoS.QoSClass(rawValue: qos_class_self()) ?? .unspecified
    let name =  String(cString:__dispatch_queue_get_label(nil))
    print("---- Third loop start ----- qos:\(qos), queueName:\(name)")
    for i in 11...15 {
        print("Value is \(i)")
    }
    print("---- Third loop end -----")
}


queueF.async {
    let qos = DispatchQoS.QoSClass(rawValue: qos_class_self()) ?? .unspecified
    let name =  String(cString:__dispatch_queue_get_label(nil))
    print("---- Fourth loop start ----- qos: \(qos), queueName:\(name)")
    for i in 16...20 {
        print("Value is \(i)")
    }
    print("---- Fourth loop end -----")
}



//Dispatch Groups

//A dispatch group is a group of tasks that is monitored as one unit. This way, collections of tasks can be aggregated. Multiple work items are attached to a group and scheduled for asynchronous execution. This way, multiple processes can be started but only one event is needed which occurs when all tasks have been completed
func myTask1(dispatchGroup:DispatchGroup){
    DispatchQueue.global().async {
        print("Task 1 finished")
        dispatchGroup.leave()
    }
}

func myTask2(dispatchGroup:DispatchGroup){
    DispatchQueue.global().async {
        print("Task 2 finished")
        dispatchGroup.leave()
    }
}
 
func myDispatchGroup(){
    let dispatchGroup = DispatchGroup()
    dispatchGroup.enter()
    myTask1(dispatchGroup: dispatchGroup)
    dispatchGroup.enter()
    myTask2(dispatchGroup: dispatchGroup)
 
    dispatchGroup.notify(queue: .main) {
        print("All tasks finished.")
    }
}


//Dispatch Work Item
//A dispatch work item encapsulates a block of code and provides the flexibility to cancel the given task.
//
//Imagine that you are using the search function in an app. With every typed letter, a new search call is made and the previous one is canceled.
   
let workItem = DispatchWorkItem {
 print("Work Item executing")
}
let queue = DispatchQueue(label: "com.example")
queue.async(execute: workItem)

workItem.cancel()
if workItem.isCancelled {
  print("Work item has been canceled")
}

//Async after
//This method can be utilized to delay the execution of a task. GCD enables the developer to set the amount of time after which the task should be run.
let time = 2.0
DispatchQueue.main.asyncAfter(deadline: .now() + time){
    print("Delayed task")
}



// Create a semaphore with an initial value of 1
//let semaphore = DispatchSemaphore(value: 1)
//
//// Shared resource
//var resourceCounter = 0
//
//// Concurrent tasks
//func taskOne() {
//    semaphore.wait() // Acquire the semaphore permit
//    for _ in 1...5 {
//        print(Thread.current)
//        resourceCounter += 1
//        print("Task One: \(resourceCounter)")
//    }
//    semaphore.signal() // Release the semaphore permit
//}
//
//func taskTwo() {
//    semaphore.wait() // Acquire the semaphore permit
//    for _ in 1...5 {
//        print(Thread.current)
//        resourceCounter -= 1
//        print("Task Two: \(resourceCounter)")
//    }
//    semaphore.signal() // Release the semaphore permit
//}
//
//// Create a concurrent queue
//let concurrentQueue = DispatchQueue(label: "com.exp.conQueue", attributes: .concurrent)
//
//// Run the tasks concurrently
//concurrentQueue.async {
//    taskOne()
//}
//
//concurrentQueue.async {
//    taskTwo()
//}
