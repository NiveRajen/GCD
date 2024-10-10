# GCD

1. Main Queue
The main queue is a system-created serial queue that uses the main thread. If we want to update UI, we have to use the main queue because UI is tied to the main thread.
If you don’t create any queue at all in XCode you are using the main queue in a synchronous manner.
Features:
*         System Created
*         Serial
*         Uses main thread
*         UI tied to the main queue
2. Global Concurrent Queue
Global concurrent queues are system-created concurrent queues. These types of queues can not use the main thread.
Features:
*         System Created
*         Concurrent
*         Can’t use the main thread.
Global concurrent queues can serve most of the concurrent execution needs we have.



Quality Of Service (QOS) - sets priority
A quality-of-service (QOS) class categorizes the work items which are performed on a dispatch queue. With this parameter, the priority of a given task is specified. There are four QOS classes that may be assigned to a queue.
Background
These are tasks that can take minutes or hours to complete such as loading or processing large amounts of data. They are not time-critical and the user needs to be able to do other things while they are happening. Such tasks are mapped to a low-priority queue.
Utility
These tasks take seconds or minutes and should be completed immediately. An example of a utility task would be one with a loading bar, such as a download.
User-initiated
These are tasks initiated by the user which should be executed right away, such as opening a document. They will be mapped to a high-priority queue and should only take a few seconds or less.
User-interactive
These are UI tasks that need to be finished immediately to ensure that the user is able to continue with the next interaction. They are mapped to the queue with the highest priority and run on the main thread.


Order and manner of dispatch
When using queues, the order and manner in which tasks are dispatched need to be chosen. GCD queues can be serial or concurrent and pushing tasks to them can happen synchronously or asynchronously.

Synchronous vs asynchronous
When a work item is scheduled synchronously, the execution of code that is happening on the current thread is paused until the item’s execution is completed. It is important not to execute a work item synchronously on the main queue as this results in a deadlock.

When it is scheduled asynchronously, the code on the current thread continues to be executed while the work item is scheduled to run on another thread.

Serial vs concurrent
In a serial queue, tasks are executed one after the other according to the FIFO algorithm. The serial queue just needs one thread since only one task is running at a time.
A concurrent queue creates as many threads as it has tasks dispatched into it. The developer does not control the creation of the threads.


Potential Problems

When multiple threads are running concurrently on shared memory, they must be controlled and used in the most advantageous way. Determining how to manage them efficiently can be difficult.

It is importantt to not keep adding more and more new threads to a program. More threads can mean more problems and the way they work together must be designed very carefully.
If threads are not managed correctly, there are several problems that can occur.
Deadlock

Deadlocks happen when two or more threads are unable to continue since they require a resource that is held by another thread. That thread requires a resource that is held by one of the threads waiting for it to be completed. In essence, each thread is waiting for another one to finish, halting any progress.
Race conditions

Race conditions occur when threads execute a section of code that can be managed concurrently by several threads, making them “race” to alter shared resources. This causes data to be inconsistent as the program output changes depending on which thread wins the race.
Starvation

Starvation happens when a thread never gets any CPU time or access to shared resources as other processes are given a higher priority. The starved thread remains at the end of the scheduling queue and is never executed.
Livelock

A livelock occurs when two threads are executing actions in response to one another instead of continuing with their task. Think of it like two people trying to pass each other in a narrow hallway and both moving in the same direction, blocking each other. Consequently, they both move to the other side, blocking each other again and so on.


Multithreading on multiple cores

Since the introduction of machines with multiple cores, it has been possible to have a dedicated processor run each thread, enabling parallelism.

With a single core, the application would need to switch back and forth to create the illusion of multitasking. With multiple cores, the underlying hardware can be used to run each thread on a dedicated core.

This allows the application to take full advantage of the available processing power, making the program more efficient and minimizing the risk of problems associated with concurrency as not all threads are running on the same core.
