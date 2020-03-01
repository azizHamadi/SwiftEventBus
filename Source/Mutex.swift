//
//  Mutex.swift
//  EventBus
//
//  Created by hamadi aziz on 01/03/2020.
//  Copyright © 2020 hamadi aziz. All rights reserved.
//

import Foundation

// convenience wrapper wround pthread_mutex_t
class Mutex {
    var mutex = pthread_mutex_t()
    
    init(recursive: Bool = false) {
        var attr = pthread_mutexattr_t()
    pthread_mutexattr_init(&attr)

    if recursive {
            pthread_mutexattr_settype(&attr, Int32(PTHREAD_MUTEX_RECURSIVE))
        } else {
        pthread_mutexattr_settype(&attr, Int32(PTHREAD_MUTEX_NORMAL))
        }
    }

    deinit {
        pthread_mutex_destroy(&mutex)
    }
    
    func lock() {
        pthread_mutex_lock(&mutex)
    }

    func unlock() {
        pthread_mutex_unlock(&mutex)
    }
}
