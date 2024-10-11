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

Dispatch group

A dispatch group is a feature of Grand Central Dispatch (GCD) that allows you to manage a collection of tasks and track their completion. It provides a way to group multiple asynchronous tasks and wait for all of them to finish before proceeding with the next step in your code. This is particularly useful when you need to perform multiple concurrent operations and then execute a final task once all of them are complete.

When to Use Dispatch Groups:

You would use dispatch groups in scenarios such as
Multiple Network Requests: When you need to fetch data from multiple sources simultaneously and then perform an action (like updating the UI) once all requests have completed.
Batch Processing: When performing a series of independent tasks that should complete before proceeding to the next stage, such as processing images or data in parallel.
Synchronization: When you want to ensure that a group of tasks has finished executing before continuing with other operations, such as initiating an animation after all data has been loaded.

How Dispatch Groups Work?

Here’s how to create and use a dispatch group:
Create a Dispatch Group: Instantiate a DispatchGroup object.
Enter and Leave the Group: Call enter() before starting each task and leave() when the task is complete. This tracks the number of tasks in the group.
Wait for Completion: Use notify(queue:execute:) to specify a block of code to run after all tasks in the group have completed.


Semaphore:

A semaphore is a synchronization primitive used in concurrent programming to control access to a shared resource by multiple threads. It essentially acts as a counter that regulates the number of threads that can access a resource concurrently. Semaphores are particularly useful in managing resource pools and ensuring that only a certain number of threads can access critical sections of code or resources at any given time.

How Semaphores Work
A semaphore maintains a count that represents the number of available resources. When a thread wants to access a resource, it "waits" (decrements the semaphore) and proceeds if the count is greater than zero. If the count is zero, the thread blocks until a resource becomes available (when another thread signals the semaphore).

Creating the Semaphore: The semaphore is initialized with a count of 2, meaning that up to two threads can access the critical section at the same time.
Waiting for Access: Each task in the loop calls semaphore.wait() before proceeding. This decrements the semaphore count. If the count is greater than zero, the task continues; if it's zero, the task will block until a resource is available.
Performing the Task: The task simulates work with sleep(2), indicating a time-consuming operation.
Signaling Completion: After finishing the task, semaphore.signal() is called, which increments the semaphore count, allowing another waiting thread to proceed.

Benefits: 
Resource Management: Semaphores help manage resource limits effectively, ensuring that only a specified number of threads can access a resource concurrently.
Avoiding Race Conditions: By controlling access, semaphores can help avoid race conditions, ensuring that shared resources are accessed safely.
Flexibility: Semaphores can be adjusted to allow different levels of concurrency by changing the initial count, making them adaptable to various scenarios.


Best Practices for GCD:
1. Avoid Blocking the Main Thread
2. Manage the Number of Concurrent Tasks
3. Use Dispatch Groups
4. Utilize Quality of Service (QoS)
4. Use Serial Queues for Ordered Execution
5. Clean Up Resources
6. Avoid retaining strong references to self in asynchronous blocks to prevent memory leaks.
7. Monitor Performance
8. Avoid Long-Lived Threads
9. Profile Memory Usage
